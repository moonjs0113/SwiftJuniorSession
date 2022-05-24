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

// residence 값이 nil인 상태에서 강제 언래핑(!) 했기 때문에 런타입 에러가 발생한다.
// let roomCount = rey.residence!.numberOfRooms

// subscript랑 rooms가 옵셔널일때 ? 파티가 벌어진다.
// rey.residence?[3]?.name

// 결과 확인하려면 Residence Class 주석 수정 필요
// 마찬가지로 residence 값이 nil이라 저장연산이 실패한다(런타임, 컴파일 에러가 아님)
// 왜 런타임, 컴파일 에러가 아닐까? -> 뒤에서 알아봅시다.
//rey.residence?.numberOfRooms = 3

/*:
 ---
### 옵셔널 체이닝
*/
func printNumberOfRooms(person: Person) {
    if let roomCount = person.residence?.numberOfRooms {
        print("roomCount 값: \(roomCount)")
    } else {
        print("옵셔널 체이닝 결과 nil")
    }
}

// residence의 값이 nil이기 때문에 첫번째 분기로 print
printNumberOfRooms(person: rey)
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

// if ((rey.residence?.address = someAddress) != nil) {
if ((rey.residence?.address = createAddress()) != nil) {
    print("address 값 저장 성공!")
} else {
    print("address 값 저장 실패!")
}

/*:
 ---
### nil 병합(nil-coalescing)
 
옵셔널 체이닝으로 인한 결과 값이 nil일 때, 대체할 값을 준다.
 
표현식의 반환값을 보면 옵셔널이 언래핑된다!
*/
print(rey.residence?.address?.buildingName)
type(of: rey.residence?.address?.buildingName) // Optional<String>

print(rey.residence?.address?.buildingName ?? "포항공과대학교 C5")
type(of: rey.residence?.address?.buildingName ?? "포항공과대학교 C5") // String

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
library.self // [MediaItem]으로 타입추론 되었다.

/*:
### 타입 검사(is)
*/
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie { // Movie 타입인지 검사
        movieCount += 1
    } else if item is Song { // Song 타입인지 검사
        songCount += 1
    }
}
print("Movie \(movieCount)개, Song \(songCount)개")

/*:
### 다운 캐스팅(Downcasting)
 
library의 타입은 [MediaItem]인 상황이다.
*/
(library[0] as? Movie).self
(library[3] as? Movie).self
for item in library {
    if let movie = (item as? Movie) { // item이 Movie로서 저장이 되는가?
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = (item as? Song) { // item이 Song으로서 저장이 되는가?
        print("Song: \(song.name), by \(song.artist)")
    }
}

/*:
MediaItem이 MediaItem을 상속 받은 하위 클래스로 타입 캐스팅되었기 떄문에 다운 캐스팅
 
다운 캐스팅은 실패할 수 있기 때문에 ?가 붙는다. -> 캐스팅의 결과는 옵셔널 값이다.
 
다운 캐스팅이 100% 성공하는 상황이면 !를 쓸 수도 있지만, 강제 언래핑을 지양하는 것과 비슷한 이유로 잘 쓰진 않는다.

### 업 캐스팅(Upcasting)
다운캐스팅이랑 반대로, 하위클래스가 상위 클래스로 캐스팅되었기 때문에 업캐스팅
 
업캐스팅은 항상 성공한다.
*/
let movie = Movie(name: "Casablanca", director: "Michael Curtiz")
(movie as MediaItem).self
(movie as MediaItem).name

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

enum Planet: CaseIterable {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

/*:
 ---
### 열거형의 사용
*/
var directionToHead = CompassPoint.south
directionToHead.self // 열거형도 하나의 타입이 된다.

/*:
### 열거형 값 비교
*/
directionToHead = .west
switch directionToHead {
case .north:
    print("북쪽")
case .south:
    print("남쪽")
case .east:
    print("동쪽")
case .west:
    print("서쪽하늘은 좋은 노래")
}

// east, west case가 고려되지 않았기 때문에 실행불가
// default 추가를 통해 실행 가능
//switch directionToHead {
//case .north:
//    print("북쪽")
//case .south:
//    print("남쪽")
//default:
//    print("나머지")
//}

/*:
### 열거형 리터럴
CaseIterable 프로토콜을 통해 채택하여, case의 개수를 가져오거나, 반복이 가능하다.
*/
let numberOfPlanet = Planet.allCases.count
for beverage in Planet.allCases {
    print(beverage)
}
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
Planet_Int.earth.rawValue

enum CompassPoint_String: String {
    case north, south, east, west
}
// south의 값은?
CompassPoint_String.south.rawValue

let possiblePlanet = Planet_Int(rawValue: 7)
possiblePlanet

let positionToFind = 11
if let somePlanet = Planet_Int(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("지구!")
    default:
        print("지구는 아니지만 암튼 Planet")
    }
} else {
    print("Planet이 아닌 무언가?")
}

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
    
    var title: String {
        switch self {
        case .firstUser:
            return "FIRST_USER"
        case .popUpClose:
            return "POPUP_CLOSE"
        case .token:
            return "TOKEN_KEY"
        }
    }
    
    func returnKeyLength(enumCase: AppStorageKey) -> Int {
        return enumCase.title.count
    }
}

AppStorageKey.token.returnKeyLength(enumCase: .token)

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
let sumClosures: (Int, Int) -> Int = { x, y in
    return x + y
}
let sumResult = sumClosures(4,5) // 9
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
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
/*:
타입 유추
*/
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
/*:
단일 표현 클로저의 임시적 변환
*/
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
/*:
짧은 인자 이름
*/
reversedNames = names.sorted(by: { $0 > $1 } )
/*:
연산자 메서드
*/
reversedNames = names.sorted(by: >)
/*:
### 후행 클로저
클로저를 인자로 받는 함수
*/
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

someFunctionThatTakesAClosure(closure: {
    
})

/*:
인자라벨 생략
*/
someFunctionThatTakesAClosure() {
    
}

/*:
클로저가 함수의 유일한 인자일 경우 소괄호까지 생략이 가능하다.
*/
someFunctionThatTakesAClosure {
    
}

/*:
### 다시보자 SwiftUI
 ``` Swift
 Button(action: () -> Void, label: () -> _)
 NavigationLink(title: StringProtocol, destination: () -> _))
 ```
 Button
*/
var buttonToggle = true
Button(action: {
    buttonToggle.toggle()
}, label: {
    Text("Button")
})

Button {
    buttonToggle.toggle()
} label: {
    Text("Button")
}

/*:
NavigationLink
*/
NavigationLink("다음페이지", destination: Text("destination 라벨"))
NavigationLink("다음페이지") {
    Text("후행 클로저 라벨 생략")
}

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
someFunctionWithEscapingClosure {
    print("escaping closure")
}
completionHandlers.first?()

var intCompletionHandlers: [(Int) -> Void] = []
func someFunctionWithEscapingClosureInt(completionHandler: @escaping (Int) -> Void) {
    intCompletionHandlers.append(completionHandler)
}
someFunctionWithEscapingClosureInt { num in
    print("num escaping closure \(num)")
}
intCompletionHandlers.first?(5)
