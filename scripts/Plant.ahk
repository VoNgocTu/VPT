#Requires AutoHotkey v2.0
#SingleInstance Off
#include Base.ahk
SetControlDelay -1 

utils := VptUtils()
treeName := A_Args.get(2)
try {
    material := A_Args.get(3)
} catch {
    material := "Lông Thú"
}

isUseGrowthMedicine := false

iconTip := " - Nhân vật: " names "`n - Trồng Nông Sản: " treeName "`n - Nguyên Liệu: " material
A_IconTip := iconTip

utils.log("Bắt đầu trồng trọt cho " iconTip)

for acc in accountArray {
    utils.log("Account: " A_Index " " acc.toString())
}

;                   ["    1    ", "    2    ", "    3    ", "    4    ", "    5    ", "    6    ", "    7    ", "    8    ", "    9    ", "   10    "] 
move_1 :=           ["x492 y351", "x453 y317", "x592 y278", "x538 y250", "x457 y194", "x398 y182", "x423 y126", "x298 y217", "x307 y276", "x375 y338"]
plantLandFront :=   ["x740 y451", "x698 y364", "x822 y294", "x845 y344", "x722 y220", "x649 y178", "x796 y183", "x169 y512", "x437 y339", "x638 y568"]
plantLandCenter :=  ["x710 y417", "x727 y309", "x885 y304", "x727 y305", "x700 y305", "x696 y306", "x703 y139", "x345 y299", "x602 y302", "x721 y523"]
strawMan :=         ["x579 y461", "x595 y354", "x759 y349", "x594 y355", "x572 y349", "x570 y349", "x575 y182", "x221 y355", "x476 y356", "x593 y570"]


loop {

    resetPosition(A_Index)

    move()

    collect(plantLandCenter)
    
    Sleep 7000

    move()

    clickArray(strawMan)
    Sleep 7000

    if (treeName == "Cây Kim Tiền") {
        clickAll("x339 y390") ; Trồng nông sản đặc biệt
        Sleep 1000
        clickAll("x303 y339") ; Cây kim tiền
        Sleep 1000
    
        if (isUseGrowthMedicine) {
            clickArray(strawMan)
            Sleep 1000
            clickAll("x307 y412") ; Thao tác nông trường
            Sleep 1000
            clickAll("x303 y339") ; Sử dụng thuốc tăng trưởng
            Sleep 1000
            sendAll("{Enter}")
            Sleep 1000
        }
    } else {
        clickAll("x294 y339") ; Trồng cây ngắn ngày
        Sleep 1000
        selectTree(treeName)
        Sleep 1000
    }


    resetScreen()
    Sleep 200
    
    petBattle(A_Index)
    plantMaterial(material, A_Index)
}


resetPosition(cycle) {
    for acc in accountArray {
        acc.resetWindowSize()
    }

    resetScreen()

    if (Mod(cycle, 10) == 1) {
        sendAll("p")
        Sleep 500
        loop 2 {
            clickAll("x280 y238") ; Reset FPS về 20
            Sleep 200
        }
    }

    resetScreen()

    clickAll("x237 y623") ; Chat Mật
    Sleep 100

    clickAll("x924 y157") ; Tắt Q
    Sleep 200

    clickAll("x525 y486") ; Tắt hướng dẫn, mạng lag đôi khi kik trúng cái này
    Sleep 200

    clickAll("x491 y365") ; Giải trừ buff auto thám hiểm K1
    Sleep 200
    
    clickAll("x365 y626") ; Xoá Chat
}


; ================================ ACTION ================================

resetScreen() {
    for acc in accountArray {
        acc.resetGui()
    }
    Sleep 200
}


clickAll(coordiante) {
    for acc in accountArray {
        acc.click(coordiante)
    }
}


clickArray(coordinateArray) {
    for acc in accountArray {
        acc.click(coordinateArray.get(A_Index))
    }
}


sendAll(key) {
    for acc in accountArray {
        acc.send(key)
    }
}

; ================================ ACTION ================================


move() {
    resetScreen()
    Sleep 200

    sendAll("``")
    Sleep 2000
   
    clickArray(move_1)
    Sleep 5000

    resetScreen()
    Sleep 200

    clickArray(plantLandFront) ; Chạy tới trước mặt đất trồng cây
    Sleep 2000
}


collect(plantLandCenter) {
    for acc in accountArray {
        strArray := StrSplit(plantLandCenter.get(A_Index), " ")
        x := SubStr(strArray.get(1), 2, 99)
        y := SubStr(strArray.get(2), 2, 99)
    
        offset := 40
        acc.click("x" x + offset " y" y)
        Sleep 200
        acc.click("x" x - offset " y" y)
        Sleep 200
        acc.click("x" x " y" y + offset)
        Sleep 200
        acc.click("x" x " y" y - offset)
    }
}


selectTree(treeName) {
    coordinate := "x330 y430"
    switch treeName
    {
        case "Lúa Mạch": 
            coordinate := "x330 y330"
        case "Lúa Gạo": 
            coordinate := "x330 y355"
        case "Bắp": 
            coordinate := "x330 y380"
        case "Khoai Lang": 
            coordinate := "x330 y405"
        case "Đậu Phộng": 
        case "Đậu Nành": 
            clickDown(1)
        case "Cải Thảo": 
            clickDown(2)
        case "Củ Cải": 
            clickDown(3)
        case "Cacao": 
            clickDown(4)
        case "Cao Lương": 
            clickDown(5)
        case "Mướp": 
            clickDown(6)
        case "Bầu": 
            clickDown(7)
        case "Bông Cải": 
            clickDown(8)
        case "Hoàng Kim Quả":
            clickDown(9)
    }

    clickAll(coordinate)
    Sleep 500
}

clickDown(times) {
    loop times {
        clickAll("x435 y436")
        Sleep 500
    }
}