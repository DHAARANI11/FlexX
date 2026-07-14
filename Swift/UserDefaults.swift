
import Foundation

let defaults = UserDefaults.standard

defaults.set("Dhaarani",forKey:"Name")

let name = defaults.string(forKey: "Name") ?? "No value"

print(name)

print("Program Started")