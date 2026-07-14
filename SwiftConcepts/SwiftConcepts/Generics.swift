func swapValues<T>(_ a: inout T, _ b: inout T) {

    let temp = a
    a = b
    b = temp
}

var x = 10
var y = 20

swapValues(&x, &y)

print(x, y)

var first = "dhaarani"
var second = "dhasrhini"

swapValues(&first, &second)

print(first, second)




struct Generic<T> {

    var value: T
}

let intGen = Generic(value: 100)

let stringGen = Generic(value: "Hello")

let boolGen = Generic(value: true)

print(intGen.value)
print(stringGen.value)
print(boolGen.value)

func compare<T: Equatable>(_ a: T, _ b: T) {
    print(a == b)
}


compare(10, 10)
compare("dharu","dhaaru")

//opaque

protocol Shape {
    func draw()
}

struct Circle: Shape {
    func draw() {
        print("Circle")
    }
}

struct Square: Shape {
    func draw() {
        print("Square")
    }
}

func createShape() -> some Shape {
    Circle()
}

let shape = createShape()

shape.draw()

//existential

var shape2: any Shape

shape2 = Circle()
shape2.draw()

shape2 = Square()
shape2.draw()

//associate type

protocol Storage {
    associatedtype Item
    mutating func add(_ item: Item)

}

struct IntStorage: Storage {
    var value = 10
    mutating func add(_ item: Int) {
        value =  value + item
    }

}

var storage = IntStorage()

storage.add(15)

print(storage.value)