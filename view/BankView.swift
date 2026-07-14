//
//  BankView.swift
//  BankingSystem
//
//  Created by Dhaarani M on 26/06/26.
//

import Foundation

class BankView {

    private let createAccountUseCase: CreateAccountUseCase
    private let depositUseCase: DepositUseCase
    private let withdrawUseCase: WithdrawUseCase
    private let transferUseCase: TransferUseCase
    private let viewAccountUseCase: ViewAccountUseCase
    private let changePinUseCase: ChangePinUseCase
    private let miniStatementUseCase: MiniStatementUseCase
    
    init(
        createAccountUseCase: CreateAccountUseCase,
        depositUseCase: DepositUseCase,
        withdrawUseCase: WithdrawUseCase,
        transferUseCase: TransferUseCase,
        viewAccountUseCase: ViewAccountUseCase,
        changePinUseCase: ChangePinUseCase,
        miniStatementUseCase: MiniStatementUseCase
    ) {
        self.createAccountUseCase = createAccountUseCase
        self.depositUseCase = depositUseCase
        self.withdrawUseCase = withdrawUseCase
        self.transferUseCase = transferUseCase
        self.viewAccountUseCase = viewAccountUseCase
        self.changePinUseCase = changePinUseCase
        self.miniStatementUseCase = miniStatementUseCase
    }

    func start() {
        
        while true {
            print("""

                 Banking System 
            1. Create Account
            2. Deposit
            3. Withdraw
            4. Transfer
            5. View Account
            6. Change PIN
            7. Mini Statement
            8. Exit
            
            """)

            print("Enter choice:", terminator: " ")
            let choice = Int(readLine() ?? "") ?? 0

            switch choice {
            case 1: createAccount()
            case 2: deposit()
            case 3: withdraw()
            case 4: transfer()
            case 5: viewAccount()
            case 6: changePin()
            case 7: miniStatement()
            case 8: print("Goodbye!"); return
            default: print("Invalid choice. Please try again.")
    
            }
        }
    }

    private func createAccount() {
        let name = InputHelper.readString(message: "Enter name:")
        let pin = InputHelper.readInt(message: "Enter 4-digit PIN:")
        let amount = InputHelper.readDouble(message: "Enter opening deposit:")

        do {
            let account = try createAccountUseCase.execute(name: name, pin: pin, deposit: amount)
            print("Account created! Your account number is \(account.accountNumber).")
        } catch let error as BankError {
            print(error.message)
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    private func deposit() {
        let accountNumber = InputHelper.readInt(message: "Enter account number:")
        let amount = InputHelper.readDouble(message: "Enter amount to deposit:")
        let pin = InputHelper.readInt(message: "Enter PIN:")

        do {
            try depositUseCase.execute(accountNumber: accountNumber, amount: amount, pin:pin)
            print("Deposit successful.")
        } catch let error as BankError {
            print(error.message)
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    private func withdraw() {
        let accountNumber = InputHelper.readInt(message: "Enter account number:")
        let pin = InputHelper.readInt(message: "Enter PIN:")
        let amount = InputHelper.readDouble(message: "Enter amount to withdraw:")

        do {
            try withdrawUseCase.execute(accountNumber: accountNumber, pin: pin, amount: amount)
            print("Withdrawal successful.")
        } catch let error as BankError {
            print(error.message)
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    private func transfer() {
        let fromAccount = InputHelper.readInt(message: "Enter source account number:")
        let toAccount = InputHelper.readInt(message: "Enter destination account number:")
        let pin = InputHelper.readInt(message: "Enter PIN:")
        let amount = InputHelper.readDouble(message: "Enter amount to transfer:")

        do {
            try transferUseCase.execute(from: fromAccount, to: toAccount, pin: pin, amount: amount)
            print("Transfer successful.")
        } catch let error as BankError {
            print(error.message)
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    private func viewAccount() {
        let accountNumber = InputHelper.readInt(message: "Enter account number:")

        do {
            let account = try viewAccountUseCase.execute(accountNumber: accountNumber)
            account.display()
        } catch let error as BankError {
            print(error.message)
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    private func changePin() {
        let accountNumber = InputHelper.readInt(message: "Enter account number:")
        let oldPin = InputHelper.readInt(message: "Enter current PIN:")
        let newPin = InputHelper.readInt(message: "Enter new 4-digit PIN:")
        do {
            try changePinUseCase.execute(accountNumber: accountNumber, oldPin: oldPin, newPin: newPin)
            print("PIN changed successfully.")
        } catch let e as BankError { print(e.message) }
            catch { print("Unexpected error: \(error)") }
    }
     
    private func miniStatement() {
        let accountNumber = InputHelper.readInt(message: "Enter account number:")
        let pin = InputHelper.readInt(message: "Enter PIN:")
        do {
            try miniStatementUseCase.execute(accountNumber: accountNumber, pin: pin, last: 10)
        } catch let e as BankError { print(e.message) }
        catch {
            print("Unexpected error: \(error)")
        }
    }
}
