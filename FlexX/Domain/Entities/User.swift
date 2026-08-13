//
//  User.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import Foundation

struct User {

    let id: UUID
    let name: String
    let email: String
    let dateOfBirth: Date
    let createdAt: Date

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
