//
//  InputHelper.swift
//  BankingSystem
//
//  Created by Dhaarani M on 26/06/26.
//

class InputHelper {

    static func readInt(message: String) -> Int {
        print(message, terminator: " ")
        return Int(readLine() ?? "") ?? 0
    }

    static func readString(message: String) -> String {
        print(message, terminator: " ")
        return readLine() ?? ""
    }

    static func readDouble(message: String) -> Double {
        print(message, terminator: " ")
        return Double(readLine() ?? "") ?? 0.0
    }
}
