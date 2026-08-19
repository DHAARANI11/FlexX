//
//  UserRepositoryError.swift
//  FlexX
//
//  Created by Dhaarani M on 18/08/26.
//

enum UserRepositoryError: Error {
    case userNotFound
    case invalidCredentials
    case userAlreadyExists
}
