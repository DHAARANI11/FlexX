//
//  LanguageViewController.swift
//  FlexX
//
//  Created by Dhaarani M on 15/08/26.
//

import UIKit

final class LanguageViewController: UIViewController {
    
    private let coordinator: AppCoordinator

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let languages = [
        ("English", "en"),
        ("தமிழ்", "ta"),
        ("हिंदी", "hi"),
        ("日本語", "ja")
    ]

    private let tableView = UITableView(
        frame: .zero,
        style: .insetGrouped
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Language"
        view.backgroundColor = .systemBackground

        setupTableView()
    }

    private func setupTableView() {

        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])

        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        languages.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = UITableViewCell(
            style: .default,
            reuseIdentifier: nil
        )

        let language = languages[indexPath.row]

        cell.textLabel?.text = language.0

        if language.1 == LanguageManager.shared.currentLanguage {
            cell.accessoryType = .checkmark
        }

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let selectedLanguage = languages[indexPath.row].1

        LanguageManager.shared.setLanguage(
            selectedLanguage
        )

        restartApplicationUI()
    }
    
    private func restartApplicationUI() {
        
        coordinator.restart()

//        guard let scene = view.window?.windowScene,
//            let window = scene.windows.first
//        else {
//            return
//        }
//
//        let navigationController = UINavigationController()
//
//        let context = PersistenceController.shared.context
//
//        let appContainer = AppContainer(
//            context: context
//        )
//
//        let coordinator = AppCoordinator(
//            navigationController: navigationController,
//            appContainer: appContainer
//        )
//
//        coordinator.showHome()
//
//        window.rootViewController = navigationController
//
//        UIView.transition(
//            with: window,
//            duration: 0.3,
//            options: .transitionCrossDissolve,
//            animations: nil
//        )
    }
}
