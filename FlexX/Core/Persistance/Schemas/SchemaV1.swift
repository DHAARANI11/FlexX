//
//  SchemaV1.swift
//  FlexX
//
//  Created by Dhaarani M on 14/08/26.
//

import Foundation
import SwiftData

enum SchemaV1: VersionedSchema {

    static var versionIdentifier: Schema.Version {
        Schema.Version(1, 0, 0)
    }

    static var models: [any PersistentModel.Type] {
        [
            SchemaV1.User.self
        ]
    }

    @Model
    final class User {

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
            createdAt: Date = .now
        ) {
            self.id = id
            self.name = name
            self.email = email
            self.dateOfBirth = dateOfBirth
            self.createdAt = createdAt
        }
    }
}
