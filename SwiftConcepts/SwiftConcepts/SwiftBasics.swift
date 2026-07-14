//
//  SwiftBasics.swift
//  SwiftConcepts
//
//  Created by Dhaarani M on 07/07/26.
//

//type inference
var age = 22
print(age)

print(type(of: age))

age = 23
print(age)

let name = "Dhaarani"

//name = "Dharshini"

print(name)

var name1: String = "Dhaarani"
var age1: Int = 22
var height1: Double = 5.8

print(name1,age1,height1)


var marks: Int
marks = 95

print(marks)

//multiple assignment

var x = 10, y = 20, z = 30

print(x)
print(y)
print(z)

var (a, b) = (100, 200)

print(a)
print(b)

//datatypes

print(Int.max)
print(Int.min)

let num = 10
let decimal = 2.5

let result = Double(num) + decimal

print(result)

let first = "Hello"
let second = "World"

let result = first + " " + second

print(result)

//string interpolation 

let name = "Dhaarani"
let age = 22

print("My name is \(name)")
print("I am \(age) years old")

//string props

let text = "i like Swift and java   "

print(text.count)
print(text.isEmpty)
print(text.uppercased())
print(text.lowercased())
print(sentence.contains("ft"))
let newText = text.replacingOccurrences(of: "Java", with: "kotlin")
print(newText)
print(text.trimmingCharacters(in: .whitespaces))
text.append(" Programming")
print(text)
print(text[text.startIndex])
let start = text.index(text.startIndex, offsetBy: 3)
let end = text.index(text.startIndex, offsetBy: 7)
let part = text[start..<end]
print(part)

//typealias

typealias Username = String

let user: Username = "Dhaarani"

print(user)

//without typealias

func getEmployee() -> (String, Int) {
    return ("Dhaarani", 22)
}

//withtypealias

typealias EmployeeInfo = (String, Int)

func getEmployeeInfo() -> EmployeeInfo {
    return ("Dhaarani", 22)
}

print(getEmployee,getEmployeeInfo)

//arithmetic ops

let a = 20
let b = 5

print(a + b)
print(a - b)
print(a * b)
print(a / b)
print(a % b)

//arithmetic assignment ops

a+=10
b-=2
b*=10
a/=2

print(a,b)

print(a==b)
print(a!=b)
print(a>b)
print(a<b)


//logical

let age = 22
let hasLicense = true

print(age>=18 && hasLicense)

print(age>=18 || hasLicense)

print(!hasLicense)

//nil coeliscing ops

var city: String? = "Coimbatore"

print(city ?? "Unknown")

let result = age >= 18 ? "Adult" : "Minor"

print(result)

//range ops

for number in 1...5 {
    print(number)
}
let range = 1...10

print(range.contains(5))
print(range.contains(20))

//string interpolation

print("Hello \(name)")

func greet() -> String {
    return "Welcome"
}

print("\(greet()) to Swift")

let message = """
hello

\(name)

dharshini
"""

print(message)

