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
import FirebaseCore
import GoogleSignIn

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
        
        print("REGISTER REPOSITORY CALLED")

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

            let userModel = UserModel(
                id: user.id,
                name: user.name,
                email: email,
                dateOfBirth: user.dateOfBirth,
                height: user.height,
                weight: user.weight,
                gender: user.gender,
                profileImageData: user.profileImageData,
                createdAt: user.createdAt
            )

            context.insert(userModel)

            try context.save()

            print("User saved")
            print("Email saved:", userModel.email)

            let passwordSaved = savePassword(
                password,
                for: email
            )

            guard passwordSaved else {
                return .failure(.credentialSaveFailed)
            }

            return .success(())

        } catch {

            print("Failed to register:", error)

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

        print("Login email:", email)

        let descriptor = FetchDescriptor<UserModel>()

        do {

            let users = try context.fetch(descriptor)

            print("Users in SwiftData:", users.count)

            for user in users {
                print("Stored email:", user.email)
            }

            guard let userModel = users.first(where: {
                $0.email.lowercased() == email
            }) else {

                print("No account found for:", email)

                return .failure(.userNotFound)
            }

            print("Account found:", userModel.email)

            guard let storedPassword = getPassword(
                for: email
            ) else {

                print("Password not found in Keychain")

                return .failure(.credentialNotFound)
            }

            guard storedPassword == password else {

                print("Password doesn't match")

                return .failure(.invalidPassword)
            }

            let user = User(
                model: userModel
            )

            return .success(user)

        } catch {

            print("Failed to login:", error)

            return .failure(.loginFailed)
        }
    }
    
    func loginWithGoogle(
        loginViewController: UIViewController,
        completion: @escaping (Result<User, Error>) -> Void
    ) {

        guard let clientID = FirebaseApp
            .app()?
            .options
            .clientID
        else {

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

        GIDSignIn.sharedInstance.configuration =
            configuration

        GIDSignIn.sharedInstance.signIn(
            withPresenting: loginViewController
        ) { [weak self] result, error in

            if let error {
                completion(.failure(error))
                return
            }

            guard let googleUser = result?.user else {

                let error = NSError(
                    domain: "AuthRepository",
                    code: 2,
                    userInfo: [
                        NSLocalizedDescriptionKey:
                            "Google user not found."
                    ]
                )

                completion(.failure(error))
                return
            }

            guard let idToken =
                    googleUser.idToken?.tokenString
            else {

                let error = NSError(
                    domain: "AuthRepository",
                    code: 3,
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
            ) { [weak self] authResult, error in

                if let error {
                    completion(.failure(error))
                    return
                }

                guard let firebaseUser =
                        authResult?.user
                else {

                    let error = NSError(
                        domain: "AuthRepository",
                        code: 4,
                        userInfo: [
                            NSLocalizedDescriptionKey:
                                "Firebase user not found."
                        ]
                    )

                    completion(.failure(error))
                    return
                }

                guard let self else {
                    return
                }

                do {

                    let user =
                        try self.createOrFetchLocalUser(
                            firebaseUser: firebaseUser,
                            googleUser: googleUser
                        )

                    completion(.success(user))

                } catch {

                    completion(.failure(error))
                }
            }
        }
    }

    private func createOrFetchLocalUser(
        firebaseUser: FirebaseAuth.User,
        googleUser: GIDGoogleUser
    ) throws -> User {

        let email = firebaseUser.email?
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .lowercased()

        guard let email else {

            throw NSError(
                domain: "AuthRepository",
                code: 5,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Google account email is missing."
                ]
            )
        }

        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { user in
                user.email == email
            }
        )

        let existingUsers =
            try context.fetch(descriptor)

        if let existingUser = existingUsers.first {

            return User(
                model: existingUser
            )
        }

        let name =
            firebaseUser.displayName
            ?? googleUser.profile?.name
            ?? "User"

        let newUser = User(
            id: UUID(),
            name: name,
            email: email,
            dateOfBirth: Date(),
            height: nil,
            weight: nil,
            gender: nil,
            profileImageData: nil,
            createdAt: .now
        )

        let userModel = UserModel(
            user: newUser
        )

        context.insert(userModel)

        try context.save()

        return newUser
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

        let passwordData =
            Data(password.utf8)

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
}
