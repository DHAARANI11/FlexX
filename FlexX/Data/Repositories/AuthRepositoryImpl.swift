//
//  AuthRepositoryImpl.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import Foundation
import SwiftData
import Security
import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

final class AuthRepositoryImpl: AuthRepository {

    private let context: ModelContext

    private let keychainService = "com.flexx.authentication"

    init(context: ModelContext) {
        self.context = context
    }

    func register(
        user: User,
        password: String
    ) -> Result<Void, AuthError> {

        let email = user.email
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .lowercased()

        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { existingUser in
                existingUser.email == email
            }
        )

        do {

            let existingUsers = try context.fetch(descriptor)

            if !existingUsers.isEmpty {
                return .failure(.emailAlreadyExists)
            }

            let userModel = UserModel(user: user)

            context.insert(userModel)

            try context.save()

            let passwordSaved = savePassword(
                password,
                for: email
            )

            if !passwordSaved {
                return .failure(.credentialSaveFailed)
            }

            return .success(())

        } catch {

            print("Failed to register user:", error)

            return .failure(.saveFailed)
        }
    }

    func login(
        email: String,
        password: String
    ) -> Result<User, AuthError> {

        let email = email
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .lowercased()

        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { user in
                user.email == email
            }
        )

        do {

            let users = try context.fetch(descriptor)

            guard let userModel = users.first else {
                return .failure(.userNotFound)
            }

            guard let storedPassword = getPassword(
                for: email
            ) else {
                return .failure(.credentialNotFound)
            }

            guard storedPassword == password else {
                return .failure(.invalidPassword)
            }

            let user = User(model: userModel)

            return .success(user)

        } catch {

            print("Failed to login:", error)

            return .failure(.loginFailed)
        }
    }

    private func getPassword(
        for email: String
    ) -> String? {

        let query: [String: Any] = [

            kSecClass as String:
                kSecClassGenericPassword,

            kSecAttrService as String:
                keychainService,

            kSecAttrAccount as String:
                email,

            kSecReturnData as String:
                true,

            kSecMatchLimit as String:
                kSecMatchLimitOne
        ]

        var result: AnyObject?

        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )

        guard status == errSecSuccess,
              let data = result as? Data
        else {
            return nil
        }

        return String(
            data: data,
            encoding: .utf8
        )
    }

    private func savePassword(
        _ password: String,
        for email: String
    ) -> Bool {

        let passwordData = Data(password.utf8)

        let query: [String: Any] = [

            kSecClass as String:
                kSecClassGenericPassword,

            kSecAttrService as String:
                keychainService,

            kSecAttrAccount as String:
                email,

            kSecValueData as String:
                passwordData
        ]

        SecItemDelete(
            query as CFDictionary
        )

        let status = SecItemAdd(
            query as CFDictionary,
            nil
        )

        return status == errSecSuccess
    }
    
    func loginwithGoogle(
        LoginViewController: UIViewController,
        completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void
    ) {

        guard let clientID = FirebaseApp.app()?.options.clientID else {

            let error = NSError(
                domain: "AuthRepository",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Firebase client ID is missing."
                ]
            )

            completion(.failure(error))
            return
        }

        let configuration = GIDConfiguration(
            clientID: clientID
        )

        GIDSignIn.sharedInstance.configuration = configuration

        GIDSignIn.sharedInstance.signIn(
            withPresenting: LoginViewController
        ) { result, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let googleUser = result?.user,
                  let idToken = googleUser.idToken?.tokenString else {

                let error = NSError(
                    domain: "AuthRepository",
                    code: 2,
                    userInfo: [
                        NSLocalizedDescriptionKey:
                            "Unable to get Google ID token."
                    ]
                )

                completion(.failure(error))
                return
            }

            let accessToken =
                googleUser.accessToken.tokenString

            let credential =
                GoogleAuthProvider.credential(
                    withIDToken: idToken,
                    accessToken: accessToken
                )

            Auth.auth().signIn(
                with: credential
            ) { authResult, error in

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let firebaseUser = authResult?.user else {

                    let error = NSError(
                        domain: "AuthRepository",
                        code: 3,
                        userInfo: [
                            NSLocalizedDescriptionKey:
                                "Firebase user not found."
                        ]
                    )

                    completion(.failure(error))
                    return
                }

                completion(.success(firebaseUser))
            }
        }
    }
}
