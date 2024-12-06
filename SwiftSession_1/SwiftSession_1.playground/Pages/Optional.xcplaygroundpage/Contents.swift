//: [Previous](@previous)
//: # Optional(옵셔널)
var intValue: Int = 100
var optionalInt: Optional<Int> = nil
var optionalString: String? = nil

// 주석을 해제하고 실행시켜보세요.
//intValue = nil

optionalInt = 100
//: ## 작동방식
//: 사실 enum과 Generic으로 작동한다.
// 아래 Optional을 command(⌘) + 우클릭해서 코드를 확인해보세요.
Optional
switch optionalInt {
case .none:
    print("nil!")
case .some(let intValue):
    print("\(intValue)")
}
// 위 코드의 정확한 작동 방식은 enum과 Generic을 알았을 때 다시 보도록하자!

// 기본 더하기도 안 됨
// optionalInt + 10

//: ## 강제 옵셔널 언래핑 - 강제 추출 ! 기호
// nil 값이 없는 안전한 상태입니다~ 이지만 nil이면 난리난다
// 좋은 방법은 아니다!
// 실행하는 동안 죽어도 정말정말 nil 값이 아닌데요?? -> 그럴거면 optional을 왜 쓰나요?
//optionalInt = nil

optionalInt.self
optionalInt!.self
optionalString.self
// optionalString!.self // nil이라 안됨

optionalString = "I am not optional!"
//: ## Optional Binding
//: ### if-let
//: 죽어도 옵셔널이 아닌 구간을 만들자!
if let stringValue = optionalString {
    stringValue
} else {
    print("optionalString is nil")
}
//: ### guard-let
//: Or 옵셔널을 풀고 쓰고 싶다!
func isOptionalValue(optionalString: String?) -> String {
    // Condition State라서 true/false로 해도 됨
    // 좋은 점은 확인 이후 변수로 계속 사용할 수 있다는 점
    // guard 함수안에서만 쓰인다.
    guard let stringValue = optionalString else {
        return ""
    }
    print(stringValue)
    return stringValue
}

//: ## 암시적으로 언래핑된 옵셔널
var assumedString: String! = nil //"An implicitly unwrapped optional string."

//assumedString = nil
//let implicitString: String = assumedString

var optionalIntArray: Array<Int?> = []
var intOptionalArray: Array<Int>? = []
var optionalIntOptionalArray: Array<Int?>? = nil
//: [End](@next)
