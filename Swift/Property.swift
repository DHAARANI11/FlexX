@propertyWrapper
struct NonNegative {

    private var value: Double = 0

    var wrappedValue: Double {

        get {
            value
        }

        set {
            value = max(0, newValue)
        }
    }
}
struct Account{
    @NonNegative
    var bal
}

var acc=Account()
acc.bal = -50
print(acc.bal)