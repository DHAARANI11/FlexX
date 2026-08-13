//
//  UserRepositoryImpl.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//

import Foundation
import SwiftData

final class UserRepositoryImpl: UserRepository {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

  //  func fetchCurrentUser() throws -> User? {

//        let descriptor = FetchDescriptor<User>()
//
//        let users = try context.fetch(descriptor)

       // return users.first
 //   }

    func updateUser(_ user: User) throws {

        try context.save()
    }
}
