//array

var someInts: [Int] = []

print(someInts)

print(someInts.count)

someInts.append(10)

print(someInts)

someInts.append(20)

print(someInts)


var arr=Array(repeating:10,count:5)

print(arr)

var arr2 = Array(repeating: 2, count: 3)

//arr concate

print(arr+arr2)

for i in arr2{
    print(i)
}

arr+=[15]

print(arr)

var strArr=["dhaaru","dharshu"]
strArr += ["Kavi"]

print(strArr)

print(strArr[1])

for (index, value) in strArr.enumerated() {
    print("Names \(index + 1): \(value)")
}


//sets

var chars=Set<String>()

chars.insert("dhaaru")
chars.insert("dhasrhu")
chars.insert("dhaaru")
chars.insert("kavi")
print(chars)

chars.remove("kavi")


let setA: Set = [1,2,3]
let setB: Set = [3,4,5]

print(setA.union(setB))
print(setA.intersection(setB))
print(setA.subtracting(setB))
print(setB.subtracting(setA))

//dic

var students = [
    101: "Dhaarani",
    102: "Dharshini"
]

if let oldStud = students.updateValue("Dhaaru",forKey:101){
    print("\(oldStud) updated")
}

for (id, name) in students {
    print("\(id) -> \(name)")
}

students.removeValue(forKey: "101")

print(students)


//sort

var numbers = [5,2,8,1]

numbers.sort()

print(numbers)

//filter

let even = numbers.filter { $0 % 2 == 0 }

print(even)

//map

let doubled = numbers.map { $0 * 2 }

print(doubled)

//tuple

let student = ("Dhaarani", 22, 8.5)

print(student.0)
print(student.1)
print(student.2)

//decomp - ignofre unwanted val

let (name, _, city) = student

print(name)
print(cgpa)