import SwiftUI
/*:
# Extension, Protocol, Generic Basic
[swift.org](https://swift.org)
---
*/
/*:
### Escaping Closures
함수가 끝나면 클로저도 사라진다.
@escaping을 붙여서 함수가 끝나도 남아있도록 할 수 있다.
*/
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

// Code
/*:
 ![escapingClosures](escapingClosures.png)
 */

// Code

/*:
 ![closureCall](closureCall.png)
 */


var intCompletionHandlers: [(Int) -> Void] = []
func someFunctionWithEscapingClosureInt(completionHandler: @escaping (Int) -> Void) {
    intCompletionHandlers.append(completionHandler)
}

someFunctionWithEscapingClosureInt { num in
    print("num escaping closure \(num)")
}

intCompletionHandlers.first?(5)
/*:
 # Extension
 - 계산된 인스턴스 프로퍼티와 계산된 타입 프로퍼티 추가
 - 인스턴스 메서드와 타입 메서드 정의
 - 새로운 초기화 구문 제공
 - 서브 스크립트 정의
 - 새로운 중첩된 타입 정의와 사용
 - 기존 타입이 프로토콜을 준수하도록 함
 ---
 
 ## 확장 구문 (Extension Syntax)
 */
// 기존 선언에 이어서 추가적인 기능을 구현할 수 있다.
// 접근이 제한적인 클래스나 구조체를 확장할 때
// 또는
// 프로토콜 채택 확장 시 코드 간결성을 사용된다.
class SomeType {
    init() {
        
    }
}

// 초기화 구문도 extension에 쓸 수 있다.
extension SomeType {
    convenience init(string: String) {
        print(string)
        self.init()
    }
}

/*:
 ---
 
 ## 계산된 프로퍼티 (Computed Properties)
 */
// 계산된 프로퍼티를 추가할 수 있다.
// 하지만 저장된 프로퍼티나 기존 프로퍼티에 프로퍼티 관찰자는 추가할 수 없다.
extension Int {
    var won: String {
        if self <= 0 {
            return "0원"
        }
        var num = self
        var won = "원"
        repeat {
            won = "\(num % 1000)" + won
            num /= 1000
            won = ((num > 0) ? "," : "") + won
        } while num != 0
        return won
    }
}

// Code

/*:
 ---
 
 ## 메서드 (Methods)
 */
// 함수도 추가할 수 있다.
extension String {
    func toColor(alpha:CGFloat) -> UIColor {
        var hexString = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgbInt: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbInt)
        
        return UIColor.init(red: CGFloat((rgbInt & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgbInt & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat(rgbInt & 0x0000FF) / 255.0,
                            alpha: alpha)
    }
}

// Code

/*:
 ---
 
 ### 인스턴스 메서드 변경 (Mutating Instance Methods)
 */
// Int는 Struct라서 mutatin 붙임
extension Int {
    mutating func square() {
        self = self * self
    }
}

// Code

/*:
 ---
 
 ## 서브 스크립트 (Subscripts)
 */
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

// Code

/*:
 ---
 
 ## 중첩된 타입 (Nested Types)
 */
//extension안에 enum을 정의해서 사용할 수 있다.
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

// Code

/*:
 # Protocol
 ---
 A *__protocol__* defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be *__adopted__* by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to *__conform__* to that protocol.
 */

// 클래스와 구조체의 선언이 제품에 대한 설계도라면, 프로토콜은 요구명세서

// Code

/*:
 ---
 ## 프로퍼티 요구사항 (Property Requirements)
 ## 메서드 요구사항 (Method Requirements)
 */

protocol SomeProtocol {
    var printLine: String { get set }
    var getRequirement: Int { get } // 읽기 전용 프로터티
    func someTypeMethod() -> Double
//    var setRequirement: Int { set }
}

// SomeProtocol을 '채택'했기 때문에
// printLine, getRequirement 두 변수와 someTypeMethod 함수를 반드시 구현해줘야한다.
// SwiftUI 에서 Identifiable을 채택했을 때, id를 만드는 것과 같다.
struct Person: SomeProtocol {
    var printLine: String
    var getRequirement: Int {
        get {
            return self.printLine.count
        }
    }
    
    func someTypeMethod() -> Double {
        return Double.pi
    }
}

var person = Person(printLine: "\(#line)")

// Code

/*:
 ---
 
 ## 초기화 구문 요구사항 (Initializer Requirements)
 */
protocol InitProtocol {
    init(someParameter: Int)
}

// 프로토콜을 따라 init 함수가 받드시 들어가야한다. -> required 생성자가 필요하다!
// Code
/*:
 ---
 
 ## 타입으로 프로토콜 (Protocols as Types)
 */
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        self.lastRandom = ((self.lastRandom * self.a + self.c)
            .truncatingRemainder(dividingBy: self.m))
        return self.lastRandom / self.m
    }
}

struct StructLinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    // struct라서 살짝 바꿔줌
    func random() -> Double {
        var lastRandom = self.lastRandom
        lastRandom = ((lastRandom * self.a + self.c)
            .truncatingRemainder(dividingBy: self.m))
        return lastRandom / self.m
    }
}

let generator = LinearCongruentialGenerator()
let structGenerator = LinearCongruentialGenerator()

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

// generator의 타입이 프로토콜이기 때문에
// 해당 프로토콜을 채택하는 값 또는 객체가 오면 된다.
// Code

/*:
 ---
 
 ## 위임 (Delegation)
 */
// 채택과 준수 같은 기능이 아니라, 디자인 패턴 중 하나다.

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

// AnyObject: 클래스 전용 프로토콜임을 명시
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

/*:
 ![ProtocolAndClass](ProtocolAndClass.png)
 */

// Code

/*:
 ![init](init.png)
 */

// DiceGameDelegate Protocol을 채택하는 객채를 받음
// Code

/*:
 ![delegate](delegate.png)
 */

// Code

/*:
 ![delegateFunc](delegateFunc.png)

 
 ---
 ## 확장으로 프로토콜 준수성 추가 (Adding Protocol Conformance with an Extension)
 */
protocol TextRepresentable {
    var textualDescription: String { get }
}

// Extension으로 프로토콜 추가
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

// Code

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

// Code

/*:
 ---
 
 ## 조건적으로 프로토콜 준수 (Conditionally Conforming to a Protocol)
 */

// Element가 TextRepresentable를 채택하는 요소들인 Array에서 사용하겠다.
// Generic에서 다시 볼 내용입니다.
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

// Code

// 없어요. 있었는데? 아니 그냥 없어요

// Code

/*:
 ---
 
 ## 확장과 함께 프로토콜 채택 선언 (Declaring Protocol Adoption with an Extension)
 */

// 프로퍼티, 메소드 준수를 꼭 채택한 코드블럭에서 할 필요는 없다.
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

// Code

//let ironManTheHamster = Hamster(name: "IronMan")
//let somethingTextRepresentable: TextRepresentable = ironManTheHamster


/*:
 ---
 
 ## 합성된 구현을 사용하여 프로토콜 채택 (Adopting a Protocol Using a Synthesized Implementation)
 - 프로토콜을 준수하는 저장된 프로토콜만 있는 구조체
 - 프로토콜을 준수하는 연관된 타입만 있는 열거형
 - 연관된 타입이 없는 열거형
 */

// x,y,z는 전부 Equatable가 채택되어있다.
struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
    //var string: notEquatable = NotEquatableClass()
}

// extension Double
// let double = Double() -> Hashable -> Equatable

//class NotEquatableClass {
//
//}
//let notEquatableClass0 = NotEquatableClass()
//let notEquatableClass1 = NotEquatableClass()
//notEquatableClass0 == notEquatableClass1

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)

// Vector3D 구조체도 == 연산이 가능해진다.
// Code

// 아래도 마찬가지
enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}

var levels = [SkillLevel.intermediate, SkillLevel.beginner,
              SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]

// Code
/*:
 ---
 
 ## 프로토콜 타입의 콜렉션 (Collections of Protocol Types)
 */

// 같은 프로토콜이 채택되어있기 때문에 가능

// Code

/*:
 ---
 
 ## 프로토콜 상속 (Protocol Inheritance)
 */
// 프로토콜도 다른 프로토콜로부터 상속을 받을 수 있다.
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

/*:
 ---
 
 ## 프로토콜 구성 (Protocol Composition)
 */
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct PersonComposition: Named, Aged {
    var name: String
    var age: Int
}

// & 연산으로 피연산 프로토콜을 모두 채택하는 파라미터를 받을 수 있다.
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = PersonComposition(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

/*:
 ---
 
 ## 프로토콜 준수에 대한 검사 (Checking for Protocol Conformance)
 ``` Swift
 protocol HasArea {
     var area: Double { get }
 }
 
 ...
 
 for object in objects {
     if let objectWithArea = object as? HasArea {
         print("Area is \(objectWithArea.area)")
     } else {
         print("Something that doesn't have an area")
     }
 }
 ```
 ---
 
 ## 옵셔널 프로토콜 요구사항 (Optional Protocol Requirements)
 */
// 채택했다고 해서 모두 준수할 필요는 없다.
// 기술적으로는 허용되지만 좋은 데이터 소스로는 적합합지 않다.
// 프로토콜과 옵셔널 요구사항 모두 @objc 속성으로 표시되어야 한다.

// Code

class Counter {
    var count = 0
//    var dataSource: CounterDataSource?
//    func increment() {
//        if let amount = dataSource?.increment?(forCount: count) {
//            count += amount
//        } else if let amount = dataSource?.fixedIncrement {
//            count += amount
//        }
//    }
}

var counter = Counter()

// @objc 속성으로 선언했기에 struct와 enum 타입에는 사용할 수 없다.
//struct StructThreeSource: CounterDataSource {
//    let fixedIncrement = 3
//}

// Code

/*:
 ---
 
 ## 프로토콜 확장 (Protocol Extensions)
 */
// Protocol 선언에는 동작(Function Body)을 추가할 수 없다.
protocol PrintLine {
    func PrintLine()
//    func PrintLine() {
//        print("RandomNumberGenerator")
//    }
}

// 확장에는 선언과 동작을 함께 작성할 수 있다.
// 이렇게 하면 채택 후에 요구사항를 구현할 필요가 사라진다.
// 채택과 준수가 동시에 이루어진다.

// Code

// let extensionGenerator = LinearCongruentialGenerator()

// Code

/*:
 ---
 
 ### 프로토콜 확장에 제약사항 추가 (Adding Constraints to Protocol Extensions)
 */
// Generic에서 다시 볼 내용입니다.

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
// Code

// 요소들이 Equatable를 채택하고 있지 않아 allEqual을 못 쓴다.
// Code
