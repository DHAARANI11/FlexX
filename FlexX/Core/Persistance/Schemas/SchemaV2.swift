//
//  SchemaV2.swift
//  FlexX
//
//  Created by Dhaarani M on 14/08/26.
//

import Foundation
import SwiftData

enum SchemaV2: VersionedSchema {

    static var versionIdentifier: Schema.Version {
        Schema.Version(2, 0, 0)
    }

    static var models: [any PersistentModel.Type] {
        [
            SchemaV2.User.self
        ]
    }

    @Model
    final class User {

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
}
