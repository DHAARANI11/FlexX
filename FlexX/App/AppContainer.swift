//
//  AppContainer.swift
//  FlexX
//
//  Created by Dhaarani M on 11/08/26.
//

import Foundation
import SwiftData

final class AppContainer {

    let authRepository: AuthRepository

    let loginUseCase: LoginUseCases

    let registerUseCase: RegisterUseCases
    
    let userRepository: UserRepository
    
    let getProfileUseCase: GetProfileUseCases
    
    let exerciseRepository: ExerciseRepository

    let getWorkoutCategoriesUseCase: GetWorkoutCategoriesUseCases

    init(context: ModelContext) {

        let repository = AuthRepositoryImpl( context: context)
        
        let userRepository = UserRepositoryImpl( context: context)

        self.userRepository = userRepository

        self.authRepository = repository

        self.loginUseCase = LoginUseCases( repository: repository)

        self.registerUseCase = RegisterUseCases( repository: repository)
        
        self.getProfileUseCase = GetProfileUseCasesImpl( userRepository: userRepository)
        
        let exerciseRepository = ExerciseRepositoryImpl()

        self.exerciseRepository = exerciseRepository

        self.getWorkoutCategoriesUseCase = GetWorkoutCategoriesUseCaseImpl(repository: exerciseRepository )
    }
}
