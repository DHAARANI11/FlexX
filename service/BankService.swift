//
//  BankService.swift
//  BankingSystem
//
//  Created by Dhaarani M on 26/06/26.
//

import Foundation

class BankService: BankServiceProtocol {

    private let db: DatabaseManager
    private let dbFile = FileStorage.fileURL(named: "bank.sqlite3")

    init() {
        db = DatabaseManager(path: dbFile)
    }

    func createAccount(name: String, pin: Int, deposit: Double) throws -> Account {
        guard Validation.isValidPin(pin: pin) else {
            throw BankError.invalidPin
        }
        guard Validation.isValidAmount(amount: deposit) else {
            throw BankError.invalidAmount
        }
        let account = Account(name: name, pin: pin, balance: deposit)

        db.insertAccount(account)
        return account
    }

    func findAccount(accountNumber: Int) -> Account? {
        return db.getAccount(accountNumber: accountNumber)
    }

    func getAccount(accountNumber: Int) throws -> Account {
        guard let account = findAccount(accountNumber: accountNumber) else {
            throw BankError.accountNotFound
        }
        return account
    }

    func deposit(accountNumber: Int, amount: Double, pin: Int) throws {

        guard Validation.isValidAmount(amount: amount) else {
            throw BankError.invalidAmount
        }

        let account = try getAccount(accountNumber: accountNumber)

        guard account.verifyPin(pin) else {
            throw BankError.incorrectPin
        }

        account.balance += amount

        db.updateAccount(account)

        db.insertTransaction(
            accountNumber: account.accountNumber,
            operation: opCode(.deposit),
            amount: amount,
            balanceAfter: account.balance
        )
    }

    func withdraw(accountNumber: Int,pin: Int,amount: Double) throws {

        guard Validation.isValidAmount(amount: amount) else {
            throw BankError.invalidAmount
        }

        let account = try getAccount(accountNumber: accountNumber)

        guard account.verifyPin(pin) else {
            throw BankError.incorrectPin
        }

        guard account.balance >= amount else {
            throw BankError.insufficientFunds
        }

        account.balance -= amount

        db.updateAccount(account)

        db.insertTransaction(
            accountNumber: account.accountNumber,
            operation: opCode(.withdrawal),
            amount: amount,
            balanceAfter: account.balance
        )
    }

    func transfer(from: Int,to: Int,pin: Int,amount: Double) throws {

        guard from != to else {
            throw BankError.duplicateTransfer
        }

        guard Validation.isValidAmount(amount: amount) else {
            throw BankError.invalidAmount
        }

        let fromAccount = try getAccount(accountNumber: from)
        let toAccount = try getAccount(accountNumber: to)

        guard fromAccount.verifyPin(pin) else {
            throw BankError.incorrectPin
        }

        guard fromAccount.balance >= amount else {
            throw BankError.insufficientFunds
        }

        fromAccount.balance -= amount
        toAccount.balance += amount

        db.updateAccount(fromAccount)
        db.updateAccount(toAccount)

        db.insertTransaction(
            accountNumber: from,
            operation: opCode(.transferOut(to: to)),
            amount: amount,
            balanceAfter: fromAccount.balance
        )

        db.insertTransaction(
            accountNumber: to,
            operation: opCode(.transferIn(from: from)),
            amount: amount,
            balanceAfter: toAccount.balance
        )
    }
    
    private func decodeOperation(_ opString: String) -> Transaction.Operations? {
        if opString == "deposit" {
            return .deposit
        } else if opString == "withdrawal" {
            return .withdrawal
        } else if opString.hasPrefix("transferOut:"),
            let to = Int(opString.replacingOccurrences(of: "transferOut:", with: "")) {
            return .transferOut(to: to)
        } else if opString.hasPrefix("transferIn:"),
            let from = Int(opString.replacingOccurrences(of: "transferIn:", with: "")) {
            return .transferIn(from: from)
        }
        return nil
    }

    private func opCode(_ op: Transaction.Operations) -> String {
        switch op {
        case .deposit: return "deposit"
        case .withdrawal: return "withdrawal"
        case .transferOut(let to): return "transferOut:\(to)"
        case .transferIn(let from): return "transferIn:\(from)"
        }
    }

    func viewAccount(accountNumber: Int) throws -> Account {
        return try getAccount(accountNumber: accountNumber)
    }

    func changePin(accountNumber: Int, oldPin: Int, newPin: Int) throws {
        let account = try getAccount(accountNumber: accountNumber)
        guard account.verifyPin(oldPin) else {
            throw BankError.incorrectPin
        }
        guard Validation.isValidPin(pin: newPin) else {
            throw BankError.invalidPin
        }
        account.updatePin(to: newPin)
        db.updateAccount(account)
    }

    func miniStatement(accountNumber: Int,pin: Int,last: Int = 10) throws {

        let account = try getAccount(accountNumber: accountNumber)

        guard account.verifyPin(pin) else {
            throw BankError.incorrectPin
        }

        let rows = db.getTransactionRows(accountNumber: accountNumber)

        guard !rows.isEmpty else {
            throw BankError.noTransactions
        }

        let entries = rows.suffix(last)

        print("""
            Mini Statement — Account \(account.accountNumber)
            Name : \(account.name)
            """)

        for (index, row) in entries.enumerated() {
            guard let operation = decodeOperation(row.operation) else {
                continue
            }
            let transaction = Transaction(
                operations: operation,
                amount: row.amount,
                balanceAfter: row.balanceAfter
            )

            transaction.display(index: index + 1)
        }

        print("""
            Current Balance : ₹\(account.balance)
            """)
    }
}
