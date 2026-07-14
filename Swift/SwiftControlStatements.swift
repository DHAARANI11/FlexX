var num = Int(readLine() ?? "") ?? 0

if num%2==1{
    print("odd")
}
else if num%2==0{
    print("even")
}
else{
    print("invalid")
}

switch num {
case 1:
    print("One")
case 2:
    print("Two")
default:
    break
}




let age = 22

switch age {
case 0...12:
    print("Child")
case 13...19:
    print("Teen")
case 20...60:
    print("Adult")
default:
    print("Senior")
}

//where 

let point = (5,5)

switch point {
case let (x,y) where x == y:
    print("Diagonal")
    fallthrough
default:
    print("Not diagonal")
}

//compound case 

let ch = "a"

switch ch {
case "a","e","i","o","u":
    print("Vowel")
default:
    print("Consonant")
}

//fallthrough

num=5

switch num {
case 5:
    print("Five")
    fallthrough
case 6:
    print("six")
    fallthrough
default:
    print("Integer")
}

//labeled

outerLoop: for i in 1...3 {
    for j in 1...3 {
        if j == 2 {
            break outerLoop
        }
        else{
            print(i)
        }
    }
}
print("Finished")

//guard

func greet(name: String?) {

    guard let name = name else {
        return
    }

    print("Hello \(name)")
}

greet(name:"dhaaru")