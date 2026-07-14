//
//  BankError.swift
//  BankingSystem
//
//  Created by Dhaarani M on 28/06/26.
//

enum BankError: Error {
    case invalidPin
    case invalidAmount
    case accountNotFound
    case insufficientFunds
    case incorrectPin
    case duplicateTransfer
    case noTransactions


    var message: String {
        switch self {
        case .invalidPin:
            return "PIN must be exactly 4 digits."
        case .invalidAmount:
            return "Amount must be greater than zero."
        case .accountNotFound:    
            return "Account not found."
        case .insufficientFunds:  
            return "Insufficient funds."
        case .incorrectPin:       
            return "Incorrect PIN."
        case .duplicateTransfer: 
            return "Source and destination accounts cannot be the same."
        case .noTransactions:     
            return "No transactions found for this account."
        }
    }
}
