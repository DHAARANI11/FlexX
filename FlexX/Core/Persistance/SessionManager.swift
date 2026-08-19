//
//  SessionManager.swift
//  FlexX
//
//  Created by Dhaarani M on 10/08/26.
//

import Foundation

final class SessionManager {

    static let shared = SessionManager()

    private init() {}

    private let isLoggedInKey = "isLoggedIn"
    private let currentUserIDKey = "currentUserID"

    var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: isLoggedInKey)
    }

    var currentUserID: UUID? {

        guard let idString = UserDefaults.standard.string(
            forKey: currentUserIDKey
        ) else {
            return nil
        }

        return UUID(uuidString: idString)
    }

    func login(userID: UUID) {

        UserDefaults.standard.set(
            true,
            forKey: isLoggedInKey
        )

        UserDefaults.standard.set(
            userID.uuidString,
            forKey: currentUserIDKey
        )
    }

    func logout() {

        UserDefaults.standard.set(
            false,
            forKey: isLoggedInKey
        )

        UserDefaults.standard.removeObject(
            forKey: currentUserIDKey
        )
    }
}
