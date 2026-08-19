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

    var height: Double?
    var weight: Double?
    var gender: String?
    var profileImageData: Data?

    var createdAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        email: String,
        dateOfBirth: Date,
        height: Double? = nil,
        weight: Double? = nil,
        gender: String? = nil,
        profileImageData: Data? = nil,
        createdAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.gender = gender
        self.profileImageData = profileImageData
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
            height: user.height,
            weight: user.weight,
            gender: user.gender,
            profileImageData: user.profileImageData,
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
            height: model.height,
            weight: model.weight,
            gender: model.gender,
            profileImageData: model.profileImageData,
            createdAt: model.createdAt
        )
    }
}
