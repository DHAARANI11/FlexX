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

    private init() {

        do {
            container = try ModelContainer(
                for: UserModel.self
            )
        } catch {
            fatalError(
                "Failed to create ModelContainer: \(error)"
            )
        }
    }

    var context: ModelContext {
        container.mainContext
    }
}
