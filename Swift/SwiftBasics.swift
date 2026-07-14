let name="Dhaarani"
var age=22

print(name, age)

age=23

//name="Dharshu"

print(name, age)

var place: String

place = "Coimbatore"

print(place)

print("My name is \(name)")


let a,b,c:String
a="A"
b="B"
c="C"

//c="cc"

/*multi 
line 
comment*/

print(a,b,c)

let min=UInt8.min
let max=UInt8.max
print(min,max)


//optional

var ops:String?=nil
//print(ops)

print(ops ?? "optional")

ops="new value"

print(ops ?? "optional")


var sum:UInt8=255

//sum=sum+1
sum=sum&+1

print(sum)

var sum2=255
sum2=sum2+1
print(sum2)

print(1+3.3)

var val=3

print(Double(val))

var doub=3.6

print(Int(doub))

print(String(doub))

//optional

var server: Int? = 404
server = nil 

print(server)

if let server{
    print(server)
}

print(server ?? 501)

// let server2=server!

// guard let server2 = server else{
//     fatalError("Invalid number")
// }

//print(Int(name))

// typealias song = String 

// var mp3:song="DUDUDU"

// print(song)


//tuple

let (x, y) = (10, 20)

print(x,y)

//age = -10
assert(age>=0, "Can't be negative")
age = 22
if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}

//precondition

let index = 1

precondition(index >= 0, "Index cannot be negative")