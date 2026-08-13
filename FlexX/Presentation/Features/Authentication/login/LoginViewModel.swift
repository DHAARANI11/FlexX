//
//  LoginViewModel.swift
//  FlexX
//
//  Created by Dhaarani M on 09/08/26.
//

import Foundation
import SwiftData
import UIKit
import FirebaseAuth

final class LoginViewModel {

    private let loginUseCase: LoginUseCases
    private let authRepository: AuthRepository

    init(loginUseCase: LoginUseCases, authRepository: AuthRepository) {
        self.loginUseCase = loginUseCase
        self.authRepository = authRepository
    }

    func validate(
        email: String,
        password: String
    ) -> String? {

        let email = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if email.isEmpty {
            return "Please enter your email"
        }

        if !isValidEmail(email) {
            return "Please enter a valid email"
        }

        if password.isEmpty {
            return "Please enter your password"
        }

        return nil
    }

    func login(
        email: String,
        password: String
    ) -> String? {

        let result = loginUseCase.execute(email: email, password: password)

        switch result {

        case .success(let user):
            print("Login successful")
            print("Welcome \(user.name)")
            return nil

        case .failure(.userNotFound):
            return "No account found with this email."

        case .failure(.invalidPassword):
            return "Incorrect password."

        case .failure(.credentialNotFound):
            return "Unable to find your credentials."

        case .failure(.loginFailed):
            return "Unable to login. Please try again."

        default:
            return "Unable to login. Please try again."
        }
    }
    
    func loginwithGoogle(
        
        LoginViewController: UIViewController,
        completion: @escaping (
            Result<FirebaseAuth.User, Error>
        ) -> Void
    ) {

        authRepository.loginwithGoogle(
            LoginViewController: LoginViewController
        ) { result in

            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {

        let emailRegex =
            "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        return NSPredicate(
            format: "SELF MATCHES %@",
            emailRegex
        ).evaluate(with: email)
    }
    
}
