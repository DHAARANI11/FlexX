//
//  LoginViewController.swift
//  FlexX
//
//  Created by Dhaarani M on 09/08/26.
//

import UIKit
import SwiftData
import FirebaseAuth

final class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    
    private let coordinator: AppCoordinator
    
    //private var keyboardmanager: KeyBoardManager?
    
    init(viewModel: LoginViewModel, coordinator: AppCoordinator) {

        self.viewModel = viewModel
        self.coordinator = coordinator

        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {

        let scrollView = UIScrollView()

        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private let contentView: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView: UIView = {

        let view = UIView()

        view.backgroundColor = .label
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let iconContainerView: UIView = {

        let view = UIView()

        view.backgroundColor = .systemBackground.withAlphaComponent(0.15)
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let iconImageView: UIImageView = {

        let imageView = UIImageView()

        imageView.image = UIImage(systemName: "dumbbell.fill")
        imageView.tintColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    private let appNameLabel: UILabel = {

        let label = UILabel()

        label.text = L10n.loginTitle
        label.font = .systemFont(
            ofSize: 24,
            weight: .bold
        )
        label.textColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let welcomeLabel: UILabel = {

        let label = UILabel()

        label.text = L10n.loginWelcome
        label.font = .systemFont(
            ofSize: 26,
            weight: .bold
        )
        label.textColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let subtitleLabel: UILabel = {

        let label = UILabel()

        label.text = L10n.loginSubtitle
        label.font = .systemFont(
            ofSize: 14,
            weight: .regular
        )
        label.textColor = .systemBackground.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let emailLabel: UILabel = {

        let label = UILabel()

        label.text = L10n.email
        label.font = .systemFont(
            ofSize: 13,
            weight: .medium
        )
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let emailTextField: UITextField = {

        let textField = UITextField()

        textField.placeholder = L10n.emailPlaceholder
        textField.borderStyle = .roundedRect

        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()
    
    private let passwordLabel: UILabel = {

        let label = UILabel()

        label.text = L10n.password
        label.font = .systemFont(
            ofSize: 13,
            weight: .medium
        )
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let passwordTextField: UITextField = {

        let textField = UITextField()

        textField.placeholder = L10n.passwordPlaceholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private func makeLeftIconView(systemName: String) -> UIView {

        let container = UIView()

        container.translatesAutoresizingMaskIntoConstraints = false
        container.isUserInteractionEnabled = false

        let imageView = UIImageView(
            image: UIImage(systemName: systemName)
        )

        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false

        container.addSubview(imageView)

        NSLayoutConstraint.activate([

            container.widthAnchor.constraint(
                equalToConstant: 40
            ),

            container.heightAnchor.constraint(
                equalToConstant: 24
            ),

            imageView.centerYAnchor.constraint(
                equalTo: container.centerYAnchor
            ),

            imageView.leadingAnchor.constraint(
                equalTo: container.leadingAnchor,
                constant: 10
            ),

            imageView.widthAnchor.constraint(
                equalToConstant: 18
            ),

            imageView.heightAnchor.constraint(
                equalToConstant: 18
            )
        ])

        return container
    }

    private func setupTextFieldIcons() {

        emailTextField.leftView = makeLeftIconView(systemName: "envelope")
        emailTextField.leftViewMode = .always

        passwordTextField.leftView = makeLeftIconView(systemName: "lock")
    
        passwordTextField.leftViewMode = .always
    }

    private func setupPasswordButton() {

        let button = UIButton(type: .system)

        button.setImage(
            UIImage(systemName: "eye.slash"),
            for: .normal
        )

        button.tintColor = .secondaryLabel

        button.addTarget(
            self,
            action: #selector(togglePasswordVisibility),
            for: .touchUpInside
        )

        passwordTextField.rightView = button
        passwordTextField.rightViewMode = .always
    }

    private let loginButton: UIButton = {

        let button = UIButton(type: .system)

        var configuration = UIButton.Configuration.filled()

        configuration.title = L10n.loginButton
        configuration.cornerStyle = .medium

        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let signupButton: UIButton = {

        let button = UIButton(type: .system)

        var configuration = UIButton.Configuration.plain()

        configuration.title = L10n.signupPrompt

        button.configuration = configuration

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let leftSeparator: UIView = {

        let view = UIView()

        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let orLabel: UILabel = {

        let label = UILabel()

        label.text = L10n.orContinueWith
        label.font = .systemFont(
            ofSize: 12,
            weight: .regular
        )
        label.textColor = .secondaryLabel
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let rightSeparator: UIView = {

        let view = UIView()

        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let googleButton: UIButton = {

        let button = UIButton(type: .system)

        var configuration = UIButton.Configuration.filled()

        configuration.title = L10n.googleLogin
        configuration.image = UIImage(systemName: "globe")
        configuration.imagePadding = 8
        configuration.baseBackgroundColor = .secondarySystemBackground
        configuration.baseForegroundColor = .label
        configuration.cornerStyle = .medium

        button.configuration = configuration

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        keyboardmanager = KeyBoardManager(
//            scrollView: scrollView,
//            contentView: contentView,
//            view: view
//        )

        setupUI()
        setupConstraints()
        setupActions()
        setupTextFieldIcons()
        setupPasswordButton()
//        keyboardmanager?.setupKeyboardHandling()
//        keyboardmanager?.setupKeyboardDismissGesture()
    }
    
    private func setupActions() {
        loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        
        signupButton.addTarget(
            self,
            action: #selector(signupButtonTapped),
            for: .touchUpInside
        )
        
        googleButton.addTarget(
            self,
            action: #selector(googleLoginTapped),
            for: .touchUpInside
        )
    }

    private func setupUI() {

        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        contentView.addSubview(headerView)

        headerView.addSubview(appNameLabel)
        headerView.addSubview(welcomeLabel)
        headerView.addSubview(subtitleLabel)
        
        headerView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)

        contentView.addSubview(emailLabel)
        contentView.addSubview(emailTextField)

        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextField)

        contentView.addSubview(loginButton)

        contentView.addSubview(leftSeparator)
        contentView.addSubview(orLabel)
        contentView.addSubview(rightSeparator)

        contentView.addSubview(googleButton)

        contentView.addSubview(signupButton)
    }

    private func setupConstraints() {

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

            headerView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),

            headerView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),

            headerView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),

            headerView.heightAnchor.constraint(
                equalToConstant: 220
            ),

            iconContainerView.topAnchor.constraint(
                equalTo: headerView.topAnchor,
                constant: 20
            ),

            iconContainerView.leadingAnchor.constraint(
                equalTo: headerView.leadingAnchor,
                constant: 20
            ),

            iconContainerView.widthAnchor.constraint(
                equalToConstant: 44
            ),

            iconContainerView.heightAnchor.constraint(
                equalToConstant: 44
            ),

            iconImageView.centerXAnchor.constraint(
                equalTo: iconContainerView.centerXAnchor
            ),

            iconImageView.centerYAnchor.constraint(
                equalTo: iconContainerView.centerYAnchor
            ),

            iconImageView.widthAnchor.constraint(
                equalToConstant: 22
            ),

            iconImageView.heightAnchor.constraint(
                equalToConstant: 22
            ),

            appNameLabel.topAnchor.constraint(
                equalTo: iconContainerView.bottomAnchor,
                constant: 14
            ),

            appNameLabel.leadingAnchor.constraint(
                equalTo: headerView.leadingAnchor,
                constant: 20
            ),

            appNameLabel.trailingAnchor.constraint(
                equalTo: headerView.trailingAnchor,
                constant: -20
            ),

            welcomeLabel.topAnchor.constraint(
                equalTo: appNameLabel.bottomAnchor,
                constant: 6
            ),

            welcomeLabel.leadingAnchor.constraint(
                equalTo: appNameLabel.leadingAnchor
            ),

            welcomeLabel.trailingAnchor.constraint(
                equalTo: appNameLabel.trailingAnchor
            ),

            subtitleLabel.topAnchor.constraint(
                equalTo: welcomeLabel.bottomAnchor,
                constant: 4
            ),

            subtitleLabel.leadingAnchor.constraint(
                equalTo: appNameLabel.leadingAnchor
            ),

            subtitleLabel.trailingAnchor.constraint(
                equalTo: appNameLabel.trailingAnchor
            ),
            
            emailLabel.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: 24
            ),

            emailLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 22
            ),

            emailLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -22
            ),

            emailTextField.topAnchor.constraint(
                equalTo: emailLabel.bottomAnchor,
                constant: 6
            ),

            emailTextField.leadingAnchor.constraint(
                equalTo: emailLabel.leadingAnchor
            ),

            emailTextField.trailingAnchor.constraint(
                equalTo: emailLabel.trailingAnchor
            ),

            emailTextField.heightAnchor.constraint(
                equalToConstant: 52
            ),

            passwordLabel.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: 16
            ),

            passwordLabel.leadingAnchor.constraint(
                equalTo: emailLabel.leadingAnchor
            ),

            passwordLabel.trailingAnchor.constraint(
                equalTo: emailLabel.trailingAnchor
            ),

            passwordTextField.topAnchor.constraint(
                equalTo: passwordLabel.bottomAnchor,
                constant: 6
            ),

            passwordTextField.leadingAnchor.constraint(
                equalTo: emailLabel.leadingAnchor
            ),

            passwordTextField.trailingAnchor.constraint(
                equalTo: emailLabel.trailingAnchor
            ),

            passwordTextField.heightAnchor.constraint(
                equalToConstant: 52
            ),

            loginButton.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: 24
            ),

            loginButton.leadingAnchor.constraint(
                equalTo: emailLabel.leadingAnchor
            ),

            loginButton.trailingAnchor.constraint(
                equalTo: emailLabel.trailingAnchor
            ),

            loginButton.heightAnchor.constraint(
                equalToConstant: 52
            ),

            orLabel.topAnchor.constraint(
                equalTo: loginButton.bottomAnchor,
                constant: 20
            ),

            orLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            orLabel.heightAnchor.constraint(
                equalToConstant: 20
            ),

            orLabel.widthAnchor.constraint(
                equalToConstant: 130
            ),

            leftSeparator.centerYAnchor.constraint(
                equalTo: orLabel.centerYAnchor
            ),

            leftSeparator.leadingAnchor.constraint(
                equalTo: emailLabel.leadingAnchor
            ),

            leftSeparator.trailingAnchor.constraint(
                equalTo: orLabel.leadingAnchor,
                constant: -10
            ),

            leftSeparator.heightAnchor.constraint(
                equalToConstant: 1
            ),
            
            rightSeparator.centerYAnchor.constraint(
                equalTo: orLabel.centerYAnchor
            ),

            rightSeparator.leadingAnchor.constraint(
                equalTo: orLabel.trailingAnchor,
                constant: 10
            ),

            rightSeparator.trailingAnchor.constraint(
                equalTo: emailLabel.trailingAnchor
            ),

            rightSeparator.heightAnchor.constraint(
                equalToConstant: 1
            ),

            googleButton.topAnchor.constraint(
                equalTo: orLabel.bottomAnchor,
                constant: 16
            ),

            googleButton.leadingAnchor.constraint(
                equalTo: emailLabel.leadingAnchor
            ),

            googleButton.trailingAnchor.constraint(
                equalTo: emailLabel.trailingAnchor
            ),

            googleButton.heightAnchor.constraint(
                equalToConstant: 50
            ),

            signupButton.topAnchor.constraint(
                equalTo: googleButton.bottomAnchor,
                constant: 16
            ),

            signupButton.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            signupButton.heightAnchor.constraint(
                equalToConstant: 40
            ),

            signupButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -24
            )
        ])
    }
    
    @objc private func loginButtonTapped() {

        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if let errorMessage = viewModel.validate(
            email: email,
            password: password
        ) {

            showAlert(message: errorMessage)
            return
        }

        if let errorMessage = viewModel.login(
            email: email,
            password: password
        ) {

            showAlert(message: errorMessage)
            return
        }

        guard let user = viewModel.loggedInUser else {
            showAlert(message: "Something went wrong. Please try again.")
            return
        }

        print("User logged in successfully")
        
        SessionManager.shared.login(userID: user.id)

        coordinator.showHome()
    }
    
    private func showAlert(message: String) {

        let alert = UIAlertController(
            title: L10n.loginButton,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: L10n.ok,
                style: .default
            )
        )

        present(alert, animated: true)
    }
    
    @objc private func signupButtonTapped() {

//        let signupViewModel = SignupViewModel(
//            registerUseCase: AppContainer.shared.registerUseCase
//        )
//
//        let signupViewController = SignupViewController(
//            viewModel: signupViewModel
//        )

        print("SIGNUP BUTTON TAPPED")
        coordinator.showSignup()
    }
    
    @objc private func togglePasswordVisibility() {

        passwordTextField.isSecureTextEntry.toggle()

        let imageName = passwordTextField.isSecureTextEntry
            ? "eye.slash"
            : "eye"

        let button = passwordTextField.rightView as? UIButton

            button?.setImage(
                UIImage(systemName: imageName),
                for: .normal
            )

        button?.tintColor = .secondaryLabel
    }
    
    @objc private func googleLoginTapped() {

        viewModel.loginWithGoogle(
            loginViewController: self
        ) { [weak self] result in

            guard let self else {
                return
            }

            switch result {

            case .success(let user):

                print("Google Login Successful")
                print("UID:", user.id)
                print("Name:", user.name )
                print("Email:", user.email )

                SessionManager.shared.login(userID: user.id)

                self.coordinator.showHome()

            case .failure(let error):

                print(
                    "Google Login Failed:",
                    error.localizedDescription
                )

//                self.showError(
//                    message: error.localizedDescription
//                )
            }
        }
    }
}
