//: [Previous](@previous)
//: # Contional - if, if-else, switch-case
//: ## if
let int3 = 3

if 5 > int3 {
    print("OK")
}

//: ## if-else
if 5 > int3 {
    print("OK")
} else {
    print("NO")
}

//: ## if-else 중첩
if 2 > int3 {
    print("if 2")
} else if 5 > int3{
    print("else if 2")
}

// ifelse와 다른점
// 1이 들어오면 둘다 들어가버림
if 2 > int3 {
    print("if 2")
}
if 5 > int3 {
    print("if 5")
}

let int51 = 51
if 100 > int51, 40 < int51 {
    print("100 > int3, 40 < int3")
}

//: ## Switch
let switchValue = 0
switch switchValue {
case ..<4 :
    print("switch case ..<4")
    fallthrough // 사용하면 조건과 상관없이 다음 case가 실행됩니다.
case 1,3,5,7,9 :
    print("switch case 1,3,5,7,9")
case 5... :
    print("switch case 5...")
case 0,2,4,6,8 :
    print("switch case 0,2,4,6,8")
default:
    print("switch default")
}

//: ## 삼항 조건자
(100 > int51) ? print("100보다 작아요.") : print("100보다 같거나 커요.")

//: [Loop](@next)
