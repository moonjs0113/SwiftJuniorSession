import Foundation

// Set, 집합
let set: Set<Int> = [1,2,1,6,3,2,1,3,4,5,5,5,6]
let IamNotSet = [1,6,2,3,4,4,5,6]
let realSet: Set = [1,2,3,4,5,6]
// 순서, 중복 없음

type(of: IamNotSet)
type(of: realSet)

// 배열에서 중복되는 값을 지우고 싶다
Set(IamNotSet)

