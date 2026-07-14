//
//  Transaction.swift
//  BankingSystem
//
//  Created by Dhaarani M on 29/06/26.
//

import Foundation

struct Transaction {
 
    enum Operations {
        case deposit
        case withdrawal
        case transferOut(to: Int)
        case transferIn(from: Int)
 
        var label: String {
            switch self {
            case .deposit:               
                return "Deposit"
            case .withdrawal:            
                return "Withdrawal"
            case .transferOut(let acc): 
                return "Transfer Out → \(acc)"
            case .transferIn(let acc):  
                return "Transfer In  ← \(acc)"
            }
        }
    }
 
    let operations: Operations
    let amount: Double
    let balanceAfter: Double
 
    func display(index: Int) {
        let sign = isCredit ? "+" : "-"
        print(String(format: "%2d. %-26@ %@₹%-10.2f Bal: ₹%.2f",
                     index,
                     operations.label,
                     sign,
                     amount,
                     balanceAfter))
    }
 
    private var isCredit: Bool {
        switch operations {
        case .deposit, .transferIn:
            return true
        default:
            return false
        }
    }
}
