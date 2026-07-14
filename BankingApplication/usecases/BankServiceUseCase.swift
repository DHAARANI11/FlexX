//
//  BankServiceUseCase.swift
//  BankingSystem
//
//  Created by Dhaarani M on 30/06/26.
//

import Foundation

final class CreateAccountUseCaseImpl: CreateAccountUseCase {
    private let service: BankServiceProtocol
    init(service: BankServiceProtocol) { self.service = service }

    func execute(name: String, pin: Int, deposit: Double) throws -> Account {
        return try service.createAccount(name: name, pin: pin, deposit: deposit)
    }
}

final class DepositUseCaseImpl: DepositUseCase {
    private let service: BankServiceProtocol
    init(service: BankServiceProtocol) { self.service = service }

    func execute(accountNumber: Int, amount: Double, pin: Int) throws {
        try service.deposit(accountNumber: accountNumber, amount: amount, pin: pin)
    }
}

final class WithdrawUseCaseImpl: WithdrawUseCase {
    private let service: BankServiceProtocol
    init(service: BankServiceProtocol) { self.service = service }

    func execute(accountNumber: Int, pin: Int, amount: Double) throws {
        try service.withdraw(accountNumber: accountNumber, pin: pin, amount: amount)
    }
}

final class TransferUseCaseImpl: TransferUseCase {
    private let service: BankServiceProtocol
    init(service: BankServiceProtocol) { self.service = service }

    func execute(from: Int, to: Int, pin: Int, amount: Double) throws {
        try service.transfer(from: from, to: to, pin: pin, amount: amount)
    }
}

final class ViewAccountUseCaseImpl: ViewAccountUseCase {
    private let service: BankServiceProtocol
    init(service: BankServiceProtocol) { self.service = service }

    func execute(accountNumber: Int) throws -> Account {
        return try service.viewAccount(accountNumber: accountNumber)
    }
}

final class ChangePinUseCaseImpl: ChangePinUseCase {
    private let service: BankServiceProtocol
    init(service: BankServiceProtocol) { self.service = service }

    func execute(accountNumber: Int, oldPin: Int, newPin: Int) throws {
        try service.changePin(accountNumber: accountNumber, oldPin: oldPin, newPin: newPin)
    }
}

final class MiniStatementUseCaseImpl: MiniStatementUseCase {
    private let service: BankServiceProtocol
    init(service: BankServiceProtocol) { self.service = service }

    func execute(accountNumber: Int, pin: Int, last: Int) throws {
        try service.miniStatement(accountNumber: accountNumber, pin: pin, last: last)
    }
}
