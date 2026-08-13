//
//  SignupViewController.swift
//  FlexX
//
//  Created by Dhaarani M on 09/08/26.
//

import UIKit
import SwiftData


final class SignupViewController: UIViewController {
    
    private let viewModel: SignupViewModel
    
    private let coordinator: AppCoordinator
    
    private var keyboardManager: KeyBoardManager?
    
    init(viewModel: SignupViewModel, coordinator: AppCoordinator) {

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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Header (matches LoginViewController)

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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.signupTitle
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.signupSubtitle
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemBackground.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private let nameLabel: UILabel = makeFieldLabel(text: L10n.signupNamelabel)

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.signupNametextfield
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let emailLabel: UILabel = makeFieldLabel(text: L10n.signupEmaillabel)

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.signupEmailtextfield
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let passwordLabel: UILabel = makeFieldLabel(text: L10n.signupPasswordlabel)

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.signupPasswordtextfield
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let confirmPasswordLabel: UILabel = makeFieldLabel(text: L10n.signupConfirmPasswordlabel)

    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.signupConfirmpasswordtextfield
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let dateOfBirthLabel: UILabel = makeFieldLabel(text: L10n.signupDoblabel)

    private let dateOfBirthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.signupDobfield
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.maximumDate = Date()
        return picker
    }()

    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)

        var configuration = UIButton.Configuration.filled()
        configuration.title = L10n.signupTitle
        configuration.cornerStyle = .medium

        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)

        var configuration = UIButton.Configuration.plain()
        configuration.title = L10n.signupLogin

        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()


    private static func makeFieldLabel(text: String) -> UILabel {

        let label = UILabel()

        label.text = text
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }


    private func makeLeftIconView(systemName: String) -> UIView {

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let imageView = UIImageView(
            image: UIImage(systemName: systemName)
        )

        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(imageView)

        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 36),
            container.heightAnchor.constraint(equalToConstant: 20),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            imageView.widthAnchor.constraint(equalToConstant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 16)
        ])

        return container
    }

    private func setupTextFieldIcons() {

        nameTextField.leftView = makeLeftIconView(systemName: "person")
        nameTextField.leftViewMode = .always

        emailTextField.leftView = makeLeftIconView(systemName: "envelope")
        emailTextField.leftViewMode = .always

        passwordTextField.leftView = makeLeftIconView(systemName: "lock")
        passwordTextField.leftViewMode = .always

        confirmPasswordTextField.leftView = makeLeftIconView(systemName: "lock")
        confirmPasswordTextField.leftViewMode = .always

        dateOfBirthTextField.leftView = makeLeftIconView(systemName: "calendar")
        dateOfBirthTextField.leftViewMode = .always
    }

    private func makePasswordToggleButton(action: Selector) -> UIButton {

        let button = UIButton(type: .system)

        button.setImage(
            UIImage(systemName: "eye.slash"),
            for: .normal
        )

        button.tintColor = .secondaryLabel

        button.addTarget(
            self,
            action: action,
            for: .touchUpInside
        )

        return button
    }

    private func setupPasswordButtons() {

        let passwordToggle = makePasswordToggleButton(
            action: #selector(togglePasswordVisibility)
        )

        passwordTextField.rightView = passwordToggle
        passwordTextField.rightViewMode = .always

        let confirmToggle = makePasswordToggleButton(
            action: #selector(toggleConfirmPasswordVisibility)
        )

        confirmPasswordTextField.rightView = confirmToggle
        confirmPasswordTextField.rightViewMode = .always
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardManager = KeyBoardManager(
            scrollView: scrollView,
            contentView: contentView,
            view: view
        )

        setupView()
        setupHierarchy()
        setupConstraints()
        setupDatePicker()
        setupTextFieldIcons()
        setupPasswordButtons()
        setupActions()
        keyboardManager?.setupKeyboardHandling()
        keyboardManager?.setupKeyboardDismissGesture()
    }


    private func setupView() {
        view.backgroundColor = .systemBackground

        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupHierarchy() {

        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        contentView.addSubview(headerView)

        headerView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)

        headerView.addSubview(titleLabel)
        headerView.addSubview(subtitleLabel)

        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)

        contentView.addSubview(emailLabel)
        contentView.addSubview(emailTextField)

        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextField)

        contentView.addSubview(confirmPasswordLabel)
        contentView.addSubview(confirmPasswordTextField)

        contentView.addSubview(dateOfBirthLabel)
        contentView.addSubview(dateOfBirthTextField)

        contentView.addSubview(createAccountButton)
        contentView.addSubview(loginButton)
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
                equalToConstant: 180
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

            titleLabel.topAnchor.constraint(
                equalTo: iconContainerView.bottomAnchor,
                constant: 14
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: headerView.leadingAnchor,
                constant: 20
            ),

            titleLabel.trailingAnchor.constraint(
                equalTo: headerView.trailingAnchor,
                constant: -20
            ),

            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 4
            ),

            subtitleLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),

            subtitleLabel.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor
            ),

            nameLabel.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: 24
            ),

            nameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 22
            ),

            nameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -22
            ),

            nameTextField.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: 6
            ),

            nameTextField.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            nameTextField.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            nameTextField.heightAnchor.constraint(
                equalToConstant: 52
            ),

            emailLabel.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor,
                constant: 16
            ),

            emailLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            emailLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            emailTextField.topAnchor.constraint(
                equalTo: emailLabel.bottomAnchor,
                constant: 6
            ),

            emailTextField.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            emailTextField.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            emailTextField.heightAnchor.constraint(
                equalToConstant: 52
            ),

            passwordLabel.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: 16
            ),

            passwordLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            passwordLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            passwordTextField.topAnchor.constraint(
                equalTo: passwordLabel.bottomAnchor,
                constant: 6
            ),

            passwordTextField.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            passwordTextField.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            passwordTextField.heightAnchor.constraint(
                equalToConstant: 52
            ),

            confirmPasswordLabel.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: 16
            ),

            confirmPasswordLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            confirmPasswordLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            confirmPasswordTextField.topAnchor.constraint(
                equalTo: confirmPasswordLabel.bottomAnchor,
                constant: 6
            ),

            confirmPasswordTextField.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            confirmPasswordTextField.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            confirmPasswordTextField.heightAnchor.constraint(
                equalToConstant: 52
            ),

            dateOfBirthLabel.topAnchor.constraint(
                equalTo: confirmPasswordTextField.bottomAnchor,
                constant: 16
            ),

            dateOfBirthLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            dateOfBirthLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            dateOfBirthTextField.topAnchor.constraint(
                equalTo: dateOfBirthLabel.bottomAnchor,
                constant: 6
            ),

            dateOfBirthTextField.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            dateOfBirthTextField.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            dateOfBirthTextField.heightAnchor.constraint(
                equalToConstant: 52
            ),

            createAccountButton.topAnchor.constraint(
                equalTo: dateOfBirthTextField.bottomAnchor,
                constant: 24
            ),

            createAccountButton.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            createAccountButton.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),

            createAccountButton.heightAnchor.constraint(
                equalToConstant: 52
            ),

            loginButton.topAnchor.constraint(
                equalTo: createAccountButton.bottomAnchor,
                constant: 16
            ),

            loginButton.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            loginButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -30
            )
        ])
    }


    private func setupDatePicker() {

        dateOfBirthTextField.inputView = datePicker

        datePicker.addTarget(
            self,
            action: #selector(dateChanged),
            for: .valueChanged
        )

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(datePickerDone)
        )

        toolbar.items = [
            flexibleSpace,
            doneButton
        ]

        dateOfBirthTextField.inputAccessoryView = toolbar
    }

    @objc private func dateChanged() {

        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        dateOfBirthTextField.text = formatter.string(
            from: datePicker.date
        )
    }

    @objc private func datePickerDone() {

        dateChanged()

        view.endEditing(true)
    }


    private func setupActions() {

        createAccountButton.addTarget(
            self,
            action: #selector(createAccountButtonTapped),
            for: .touchUpInside
        )

        loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
    }

    @objc private func createAccountButtonTapped() {

        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""

        if let errorMessage = viewModel.validate(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            dateOfBirth: datePicker.date
        ) {

            showAlert(message: errorMessage)
            return
        }

        if let errorMessage = viewModel.register(
            name: name,
            email: email,
            password: password,
            dateOfBirth: datePicker.date
        ) {

            showAlert(message: errorMessage)
            return
        }

        showRegistrationSuccess()
    }
    
    private func showRegistrationSuccess() {

        let alert = UIAlertController(
            title: L10n.signupAlerttitle,
            message: L10n.signupAlertmessage,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: L10n.signupAlerttologin,
                style: .default
            ) {[weak self] _ in
                
                self?.coordinator.showLogin()

//                self?.navigationController?.popViewController(
//                    animated: true
//                )
                
            }
        )

        present(alert, animated: true)
    }
    
    private func showAlert(message: String) {

        let alert = UIAlertController(
            title: L10n.signup,
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

    @objc private func loginButtonTapped() {

//        navigationController?.popViewController(
//            animated: true
//        )
        coordinator.showLogin()
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

    @objc private func toggleConfirmPasswordVisibility() {

        confirmPasswordTextField.isSecureTextEntry.toggle()

        let imageName = confirmPasswordTextField.isSecureTextEntry
            ? "eye.slash"
            : "eye"

        let button = confirmPasswordTextField.rightView as? UIButton

        button?.setImage(
            UIImage(systemName: imageName),
            for: .normal
        )

        button?.tintColor = .secondaryLabel
    }
    
    
}
