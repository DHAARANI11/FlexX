class Person {

    let name: String
    var apartment: Apartment?

    init(name: String) {
        self.name = name
        print("\(name) is created")
    }

    deinit {
        print("\(name) is destroyed")
    }
}

var p: Person? = Person(name: "dhaaru")
p = nil


//unowned

class Customer {

    let name: String
    var card: CreditCard?

    init(name: String) {
        self.name = name
        print("Customer created")
    }

    deinit {
        print("Customer destroyed")
    }
}

class CreditCard {

    let number: Int
    unowned let customer: Customer

    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
        print("Card created")
    }

    deinit {
        print("Card destroyed")
    }
}

var customer: Customer? = Customer(name: "dhaaru")

customer!.card = CreditCard(
    number: 1234,
    customer: customer!
)

customer = nil

//strong and weak reference

class Apartment {

    let number: Int
    var tenant: Person?     

    init(number: Int) {
        self.number = number
        print("Apartment \(number) is created")
    }

    deinit {
        print("Apartment \(number) is destroyed")
    }
}

var person: Person? = Person(name: "dharshu")
var apartment: Apartment? = Apartment(number: 101)

person?.apartment = apartment
apartment?.tenant = person

person = nil
apartment = nil


class Apartment2 {

    let number: Int

    weak var tenant: Person?    

    init(number: Int) {
        self.number = number
        print("Apartment2 \(number) is created")
    }

    deinit {
        print("Apartment2 \(number) is destroyed")
    }
}

var person2: Person? = Person(name: "dhaaru")
var apartment2: Apartment? = Apartment(number: 102)

person2?.apartment = apartment
apartment2?.tenant = person

person = nil
apartment = nil