protocol Orders {

    func orderDetails()
}

protocol Refund {

    func refund()
}

//Protocol inheritance

protocol Payment: Orders {

    // Protocol property requirement
    var amount: Double { 
        get 
    }

    // Protocol method requirement
    func pay()

    func orderDetails()
}

//Protocol conformance

class CardPayment: Payment {

    var amount: Double = 500

    func orderDetails() {
        print("Order ID: 101")
    }
}


//protocol composition

struct CashPayment: Payment, Refund {

    var amount: Double = 600

    func pay() {
        print("Cash Payment")
    }

    func orderDetails() {
        print("Order ID: 102")
    }

    func refund(){
        print("refunded")
    }
}

enum UPIPayment: Payment {

    case phonePe
    case googlePay
    case paytm

    var amount: Double {
        return 300
    }

    func pay() {
        print("UPI Payment")
    }

    func orderDetails() {
        print("Order ID: 103")
    }
}

func process(payment: Payment & Refund){

    payment.pay()

    payment.refund()
}

extension CardPayment {

    //computed property
    var totalAmount: Double {
        amount + 50
    }

    func printReceipt() {
       print("Receipt Printed")
    }
}

extension CashPayment {

    func printCashReceipt() {
       print("Cash Receipt Printed")
    }
}

extension UPIPayment {

    func printUpiReceipt(){
        print("Upi receipt Pritend")
    }

}

extension Payment {

    func pay(){
        print("payment")
    }

    func paymentStatus(){
        print("successful")
    }
}

let card = CardPayment()
card.orderDetails()
print("Amount: \(card.amount)")
print("Total: \(card.totalAmount)")
card.pay()
card.printReceipt()
card.paymentStatus()

let cash = CashPayment()
cash.orderDetails()
print("Amount: \(cash.amount)")
cash.pay()
process(payment : cash)
cash.printCashReceipt()
cash.paymentStatus()

let upi = UPIPayment.phonePe
upi.orderDetails()
print("Amount: \(upi.amount)")
upi.pay()
upi.printUpiReceipt()
upi.paymentStatus()


//equatable

struct Student: Equatable {

    let id: Int
    let name: String
}

let student1 = Student(id: 1, name: "dhaaru")
let student2 = Student(id: 1, name: "dhaaru")
let student3 = Student(id: 2, name: "dharshu")

print(student1 == student2)
print(student1 == student3)

//custom equatable

struct Employee: Equatable {

    let id: Int
    let name: String

    static func == (a: Employee, b: Employee) -> Bool {
        return a.id == b.id
    }
}

let e1 = Employee(id: 101, name: "dharu")
let e2 = Employee(id: 101, name: "dhasrhu")

print(e1 == e2)