//
//  User.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import Foundation

struct User {

    let id: UUID
    var name: String
    let email: String
    let dateOfBirth: Date

    var height: Double?
    var weight: Double?
    var gender: String?
    var profileImageData: Data?

    let createdAt: Date

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
