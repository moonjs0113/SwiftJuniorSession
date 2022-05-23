import SwiftUI
/*:
# 옵셔널과 타입(with Class)
# 열거형(Enum), 클로저(Closures)

---

## 옵셔널과 타입캐스팅(with Class)
### Class 준비물
*/
class Person {
    var residence: Residence?
}

class Residence {
//    var numberOfRooms: Int = 1
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    // subscript 키워드
    // [] 을 통해 접근가능하도록 한다.
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

let rey = Person()

// subscript랑 rooms가 옵셔널일때 ? 파티가 벌어진다.
// rey.residence?[3]?.name

// residence 값이 nil인 상태에서 강제 언래핑(!) 했기 때문에 런타입 에러가 발생한다.
// let roomCount = rey.residence!.numberOfRooms

// 결과 확인하려면 Residence Class 주석 수정 필요
// 마찬가지로 residence 값이 nil이라 저장연산이 실패한다(런타임, 컴파일 에러가 아님)
// 왜 런타임, 컴파일 에러가 아닐까? -> 뒤에서 알아봅시다.
//rey.residence?.numberOfRooms = 3

/*:
 ---
### 옵셔널 체이닝
*/


// residence의 값이 nil이기 때문에 첫번째 분기로 print
//printNumberOfRooms(person: rey)
// residence에 값 저장
//rey.residence = Residence()
// residence의 값이 있기 때문에 두번째 분기로 print
//printNumberOfRooms(person: rey)

func createAddress() -> Address {
    print("Function was called.")

    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"

    return someAddress
}
let someAddress = Address()
/*:
= 연산도 무언가를 반환한다??
 
옵셔널 체이닝을 통해 프로퍼티를 설정하려는 연산은 Void? 타입의 값을 반환한다.
 
위의 if let 예제가 해당 개념으로 설명이 가능하다.

residence가 nil이기 때문에 옵셔널 체이닝에 의해 address에 값 저장 실패 -> nil이 반환된다.
*/



/*:
 ---
### nil 병합(nil-coalescing)
 
옵셔널 체이닝으로 인한 결과 값이 nil일 때, 대체할 값을 준다.
 
표현식의 반환값을 보면 옵셔널이 언래핑된다!
*/



/*:
 ---
### 타입캐스팅 준비물
*/
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

/*:
 ---
### 상속된 Class의 타입 추론
*/


/*:
### 타입 검사(is)
*/
var movieCount = 0
var songCount = 0



print("Movie \(movieCount)개, Song \(songCount)개")
/*:
### 다운 캐스팅(Downcasting)
 
library의 타입은 [MediaItem]인 상황이다.
*/



/*:
MediaItem이 MediaItem을 상속 받은 하위 클래스로 타입 캐스팅되었기 떄문에 다운 캐스팅
 
다운 캐스팅은 실패할 수 있기 때문에 ?가 붙는다. -> 캐스팅의 결과는 옵셔널 값이다.
 
다운 캐스팅이 100% 성공하는 상황이면 !를 쓸 수도 있지만, 강제 언래핑을 지양하는 것과 비슷한 이유로 잘 쓰진 않는다.

### 업 캐스팅(Upcasting)
다운캐스팅이랑 반대로, 하위클래스가 상위 클래스로 캐스팅되었기 때문에 업캐스팅
 
업캐스팅은 항상 성공한다.
*/
let movie = Movie(name: "Casablanca", director: "Michael Curtiz")



/*:
 ---
## 열거형(Enumerations)
### 열거형 준비물
*/
enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Planet { // : CaseIterable {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

/*:
 ---
### 열거형의 사용
*/



/*:
### 열거형 값 비교
*/



/*:
### 열거형 리터럴
CaseIterable 프로토콜을 통해 채택하여, case의 개수를 가져오거나, 반복이 가능하다.
*/



/*:
### 연관된 값(Associated Values)
이렇게 쓰인다 정도로 이해!
*/
// 선언시, 연관된 값의 타입을 정의
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

// 정의된 형태에 따라 값 저장
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

// switch 구문을 통해서 연관된 값을 var(변수) or let(상수)로 사용
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(var productCode):
    productCode = "NEWABCDEFGHIJKLMNOP"
    print("QR code: \(productCode).")
}

/*:
### 원시값(Raw Velues)
*/
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

enum Planet_Int: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
// earth의 값은?

enum CompassPoint_String: String {
    case north, south, east, west
}
// south의 값은?


/*:
### 재귀 열거형(Recursive Enumerations)

 열거형 안에서 자신을 사용하겠다는 의미

 마찬가지로 지금 당장 이해하겠다기 보단 이렇게도 사용할 수 있다 정도로 이해
*/
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
// 또는

//indirect enum ArithmeticExpression {
//    case number(Int)
//    case addition(ArithmeticExpression, ArithmeticExpression)
//    case multiplication(ArithmeticExpression, ArithmeticExpression)
//}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}


print(evaluate(product))
/*:
![Recursive Enumerations](indirectEnum.png)

### 프로퍼티와 함수
*/

enum AppStorageKey: String {
    case firstUser, popUpClose, token
}

/*:
 ### 열거형을 쓰는 이유
 - 코드가 간결해진다.
 - 하드 코딩의 실수를 줄인다.(오탈자)
 - 코드 작성에 용이하다. (자동완성으로 인한 코드 생산성 향상)

 ---
 ## Closures
 ### 표현식
 ``` Swift
 { (parameters) -> return type in
     statements
 }
 ```
*/
// 클로저의 타입은 파라미터와 리턴 타입으로 표현된다.
let sumClosures: (Int, Int) -> Int


/*:
 ### 클로저의 축약
*/

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

// sorted에 함수를 인자로 주었다.
var reversedNames = names.sorted(by: backward)

/*:
 sorted(by:)의 형태
 ```Swift
 func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element]
 ```
 
 함수 인자를 클로저로 변환
*/


/*:
타입 유추
*/


/*:
단일 표현 클로저의 임시적 변환
*/


/*:
짧은 인자 이름
*/


/*:
연산자 메서드
*/


/*:
### 후행 클로저
클로저를 인자로 받는 함수
*/
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}


/*:
인자라벨 생략
*/


/*:
클로저가 함수의 유일한 인자일 경우 소괄호까지 생략이 가능하다.
*/


/*:
### 다시보자 SwiftUI
 ``` Swift
 Button(action: () -> Void, label: () -> _)
 NavigationLink(title: StringProtocol, destination: () -> _))
 ```
 Button
*/
var buttonToggle = true


/*:
NavigationLink
*/



/*:
### 값 캡쳐
*/
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()
/*:
![Recursive Enumerations](indirectEnum.png)
*/
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incrementBySeven()

/*:
### Reference Type
*/
let referenceTen =  incrementByTen
referenceTen()
incrementByTen()

/*:
### Escaping Closures
함수가 끝나면 클로저도 사라진다.
@escaping을 붙여서 함수가 끝나도 남아있도록 할 수 있다.
*/
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

// 파라미터가 있는 경우
var intCompletionHandlers: [(Int) -> Void] = []
func someFunctionWithEscapingClosureInt(completionHandler: @escaping (Int) -> Void) {
    intCompletionHandlers.append(completionHandler)
}
