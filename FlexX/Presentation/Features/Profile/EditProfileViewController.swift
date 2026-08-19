//
//  EditProfileViewController.swift
//  FlexX
//
//  Created by Dhaarani M on 14/08/26.
//

import UIKit
import PhotosUI

final class EditProfileViewController: UIViewController {

    private let viewModel: EditProfileViewModel
    private let coordinator: AppCoordinator

    private var selectedImage: UIImage?

    init(viewModel: EditProfileViewModel, coordinator: AppCoordinator) {

        self.viewModel = viewModel
        self.coordinator = coordinator

        super.init(nibName: nil, bundle: nil)
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

    private let photoImageView: UIImageView = {

        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = 48
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let photoPlaceholderImageView: UIImageView = {

        let config = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let imageView = UIImageView(
            image: UIImage(systemName: "person.fill", withConfiguration: config)
        )

        imageView.tintColor = .tertiaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let cameraBadgeButton: UIButton = {

        let button = UIButton(type: .system)

        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.tintColor = .white

        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
        button.setImage(
            UIImage(systemName: "camera.fill", withConfiguration: config),
            for: .normal
        )

        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let nameLabel: UILabel =
        EditProfileViewController.makeFieldLabel(
            text: "Name"
        )

    private let nameTextField: UITextField = {

        let textField = UITextField()

        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let heightLabel: UILabel = EditProfileViewController.makeFieldLabel(text: "Height (cm)")

    private let heightTextField: UITextField = {

        let textField = UITextField()

        textField.placeholder = "e.g. 170"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let weightLabel: UILabel = EditProfileViewController.makeFieldLabel(text: "Weight (kg)")

    private let weightTextField: UITextField = {

        let textField = UITextField()

        textField.placeholder = "e.g. 60"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let genderLabel: UILabel = EditProfileViewController.makeFieldLabel(text: "Gender")

    private let genderSegmentedControl: UISegmentedControl = {

        let control = UISegmentedControl(items: ["Male", "Female", "Other"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let saveButton: UIButton = {

        let button = UIButton(type: .system)

        var configuration = UIButton.Configuration.filled()
        configuration.title = "Save Changes"
        configuration.cornerStyle = .medium

        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupConstraints()
        setupActions()

        viewModel.loadUser()
        bindUser()
    }

    private func setupView() {

        view.backgroundColor = .systemBackground

        title = "Edit Profile"
        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupHierarchy() {

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(photoImageView)
        photoImageView.addSubview(photoPlaceholderImageView)
        contentView.addSubview(cameraBadgeButton)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)

        contentView.addSubview(heightLabel)
        contentView.addSubview(heightTextField)

        contentView.addSubview(weightLabel)
        contentView.addSubview(weightTextField)

        contentView.addSubview(genderLabel)
        contentView.addSubview(genderSegmentedControl)

        contentView.addSubview(saveButton)
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

            photoImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 24
            ),

            photoImageView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            photoImageView.widthAnchor.constraint(
                equalToConstant: 96
            ),

            photoImageView.heightAnchor.constraint(
                equalToConstant: 96
            ),

            photoPlaceholderImageView.centerXAnchor.constraint(
                equalTo: photoImageView.centerXAnchor
            ),

            photoPlaceholderImageView.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor
            ),

            cameraBadgeButton.trailingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 2
            ),

            cameraBadgeButton.bottomAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 2
            ),

            cameraBadgeButton.widthAnchor.constraint(
                equalToConstant: 28
            ),

            cameraBadgeButton.heightAnchor.constraint(
                equalToConstant: 28
            ),

            nameLabel.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 32
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
                equalToConstant: 48
            ),

            heightLabel.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor,
                constant: 16
            ),

            heightLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 22
            ),

            heightLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -22
            ),

            heightTextField.topAnchor.constraint(
                equalTo: heightLabel.bottomAnchor,
                constant: 6
            ),

            heightTextField.leadingAnchor.constraint(
                equalTo: heightLabel.leadingAnchor
            ),

            heightTextField.trailingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor
            ),

            heightTextField.heightAnchor.constraint(
                equalToConstant: 48
            ),

            weightLabel.topAnchor.constraint(
                equalTo: heightTextField.bottomAnchor,
                constant: 16
            ),

            weightLabel.leadingAnchor.constraint(
                equalTo: heightLabel.leadingAnchor
            ),

            weightLabel.trailingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor
            ),

            weightTextField.topAnchor.constraint(
                equalTo: weightLabel.bottomAnchor,
                constant: 6
            ),

            weightTextField.leadingAnchor.constraint(
                equalTo: heightLabel.leadingAnchor
            ),

            weightTextField.trailingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor
            ),

            weightTextField.heightAnchor.constraint(
                equalToConstant: 48
            ),

            genderLabel.topAnchor.constraint(
                equalTo: weightTextField.bottomAnchor,
                constant: 16
            ),

            genderLabel.leadingAnchor.constraint(
                equalTo: heightLabel.leadingAnchor
            ),

            genderLabel.trailingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor
            ),

            genderSegmentedControl.topAnchor.constraint(
                equalTo: genderLabel.bottomAnchor,
                constant: 8
            ),

            genderSegmentedControl.leadingAnchor.constraint(
                equalTo: heightLabel.leadingAnchor
            ),

            genderSegmentedControl.trailingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor
            ),

            saveButton.topAnchor.constraint(
                equalTo: genderSegmentedControl.bottomAnchor,
                constant: 32
            ),

            saveButton.leadingAnchor.constraint(
                equalTo: heightLabel.leadingAnchor
            ),

            saveButton.trailingAnchor.constraint(
                equalTo: heightLabel.trailingAnchor
            ),

            saveButton.heightAnchor.constraint(
                equalToConstant: 52
            ),

            saveButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -32
            )
        ])
    }

    private func setupActions() {

        cameraBadgeButton.addTarget(
            self,
            action: #selector(cameraBadgeTapped),
            for: .touchUpInside
        )

        saveButton.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside
        )
    }

    @objc private func cameraBadgeTapped() {
        presentPhotoPicker()
    }

    @objc private func saveButtonTapped() {
        
        let name = nameTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if name.isEmpty {
            showAlert(message: "Please enter your name")
            return
        }

        let height = Double(
            heightTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        )

        let weight = Double(
            weightTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        )

        let gender: String? = {
            switch genderSegmentedControl.selectedSegmentIndex {
            case 0: return "Male"
            case 1: return "Female"
            case 2: return "Other"
            default: return nil
            }
        }()
        
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)

        if let errorMessage = viewModel.save(
            name: name,
            height: height,
            weight: weight,
            gender: gender,
            profileImageData: imageData
        ) {
            showAlert(message: errorMessage)
            return
        }

        navigationController?.popViewController(animated: true)
    }

    private func presentPhotoPicker() {

        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self

        present(picker, animated: true)
    }

    private func bindUser() {

        guard let user = viewModel.user else {
            return
        }
        
        nameTextField.text = user.name

        if let height = user.height {
            heightTextField.text = String(height)
        }

        if let weight = user.weight {
            weightTextField.text = String(weight)
        }

        switch user.gender?.lowercased() {
        case "male":
            genderSegmentedControl.selectedSegmentIndex = 0
        case "female":
            genderSegmentedControl.selectedSegmentIndex = 1
        case "other":
            genderSegmentedControl.selectedSegmentIndex = 2
        default:
            genderSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        }

        if let data = user.profileImageData, let image = UIImage(data: data) {
            photoImageView.image = image
            photoPlaceholderImageView.isHidden = true
        } else {
            photoImageView.image = nil
            photoPlaceholderImageView.isHidden = false
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

    private static func makeFieldLabel(text: String) -> UILabel {

        let label = UILabel()

        label.text = text
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }
}

extension EditProfileViewController: PHPickerViewControllerDelegate {

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
                self.selectedImage = image
                self.photoImageView.image = image
                self.photoPlaceholderImageView.isHidden = true
            }
        }
    }
}
