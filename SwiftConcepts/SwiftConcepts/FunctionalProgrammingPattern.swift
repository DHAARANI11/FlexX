let numbers = [1,5,3,2,4]

//map

let result = numbers.map { $0 * 2 }

print(numbers)

print(result)

let names = ["dhaarani", "dhasrhini", "kavi", "ramya"]

let upper = names.map { $0.uppercased() }

print(upper)

//filter

let even = numbers.filter {
    $0 % 2 == 0
}
print(even)

//reduce - combine all into one

let sum = numbers.reduce(0) {
    $0 + $1
}
print(sum)

//flatmap

let values = [
    [1,2],
    [3,4],
    [5]
]
let flat = values.flatMap {
    $0
}
print(flat)

//compact map - removes nil

var vals = [
    "123",
    "abc",
    "456"
]


let nums = vals.map {
    Int($0)
}

let num2 = vals.compactMap{
    Int($0)
}

print(nums)

print(num2)

print(numbers.sorted())


//chaining hof

let ans = numbers
.lazy.filter {
    $0 % 2 == 0
}.map {
    $0 * 10
}.reduce(0) {
    $0 + $1
}

print(ans)