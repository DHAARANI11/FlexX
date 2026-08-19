//
//  ProfileViewModel.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//

import UIKit

final class ProfileViewModel {

    private let getProfileUseCase: GetProfileUseCases

    private(set) var user: User?

    init(
        getProfileUseCase: GetProfileUseCases
    ) {
        self.getProfileUseCase = getProfileUseCase
    }

    func loadProfile() {

        do {
            user = try getProfileUseCase.execute()
        } catch {
            print("Failed to load profile: \(error)")
        }
    }

    var name: String {
        user?.name ?? ""
    }

    var email: String {
        user?.email ?? ""
    }

    var heightText: String {
        guard let height = user?.height else {
            return "\(L10n.profileNotset)"
        }

        return "\(height)"
    }

    var weightText: String {
        guard let weight = user?.weight else {
            return "\(L10n.profileNotset)"
        }

        return "\(weight)"
    }

    var genderText: String {
        "\(user?.gender ?? L10n.profileNotset)"
    }
    
    var profileImage: UIImage? {

        guard let imageData = user?.profileImageData else {
            return nil
        }

        return UIImage(data: imageData)
    }
}
