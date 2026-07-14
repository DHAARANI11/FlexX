func greet() {
    print("Welcome to Swift")
}

greet()

//with parameter

func greet(name: String) {
    print("Hello \(name)")
}

greet(name: "Dhaarani")

//variadic 

func printNames(names: String...) {

    print(names)

}

printNames(names: "Dhaarani", "dharsh", "ramys")


func display(names: String...) {

    for name in names {
        print(name)
    }
}

display(names: "Dhaarani", "dharshini", "kavi")

//inout - directly modify value

func increment(number: inout Int) {
    number += 1
}

var value = 10

increment(number: &value)

print(value)


func swapNumbers(_ a: inout Int, _ b: inout Int) {

    let temp = a
    a = b
    b = temp
}

var x = 10
var y = 20

swapNumbers(&x, &y)

print(x)
print(y)


func add(a: Int, b: Int) -> Int {
    return a + b
}

print(add(a: 5, b: 7))

let operation = add

print(operation(5, 3))


func getEmp() -> (String, Int) {
    return ("Dhaarani", 22)
}

let emp = getEmp()

print(emp.0)
print(emp.1)


func getEmpl() -> (name: String, age: Int) {
    return ("Dhaarani", 22)
}

let empl = getEmpl()

print(empl.name)
print(empl.age)


//nested fun

func outerFunction() {

    func innerFunction() {
        print("Inner Function")
    }

    print("Outer Function")

    innerFunction()
}

outerFunction()


