protocol Person {
    func isEligible()
}



struct Student:Person{
    var id:Int;
    var name:String;
    var age:Int;
    func greet(){
        print("Hello \(name)")
    }

    func isEligible(){
        if(age<20){
            print("Eligible")
        }
        else{
            print("Not Eligible")
        }
    }

}

let student1=Student(id:1,name:"Dharshu",age:22)
student1.greet()
student1.isEligible()


struct Student {
    var age = 20
}

var s1 = Student()
var s2 = s1

s2.age = 30

print(s1.age)
print(s2.age)