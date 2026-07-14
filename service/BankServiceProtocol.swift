//
//  BankServiceProtocol.swift
//  BankingSystem
//
//  Created by Dhaarani M on 28/06/26.
//

protocol BankServiceProtocol {
    func createAccount(name: String, pin: Int, deposit: Double) throws -> Account
    func deposit(accountNumber: Int, amount: Double, pin: Int) throws
    func withdraw(accountNumber: Int, pin: Int, amount: Double) throws
    func transfer(from: Int, to: Int, pin: Int, amount: Double) throws
    func viewAccount(accountNumber: Int) throws -> Account
    func changePin(accountNumber: Int, oldPin: Int, newPin: Int) throws
    func miniStatement(accountNumber: Int, pin: Int, last: Int) throws
    
}
