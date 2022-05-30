import Foundation
/*:
# Higher-Order Function
## 함수를 인자로 전달받거나 함수를 결과로 반환하는 함수
### Map, Filter, Reduce
[swift.org](https://swift.org)
*/
let array: [Int] = [10,4,4,2,31,5,6,6,13,43,24,123,4123,1253,5]
/*:
 ![forEach](forEach.png)
 [Array forEach](https://developer.apple.com/documentation/swift/array/1689783-foreach)
 ---
 ![SwiftUIForEach](SwiftUIForEach.png)
 [SwiftUIForEach](https://developer.apple.com/documentation/swiftui/foreach)
 */

// SwiftUI ForEach 아님!

//Code

/*:
 ---
 ## Map
 ![Map](Map.png)
 */
// Code

/*:
 ---
 ## Filter
 ![Filter](Filter.png)
 */
// Code

/*:
 ---
 ## Reduce
 ![Reduce](Reduce.png)
 */

// Code

let num = Array(repeating: 2, count: 10)
// Code

/*:
 ---
 ## map 만들어보기
 ### 함수로
 */
let testArray = [1,2,3,4,5,6,7]

func customMap<E,T>(collection: [E], closure: (E) -> T) -> [T] {
    var returnValue: [T] = []
    for element in collection {
        returnValue.append(closure(element))
    }
    return returnValue
}

customMap(collection: testArray) {
    $0 * 3
}

/*:
 ### Extension 으로
 */
// Code with forEach
//extension Collection {
//    func customMapWithForEach<T>(closure: (Element) -> T) -> [T] {
//
//    }
//}

// Code
