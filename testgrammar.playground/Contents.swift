//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
var p:String  = greet(person: "mike", day: "wednesday")

print (p)

let linePath = UIBezierPath()
linePath.move(to: CGPoint(x:100, y:100))
linePath.addLine(to: CGPoint(x:200, y:200))

class UICloudSharingPermissionOptions{
    
}

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}