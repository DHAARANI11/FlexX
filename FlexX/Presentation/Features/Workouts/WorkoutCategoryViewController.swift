//
//  WorkoutCategoryViewController.swift
//  FlexX
//
//  Created by Dhaarani M on 17/08/26.
//

import UIKit

final class WorkoutCategoryViewController: UIViewController {
    
    private let viewModel: WorkoutCategoryViewModel
    private let coordinator: AppCoordinator
    
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Strength Training"
        
        label.font = .systemFont(
            ofSize: 28,
            weight: .bold
        )
        
        label.textColor = .label
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Choose a muscle group to start your workout"
        
        label.font = .systemFont(
            ofSize: 15,
            weight: .regular
        )
        
        label.textColor = .secondaryLabel
        
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = createCollectionViewLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.backgroundColor =
            .systemBackground
        
        collectionView.showsVerticalScrollIndicator =
        false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            WorkoutTypeCell.self,
            forCellWithReuseIdentifier:
                WorkoutTypeCell.identifier
        )
        
        return collectionView
    }()
    
    init(
        viewModel: WorkoutCategoryViewModel,
        coordinator: AppCoordinator
    ) {
        
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(
        coder: NSCoder
    ) {
        
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =
            .systemBackground
        
        //setupNavigationBar()
        setupHierarchy()
        setupConstraints()
        bindViewModel()
        
        viewModel.loadCategories()
    }
}
    
private extension WorkoutCategoryViewController {

    func setupHierarchy() {

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(collectionView)
    }
}
    
private extension WorkoutCategoryViewController {
    
    func setupConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(
                equalTo:
                    view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 6
            ),
            
            subtitleLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            
            subtitleLabel.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor
            ),
            
            collectionView.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: 24
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
                equalTo:
                    view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}

private extension WorkoutCategoryViewController {

    func createCollectionViewLayout()
        -> UICollectionViewLayout {

        let itemSize =
            NSCollectionLayoutSize(
                widthDimension:
                    .fractionalWidth(1.0),
                heightDimension:
                    .fractionalHeight(1.0)
            )

        let item =
            NSCollectionLayoutItem(
                layoutSize: itemSize
            )

        let groupSize =
            NSCollectionLayoutSize(
                widthDimension:
                    .fractionalWidth(1.0),
                heightDimension:
                    .absolute(150)
            )

        let group =
            NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [
                    item,
                    item
                ]
            )

        group.interItemSpacing =
            .fixed(12)

        let section =
            NSCollectionLayoutSection(
                group: group
            )

        section.interGroupSpacing =
            12

        return UICollectionViewCompositionalLayout(
            section: section
        )
    }
}

private extension WorkoutCategoryViewController {

    func bindViewModel() {

        viewModel.onUpdate = { [weak self] in

            DispatchQueue.main.async {

                self?.collectionView.reloadData()
            }
        }

        viewModel.onError = { [weak self] message in

            DispatchQueue.main.async {

                self?.showError(
                    message: message
                )
            }
        }
    }
}

extension WorkoutCategoryViewController:
    UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        return viewModel.categories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier:
                        WorkoutTypeCell.identifier,
                    for: indexPath
                ) as? WorkoutTypeCell
        else {
            return UICollectionViewCell()
        }

        let category =
            viewModel.categories[indexPath.item]

        cell.configure(
            with: category
        )

        return cell
    }
}

extension WorkoutCategoryViewController:
    UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {

        let category =
            viewModel.categories[indexPath.item]

        print(
            "Selected workout category:",
            category.title
        )
    }
}

private extension WorkoutCategoryViewController {

    func showError(
        message: String
    ) {

        let alert =
            UIAlertController(
                title: "Something went wrong",
                message: message,
                preferredStyle: .alert
            )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(
            alert,
            animated: true
        )
    }
}
