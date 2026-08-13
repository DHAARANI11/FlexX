//
//  UserModel.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import Foundation
import SwiftData

@Model
final class UserModel {

    var id: UUID
    var name: String
    var email: String
    var dateOfBirth: Date
    var createdAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        email: String,
        dateOfBirth: Date,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.createdAt = createdAt
    }
}

extension UserModel {

    convenience init(user: User) {

        self.init(
            id: user.id,
            name: user.name,
            email: user.email,
            dateOfBirth: user.dateOfBirth,
            createdAt: user.createdAt
        )
    }
}

extension User {

    init(model: UserModel) {

        self.init(
            id: model.id,
            name: model.name,
            email: model.email,
            dateOfBirth: model.dateOfBirth,
            createdAt: model.createdAt
        )
    }
}
