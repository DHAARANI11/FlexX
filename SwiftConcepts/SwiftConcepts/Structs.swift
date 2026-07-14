
//value type semantics

struct Student {

    var name: String //member wise initializer

}

var student1 = Student(name: "Dhaarani")

var student2 = student1

student2.name = "Dharshini"

print(student1.name)
print(student2.name)

//mutating

struct Counter {

    var value = 0

    mutating func increment() {
        value += 1
    }
}
var counter = Counter()

counter.increment()

print(counter.value)