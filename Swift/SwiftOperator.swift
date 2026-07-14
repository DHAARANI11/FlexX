let a = 10
let b = 3

print(a + b) 
print(a - b) 
print(a * b) 
print(a / b) 
print(a % b) 


//string concatination

let first = "Hello"
let second = "Swift"

print(first + " " + second)

//unary minus

let num = 5
let negative = -num

print(negative)

//unary plus

let num2 = -10
let sameValue = +num2

print(sameValue)

//compund assignment oper

var score = 10

score += 5
print(score) 

score -= 3
print(score) 

score *= 2
print(score) 

score /= 4
print(score) 

//comparison operator

let a1 = 10
let b1 = 20

print(a1 == b1) 
print(a1 != b1) 
print(a1 < b1)  
print(a1 > b1)  
print(a1 <= b1) 
print(a1 >= b1) 

//if statemnt

let age = 18

if age >= 18 {
    print("Eligible to vote")
}

//ternary operator

let mark = 80

if mark >= 50 {
    print("Pass")
} else {
    print("Fail")
}

//nil coeleasing oper

var name1: String? = nil

let username = name1 ?? "Guest"

print(username)


//for loop

for i in 1...5 {
    print(i)
}

//range

let numbers = [10,20,30,40,50]

print(numbers[2...])

//not

let isLoggedIn = false

if !isLoggedIn {
    print("Please Login")
}

//and

let user = true
let password = true

if user && password {
    print("Login Success")
}

//or

let hasKey = false
let knowsPassword = true

if hasKey || knowsPassword {
    print("Access Granted")
}