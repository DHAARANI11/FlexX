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

    var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: isLoggedInKey)
    }

    func login() {
        UserDefaults.standard.set(
            true,
            forKey: isLoggedInKey
        )
    }

    func logout() {
        UserDefaults.standard.set(
            false,
            forKey: isLoggedInKey
        )
    }
}
