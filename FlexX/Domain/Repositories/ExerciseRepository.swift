//
//  ExerciseRepository.swift
//  FlexX
//
//  Created by Dhaarani M on 17/08/26.
//

protocol ExerciseRepository {

    func fetchExercises() async throws -> [Exercise]
}
