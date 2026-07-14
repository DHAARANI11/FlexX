//
//  Account.swift
//  BankingSystem
//
//  Created by Dhaarani M on 26/06/26.
//

class Account: Displayable {

    let accountNumber: Int
    static var accNum: Int = 1000
    var name: String
    private var pin: Int
    var balance: Double

    private(set) var transactions: [Transaction] = []

    init(name: String, pin: Int, balance: Double) {
        Account.accNum += 1
        self.accountNumber = Account.accNum
        self.name = name
        self.pin = pin
        self.balance = balance
    }
    
    init(accountNumber: Int, name: String, pin: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.name = name
        self.pin = pin
        self.balance = balance
        if accountNumber >= Account.accNum {
            Account.accNum = accountNumber
        }
    }

    func verifyPin(_ enteredPin: Int) -> Bool {
        return self.pin == enteredPin
    }

    func updatePin(to newPin: Int) {
        pin = newPin
    }

    func recordTransaction(_ tx: Transaction) {
        transactions.append(tx)
    }
    
    var pinForStorage: Int {
            return pin
    }

    func display() {
        print("""
                 Account Details         
         Account Number : \(accountNumber)
         Name           : \(name)
         Balance        : ₹\(balance)
        
        """)
    }
}
