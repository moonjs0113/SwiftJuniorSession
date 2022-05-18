import Foundation

// Array
var intStringArray: Array<String> = ["1", "3", "4"]
var engStringArray: [String] = ["a", "b", "c"]
var korStringArray = ["ㄱ", "ㄴ", "ㄷ"] // 타입 추론!
//var errorArray = []
var emptyStringArray = [String]()
// 순서가 존재한다.

korStringArray[0]
// korStringArray[4] // 에러!

emptyStringArray.isEmpty
intStringArray.count
intStringArray.insert("2", at: 1)

korStringArray.contains("ㄱ")
korStringArray.contains("ㄹ")

engStringArray.append("d")
engStringArray.removeFirst()
engStringArray

var matrix = [[1,2,3], [4,5,6], [7,8,9]]
// [[Int]], Array<Array<Int>>
// 8에는 어떻게 접근할까?
// 한번 해보세요!
