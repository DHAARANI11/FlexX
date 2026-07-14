//
//  DatabaseManager.swift
//  BankingSystem
//
//  Created by Dhaarani M on 03/07/26.
//
import Foundation
import SQLite3

class DatabaseManager {

    var db: OpaquePointer?

    init(path: URL) {
        if sqlite3_open(path.path, &db) != SQLITE_OK {
            fatalError("Unable to open database")
        }
        createTables()
    }

    deinit {
        sqlite3_close(db)
    }

    private func createTables() {
        let accountsSQL = """
            CREATE TABLE IF NOT EXISTS Accounts (
                accountNumber INTEGER PRIMARY KEY,
                name TEXT NOT NULL,
                pin INTEGER NOT NULL,
                balance REAL NOT NULL
            );
        """
        let transactionsSQL = """
            CREATE TABLE IF NOT EXISTS Transactions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                accountNumber INTEGER NOT NULL,
                operation TEXT NOT NULL,
                amount REAL NOT NULL,
                balanceAfter REAL NOT NULL,
                FOREIGN KEY(accountNumber) REFERENCES Accounts(accountNumber)
            );
        """

        exec(accountsSQL, label: "create Accounts table")
        exec(transactionsSQL, label: "create Transactions table")
    }

    private func exec(_ sql: String, label: String) {
        var errMsg: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, sql, nil, nil, &errMsg) != SQLITE_OK {
            let message = errMsg.map {
                String(cString: $0)
            } ?? "unknown error"
            print("Failed to \(label): \(message)")
            sqlite3_free(errMsg)
        }
    }

    func insertAccount(_ account: Account) {
        let sql = "INSERT INTO Accounts (accountNumber, name, pin, balance) VALUES (?, ?, ?, ?)"
        var statement: OpaquePointer?

        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            print("Prepare statement failed: \(String(cString: sqlite3_errmsg(db)))")
            return
        }
        defer {
            sqlite3_finalize(statement)
        }

        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

        sqlite3_bind_int(statement, 1, Int32(account.accountNumber))
        sqlite3_bind_text(statement, 2, account.name, -1, SQLITE_TRANSIENT)
        sqlite3_bind_int(statement, 3, Int32(account.pinForStorage))
        sqlite3_bind_double(statement, 4, account.balance)

        if sqlite3_step(statement) != SQLITE_DONE {
            print("Failed to insert account: \(String(cString: sqlite3_errmsg(db)))")
        }
    }

    func updateAccount(_ account: Account) {
        let sql = "UPDATE Accounts SET name = ?, pin = ?, balance = ? WHERE accountNumber = ?"
        var statement: OpaquePointer?

        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            print("Prepare statement failed: \(String(cString: sqlite3_errmsg(db)))")
            return
        }
        defer { sqlite3_finalize(statement) }

        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

        sqlite3_bind_text(statement, 1, account.name, -1, SQLITE_TRANSIENT)
        sqlite3_bind_int(statement, 2, Int32(account.pinForStorage))
        sqlite3_bind_double(statement, 3, account.balance)
        sqlite3_bind_int(statement, 4, Int32(account.accountNumber))

        if sqlite3_step(statement) != SQLITE_DONE {
            print("Failed to update account: \(String(cString: sqlite3_errmsg(db)))")
        }
    }

    func getAccount(accountNumber: Int) -> Account? {
        let sql = "SELECT accountNumber, name, pin, balance FROM Accounts WHERE accountNumber = ?"
        var statement: OpaquePointer?

        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            return nil
        }
        defer { sqlite3_finalize(statement) }

        sqlite3_bind_int(statement, 1, Int32(accountNumber))

        guard sqlite3_step(statement) == SQLITE_ROW else {
            return nil
        }

        return accountFromRow(statement)
    }

    func getAllAccounts() -> [Account] {
        var accounts: [Account] = []
        let sql = "SELECT accountNumber, name, pin, balance FROM Accounts"
        var statement: OpaquePointer?

        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            return []
        }
        defer { sqlite3_finalize(statement) }

        while sqlite3_step(statement) == SQLITE_ROW {
            if let account = accountFromRow(statement) {
                accounts.append(account)
            }
        }
        return accounts
    }

    private func accountFromRow(_ statement: OpaquePointer?) -> Account? {
        let accountNumber = Int(sqlite3_column_int(statement, 0))
        guard let namePointer = sqlite3_column_text(statement, 1) else { return nil }
        let name = String(cString: namePointer)
        let pin = Int(sqlite3_column_int(statement, 2))
        let balance = sqlite3_column_double(statement, 3)

        return Account(
            accountNumber: accountNumber,
            name: name,
            pin: pin,
            balance: balance
        )
    }


    func insertTransaction(accountNumber: Int, operation: String, amount: Double, balanceAfter: Double) {
        let sql = "INSERT INTO Transactions (accountNumber, operation, amount, balanceAfter) VALUES (?, ?, ?, ?)"
        var statement: OpaquePointer?

        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            print("Prepare statement failed: \(String(cString: sqlite3_errmsg(db)))")
            return
        }
        defer { sqlite3_finalize(statement) }

        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

        sqlite3_bind_int(statement, 1, Int32(accountNumber))
        sqlite3_bind_text(statement, 2, operation, -1, SQLITE_TRANSIENT)
        sqlite3_bind_double(statement, 3, amount)
        sqlite3_bind_double(statement, 4, balanceAfter)

        if sqlite3_step(statement) != SQLITE_DONE {
            print("Failed to insert transaction: \(String(cString: sqlite3_errmsg(db)))")
        }
    }

    func getTransactionRows(accountNumber: Int) -> [(operation: String, amount: Double, balanceAfter: Double)] {
        var rows: [(operation: String, amount: Double, balanceAfter: Double)] = []
        let sql = "SELECT operation, amount, balanceAfter FROM Transactions WHERE accountNumber = ? ORDER BY id ASC"
        var statement: OpaquePointer?

        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            return []
        }
        defer { sqlite3_finalize(statement) }

        sqlite3_bind_int(statement, 1, Int32(accountNumber))

        while sqlite3_step(statement) == SQLITE_ROW {
            guard let opPointer = sqlite3_column_text(statement, 0) else { continue }
            let operation = String(cString: opPointer)
            let amount = sqlite3_column_double(statement, 1)
            let balanceAfter = sqlite3_column_double(statement, 2)
            rows.append((operation, amount, balanceAfter))
        }
        return rows
    }
}
