//
//  Validation.swift
//  BankingSystem
//
//  Created by Dhaarani M on 26/06/26.
//

class Validation {

    static func isValidPin(pin: Int) -> Bool {
        let pinStr = String(pin)
        return pinStr.count == 4 && pinStr.allSatisfy({ $0.isNumber })
    }

    static func isValidAmount(amount: Double) -> Bool {
        return amount > 0
    }
}
