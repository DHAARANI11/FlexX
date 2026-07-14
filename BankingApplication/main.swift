//
//  main.swift
//  BankingSystem
//
//  Created by Dhaarani M on 25/06/26.
//

import Foundation

let service: BankServiceProtocol=BankService()

let bankView = BankView(
    createAccountUseCase: CreateAccountUseCaseImpl(service: service),
    depositUseCase: DepositUseCaseImpl(service: service),
    withdrawUseCase: WithdrawUseCaseImpl(service: service),
    transferUseCase: TransferUseCaseImpl(service: service),
    viewAccountUseCase: ViewAccountUseCaseImpl(service: service),
    changePinUseCase: ChangePinUseCaseImpl(service: service),
    miniStatementUseCase: MiniStatementUseCaseImpl(service: service)
)
bankView.start()

