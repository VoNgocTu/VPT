#Requires AutoHotkey v2.0
#SingleInstance Off
#include VptUtils.ahk
SetControlDelay -1 

utils := VptUtils()

names := A_Args.get(1)
accountArray := utils.getAccountArray(names)

cycle := 0

petBattleCoordinateArray := []
loop 10 {
    petBattleCoordinateArray.Push("x750 y" 449 - 24 * A_Index)
}

petBattle(cycle) {
    utils.click(accountArray, "x1008 y357") ; Mở Đấu pet
    Sleep 2000
    index := Mod(cycle, 10) + 1
    utils.click(accountArray, petBattleCoordinateArray[index])
    Sleep 500
    utils.click(accountArray, "x1008 y357") ; Tắt Đấu pet
    Sleep 500
}



; x420 y200   x590 y310 => x + 170/3, y + 110/3
; x260 y290   x430 y400 => x + 170/3, y + 110/3 => 1st Row
; x + 160/3   y - 90/3
class ColumnCoordinate {
    coordinateArray := []
    __New(x, y) {
        loop 4 { 
            multiplier := A_Index - 1
            this.coordinateArray.Push("x" x + multiplier * 160 / 3  " y" y - multiplier * 90 / 3)        
        }        
    }

    click(utils, accountArray) {
        for coordinate in this.coordinateArray {
            utils.click(accountArray, coordinate)
            Sleep 500
            utils.send(accountArray, "{Enter}")
            Sleep 500
        }
    }
}
columnCoordinateArray := []
loop 4 {
    multiplier := A_Index - 1
    columnCoordinateArray.Push(ColumnCoordinate(260 + multiplier * 170 / 3, 290 + multiplier * 110 / 3))
}

plantMaterial(name, cycle := 0) {
    coordinate := "x335 y169" ; Kim Loại
    switch name
    {
        case "Kim Loại": 
        case "Kim Loại Hiếm": 
            coordinate := "x606 y235"
        case "Gỗ": 
            coordinate := "x480 y165"
        case "Gỗ Tốt": 
            coordinate := "x341 y270"
        case "Ngọc": 
            coordinate := "x607 y168"
        case "Pha Lê": 
            coordinate := "x481 y262"
        case "Vải": 
            coordinate := "x332 y218"
        case "Gấm Vóc": 
            coordinate := "x604 y264"
        case "Lông Thú": 
            coordinate := "x476 y228"
        case "Da Thú": 
            coordinate := "x350 y326"
    }
    
    utils.click(accountArray, "x1000 y330") ; trang vien
    Sleep 3000
    utils.click(accountArray, "x425 y489")  ; Click Nuôi Trồng
    Sleep 1500
    utils.click(accountArray, coordinate)  ; Chọn Nguyên liệu
    Sleep 1000
    
    if (cycle) {
        index := Mod(cycle, 4) + 1
        columnCoordinateArray[index].click(utils, accountArray)
    } else {
        for columnCoordinate in columnCoordinateArray {
            columnCoordinate.click(utils, accountArray)
        }
    }
    
    utils.click(accountArray, "x528 y493") ; Toàn bộ
    Sleep 500
    utils.click(accountArray, "x564 y307") ; Thu hoạch
    Sleep 5000

    utils.click(accountArray, "x1000 y330") ; trang vien
    Sleep 1000
}

