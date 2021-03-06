import Foundation
/*:
# 예외처리 中 throws, rethrows
[swift.org](https://swift.org)
 ---
 ## throws
 ### 에러가 발생할 수 있는 상황임을 알려준다.
*/

enum ExampleError: Error {
    case stringIsNil
}

func canThrowErrors() throws -> String{
    let stringArray: [String] = []
    guard stringArray.first != nil else {
        throw ExampleError.stringIsNil
    }
    return "String!!"
}

do {
    let result = try canThrowErrors()
    print(result)
} catch {
    print(error)
}

/*:
 ---
 ## rethrows
 ### 파라미터가 throws 함수일 경우 rethrows를 사용한다.
*/

func throwFunctionInParameter(function: () throws -> String) rethrows {
    let result = try function()
    print(result)
}

do {
    try throwFunctionInParameter(function: canThrowErrors)
} catch {
    print(error)
}

/*:
 ### rethrows를 안 쓴다면?
*/
func notUseRethrows(function: () throws -> String) {
    do {
        let result = try canThrowErrors()
        print(result)
    } catch {
        print(error)
    }
}

notUseRethrows(function: canThrowErrors)
