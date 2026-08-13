//
//  AuthRepository.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import Foundation
import UIKit
import FirebaseAuth

protocol AuthRepository {

    func register(
        user: User,
        password: String
    ) -> Result<Void, AuthError>

    func login(
        email: String,
        password: String
    ) -> Result<User, AuthError>
    
    func loginwithGoogle(
        LoginViewController: UIViewController,
        completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void
    )
}
