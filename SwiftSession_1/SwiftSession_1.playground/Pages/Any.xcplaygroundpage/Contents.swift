//: [Previous](@previous)
//: # Any, AnyObject, nil
//: ### Any
var anyType: Any
anyType = "string"
MemoryLayout.size(ofValue: anyType)
anyType = false
MemoryLayout.size(ofValue: anyType)
anyType = 1234
MemoryLayout.size(ofValue: anyType)
anyType = Float.infinity
MemoryLayout.size(ofValue: anyType)
// 크기가 고정되어있음

//: ### AnyObject
var anyObject: AnyObject = "String is not Object."

//: ### nil
//: 아무 값도 없음을 나타내는 키워드, 다른 언어에서는 null, none 등으로 사용된다. 타입은 아니다.
//: 값이 없음을 나타내는 값이다.

//: [Tuple](@next)
