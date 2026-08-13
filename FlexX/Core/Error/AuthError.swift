//
//  AuthError.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

enum AuthError: Error {

    case emailAlreadyExists
    case saveFailed
    case credentialSaveFailed
    case credentialNotFound
    case userNotFound
    case invalidPassword
    case loginFailed
}
