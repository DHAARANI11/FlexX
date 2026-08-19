//
//  AppCoordinator.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import UIKit

final class AppCoordinator {

    private let navigationController: UINavigationController
    private let appContainer: AppContainer

    init(
        navigationController: UINavigationController,
        appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
    }

    func start() {

        let loginViewModel = LoginViewModel(loginUseCase: appContainer.loginUseCase, authRepository: appContainer.authRepository
        )

        let loginViewController = LoginViewController(viewModel: loginViewModel,
            coordinator: self
        )

        navigationController.setViewControllers(
            [loginViewController],
            animated: false
        )
    }
    
    func restart() {

        navigationController.setViewControllers(
            [],
            animated: false
        )

        if SessionManager.shared.isLoggedIn {
            showHome()
        } else {
            start()
        }
    }

    func showSignup() {

        let signupViewModel = SignupViewModel(registerUseCase: appContainer.registerUseCase
        )

        let signupViewController = SignupViewController(viewModel: signupViewModel,
            coordinator: self
        )

        navigationController.pushViewController(
            signupViewController,
            animated: true
        )
    }
    
    func showLogin(){
        
        let loginViewModel = LoginViewModel(loginUseCase: appContainer.loginUseCase, authRepository: appContainer.authRepository
        )
        
        let loginViewController = LoginViewController(viewModel: loginViewModel,
            coordinator: self
        )
        
        navigationController.setViewControllers(
            [loginViewController],
            animated: true
        )
        
    }
    
    func showHome() {
        
        let tabBarController = MainTabBarController(coordinator: self,
            appContainer: appContainer
        )

        navigationController.setViewControllers(
            [tabBarController],
            animated: true
        )
    }
    
    func showProfile() {
     
        let profileViewModel = ProfileViewModel(getProfileUseCase: appContainer.getProfileUseCase
        )
     
        let editProfileViewModel = EditProfileViewModel(userRepository: appContainer.userRepository
        )
     
        let profileViewController = ProfileViewController(viewModel: profileViewModel,
            editProfileViewModel: editProfileViewModel,
            coordinator: self
        )
     
        navigationController.pushViewController(
            profileViewController,
            animated: true
        )
    }
    
    func showLanguageSettings() {

        let languageViewController = LanguageViewController(coordinator: self)

        navigationController.pushViewController(
            languageViewController,
            animated: true
        )
    }
    
    
    func showEditProfile() {
     
        let editProfileViewModel = EditProfileViewModel(userRepository: appContainer.userRepository
        )
    
        let editProfileViewController = EditProfileViewController(viewModel: editProfileViewModel,
            coordinator: self
        )
     
        navigationController.pushViewController(
            editProfileViewController,
            animated: true
        )
    }
    
    func showWorkoutCategories() {

        let viewModel = WorkoutCategoryViewModel(getWorkoutCategoriesUseCase:
                appContainer.getWorkoutCategoriesUseCase
        )

        let viewController = WorkoutCategoryViewController(viewModel: viewModel,
            coordinator: self
        )

        navigationController.pushViewController(
            viewController,
            animated: true
        )
    }
}
