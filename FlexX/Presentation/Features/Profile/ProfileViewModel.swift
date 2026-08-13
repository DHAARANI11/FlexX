//
//  ProfileViewModel.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//

import UIKit
import SwiftData

final class ProfileViewModel {

    private let userRepository: UserRepository

    private(set) var user: User?

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

//    func loadProfile() {
//
//        do {
//            user = try userRepository.fetchCurrentUser()
//        } catch {
//            print("Failed to load profile: \(error)")
//        }
//    }

    var name: String {
        user?.name ?? ""
    }

    var email: String {
        user?.email ?? ""
    }

//    var heightText: String {
//        guard let height = user?.height else {
//            return "\(L10n.height): \(L10n.notSet)"
//        }
//
//        return "\(L10n.height): \(height) cm"
//    }
//
//    var weightText: String {
//        guard let weight = user?.weight else {
//            return "\(L10n.weight): \(L10n.notSet)"
//        }
//
//        return "\(L10n.weight): \(weight) kg"
//    }
//
//    var genderText: String {
//        "\(L10n.gender): \(user?.gender ?? L10n.notSet)"
//    }
//
//    var fitnessGoalText: String {
//        "\(L10n.fitnessGoal): \(user?.fitnessGoal ?? L10n.notSet)"
//    }
//
//    var profileImage: UIImage? {
//
//        guard let imageData = user?.profileImageData else {
//            return nil
//        }
//
//        return UIImage(data: imageData)
//    }
}
