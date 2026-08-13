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
        appContainer: AppContainer
    ) {
        self.navigationController = navigationController
        self.appContainer = appContainer
    }

    func start() {

        let loginViewModel = LoginViewModel(
            loginUseCase: appContainer.loginUseCase, authRepository: appContainer.authRepository
        )

        let loginViewController = LoginViewController(
            viewModel: loginViewModel,
            coordinator: self
        )

        navigationController.setViewControllers(
            [loginViewController],
            animated: false
        )
    }

    func showSignup() {

        let signupViewModel = SignupViewModel(
            registerUseCase: appContainer.registerUseCase
        )

        let signupViewController = SignupViewController(
            viewModel: signupViewModel,
            coordinator: self
        )

        navigationController.pushViewController(
            signupViewController,
            animated: true
        )
    }
    
    func showLogin(){
        
        let loginViewModel = LoginViewModel(
            loginUseCase: appContainer.loginUseCase, authRepository: appContainer.authRepository
        )
        
        let loginViewController = LoginViewController(
            viewModel: loginViewModel,
            coordinator: self
        )
        
        navigationController.setViewControllers(
            [loginViewController],
            animated: true
        )
        
    }
    
    func showHome() {
        
        let tabBarController = MainTabBarController(
            coordinator: self
        )

        navigationController.setViewControllers(
            [tabBarController],
            animated: true
        )
    }
}
