/*:
# Struct & Class

## 공통점
- 내부에 프로퍼티 정의
- 메서드 정의
- 초기화
- Extension
- 프로토콜

## init()
*/


//struct Fahrenheit {
//    var temperature: Double
//    init() {
//        temperature = 32.0
//    }
//}
// or
// 초기값이 항상 같다면

struct Fahrenheit {
    var temperature = 32.0
}
var f = Fahrenheit()
// init()을 여러개 만들 수도 있다.
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

// 프로퍼티가 옵셔널이면, 초기화도 옵션이다.
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

 /*:
  ---
  ## Structure
  ### Value Type
  */
struct Resolution {
    var width = 0
    var height = 0
}

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

//: ![ValueTypeImage](valueType.png)

/*:
### 정의
*/
struct Rectangle {
    var width: Int
    var height: Int

    func getSumHeightWidth() -> Int {
        // self 키워드: 구조체나, 클래스 내의 프로퍼티 임을 나타낸다.
        return self.width + self.height
    }
}

/*:
### Value Type의 값 수정
*/
struct RectangleWithMethod {
    var width: Int
        var height: Int

        func getSumHeightWidth() -> Int {
            return self.width + self.height
        }

    mutating func setWidth(num: Int) {
        self.width += num
    }
}
/*:
### Computed Properties(getter, setter)
*/
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var rect: Rect = Rect()
rect.center // get 호출
rect.center = Point(x: 0.1, y: 1.3)// set 호출
rect.center // get 호출
/*:
---
## Class
### Reference Type
*/
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

//: ![ReferenceTypeImage](ReferType.png)

/*:
### 정의
*/
class Vehicle {
    var currentSpeed = 0.0
    
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func vehicleFunc() {
        print("\(#function) in \(type(of: self))")
    }
}
/*:

### 상속
*/
class Bicycle: Vehicle {
    var hasBasket = false

    func bicycleFunc() {
        print("\(#function) in \(type(of: self))")
    }
}
let bicycle = Bicycle()
bicycle.bicycleFunc()

class HybridBicycle: Bicycle {
    func printMe() {
        print("I am Hybrid Bicycle")
    }
}

class MTB: Bicycle {
    let maxGearLevel = 35
    
    override func bicycleFunc() {
        print("MTB's MaxGearLevel is = \(self.maxGearLevel)")
    }
}
let mtb = MTB()
mtb.bicycleFunc()

/*:

### Property Observers
*/
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 10
/*:

### static, class
*/
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

SomeStructure.storedTypeProperty

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
SomeClass.storedTypeProperty
/*:

---
## Designated init, convenience init, super.init, required init, deinit
*/
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

//: ![convenience](init_1.png)
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        //바로 위의 부모 클래스의 init을 불러온다.
        super.init(name: name)
    }

    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
//: ![convenience](init_2.png)
class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
ShoppingListItem()
//: ![convenience](init_3.png)
class classA {
    required init() {
        print("I'm A")
    }
    init(str: String){
        print("string print", str)
    }
}

class classB: classA {
//    override init(str: String) {
//        super.init(str: str)
//    }
    
    required init() {
        super.init()
        print("classB init")
    }
}
/*:

## deinit
*/
class DeinitClass {
    init(){
        print("init")
    }
    deinit {
        print("deinit")
    }
}

var deinitClass: DeinitClass? = DeinitClass()
deinitClass = nil
