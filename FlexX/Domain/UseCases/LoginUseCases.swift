//
//  LoginUseCases.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import Foundation
import UIKit
import FirebaseAuth

final class LoginUseCases {

    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(
        email: String,
        password: String
    ) -> Result<User, AuthError> {

        return repository.login(
            email: email,
            password: password
        )
    }
    
    func loginWithGoogle(
        loginViewController: UIViewController,
        completion: @escaping (Result<User, Error>) -> Void
    ) {

        repository.loginWithGoogle(
            loginViewController: loginViewController
        ) { result in

            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
