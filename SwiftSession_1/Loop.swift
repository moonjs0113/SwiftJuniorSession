import Foundation

// items에는 꼭 콜렉션 타입(배열같은 요소의 나열 형태)이 와야한다.
// for i = 0 ; i > 6 ; i++ {
//
// }
    
print("## for-in Rey is Morning ##")
for char in "Rey is Morning" {
    print(char)
}

print("\n## for-in 0...4 ##")
for num in 0...4 {
    print(num)
}
let anyDictionary: [String: Any] = [ "dictionary" : [4:"four"],
                  "array": [1,2,3,4,5],
                   "int": 5 ]
for element in  anyDictionary {
    print(element)
    print(element.key)
    print(element.value)
}

var num = 3

print("\n## while ##")
while num > 0 {
    print(num)
    num -= 1
}

// 조건 체크 -> 실행 -> 조건체크 ...
print("\n## while start num = 0 ##")
num = 0
while num > 0 {
    print("while num: \(num)")
    num -= 1
}

// 실행 -> 조건체크 -> 실행 ...
print("\n## repeat-while start num = 0 ##")
num = 0
repeat {
    print("repeat-while num: \(num)")
    num -= 1
} while num > 0


// break로 나갈 수 있다.
print("\n## while with break, start num = 1 ##")
num = 1
while num > 0 {
    print("while num: \(num)")
    num += 1
    if num == 3 {
        print("break! \(num)")
        break
    }
}

// namespace
let engString = "ABCDEFG"
let korString = "ㄱㄴㄷㄹㅁㅂㅅ"
engLoop: for eng in engString {
    print(eng)
    if eng == "B" {
        continue
    }
    for kor in korString {
        print(eng,kor)
        if eng == "D" && kor == "ㄷ" {
//            break
            break engLoop
        }
    }
}
