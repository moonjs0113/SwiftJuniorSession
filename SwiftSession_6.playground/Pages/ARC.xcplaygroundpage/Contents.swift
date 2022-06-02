import Foundation
/*:
 # Automatic Reference Counting(ARC)
 [swift.org](https://swift.org)
 
 ---
 
 ## 메모리 구조
 
 ![Memory0](Memory0.png)
 
 ---
 
 ## ARC가 하는 일
 - 인스턴스가 더이상 필요하지 않을 때 자동으로 메모리 할당을 해제
 - 참조 카운팅 관리
 - 클래스의 인스턴스에만 사용 -> 객체라고 불리는 것들에 해당
 - struct, enum은 값 타입이라 일반적으로 해당 안됨
 
 ## ARC 작동 원리
 - 클래스 인스턴스 생성되면 인스턴스와 관련된 프로퍼티와 타입에 대한 정보 저장을 위한 메모리 청크 할당
 - 인스턴스가 필요치 않을 떄 메모리 할당 해제
 - 사용중인 인스턴스를 해제하면 접근불가 -> 접근 시 Crash
 - 인스턴스 참조가 하나라도 존재하는 한 할당을 해제하지 않는다.
 - 프로퍼티, 상수, 변수에 인스터스를 할당할 때마다 강한 참조(Strong Reference)를 만든다.
 
 ## ARC 증가시키기
 */
class ReferencePerson {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: ReferencePerson?
var reference2: ReferencePerson?
var reference3: ReferencePerson?

reference1 = ReferencePerson(name: "Rey")
CFGetRetainCount(reference1)
/*:
 ![reference1](reference1.png)
 */
reference2 = reference1
CFGetRetainCount(reference1)
/*:
 ![reference2](reference2.png)
 */
reference3 = reference1
CFGetRetainCount(reference1)
CFGetRetainCount(reference3)
/*:
 ![reference3](reference3.png)
 */
reference1 = nil
CFGetRetainCount(reference3)
/*:
 ![reference4](reference4.png)
 */
reference2 = nil
CFGetRetainCount(reference3)
/*:
 ![reference5](reference5.png)
 */

reference3 = nil

/*:
 ---
 ## 클래스 강한 참조(Strong Reference Cycle) 만들기
 레퍼런스에 접근할 수는 없지만,
 
 두개 이상의 레퍼런스가 서로를 참조하고 있어 메모리에서 해제가 이루어지지 않는 상태
 */
print("\n=== 강한 참조(Strong Reference Cycle) ===")
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var rey: Person?
var unit4A: Apartment?

// 참조의 기본은 강한 참조
rey = Person(name: "Rey is not Car")
unit4A = Apartment(unit: "4A")

CFGetRetainCount(rey)
CFGetRetainCount(unit4A)
/*:
 ![StrongReferenceCycle](StrongReferenceCycle0.png)
 */
rey?.apartment = unit4A
unit4A?.tenant = rey

CFGetRetainCount(rey)
CFGetRetainCount(unit4A)
/*:
 ![StrongReferenceCycle](StrongReferenceCycle1.png)
 */

rey = nil
unit4A?.tenant?.name
unit4A = nil
// deinit이 안 찍힌다.
/*:
 ![StrongReferenceCycle](StrongReferenceCycle2.png)
 
 ---
 ## 클래스 간의 강한 참조 해결
 ### 약한 참조(Weak References) 사용하기
 */
print("\n=== 약한 참조(Weak References) ===")
class weakPerson {
    let name: String
    init(name: String) { self.name = name }
    var apartment: weakApartment?
    deinit { print("\(name) is being deinitialized") }
}

class weakApartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: weakPerson?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var weakRey: weakPerson?
var weakUnit4A: weakApartment?

weakRey = weakPerson(name: "Weak Rey is not Car")
weakUnit4A = weakApartment(unit: "4A")

CFGetRetainCount(weakRey)

CFGetRetainCount(weakUnit4A)

weakRey?.apartment = weakUnit4A
weakUnit4A?.tenant = weakRey

CFGetRetainCount(weakRey)

CFGetRetainCount(weakUnit4A)

/*:
 ![WeakReference](WeakReference0.png)
 */

weakRey = nil
weakUnit4A?.tenant?.name

// 반대로 하면 메모리에 남아있다.
// weakUnit4A = nil
// weakRey?.apartment?.unit

print(weakUnit4A?.tenant?.name)
CFGetRetainCount(weakUnit4A)
/*:
 ![WeakReference](WeakReference1.png)
 */

weakUnit4A = nil

/*:
 ![WeakReference](WeakReference2.png)
 
 ---
 ### 미소유 참조(Unowned References) 사용하기
 
 다른 인스턴스의 수명이 같거나 더 긴 경우에 사용된다.
 */
print("\n=== 미소유 참조(Unowned References) ===")
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
/*:
 고객은 카드 정보가 없을 수 있지만, 카드는 고객정보가 필수이다.(고객정보 없는 카드는 없다.)
 
 -> 고객 인스턴스의 수명이 카드보다 길 수 밖에 없다.
 */


var customerRey: Customer?

customerRey = Customer(name: "Rey Appleseed")
CFGetRetainCount(customerRey)

customerRey!.card = CreditCard(number: 1234_5678_9012_3456, customer: customerRey!)
CFGetRetainCount(customerRey)

/*:
 ![UnownedReference](UnownedReference0.png)
 */

customerRey = nil

/*:
 ![UnownedReference1](UnownedReference1.png)
 
 ---
 
 ## 클로저 강한 참조 만들기
 */
print("\n=== 클로저 강한 참조(Strong Reference Cycle) ===")
class HTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

/*:
 ![ClosureReference](ClosureReference.png)
 */
paragraph = nil

/*:
 ---
 ### 약한 참조(Weak References) 사용하기
 */
print("\n=== 클로저 약한 참조(Weak Reference) ===")
class WeakHTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = { [weak self] in
        if let text = self?.text {
            return "<\(self?.name)>\(text)</\(self?.name)>"
        } else {
            return "<\(self?.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

var weakParagraph: WeakHTMLElement? = WeakHTMLElement(name: "weak", text: "hello, world!")
print(weakParagraph!.asHTML())

weakParagraph = nil

/*:
 ---
 ### 미소유 참조(Unowned References) 사용하기
 */
print("\n=== 클로저 미소유 참조(Unowned Reference) ===")
class UnownedHTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}
var unownedParagraph: UnownedHTMLElement? = UnownedHTMLElement(name: "unowned", text: "hello, world")
print(unownedParagraph!.asHTML())

/*:
 ![ClosureReference](ClosureReference1.png)
 */
unownedParagraph = nil

