//
//  EditProfileViewModel.swift
//  FlexX
//
//  Created by Dhaarani M on 14/08/26.
//

import Foundation

final class EditProfileViewModel {

    private let userRepository: UserRepository

    private(set) var user: User?

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func loadUser() {

        do {
            user = try userRepository.fetchCurrentUser()
        } catch {
            print("Failed to load user for editing:", error)
            user = nil
        }
    }

    func save(
        name: String,
        height: Double?,
        weight: Double?,
        gender: String?,
        profileImageData: Data?
    ) -> String? {

        guard var updatedUser = user else {
            return "Unable to load your profile. Please try again."
        }

        updatedUser.name = name
        updatedUser.height = height
        updatedUser.weight = weight
        updatedUser.gender = gender

        if let profileImageData {
            updatedUser.profileImageData = profileImageData
        }

        do {
            try userRepository.updateUser(updatedUser)
            user = updatedUser
            return nil
        } catch UserRepositoryError.userNotFound {
            print("Save failed: no UserModel found matching id", updatedUser.id)
            return "Couldn't find your account to save changes to. Try logging out and back in."
        } catch {
            print("Failed to save profile:", error)
            return "Unable to save your changes. Please try again."
        }
    }
}
