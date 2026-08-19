//
//  GetWorkoutCategoryUseCases.swift
//  FlexX
//
//  Created by Dhaarani M on 17/08/26.
//

import Foundation

protocol GetWorkoutCategoriesUseCases {

    func execute() async throws -> [WorkoutType]
}

final class GetWorkoutCategoriesUseCaseImpl: GetWorkoutCategoriesUseCases {

    private let repository: ExerciseRepository

    init(repository: ExerciseRepository) {
        self.repository = repository
    }

    func execute() async throws -> [WorkoutType] {

        let exercises = try await repository.fetchExercises()

        return createCategories(
            from: exercises
        )
    }

    private func createCategories(
        from exercises: [Exercise]
    ) -> [WorkoutType] {

        let groupedExercises =
            Dictionary(
                grouping: exercises
            ) { exercise in

                exercise.targetMuscles.first
                    ?? "other"
            }

        return groupedExercises.map {
            muscle, exercises in

            WorkoutType(
                title: muscle.capitalized,
                subtitle: "\(exercises.count) exercises",
                iconName: iconFor(muscle: muscle)
            )

        }.sorted(by: {
            $0.title < $1.title
        })
    }

    private func iconFor(
        muscle: String
    ) -> String {

        switch muscle.lowercased() {

        case "biceps",
             "triceps",
             "delts",
             "pectorals",
             "lats":

            return "figure.strengthtraining.traditional"

        case "abs":

            return "figure.core.training"

        case "quadriceps",
             "hamstrings",
             "glutes",
             "calves":

            return "figure.walk"

        case "cardiovascular system":

            return "figure.run"

        default:

            return "figure.strengthtraining.traditional"
        }
    }
}
