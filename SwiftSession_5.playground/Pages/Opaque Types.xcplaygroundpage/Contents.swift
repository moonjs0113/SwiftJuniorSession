import Foundation
/*:
 # Opaque Types
 [swift.org](https://swift.org)
 ---
 */
protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}
let smallTriangle = Triangle(size: 3)
smallTriangle.self
//print(smallTriangle.draw())

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}
let flippedTriangle = FlippedShape(shape: smallTriangle)
//print(flippedTriangle.draw())

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print(joinedTriangles.draw())

struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}
print(Square(size: 4).draw())

/*:
 ---
 ## vs Generics
 */

// 제네릭 where -> 어떠한 프로토콜을 준수하는 파라미터를 받는다.
// 불투명한 타입 some -> 어떠한 프로토콜을 준수하는 값을 반환한다.
func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
//    trapezoid
    return trapezoid
}

let trapezoid = makeTrapezoid()
trapezoid.self

// 프로토콜 타입으로 반환하는 꼴
// 따라서 해당 함수의 재사용이 불가능해진다.
// protoFlip의 제네릭 T는 Shape프토로콜을 준수하는 인자를 받는 것이지, Shape 타입을 받는게 아니기 때문이다.
func protoFlip<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        print("Is Square!")
        return shape
    }
    return FlippedShape(shape: shape)
}

// 모든 분기의 리턴 타입은 같아야한다.
func protoFlipSome<T: Shape>(_ shape: T) -> some Shape {
        if shape is Square {
            return shape
        }
    return FlippedShape(shape: shape)
}



let protoFlippedTriangle = protoFlip(smallTriangle)
//protoFlip(protoFlippedTriangle)
//print(protoFlippedTriangle.draw())

let someThing = protoFlipSome(smallTriangle)
protoFlipSome(someThing)


//- URLSession으로 데이터 가져오기 & (await / async) //3
//- Third Party Framework(cocoapods, carthago, SPM) 사용해보기 (How) // 4
//- SwiftUI Property Wrapper // 1,2
//- Swift Code 작성법 // 2,1
//
//- UIKit 기초
