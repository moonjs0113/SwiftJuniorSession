import Foundation
import SwiftUI
//: [Previous](@previous)
//: # Function - 함수

//typealias 타입: Int
//typealias 리턴타입: Int
// 드디어 함수 입니다.
/*:
 구조 - 변수(인자)와 리턴타입 지정은 선택
 ```
 func 함수이름(변수1: 타입, 변수2: 타입) -> 리턴타입{
 
 }
 ```
 */
//: 아무것도 없는거
func withoutParametersAndReturnType() {
    print("withoutParametersAndReturnType")
    print(#function)
}
//: 리턴타입 있는거
func sayHelloWorld() -> String {
    return "hello, world"
}
//: 호출
sayHelloWorld()
func convertIntToString(intValue: Int) -> String {
    return "\(intValue)"
}
convertIntToString(intValue: 4)

//: 파라미터 이름
func addMorningSession(juniorLearner name: String) -> String{
    return name + " Morning"
}

addMorningSession(juniorLearner: "Rey")

//: 파라미터 여러개
func add(x: Int, y: Int = 8) -> Int {
    return x + y
    // x + y
}
add(x: 5, y: 2)
add(x: 5)

func sumIntLiteral(array: Int...) -> Int{
    var result = 0
//    type(of: array)
    for intNum in array {
        result += intNum
    }
    return result
}
sumIntLiteral(array: 1,2,3,4,5)

func sumIntArray(array: [Int]) -> Int{
    var result = 0
    for intNum in array {
        result += intNum
    }
    return result
}
sumIntArray(array: [1,2,3,4,5])

func containRCharacter(name: String) -> Bool {
    return name.contains("R")
}

//: _ 축약
func printAddResult(_ x: Int, _ y: Int) {
    let result = x + y
    print(convertIntToString(intValue: result))
}
printAddResult(5, 8)

let xPoint = 0
var yPoint = 0
print(xPoint, yPoint)

//: 인자 값 수정
// let이라 안됨
//func move5Point(x: Int, y: Int) {
//    x += 5
//    y += 5
//}

//: inout
func move5Point(x: inout Int, y: inout Int) {
    x += 5
    y += 5
}

// 선언된 값이 let이면 당연히 안됨
// move5Point(x: &xPoint, y: &yPoint)
// 78,79 라인에서 선언을 var로 바꾸면 됨,
print(xPoint, yPoint)

//: ## 함수 타입
// 함수도 하나의 타입이 될 수 있다.
func mathAndReturnString(_ mathFunc: (Int,Int) -> Int, x: Int, y: Int) -> String {
    let result = mathFunc(x, y)
    return convertIntToString(intValue: result)
}

// 복잡하죠?
mathAndReturnString(add(x:y:), x: 5, y: 2)

// 사실 SwiftUI의 버튼에도 이와같은 로직으로 작동한다.
// Button(action: <#T##() -> Void#>, label: <#T##() -> _#>)

//: [Optional](@next)
