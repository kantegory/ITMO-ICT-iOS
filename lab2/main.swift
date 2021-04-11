import Foundation


// Задание 1 
func calcAvg(firstFloat: Float, secondFloat: Float) -> Double {
 
    var sum : Double = Double(firstFloat) + Double(secondFloat)
    var  avg : Double = sum / 2
 
    return avg
}

let calcedValue: Double = calcAvg(
    firstFloat: 1.5, 
    secondFloat: 5.5
)

print(calcedValue)
 
// Задание 2
func helloMe(myName: String = "David", myAge: Int = 21, myCity: String = "Priozersk") {
    print("My name is \(myName), I'm \(myAge)! My native city \(myCity).")
}

helloMe()
helloMe(myName: "Vasya")
helloMe(myName: "Vasya", myAge: 20)
helloMe(myAge: 22)
helloMe(myCity: "Saint-Petersburg")
helloMe(myName: "Vasya", myAge: 20, myCity: "Saint-Petersburg")

// Задание 3
func helloMeToo(name: String?) {
    if let name = name {
        print("Привет, \(name)")
    } else {
        print("Привет, человек")
    }
}
 
helloMeToo(name: nil)
 
// Задание 4
func modulo(_ firstInt: Int?, _ secondInt: Int?) -> (Int)? {
    guard let first = firstInt else { 
        print("У вас firstInt сломался")
        return nil
    }
 
    guard let second = secondInt else { 
        print("У вас secondInt сломался")
        return nil
    }
 
    return first % second
}
 
print(modulo(10, 3))
