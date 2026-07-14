let greet = {
    print("Hello Swift")
}

greet()

//with param

let add = { (a: Int, b: Int) -> Int in
    return a + b
}

print(add(10, 20))

//without param

let message: () -> Void = {
    print("Welcome")
}

message()

//shorthand arg

let add: (Int, Int) -> Int = {
    $0 + $1
}

print(add(5, 10))


let numbers = [4, 2, 8]

let sorted = numbers.sorted {
    $0 < $1
}

print(sorted)

//capture values

func makeCounter() -> () -> Int {

    var count = 0

    return {
        count += 1
        return count
    }
}

let counter = makeCounter()

print(counter())
print(counter())
print(counter())