
//inout

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

var x = 10
var y = 20

swapTwoInts(&x, &y)

print(x,y)

//closures

var nums=[4,5,6,2,4,6,8]
// let reversedNums = nums.sorted(by: { (s1: Int, s2: Int) -> Bool in
//     return s1 > s2
// })

//inferring type from context

//let reversedNums = nums.sorted(by: { s1, s2 in return s1 > s2 } )


//implicit returns
//let reversedNums= nums.sorted(by: { s1, s2 in s1 > s2 } )

//shorthand args

let reversedNums = nums.sorted(by: { $0 > $1 } )

//operator methods

let reversedNums = nums.sorted(by: >)

for num in nums {
    print(num)
}

for rev in reversedNums{
    print(rev)
}