//
//  UserRepository.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//

import Foundation

protocol UserRepository {
    
    //func fetchCurrentUser() throws -> User?

    func updateUser(_ user: User) throws
}
