//
//  HomeViewModel.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import Foundation

final class HomeViewModel {

    private let getProfileUseCase: GetProfileUseCases

    private(set) var user: User?

    init(getProfileUseCase: GetProfileUseCases) {
        self.getProfileUseCase = getProfileUseCase
    }

    func loadUser() {

        do {
            user = try getProfileUseCase.execute()
        } catch {
            print("Failed to load user:", error)
        }
    }

    var userName: String {
        user?.name ?? ""
    }
}
