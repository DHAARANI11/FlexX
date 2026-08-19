//
//  ProfileEditableRowView.swift
//  FlexX
//
//  Created by Dhaarani M on 18/08/26.
//

import UIKit

final class ProfileEditableRowView: UIView, ProfileCardRow {

    enum InputKind {
        case text(keyboardType: UIKeyboardType, unit: String?)
        case picker(options: [String])
    }

    let separatorLeadingInset: CGFloat = 54

    var text: String? {
        get { valueField.text }
        set { valueField.text = newValue }
    }

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
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let valueField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.textAlignment = .right
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let unitLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let inputKind: InputKind
    private let pickerOptions: [String]
    private lazy var pickerView = UIPickerView()

    init(icon: String, iconTint: UIColor, title: String, inputKind: InputKind) {

        self.inputKind = inputKind

        if case .picker(let options) = inputKind {
            self.pickerOptions = options
        } else {
            self.pickerOptions = []
        }

        super.init(frame: .zero)

        iconContainerView.backgroundColor = iconTint.withAlphaComponent(0.15)

        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)
        iconImageView.image = UIImage(systemName: icon, withConfiguration: config)
        iconImageView.tintColor = iconTint

        titleLabel.text = title

        switch inputKind {

        case .text(let keyboardType, let unit):
            valueField.keyboardType = keyboardType
            unitLabel.text = unit
            unitLabel.isHidden = unit == nil

        case .picker:
            unitLabel.isHidden = true
            setupPickerInput()
        }
        valueField.isUserInteractionEnabled = false
        valueField.textColor = .secondaryLabel

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEditing(_ editing: Bool) {

        valueField.isUserInteractionEnabled = editing
        valueField.textColor = editing ? .label : .secondaryLabel
        underlineView.isHidden = !editing

        if !editing {
            valueField.resignFirstResponder()
        }
    }

    private func setupPickerInput() {

        pickerView.dataSource = self
        pickerView.delegate = self

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
            action: #selector(pickerDoneTapped)
        )

        toolbar.items = [flexibleSpace, doneButton]

        valueField.inputView = pickerView
        valueField.inputAccessoryView = toolbar
        valueField.tintColor = .clear
    }

    @objc private func pickerDoneTapped() {

        let selectedIndex = pickerView.selectedRow(inComponent: 0)

        if pickerOptions.indices.contains(selectedIndex) {
            valueField.text = pickerOptions[selectedIndex]
        }

        valueField.resignFirstResponder()
    }

    private func setup() {

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(valueField)
        addSubview(unitLabel)
        addSubview(underlineView)

        heightAnchor.constraint(
            equalToConstant: 50
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

            titleLabel.widthAnchor.constraint(
                equalToConstant: 60
            ),

            unitLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -14
            ),

            unitLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),

            valueField.trailingAnchor.constraint(
                equalTo: unitLabel.isHidden ? trailingAnchor : unitLabel.leadingAnchor,
                constant: -6
            ),

            valueField.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: -4
            ),

            valueField.leadingAnchor.constraint(
                greaterThanOrEqualTo: titleLabel.trailingAnchor,
                constant: 8
            ),

            underlineView.leadingAnchor.constraint(
                equalTo: valueField.leadingAnchor
            ),

            underlineView.trailingAnchor.constraint(
                equalTo: valueField.trailingAnchor
            ),

            underlineView.topAnchor.constraint(
                equalTo: valueField.bottomAnchor,
                constant: 2
            ),

            underlineView.heightAnchor.constraint(
                equalToConstant: 1
            )
        ])
    }
}


extension ProfileEditableRowView: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerOptions.indices.contains(row) {
            valueField.text = pickerOptions[row]
        }
    }
}
