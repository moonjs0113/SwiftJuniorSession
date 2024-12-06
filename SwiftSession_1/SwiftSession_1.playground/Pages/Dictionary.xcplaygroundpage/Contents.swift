//: [Previous](@previous)
//: # Dictionary

var stringDictionary: Dictionary<String, String> = ["Rey": "Morning"]
let intDictionary: [Int:String] = [:]
let inferenceDictionary =  [8: "팔"] // 타입 추론

// Key는 고유함을 나타낼 수 있는 데이터 타입이라면 무엇이든 가능하다.
// Value는 기본 타입뿐만 아니라, 배열, 딕셔너리 등 여러 데이터 타입으로 선언 가능하다.
let anyDictionary: [String: Any] = [
    "dictionary": [4: "four"],
    "array": [1,2,3,4,5],
    "int": 5
]
print(anyDictionary)
//: [Set](@next)
