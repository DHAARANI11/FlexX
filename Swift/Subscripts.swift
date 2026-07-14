class StudentMarks {

    var marks = [90, 85, 95]

    subscript(index: Int) -> Int {
        get {
            return marks[index]
        }
        set {
            marks[index] = newValue
        }
    }
}

let s = StudentMarks()

print(s[1])
s[1]=100
print(s[1])