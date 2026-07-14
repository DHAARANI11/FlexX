enum BankError: Error {

    case insufficientBalance(String)
    case inValidPassword(String)
    case invalidAccountNumber

}


func withdraw(balance: Double, amount: Double) throws {
    if amount > balance {
        throw BankError.insufficientBalance("Insufficient balance")
    }

    print("Money Withdrawn")

}

func login(accountNum: Int) throws {
    if accountNum < 0{
        throw BankError.invalidAccountNumber
    }
    print("Login successful")
}

do {
    try withdraw(balance: 1000, amount: 2000)
}
catch {
    print(error)
}

let ans = try? login(accountNum : -10)

print(ans)

try! withdraw(balance: 1000, amount: 200)

//result type

enum LoginError: Error {
    case invalidUsername
    case wrongPassword
}

func fetchUser(id: Int) -> Result<String, LoginError> {
    if id == 1 {
        return .success("dhaaru")
    } else {
        return .failure(.invalidUsername)
    }
}

let outcome = fetchUser(id: 2)

switch outcome {
case .success(let name):
    print("Fetched user: \(name)")
case .failure(let error):
    print("Failed: \(error)")
}