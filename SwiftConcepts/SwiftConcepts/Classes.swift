class Student {

    var name: String

    static var school:String = "ABC School"

    init(name: String) {
        self.name = name
    }

    class func classMethod(){
        print("class method")
    }

    func greet(){
        print("Hello \(name) ")
    }
    final func welcome(){
        print("Welcome")
    }
    deinit {
        print("Student Destroyed")
    }

}

let student1 = Student(name: "Dhaarani")

let student2 = student1

student2.name = "Dharshini"

print(student1.name)
print(student2.name)

print(student1 === student2)


final class ECEStudent : Student{

    var section = "A"

    override func greet(){
        super.greet()
        print("Hi \(name)")
    }

    // override func welcome(){
    //     print("welcome here")
    // }
}

let ece = ECEStudent(name: "Dhaaru")

print(ece.name)
print(ece.section)
print(ece.greet())
print(ece.welcome())


class Average{

    var mark1 : Double

    var mark2 : Double

    init(mark1: Double, mark2: Double){
        self.mark1 = mark1
        self.mark2 = mark2
    }

    var avrg:Double{
        
        get{
            return (mark1 + mark2)/2
        }

        set {
            mark1 = newValue

            mark2 = newValue
        }


    }

}

var avg = Average(mark1: 55,mark2: 56)

avg.mark1 = 95

avg.mark2 = 99

print(avg.avrg)


class Rank {

    var A = "A" {
        willSet{
            print("After \(newValue)")
        }

        didSet{
            print("Before \(oldValue)")
        }
    }
}

let rank = Rank()

//print(rank.A)

rank.A = "B"

//print(rank.A)


class App {

    lazy var stud = Student(name: "dhaaru")

}

let app = App()

print("App Started")

app.stud.greet()

print(Student.school)

print(Student.classMethod())


//failable

struct Person {
    var age: Int

    init?(age: Int) {

        if age < 0 {

            return nil

        }
        self.age = age

    }

}
let p1 = Person(age: 22)
print(p1)
let p2 = Person(age: -5)
print(p2)

    