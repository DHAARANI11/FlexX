//
//  UserRepositoryImpl.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//

import SwiftData

import Foundation
import SwiftData

final class UserRepositoryImpl: UserRepository {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchCurrentUser() throws -> User? {

        guard let currentUserID = SessionManager.shared.currentUserID else {
            return nil
        }

        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { userModel in
                userModel.id == currentUserID
            }
        )

        guard let model = try context.fetch(descriptor).first else {
            return nil
        }

        return User(
            id: model.id,
            name: model.name,
            email: model.email,
            dateOfBirth: model.dateOfBirth,
            height: model.height,
            weight: model.weight,
            gender: model.gender,
            profileImageData: model.profileImageData,
            createdAt: model.createdAt
        )
    }

    func updateUser(_ user: User) throws {

        let userID = user.id

        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { userModel in
                userModel.id == userID
            }
        )

        guard let model = try context.fetch(descriptor).first else {
            return
        }

        model.name = user.name
        model.email = user.email
        model.dateOfBirth = user.dateOfBirth
        model.height = user.height
        model.weight = user.weight
        model.gender = user.gender
        model.profileImageData = user.profileImageData

        try context.save()
    }
}
