var city: String?

print(city)

print(city ?? "Unknown City") //nil coeloasing

city = "cbe"

print(city)

//optional binding

var name: String? = "Dhaarani"

print(name!) //force unwrap

if let unwrappedName = name {
    print(unwrappedName)
}

func greet(name: String?) {

    guard let name = name else {
        print("No name found")
        return
    }

    print("Hello \(name)")
}

greet(name: "Dhaarani")


class Student {

    var name: String

    init(name: String) {
        self.name = name
    }
}
var student: Student? = Student(name: "Dhaarani")

print(student?.name)

//ops map

let number: Int? = 10

let doubled = number.map { $0 * 2 }

print(doubled)

//flatmap

let text: String? = "abc"

let number = text.flatMap { Int($0) }

print(number)