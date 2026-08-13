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

    init(context: ModelContext) {

        let repository = AuthRepositoryImpl(
            context: context
        )

        self.authRepository = repository

        self.loginUseCase = LoginUseCases(
            repository: repository
        )

        self.registerUseCase = RegisterUseCases(
            repository: repository
        )
    }
}
