//
//  MainTabBarController.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//

import UIKit

final class MainTabBarController: UITabBarController {

    private let coordinator: AppCoordinator

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
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

        let homeViewController = HomeViewController(
            context: PersistenceController.shared.context,
            coordinator: coordinator
        )

        let favouritesViewController = FavouritesViewController(
            context: PersistenceController.shared.context,
            coordinator: coordinator
        )

//        let profileViewController = ProfileViewController(
//            context: PersistenceController.shared.context,
//            coordinator: coordinator
//        )
        
        let context = PersistenceController.shared.context

        let userRepository = UserRepositoryImpl(
            context: context
        )

        let profileViewModel = ProfileViewModel(
            userRepository: userRepository
        )

        let profileViewController = ProfileViewController(
            viewModel: profileViewModel,
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
