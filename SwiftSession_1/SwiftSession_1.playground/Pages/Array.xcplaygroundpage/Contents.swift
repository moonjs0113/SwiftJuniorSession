//: [Previous](@previous)
//: # Array

var intArray: Array<Int> = [3, 1, 4, 1, 5, 9, 2]
var stringArray: Array<String> = ["S", "TR", "IN", "G"]
var floatArray: Array<Float> = [0.0, 0.5, 1.23]

var intStringArray: Array<String> = ["1", "3", "4"]
var engStringArray: [String] = ["a", "b", "c"]
var korStringArray = ["ㄱ", "ㄴ", "ㄷ"] // 타입 추론!
var emptyStringArray = [String]()

korStringArray[0] // "ㄲ"
// 아래 주석을 해제하고 실행해보세요.
// korStringArray[4] // 에러!!

emptyStringArray.isEmpty
intStringArray.count
intStringArray.insert("2", at: 1)
korStringArray.contains("7")
korStringArray.contains("=")
engStringArray.append("d")
engStringArray.removeFirst()
//: [Dictionary](@next)
