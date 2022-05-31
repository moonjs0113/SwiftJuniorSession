import Foundation

// Dictionary
// Key와 Value로 구성

// Key는 항상 고유해야한다.
// 정확히는 Hashble 프로토콜을 준수
var stringDictionary: Dictionary<String,String> = ["Rey":"Morning"] //, "Rey":"Afternoon"]
let intDictionary: [Int:String] = [:]
let inferenceDictionary = [8:"팔"] // 타입 추론
type(of: inferenceDictionary)

//let errorDictionary = [:] // 타입추론 안되서 에러

// Value에는 기본 타입뿐만 아니라, 배열, 딕셔너리 등 여러 데이터 타입으로 선언 가능하다
let anyDictionary: [String: Any] = [ "dictionary" : [4:"four"],
                  "array": [1,2,3,4,5],
                   "int": 5 ]

stringDictionary["Rey"]
stringDictionary["CloneRey"] //에러는 아니지만 nil 반환
stringDictionary["Rey"] = "Afternoon" // 수정
stringDictionary["Rey"]
stringDictionary["CloneRey"] = "Morning" //새값

anyDictionary["array"]
anyDictionary.keys
anyDictionary.values

