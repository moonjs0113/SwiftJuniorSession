import Foundation

// Tuple

// 이름 지정가능
let 포항공대맛집 = ("버거킹", "투썸플레이스")
let 투썸메뉴 = (menu: "아이스아메리카노", price: 4500)

포항공대맛집.0 // "버거킹"
포항공대맛집.1 // "투썸플레이스"


type(of: 포항공대맛집) // (String, String)

투썸메뉴.menu // "아이스아메리카노"
투썸메뉴.price // 4500

