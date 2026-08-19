//
//  MainTabBarController.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//

import UIKit

final class MainTabBarController: UITabBarController {

    private let coordinator: AppCoordinator
    private let appContainer: AppContainer

    init(
        coordinator: AppCoordinator,
        appContainer: AppContainer
    ) {
        self.coordinator = coordinator
        self.appContainer = appContainer

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
        setupTabBarAppearance()
    }

    private func setupTabs() {

        let homeViewModel = HomeViewModel(
            getProfileUseCase: appContainer.getProfileUseCase
        )

        let homeViewController = HomeViewController(
            viewModel: homeViewModel,
            coordinator: coordinator
        )

        let favouritesViewController = FavouritesViewController(
            context: PersistenceController.shared.context,
            coordinator: coordinator
        )

        let profileViewModel = ProfileViewModel(
            getProfileUseCase: appContainer.getProfileUseCase
        )

        let editProfileViewModel = EditProfileViewModel(
            userRepository: appContainer.userRepository
        )

        let profileViewController = ProfileViewController(
            viewModel: profileViewModel,
            editProfileViewModel: editProfileViewModel,
            coordinator: coordinator
        )

        let homeNavigationController = UINavigationController(
            rootViewController: homeViewController
        )

        let favouritesNavigationController = UINavigationController(
            rootViewController: favouritesViewController
        )

        let profileNavigationController = UINavigationController(
            rootViewController: profileViewController
        )

        homeNavigationController.tabBarItem = UITabBarItem(
            title: L10n.tabHome,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        favouritesNavigationController.tabBarItem = UITabBarItem(
            title: L10n.tabFavorite,
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )

        profileNavigationController.tabBarItem = UITabBarItem(
            title: L10n.tabProfile,
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        viewControllers = [
            homeNavigationController,
            favouritesNavigationController,
            profileNavigationController
        ]
    }

    private func setupTabBarAppearance() {

        let appearance = UITabBarAppearance()

        appearance.configureWithDefaultBackground()

        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
