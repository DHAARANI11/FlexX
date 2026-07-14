enum TrafficLight : CaseIterable {
    case red
    case yellow
    case green
}

var signal = TrafficLight.red
print(signal)

for tl in TrafficLight.allCases {
    print(tl)
}

print(TrafficLight.allCases.count)

let tl = TrafficLight.red

switch tl{
    case .red : 
        print("red")
    
    case .green : 
        print("green")
    
    case .yellow : 
        print("yellow")
    
}

switch result {

case .yellow(let act):
    print("You should \(act)")

case .red("stop"):
    print("stop")

}

var signal2 : TrafficLight = .yellow("wait")
print(signal2)


enum TrafficSignal {

    case red(action: String)

    case yellow(action: String)

    case green(action: String)

}

let signal = TrafficSignal.red(action: "Stop")

print(signal)


enum TrafficLights: CaseIterable {

    case red(action: String)
    case yellow(action: String)
    case green(action: String)

    static var allCases: [TrafficLight] {
        [
            .red(action: "Stop"),
            .yellow(action: "Wait"),
            .green(action: "Go")
        ]
    }
}

for light in TrafficLights.allCases {
    print(light)
}

enum Month: Int {
    case january = 1
    case february
    case march
    case april
}

print(Month.january.rawValue)
print(Month.february.rawValue)
print(Month.april.rawValue)

enum Payment {
    case cash
    case card(cardNumber: String)
    case upi(id: String)
}

let payment = Payment.card(cardNumber: "1234")
print(payment)
