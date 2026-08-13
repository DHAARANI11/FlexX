//
//  FavouritesViewController.swift
//  FlexX
//
//  Created by Dhaarani M on 13/08/26.
//
import UIKit
import SwiftData

class FavouritesViewController: UIViewController {
    
    private let coordinator: AppCoordinator
    
    private let context: ModelContext

    init(
        context: ModelContext,
        coordinator: AppCoordinator
    ) {
        self.context = context
        self.coordinator = coordinator

        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
