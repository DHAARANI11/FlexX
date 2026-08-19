//
//  WorkoutTypeCell.swift
//  FlexX
//
//  Created by Dhaarani M on 17/08/26.
//

import UIKit

final class WorkoutTypeCell: UICollectionViewCell {

    static let identifier = "WorkoutTypeCell"

    private let iconContainer: UIView = {

        let view = UIView()

        view.backgroundColor =
            .secondarySystemBackground

        view.layer.cornerRadius = 28

        return view
    }()

    private let iconImageView: UIImageView = {

        let imageView = UIImageView()

        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let titleLabel: UILabel = {

        let label = UILabel()

        label.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )

        label.textColor = .label

        return label
    }()

    private let subtitleLabel: UILabel = {

        let label = UILabel()

        label.font = .systemFont(
            ofSize: 14
        )

        label.textColor = .secondaryLabel

        return label
    }()

    private let arrowImageView: UIImageView = {

        let imageView = UIImageView(
            image: UIImage(
                systemName: "chevron.right"
            )
        )

        imageView.tintColor = .secondaryLabel

        return imageView
    }()

    override init(
        frame: CGRect
    ) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }

    private func setupUI() {

        contentView.backgroundColor =
            .secondarySystemBackground

        contentView.layer.cornerRadius = 18

        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)

        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(arrowImageView)

        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            iconContainer.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),

            iconContainer.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),

            iconContainer.widthAnchor.constraint(
                equalToConstant: 56
            ),

            iconContainer.heightAnchor.constraint(
                equalToConstant: 56
            ),

            iconImageView.centerXAnchor.constraint(
                equalTo: iconContainer.centerXAnchor
            ),

            iconImageView.centerYAnchor.constraint(
                equalTo: iconContainer.centerYAnchor
            ),

            iconImageView.widthAnchor.constraint(
                equalToConstant: 26
            ),

            iconImageView.heightAnchor.constraint(
                equalToConstant: 26
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: iconContainer.trailingAnchor,
                constant: 16
            ),

            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 25
            ),

            subtitleLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),

            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 4
            ),

            arrowImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -18
            ),

            arrowImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),

            titleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo:
                    arrowImageView.leadingAnchor,
                constant: -10
            )
        ])
    }

    func configure(
        with workoutType: WorkoutType
    ) {

        titleLabel.text = workoutType.title
        subtitleLabel.text = workoutType.subtitle

        iconImageView.image =
            UIImage(
                systemName: workoutType.iconName
            )
    }
}
