//
//  PersistanceContainer.swift
//  FlexX
//
//  Created by Dhaarani M on 09/08/26.
//

import SwiftData

final class PersistenceController {

    static let shared = PersistenceController()

    let container: ModelContainer

    var context: ModelContext { container.mainContext }

    private init() {

        do {

            let schema = Schema([UserModel.self])

            let configuration = ModelConfiguration(
                schema: schema
            )

            container = try ModelContainer(
                for: schema,
                configurations: configuration
            )

        } catch {

            print("Failed to create ModelContainer")
            print("Error:", error)

            fatalError(
                "Failed to create ModelContainer: \(error)"
            )
        }
    }
}
