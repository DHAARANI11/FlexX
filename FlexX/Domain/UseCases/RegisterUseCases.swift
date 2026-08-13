//
//  RegisterUseCases.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import Foundation

final class RegisterUseCases {

    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(
        user: User,
        password: String
    ) -> Result<Void, AuthError> {

        return repository.register(
            user: user,
            password: password
        )
    }
}
