//
//  WorkoutCategoryViewModel.swift
//  FlexX
//
//  Created by Dhaarani M on 17/08/26.
//


import Foundation

@MainActor
final class WorkoutCategoryViewModel {

    private let getWorkoutCategoriesUseCase: GetWorkoutCategoriesUseCases

    private(set) var categories: [WorkoutType] = []

    var onUpdate: (() -> Void)?

    var onError: ((String) -> Void)?

    init(
        getWorkoutCategoriesUseCase: GetWorkoutCategoriesUseCases
    ) {

        self.getWorkoutCategoriesUseCase = getWorkoutCategoriesUseCase
    }

    func loadCategories() {

        Task {

            do {

                categories = try await getWorkoutCategoriesUseCase.execute()

                onUpdate?()

            } catch {

                onError?(
                    "Unable to load workouts."
                )
            }
        }
    }
}

