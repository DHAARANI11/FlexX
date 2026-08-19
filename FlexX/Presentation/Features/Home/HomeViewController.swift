//
//  HomeViewController.swift
//  FlexX
//
//  Created by Dhaarani M on 10/08/26.
//

import UIKit

final class HomeViewController: UIViewController {

    private let viewModel: HomeViewModel
    private let coordinator: AppCoordinator

    private let greetingLabel: UILabel = {

        let label = UILabel()

        label.font = .systemFont(
            ofSize: 28,
            weight: .bold
        )

        label.textColor = .label
        label.numberOfLines = 0

        return label
    }()

    private let sectionLabel: UILabel = {

        let label = UILabel()

        label.text = "Choose your workout"
        label.font = .systemFont(
            ofSize: 22,
            weight: .semibold
        )

        label.textColor = .label

        return label
    }()

    private lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ in

                let itemSize =
                    NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(100)
                    )

                let item =
                    NSCollectionLayoutItem(
                        layoutSize: itemSize
                    )

                let group =
                    NSCollectionLayoutGroup.vertical(
                        layoutSize: itemSize,
                        subitems: [item]
                    )

                let section =
                    NSCollectionLayoutSection(
                        group: group
                    )

                section.interGroupSpacing = 14

                return section
            }
        )

        let collectionView =
            UICollectionView(
                frame: .zero,
                collectionViewLayout: layout
            )

        collectionView.backgroundColor = .clear

        collectionView.register(
            WorkoutTypeCell.self,
            forCellWithReuseIdentifier:
                WorkoutTypeCell.identifier
        )

        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    init(
        viewModel: HomeViewModel,
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

        view.backgroundColor = .systemBackground

        setupHierarchy()
        setupConstraints()

        viewModel.loadUser()
        //updateUI()
    }
    
    private func setupHierarchy() {

        view.addSubview(greetingLabel)
        view.addSubview(sectionLabel)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {

        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            greetingLabel.topAnchor.constraint(
                equalTo:
                    view.safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),

            greetingLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),

            greetingLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),

            sectionLabel.topAnchor.constraint(
                equalTo: greetingLabel.bottomAnchor,
                constant: 28
            ),

            sectionLabel.leadingAnchor.constraint(
                equalTo: greetingLabel.leadingAnchor
            ),

            collectionView.topAnchor.constraint(
                equalTo: sectionLabel.bottomAnchor,
                constant: 16
            ),

            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),

            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),

            collectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}

extension HomeViewController:
    UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        workoutTypes.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier:
                    WorkoutTypeCell.identifier,
                for: indexPath
            ) as! WorkoutTypeCell

        cell.configure(
            with: workoutTypes[indexPath.item]
        )

        return cell
    }
}

extension HomeViewController:
    UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {

        let workoutType =
            workoutTypes[indexPath.item]

        coordinator.showWorkoutCategories()
    }
}
