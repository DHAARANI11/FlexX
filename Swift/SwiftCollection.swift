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
print(chars)


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