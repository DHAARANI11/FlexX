//
//  ExerciseRepositoryImpl.swift
//  FlexX
//
//  Created by Dhaarani M on 17/08/26.
//

import Foundation

final class ExerciseRepositoryImpl: ExerciseRepository {

    private let baseURL = "https://oss.exercisedb.dev/api/v1/exercises"

    func fetchExercises() async throws -> [Exercise] {

        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }

        let (data, response) =
            try await URLSession.shared.data(
                from: url
            )

        guard let httpResponse =
                response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode
        else {
            throw URLError(.badServerResponse)
        }

        let result =
            try JSONDecoder().decode(
                ExerciseResponse.self,
                from: data
            )

        return result.data
    }
}
