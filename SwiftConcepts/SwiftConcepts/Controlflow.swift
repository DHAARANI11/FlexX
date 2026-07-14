

//if else else if


let marks = 85

if marks >= 90 {
    print("Grade A")
} else if marks >= 75 {
    print("Grade B")
} else if marks >= 50 {
    print("Grade C")
} else {
    print("Fail")
}

//nested if 

if(mark > 80){
    if(mark<90){
        print("B grade")
    }
}

//ops val

let name: String? = "Dhaarani"

if let userName = name {
    print("Hello \(userName)")
}

//switch

let day = 3

switch day {
case 1:
    print("Monday")
case 2:
    print("Tuesday")
    fallthrough
case 3:
    print("Wednesday")
default:
    print("Invalid Day")
}

//pattern 

switch marks {
case 90...100:
    print("Grade A")

case 75..<90:
    print("Grade B")

case 50..<75:
    print("Grade C")

default:
    print("Fail")
}

switch marks {

case let x where x % 2 == 0:
    print("Even Number")

default:
    print("Odd Number")
}

//switch with enum

enum Direction {
    case north
    case south
    case east
    case west
}

let direction = Direction.north

switch direction {

case .north:
    print("Move Up")

case .south:
    print("Move Down")

case .east:
    print("Move Right")

case .west:
    print("Move Left")
}

//for in loop

for number in 1...5 {
    print(number)
}

for number in 1..<5 {
    print(number)
}

let names = ["dhaaru","dharshu"]

for name in names{
    print(name)
}

for index in 0..<names.count {
    print("\(index): \(names[index])")
}

for (index, name) in names.enumerated() {
    print("\(index): \(name)")
}

//dict

let user = [
    "Name": "Dhaarani",
    "Age": "22",
    "City": "Coimbatore"
]

for (key, value) in user {
    print("\(key): \(value)")
}

let values: Set = [10, 20, 30, 10]

for value in values {
    print(number)
}

for _ in 1...3 {
    print("dhaaru")
}

for number in stride(from: 0, through: 10, by: 2) {
    print(number)
}

var number = 1

while number <= 5 {
    print(number)
    number += 1
}

number = 1

repeat {
    print(number)
    number += 1
} while number <= 5


func greet(age: Int) {

    guard age >= 18 else {
        print("Not Eligible")
        return
    }

    print("Welcome")
}

greet(age: 20)