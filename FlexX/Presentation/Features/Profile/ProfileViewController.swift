//
//  ProfileViewController.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let viewModel: ProfileViewModel
    private let coordinator: AppCoordinator

    private let scrollView: UIScrollView = {

        let scrollView = UIScrollView()

        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private let contentView: UIView = {

        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let profileImageView: UIImageView = {

        let imageView = UIImageView()

        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let nameLabel: UILabel = {

        let label = UILabel()

        label.text = "Name"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let emailLabel: UILabel = {

        let label = UILabel()

        label.text = "Email"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let personalInformationLabel: UILabel = {

        let label = UILabel()

        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let informationContainer: UIView = {

        let view = UIView()

        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let heightLabel = UILabel()
    private let weightLabel = UILabel()
    private let genderLabel = UILabel()
    private let fitnessGoalLabel = UILabel()


    private let editProfileButton: UIButton = {

        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let logoutButton: UIButton = {

        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()


    init(
        viewModel: ProfileViewModel,
        coordinator: AppCoordinator
    ) {

        self.viewModel = viewModel
        self.coordinator = coordinator

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupConstraints()
        setupInformationLabels()
        setupActions()
        bindViewModel()
    }
    
    func setupView() {

        view.backgroundColor = .systemBackground
        
        //title = L10n.profile
    }

    func setupHierarchy() {

        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)

        contentView.addSubview(personalInformationLabel)
        contentView.addSubview(informationContainer)

        informationContainer.addSubview(heightLabel)
        informationContainer.addSubview(weightLabel)
        informationContainer.addSubview(genderLabel)
        informationContainer.addSubview(fitnessGoalLabel)

        contentView.addSubview(editProfileButton)
        contentView.addSubview(logoutButton)
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            
            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            
            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            
            scrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            
            contentView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor
            ),
            
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor
            ),
            
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor
            ),
            
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            ),
            
            contentView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor
            ),
            
            profileImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 32
            ),
            
            profileImageView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            
            profileImageView.widthAnchor.constraint(
                equalToConstant: 110
            ),
            
            profileImageView.heightAnchor.constraint(
                equalTo: profileImageView.widthAnchor
            ),
            
            nameLabel.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor,
                constant: 16
            ),
            
            nameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 24
            ),
            
            nameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24
            ),
            
            emailLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: 4
            ),
            
            emailLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),
            
            emailLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),
            
            personalInformationLabel.topAnchor.constraint(
                equalTo: emailLabel.bottomAnchor,
                constant: 32
            ),
            
            personalInformationLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 24
            ),
            
            personalInformationLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24
            ),
            
            informationContainer.topAnchor.constraint(
                equalTo: personalInformationLabel.bottomAnchor,
                constant: 12
            ),
            
            informationContainer.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            
            informationContainer.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),
            
            heightLabel.topAnchor.constraint(
                equalTo: informationContainer.topAnchor,
                constant: 18
            ),
            
            heightLabel.leadingAnchor.constraint(
                equalTo: informationContainer.leadingAnchor,
                constant: 16
            ),
            
            heightLabel.trailingAnchor.constraint(
                equalTo: informationContainer.trailingAnchor,
                constant: -16
            ),
            
            weightLabel.topAnchor.constraint(
                equalTo: heightLabel.bottomAnchor,
                constant: 16
            ),
            
            weightLabel.leadingAnchor.constraint(
                equalTo: heightLabel.leadingAnchor
            ),
            
            weightLabel.trailingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor
            ),
            
            genderLabel.topAnchor.constraint(
                equalTo: weightLabel.bottomAnchor,
                constant: 16
            ),
            
            genderLabel.leadingAnchor.constraint(
                equalTo: heightLabel.leadingAnchor
            ),
            
            genderLabel.trailingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor
            ),
            
            fitnessGoalLabel.topAnchor.constraint(
                equalTo: genderLabel.bottomAnchor,
                constant: 16
            ),
            
            fitnessGoalLabel.leadingAnchor.constraint(
                equalTo: heightLabel.leadingAnchor
            ),
            
            fitnessGoalLabel.trailingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor
            ),
            
            fitnessGoalLabel.bottomAnchor.constraint(
                equalTo: informationContainer.bottomAnchor,
                constant: -18
            ),
            
            editProfileButton.topAnchor.constraint(
                equalTo: informationContainer.bottomAnchor,
                constant: 28
            ),
            
            editProfileButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 24
            ),
            
            editProfileButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24
            ),
            
            editProfileButton.heightAnchor.constraint(
                equalToConstant: 50
            ),
            
            logoutButton.topAnchor.constraint(
                equalTo: editProfileButton.bottomAnchor,
                constant: 12
            ),
            
            logoutButton.leadingAnchor.constraint(
                equalTo: editProfileButton.leadingAnchor
            ),
            
            logoutButton.trailingAnchor.constraint(
                equalTo: editProfileButton.trailingAnchor
            ),
            
            logoutButton.heightAnchor.constraint(
                equalTo: editProfileButton.heightAnchor
            ),
            
            logoutButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -32
            )
        ])
    }
        
        func setupInformationLabels() {
            
            let labels = [
                heightLabel,
                weightLabel,
                genderLabel,
                fitnessGoalLabel
            ]
            
            labels.forEach { label in
                
                label.font = .preferredFont(
                    forTextStyle: .body
                )
                
                label.textColor = .label
                label.numberOfLines = 0
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
        func setupActions() {
            
            editProfileButton.setTitle(
                L10n.editProfile,
                for: .normal
            )
            
            logoutButton.setTitle(
                L10n.profileLogout,
                for: .normal
            )
            
            editProfileButton.addTarget(
                self,
                action: #selector(editProfileTapped),
                for: .touchUpInside
            )
            
            logoutButton.addTarget(
                self,
                action: #selector(logoutTapped),
                for: .touchUpInside
            )
        }
        
        @objc private func editProfileTapped() {
            
            
        }
        
        @objc private func logoutTapped() {
            
            SessionManager.shared.logout()
            
            coordinator.start()
        }
        
        func bindViewModel() {
            
  //          viewModel.loadProfile()
            
//            nameLabel.text = viewModel.name
//            emailLabel.text = viewModel.email
//            
//            heightLabel.text = viewModel.heightText
//            weightLabel.text = viewModel.weightText
//            genderLabel.text = viewModel.genderText
//            fitnessGoalLabel.text = viewModel.fitnessGoalText
//            
//            if let image = viewModel.profileImage {
//                profileImageView.image = image
//            }
    }
}
