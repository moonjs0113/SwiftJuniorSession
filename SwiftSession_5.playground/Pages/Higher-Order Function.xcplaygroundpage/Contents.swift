import Foundation
/*:
# Higher-Order Function
## 함수를 인자로 전달받거나 함수를 결과로 반환하는 함수
### Map, Filter, Reduce
[swift.org](https://swift.org)
*/
let array: [Int] = [10,4,4,2,31,5,6,6,13,43,24,123,4123,1253,5]

array.forEach( { (num: Int) in
    print(num)
})
/*:
 ---
 ## Map
 ![Map](Map.png)
 */
let mapArray2 = array.map({ (a: Int) in
    return a * 2
})

let mapArray3 = array.map { num in
    num * 3
}

let mapArray5 = array.map {
    $0 * 5
}

/*:
 ---
 ## Filter
 ![Filter](Filter.png)
 */
let filterEvenArray = array.filter({ (a: Int) in
    return a % 2 == 0
})

let filterOddArray = array.filter {
    $0 % 2 == 1
}

/*:
 ---
 ## Reduce
 ![Reduce](Reduce.png)
 */

let reduceResult = array.reduce(1, { (preValue: Int, nextValue: Int) in
    return preValue + nextValue
})

let num = Array(repeating: 2, count: 10)
let reduceResultMul = num.reduce(1) {
    $0 * $1
}

let testArray = [1,2,3,4,5,6,7]
/*:
 ---
 ## map 만들어보기
 ### 함수로
 */
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
//extension Collection {
//    func customMapWithForEach<T>(closure: (Element) -> T) -> [T] {
//        
//    }
//}

extension Collection {
    func customMap<T>(closure: (Element) -> T) -> [T] {
        var returnValue: [T] = []
        var index: Index = self.startIndex
        var indexCount = 0
        while indexCount < self.count {
            returnValue.append(closure(self[index]))
            index = self.index(after: index)
            indexCount += 1
        }
        return returnValue
    }
}

testArray.customMap{
    $0 * 2
}
