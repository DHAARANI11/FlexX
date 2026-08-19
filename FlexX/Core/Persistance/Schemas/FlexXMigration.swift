//
//  FlexXMigration.swift
//  FlexX
//
//  Created by Dhaarani M on 14/08/26.
//

import SwiftData

enum FlexXMigrationPlan: SchemaMigrationPlan {

    static var schemas: [any VersionedSchema.Type] {
        [
            SchemaV1.self,
            SchemaV2.self
        ]
    }

    static var stages: [MigrationStage] {
        [
            migrateV1ToV2
        ]
    }

    static let migrateV1ToV2 =
        MigrationStage.lightweight(
            fromVersion: SchemaV1.self,
            toVersion: SchemaV2.self
        )
}
