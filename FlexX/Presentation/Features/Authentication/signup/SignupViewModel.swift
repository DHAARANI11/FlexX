//
//  SignupViewModel.swift
//  FlexX
//
//  Created by Dhaarani M on 09/08/26.
//

import Foundation
import SwiftData

final class SignupViewModel {

    private let registerUseCase: RegisterUseCases

    init(registerUseCase: RegisterUseCases) {
        self.registerUseCase = registerUseCase
    }

    func validate(
        name: String,
        email: String,
        password: String,
        confirmPassword: String,
        dateOfBirth: Date?
    ) -> String? {

        if name
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty {

            return "Please enter your full name"
        }

        if email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty {

            return "Please enter your email"
        }

        if !isValidEmail(email) {
            return "Please enter a valid email"
        }

        if password.isEmpty {
            return "Please enter your password"
        }

        if !isValidPassword(password) {
            return """
            password should contain at least: 
            1 lowercase character, 
            1 uppercase character, 
            1 number,
            1 special character
        """
        }
        
        if password.count < 6 {
            return "Password should be at least 6 characters"
        }

        if confirmPassword.isEmpty {
            return "Please confirm your password"
        }

        if password != confirmPassword {
            return "Passwords do not match"
        }

        if dateOfBirth == nil {
            return "Please select your date of birth"
        }

        return nil
    }

    func register(
        name: String,
        email: String,
        password: String,
        dateOfBirth: Date
    ) -> String? {

        let user = User(
            name: name,
            email: email.lowercased(),
            dateOfBirth: dateOfBirth
        )

        let result = registerUseCase.execute(user: user, password: password)
        //authService.register(user: user,password: password)

        switch result {

        case .success:
            return nil

        case .failure(.emailAlreadyExists):
            return "An account with this email already exists"

        case .failure(.saveFailed):
            return "Unable to create account. Please try again."
            
        case .failure(.credentialSaveFailed):
            return "Unable to securely save your password."
            
        default:
            return "Unable to create account. Please try again."
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
    
    private func isValidPassword(_ password: String) -> Bool {
        
        let passwordRegex =
                "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{6,}$"

            return NSPredicate(
                format: "SELF MATCHES %@",
                passwordRegex
            ).evaluate(with: password)
    }
}
