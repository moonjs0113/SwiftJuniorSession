import Foundation
/*:
# Generic
[swift.org](https://swift.org)
 
 ---
 ## Generics 란?
 모든 타입 또는 특정 조건을 만족하는 타입에서 동작할 수 있도록
 유연하고 재사용이 용이하도록 해주는 기능

 ---
 ## 제너릭이 해결하는 문제 (The Problem That Generics Solve)
 두 변수의 값을 Swap하는 함수를 작성한다고 가정
*/

// Int 데이터의 Swap 함수
//func swapTwoInts() {
    // Code
//}
//var firstInt = 1
//var secondInt = 13
//print("firstInt: \(firstInt), secondInt: \(secondInt)")
//swapTwoInts(&firstInt, &secondInt)
//print("firstInt: \(firstInt), secondInt: \(secondInt)")

// 만약 Int 말고 String이나 Double 타입의 값을 Swap하고 싶다면,
// 더 나아가 직접 선언한 구조체나 클래스의 값을 Swap하고 싶다면!

//Cdoe

// 계속 함수를 만들어야한다...

// 이럴 때, Generic 함수를 만들어 사용하자!

// T -> 타입 파라미터 (Type Parameters)의 T
// T가 아니라 다른문자도 가능
//swapTwoValues(&firstInt, &secondInt)
//print("firstInt: \(firstInt), secondInt: \(secondInt)")

// Array를 들여다보자.
// Array
/*:
 ---
 ## Stack Example
 ![Stack_Push_Pop](Stack_Push_Pop.png)
 */

// Int 밖에 못쓰는 Stack
struct IntStack {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

// 모든 타입이 가능한 Stack
// Code

//var stackOfStrings = Stack<String>()
//stackOfStrings.push("uno")
//stackOfStrings.push("dos")
//stackOfStrings.push("tres")
//stackOfStrings.push("cuatro")
/*:
 ![Stack_Pushed_Four_Strings](Stack_Pushed_Four_Strings.png)
 */

//let fromTheTop = stackOfStrings.pop()
/*:
 ![Stack_Poped_One_String](Stack_Poped_One_String.png)
 */

/*:
 ---
 ## 제너릭 타입 확장 (Extending a Generic Type)
 */
//extension Stack {
    // printItems 추가
    // Code
//}

//if let topItem = stackOfStrings.topItem {
//    print("The top item on the stack is \(topItem).")
//}

/*:
 ---
 ## 타입 제약 (Type Constraints)
 ### 타입 제약 구문 (Type Constraint Syntax)
 */

let childClass = ChildClass()
let protocolClass = ProtocolClass()

func someFunction<T: SuperClass, U: GenericProtocol>(someT: T, someU: U) {
    
}

/*:
 ---
 ### 타입 제약 동작 (Type Constraints in Action)
 */
// String만 가능한 함수
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

// 1. 복사해서 Generic으로 바꿔봅니다.
// 2. Equatable 제약사항을 추가합니다.
/*:
 ---
 ## 연관된 타입 (Associated Types)
 ### 연관된 타입의 동작 (Associated Types in Action)
 */
protocol Container {
    associatedtype Item
    // associatedtype Item: Equatable
    // 프로토콜이 실제로 채택되기 전까지 지정되지 않는 타입
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// IntStack
//extension IntStack: Container {
// Code
//}
// 타입 추론으로인해 typealias를 주석처리해도 작동한다.

// Generic Stack
// Code
// Generic Type으로 타입 추론이 되었기 때문에
// 마찬가지로 typealias가 없어도 작동한다.

/*:
 ---
 ## 연관된 타입의 제약조건에서 프로토콜 사용 (Using a Protocol in Its Associated Type’s Constraints)
 */

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

// Sufiix에 지정될 타입의 Item 과 Item이 같아야한다.
//extension Stack: SuffixableContainer {
//    func suffix(_ size: Int) -> Stack {
//        var result = Stack()
//        for index in (count-size)..<count {
//            result.append(self[index])
//        }
//        result.printItems()
//        return result
//    }
//}

//var stackOfInts = Stack<Int>()
//stackOfInts.append(10)
//stackOfInts.append(20)
//stackOfInts.append(30)
//let suffix = stackOfInts.suffix(2)

/*:
 ---
 ## 제너릭 Where 절 (Generic Where Clauses)
 */
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
        if someContainer.count != anotherContainer.count {
            return false
        }

        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        return true
}

var arrayOfStrings = ["uno", "dos", "tres"]

// Array가 Container를 채택해야한다.
extension Array: Container {}

//if allItemsMatch(stackOfStrings, arrayOfStrings) {
//    print("All items match.")
//} else {
//    print("Not all items match.")
//}

/*:
 ---
 ### 제너릭 Where 절이 있는 확장 (Extensions with a Generic Where Clause)
 ### 상황별 Where 절 (Contextual Where Clauses)
 */
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        print("extension Container where Item == Double")
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())

extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        print("func average() -> Double where Item == Int")
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}
let numbers = [1260, 1200, 98, 37]
print(numbers.average())
print(numbers.endsWith(37))
