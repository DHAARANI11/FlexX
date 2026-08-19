//
//  ProfileViewController.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//

import UIKit
import PhotosUI

final class ProfileViewController: UIViewController {

    private let viewModel: ProfileViewModel
    private let editProfileViewModel: EditProfileViewModel
    private let coordinator: AppCoordinator

    private var pendingImage: UIImage?

    private var editSnapshot: (name: String?, height: String?, weight: String?, gender: String?)?

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

    private let profileImageView: UIImageView = {

        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 42
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let initialsBackgroundView: UIView = {

        let view = UIView()

        view.backgroundColor = .systemBlue.withAlphaComponent(0.15)
        view.layer.cornerRadius = 42
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let initialsLabel: UILabel = {

        let label = UILabel()

        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let cameraBadgeButton: UIButton = {

        let button = UIButton(type: .system)

        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.tintColor = .white

        let config = UIImage.SymbolConfiguration(pointSize: 11, weight: .semibold)
        button.setImage(
            UIImage(systemName: "camera.fill", withConfiguration: config),
            for: .normal
        )

        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let nameField: UITextField = {

        let textField = UITextField()

        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 19, weight: .semibold)
        textField.isUserInteractionEnabled = false
        textField.adjustsFontForContentSizeCategory = true
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let emailLabel: UILabel = {

        let label = UILabel()

        label.text = "Email"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()


    private let personalInformationLabel: UILabel = ProfileViewController.makeSectionHeaderLabel(
        text: L10n.personalInformation
    )

    private let cancelEditButton: UIButton = {

        let button = UIButton(type: .system)

        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 13
        button.tintColor = .systemRed
        button.isHidden = true

        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        button.setImage(
            UIImage(systemName: "xmark", withConfiguration: config),
            for: .normal
        )

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let editPencilButton: UIButton = {

        let button = UIButton(type: .system)

        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 13
        button.tintColor = .label

        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)
        button.setImage(
            UIImage(systemName: "pencil", withConfiguration: config),
            for: .normal
        )

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let informationCardView = ProfileCardView()

    private let heightRow = ProfileEditableRowView(
        icon: "ruler",
        iconTint: .systemBlue,
        title: L10n.profileHeight,
        inputKind: .text(keyboardType: .decimalPad, unit: "cm")
    )

    private let weightRow = ProfileEditableRowView(
        icon: "scalemass",
        iconTint: .systemGreen,
        title: L10n.profileWeight,
        inputKind: .text(keyboardType: .decimalPad, unit: "kg")
    )

    private let genderRow = ProfileEditableRowView(
        icon: "person.2",
        iconTint: .systemOrange,
        title: L10n.profileGender,
        inputKind: .picker(options: ["Male", "Female", "Other"])
    )

    private let caloriesHeaderLabel: UILabel = ProfileViewController.makeSectionHeaderLabel(
        text: "Total Calories Burned"
    )

    private let caloriesCardView: UIView = {

        let view = UIView()

        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let caloriesGradientLayer: CAGradientLayer = {

        let layer = CAGradientLayer()

        layer.colors = [
            UIColor.systemOrange.cgColor,
            UIColor.systemRed.cgColor
        ]

        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.cornerRadius = 14

        return layer
    }()

    private let flameChipView: UIView = {

        let view = UIView()

        view.backgroundColor = UIColor.white.withAlphaComponent(0.18)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let flameImageView: UIImageView = {

        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        let imageView = UIImageView(
            image: UIImage(systemName: "flame.fill", withConfiguration: config)
        )

        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let caloriesValueLabel: UILabel = {

        let label = UILabel()

        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let caloriesCaptionLabel: UILabel = {

        let label = UILabel()

        label.text = "kcal burned"
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.85)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let settingsHeaderLabel: UILabel = ProfileViewController.makeSectionHeaderLabel(
        text: "App Settings"
    )

    private let settingsCardView = ProfileCardView()

    private let languageRow = ProfileRowView(
        icon: "globe",
        iconTint: .systemBlue,
        title: "Change Language",
        style: .navigation
    )

    private let logoutRow = ProfileRowView(
        icon: "rectangle.portrait.and.arrow.right",
        iconTint: .systemRed,
        title: "Logout",
        style: .destructive
    )


    init(
        viewModel: ProfileViewModel,
        editProfileViewModel: EditProfileViewModel,
        coordinator: AppCoordinator
    ) {

        self.viewModel = viewModel
        self.editProfileViewModel = editProfileViewModel
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
        setupActions()
        setupKeyboardHandling()
        bindViewModel()

        editProfileViewModel.loadUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !isEditing {
            bindViewModel()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        caloriesGradientLayer.frame = caloriesCardView.bounds
    }
    
    func setupView() {

        view.backgroundColor = .systemBackground
        
        title = L10n.tabProfile
    }

    func setupHierarchy() {

        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        contentView.addSubview(initialsBackgroundView)
        initialsBackgroundView.addSubview(initialsLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(cameraBadgeButton)

        contentView.addSubview(nameField)
        contentView.addSubview(emailLabel)

        contentView.addSubview(personalInformationLabel)
        contentView.addSubview(cancelEditButton)
        contentView.addSubview(editPencilButton)
        contentView.addSubview(informationCardView)

        informationCardView.addRows([heightRow, weightRow, genderRow])

        contentView.addSubview(caloriesHeaderLabel)
        contentView.addSubview(caloriesCardView)

        caloriesCardView.layer.insertSublayer(caloriesGradientLayer, at: 0)

        caloriesCardView.addSubview(flameChipView)
        flameChipView.addSubview(flameImageView)
        caloriesCardView.addSubview(caloriesValueLabel)
        caloriesCardView.addSubview(caloriesCaptionLabel)

        contentView.addSubview(settingsHeaderLabel)
        contentView.addSubview(settingsCardView)

        settingsCardView.addRows([languageRow, logoutRow])
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

            initialsBackgroundView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),

            initialsBackgroundView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            initialsBackgroundView.widthAnchor.constraint(
                equalToConstant: 84
            ),

            initialsBackgroundView.heightAnchor.constraint(
                equalToConstant: 84
            ),

            initialsLabel.centerXAnchor.constraint(
                equalTo: initialsBackgroundView.centerXAnchor
            ),

            initialsLabel.centerYAnchor.constraint(
                equalTo: initialsBackgroundView.centerYAnchor
            ),

            profileImageView.topAnchor.constraint(
                equalTo: initialsBackgroundView.topAnchor
            ),

            profileImageView.leadingAnchor.constraint(
                equalTo: initialsBackgroundView.leadingAnchor
            ),

            profileImageView.trailingAnchor.constraint(
                equalTo: initialsBackgroundView.trailingAnchor
            ),

            profileImageView.bottomAnchor.constraint(
                equalTo: initialsBackgroundView.bottomAnchor
            ),

            cameraBadgeButton.trailingAnchor.constraint(
                equalTo: initialsBackgroundView.trailingAnchor,
                constant: 2
            ),

            cameraBadgeButton.bottomAnchor.constraint(
                equalTo: initialsBackgroundView.bottomAnchor,
                constant: 2
            ),

            cameraBadgeButton.widthAnchor.constraint(
                equalToConstant: 24
            ),

            cameraBadgeButton.heightAnchor.constraint(
                equalToConstant: 24
            ),
            
            nameField.topAnchor.constraint(
                equalTo: initialsBackgroundView.bottomAnchor,
                constant: 12
            ),
            
            nameField.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 24
            ),
            
            nameField.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24
            ),
            
            emailLabel.topAnchor.constraint(
                equalTo: nameField.bottomAnchor,
                constant: 3
            ),
            
            emailLabel.leadingAnchor.constraint(
                equalTo: nameField.leadingAnchor
            ),
            
            emailLabel.trailingAnchor.constraint(
                equalTo: nameField.trailingAnchor
            ),

            personalInformationLabel.topAnchor.constraint(
                equalTo: emailLabel.bottomAnchor,
                constant: 26
            ),
            
            personalInformationLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),

            personalInformationLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: cancelEditButton.leadingAnchor,
                constant: -8
            ),

            editPencilButton.centerYAnchor.constraint(
                equalTo: personalInformationLabel.centerYAnchor
            ),

            editPencilButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),

            editPencilButton.widthAnchor.constraint(
                equalToConstant: 26
            ),

            editPencilButton.heightAnchor.constraint(
                equalToConstant: 26
            ),

            cancelEditButton.centerYAnchor.constraint(
                equalTo: editPencilButton.centerYAnchor
            ),

            cancelEditButton.trailingAnchor.constraint(
                equalTo: editPencilButton.leadingAnchor,
                constant: -8
            ),

            cancelEditButton.widthAnchor.constraint(
                equalToConstant: 26
            ),

            cancelEditButton.heightAnchor.constraint(
                equalToConstant: 26
            ),
            
            informationCardView.topAnchor.constraint(
                equalTo: personalInformationLabel.bottomAnchor,
                constant: 8
            ),
            
            informationCardView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 18
            ),
            
            informationCardView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -18
            ),

            caloriesHeaderLabel.topAnchor.constraint(
                equalTo: informationCardView.bottomAnchor,
                constant: 20
            ),

            caloriesHeaderLabel.leadingAnchor.constraint(
                equalTo: personalInformationLabel.leadingAnchor
            ),

            caloriesHeaderLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),

            caloriesCardView.topAnchor.constraint(
                equalTo: caloriesHeaderLabel.bottomAnchor,
                constant: 8
            ),

            caloriesCardView.leadingAnchor.constraint(
                equalTo: informationCardView.leadingAnchor
            ),

            caloriesCardView.trailingAnchor.constraint(
                equalTo: informationCardView.trailingAnchor
            ),

            flameChipView.leadingAnchor.constraint(
                equalTo: caloriesCardView.leadingAnchor,
                constant: 14
            ),

            flameChipView.centerYAnchor.constraint(
                equalTo: caloriesCardView.centerYAnchor
            ),

            flameChipView.widthAnchor.constraint(
                equalToConstant: 40
            ),

            flameChipView.heightAnchor.constraint(
                equalToConstant: 40
            ),

            flameImageView.centerXAnchor.constraint(
                equalTo: flameChipView.centerXAnchor
            ),

            flameImageView.centerYAnchor.constraint(
                equalTo: flameChipView.centerYAnchor
            ),

            caloriesValueLabel.leadingAnchor.constraint(
                equalTo: flameChipView.trailingAnchor,
                constant: 12
            ),

            caloriesValueLabel.topAnchor.constraint(
                equalTo: caloriesCardView.topAnchor,
                constant: 16
            ),

            caloriesValueLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: caloriesCardView.trailingAnchor,
                constant: -14
            ),

            caloriesCaptionLabel.leadingAnchor.constraint(
                equalTo: caloriesValueLabel.leadingAnchor
            ),

            caloriesCaptionLabel.topAnchor.constraint(
                equalTo: caloriesValueLabel.bottomAnchor,
                constant: 3
            ),

            caloriesCaptionLabel.bottomAnchor.constraint(
                equalTo: caloriesCardView.bottomAnchor,
                constant: -16
            ),

            settingsHeaderLabel.topAnchor.constraint(
                equalTo: caloriesCardView.bottomAnchor,
                constant: 20
            ),

            settingsHeaderLabel.leadingAnchor.constraint(
                equalTo: personalInformationLabel.leadingAnchor
            ),

            settingsHeaderLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),

            settingsCardView.topAnchor.constraint(
                equalTo: settingsHeaderLabel.bottomAnchor,
                constant: 8
            ),

            settingsCardView.leadingAnchor.constraint(
                equalTo: informationCardView.leadingAnchor
            ),

            settingsCardView.trailingAnchor.constraint(
                equalTo: informationCardView.trailingAnchor
            ),

            settingsCardView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -32
            )
        ])
    }
        
    func setupActions() {

        editPencilButton.addTarget(
            self,
            action: #selector(editPencilTapped),
            for: .touchUpInside
        )

        cancelEditButton.addTarget(
            self,
            action: #selector(cancelEditTapped),
            for: .touchUpInside
        )

        cameraBadgeButton.addTarget(
            self,
            action: #selector(cameraBadgeTapped),
            for: .touchUpInside
        )

        languageRow.onTap = { [weak self] in
            self?.coordinator.showLanguageSettings()
        }

        logoutRow.onTap = { [weak self] in
            self?.logoutTapped()
        }
    }

    private func setupKeyboardHandling() {

        let tapToDismiss = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tapToDismiss.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapToDismiss)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {

        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        scrollView.contentInset.bottom = frame.height
        scrollView.verticalScrollIndicatorInsets.bottom = frame.height
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    @objc private func editPencilTapped() {

        if isEditing {
            saveEdits()
        } else {
            enterEditMode()
        }
    }

    private func enterEditMode() {

        isEditing = true

        editSnapshot = (
            name: nameField.text,
            height: heightRow.text,
            weight: weightRow.text,
            gender: genderRow.text
        )

        nameField.isUserInteractionEnabled = true
        nameField.textColor = .label

        heightRow.setEditing(true)
        weightRow.setEditing(true)
        genderRow.setEditing(true)

        updateEditButtonAppearance()
    }

    @objc private func cancelEditTapped() {

        if let snapshot = editSnapshot {
            nameField.text = snapshot.name
            heightRow.text = snapshot.height
            weightRow.text = snapshot.weight
            genderRow.text = snapshot.gender
        }

        pendingImage = nil

        exitEditMode()
        bindViewModel() 
    }

    private func saveEdits() {

        let name = nameField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if name.isEmpty {
            showAlert(message: "Please enter your name")
            return
        }

        let height = Double(
            heightRow.text?.trimmingCharacters(in: .whitespaces) ?? ""
        )

        let weight = Double(
            weightRow.text?.trimmingCharacters(in: .whitespaces) ?? ""
        )

        let gender = genderRow.text?.isEmpty == false ? genderRow.text : nil

        let imageData = pendingImage?.jpegData(compressionQuality: 0.8)
        
        print("Saving with user id:", editProfileViewModel.user?.id.uuidString ?? "NIL")

        if let errorMessage = editProfileViewModel.save(
            name: name,
            height: height,
            weight: weight,
            gender: gender,
            profileImageData: imageData
        ) {
            showAlert(message: errorMessage)
            return
        }

        pendingImage = nil

        exitEditMode()
        bindViewModel()
    }

    private func exitEditMode() {

        isEditing = false

        nameField.isUserInteractionEnabled = false
        nameField.textColor = .label

        heightRow.setEditing(false)
        weightRow.setEditing(false)
        genderRow.setEditing(false)

        updateEditButtonAppearance()

        view.endEditing(true)
    }

    private func updateEditButtonAppearance() {

        let symbolName = isEditing ? "checkmark" : "pencil"
        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)

        editPencilButton.setImage(
            UIImage(systemName: symbolName, withConfiguration: config),
            for: .normal
        )

        editPencilButton.backgroundColor = isEditing ? .systemBlue : .secondarySystemBackground
        editPencilButton.tintColor = isEditing ? .white : .label

        cancelEditButton.isHidden = !isEditing
    }


    @objc private func cameraBadgeTapped() {

        if !isEditing {
            enterEditMode()
        }

        presentPhotoPicker()
    }

    private func presentPhotoPicker() {

        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self

        present(picker, animated: true)
    }
        
    private func logoutTapped() {
            
        SessionManager.shared.logout()
            
        coordinator.start()
    }
        
    func bindViewModel() {
            
        viewModel.loadProfile()
        
        nameField.text = viewModel.name
        emailLabel.text = viewModel.email
            
        heightRow.text = viewModel.heightText
        weightRow.text = viewModel.weightText
        genderRow.text = viewModel.genderText

        caloriesValueLabel.text = "1000"

        if let image = viewModel.profileImage {

            profileImageView.image = image
            profileImageView.isHidden = false
            initialsBackgroundView.isHidden = true

        } else {

            profileImageView.isHidden = true
            initialsBackgroundView.isHidden = false
            initialsLabel.text = Self.initials(from: viewModel.name)
        }
    }

    private func showAlert(message: String) {

        let alert = UIAlertController(
            title: "Edit Profile",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )

        present(alert, animated: true)
    }


    private static func makeSectionHeaderLabel(text: String) -> UILabel {

        let label = UILabel()

        label.attributedText = NSAttributedString(
            string: text.uppercased(),
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .semibold),
                .foregroundColor: UIColor.secondaryLabel,
                .kern: 0.3
            ]
        )

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }

    private static func initials(from name: String) -> String {

        let parts = name
            .split(separator: " ")
            .prefix(2)
            .compactMap { $0.first }

        let initials = String(parts)

        return initials.isEmpty ? "?" : initials.uppercased()
    }
}



extension ProfileViewController: PHPickerViewControllerDelegate {

    func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {

        picker.dismiss(animated: true)

        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self)
        else {
            return
        }

        provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in

            guard let self, let image = object as? UIImage else {
                return
            }

            DispatchQueue.main.async {
                self.pendingImage = image
                self.profileImageView.image = image
                self.profileImageView.isHidden = false
                self.initialsBackgroundView.isHidden = true
            }
        }
    }
}


final class ProfileCardView: UIView {

    private let stackView: UIStackView = {

        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 14
        clipsToBounds = true

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func addRows(_ rows: [ProfileCardRow]) {

        for (index, row) in rows.enumerated() {

            stackView.addArrangedSubview(row)

            if index < rows.count - 1 {
                stackView.addArrangedSubview(makeSeparator(leadingInset: row.separatorLeadingInset))
            }
        }
    }

    private func makeSeparator(leadingInset: CGFloat) -> UIView {

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let separator = UIView()
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(separator)

        NSLayoutConstraint.activate([

            container.heightAnchor.constraint(equalToConstant: 0.5),

            separator.topAnchor.constraint(equalTo: container.topAnchor),
            separator.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            separator.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            separator.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: leadingInset)
        ])

        return container
    }
}

protocol ProfileCardRow: UIView {
    var separatorLeadingInset: CGFloat { get }
}


final class ProfileRowView: UIView, ProfileCardRow {

    enum Style: Equatable {
        case info
        case navigation
        case destructive
    }

    var onTap: (() -> Void)?

    let separatorLeadingInset: CGFloat = 54

    private let iconContainerView: UIView = {

        let view = UIView()

        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let iconImageView: UIImageView = {

        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let titleLabel: UILabel = {

        let label = UILabel()

        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let valueLabel: UILabel = {

        let label = UILabel()

        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let chevronImageView: UIImageView = {

        let imageView = UIImageView(
            image: UIImage(systemName: "chevron.right")
        )

        imageView.tintColor = .tertiaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    init(icon: String, iconTint: UIColor, title: String, style: Style) {

        super.init(frame: .zero)

        iconContainerView.backgroundColor = iconTint.withAlphaComponent(0.15)

        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)
        iconImageView.image = UIImage(systemName: icon, withConfiguration: config)
        iconImageView.tintColor = iconTint

        titleLabel.text = title

        switch style {

        case .info:
            titleLabel.textColor = .label
            chevronImageView.isHidden = true

        case .navigation:
            titleLabel.textColor = .label
            chevronImageView.isHidden = false

        case .destructive:
            titleLabel.textColor = .systemRed
            valueLabel.isHidden = true
            chevronImageView.isHidden = true
        }

        setup(style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(style: Style) {

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(chevronImageView)

        heightAnchor.constraint(
            equalToConstant: 52
        ).isActive = true

        NSLayoutConstraint.activate([

            iconContainerView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 14
            ),

            iconContainerView.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),

            iconContainerView.widthAnchor.constraint(
                equalToConstant: 26
            ),

            iconContainerView.heightAnchor.constraint(
                equalToConstant: 26
            ),

            iconImageView.centerXAnchor.constraint(
                equalTo: iconContainerView.centerXAnchor
            ),

            iconImageView.centerYAnchor.constraint(
                equalTo: iconContainerView.centerYAnchor
            ),

            iconImageView.widthAnchor.constraint(
                equalToConstant: 15
            ),

            iconImageView.heightAnchor.constraint(
                equalToConstant: 15
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: iconContainerView.trailingAnchor,
                constant: 10
            ),

            titleLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),

            chevronImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -14
            ),

            chevronImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),

            chevronImageView.widthAnchor.constraint(
                equalToConstant: 12
            ),

            chevronImageView.heightAnchor.constraint(
                equalToConstant: 12
            ),

            valueLabel.trailingAnchor.constraint(
                equalTo: style == .navigation
                    ? chevronImageView.leadingAnchor
                    : trailingAnchor,
                constant: -8
            ),

            valueLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),

            valueLabel.leadingAnchor.constraint(
                greaterThanOrEqualTo: titleLabel.trailingAnchor,
                constant: 8
            )
        ])

        if style != .info {

            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(handleTap)
            )

            addGestureRecognizer(tapGesture)
            isUserInteractionEnabled = true
        }
    }

    func setValue(_ value: String) {
        valueLabel.text = value
    }

    @objc private func handleTap() {
        onTap?()
    }
}
