//
//  GetUserProfileUseCases.swift
//  FlexX
//
//  Created by Dhaarani M on 14/08/26.
//

import Foundation

protocol GetProfileUseCases {

    func execute() throws -> User?
}

final class GetProfileUseCasesImpl: GetProfileUseCases {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute() throws -> User? {
        try userRepository.fetchCurrentUser()
    }
}
