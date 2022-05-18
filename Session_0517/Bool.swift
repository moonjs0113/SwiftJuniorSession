import Foundation

true && true
true && false

func returnFalse() -> Bool{
    print(false)
    return false
}

func returnTrue() -> Bool{
    print(true)
    return true
}

returnTrue() && returnFalse()
returnFalse() && returnTrue()
// && 연산은 앞에서부터 컨디션을 체크하고 false이 발견되면 그냥 넘깁니다.
// 결과가 거짓일 확률이 높은걸 앞으로 두는게 더 효율적!

false || true
returnFalse() || returnTrue()

!true

print("if")
if returnTrue(), returnFalse() {
    print("returnTrue(), returnFalse()")
}

if returnFalse(), returnTrue() {
    print("returnTrue(), returnFalse()")
}
