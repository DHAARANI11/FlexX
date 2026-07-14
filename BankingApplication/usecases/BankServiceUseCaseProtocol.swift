//
//  BankServiceUseCaseProtocol.swift
//  BankingSystem
//
//  Created by Dhaarani M on 30/06/26.
//

import Foundation

protocol CreateAccountUseCase {
    func execute(name: String, pin: Int, deposit: Double) throws -> Account
}

protocol DepositUseCase {
    func execute(accountNumber: Int, amount: Double, pin: Int) throws
}

protocol WithdrawUseCase {
    func execute(accountNumber: Int, pin: Int, amount: Double) throws
}

protocol TransferUseCase {
    func execute(from: Int, to: Int, pin: Int, amount: Double) throws
}

protocol ViewAccountUseCase {
    func execute(accountNumber: Int) throws -> Account
}

protocol ChangePinUseCase {
    func execute(accountNumber: Int, oldPin: Int, newPin: Int) throws
}

protocol MiniStatementUseCase {
    func execute(accountNumber: Int, pin: Int, last: Int) throws
}
