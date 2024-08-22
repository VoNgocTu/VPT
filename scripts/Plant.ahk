#Requires AutoHotkey v2.0
#SingleInstance Off
#include Base.ahk
SetControlDelay -1 

utils := VptUtils()
; ids := A_Args.get(1)
treeName := A_Args.get(2)
try {
    material := A_Args.get(3)
} catch {
    material := "Lông Thú"
}

A_IconTip :=  " - Nhân vật: " names "`n - Trồng Nông Sản: " treeName "`n - Nguyên Liệu: " material

;                   ["    1    ", "    2    ", "    3    ", "    4    ", "    5    ", "    6    ", "    7    ", "    8    ", "    9    ", "   10    "] 
move_1 :=           ["x492 y351", "x453 y317", "x592 y278", "x538 y250", "x457 y194", "x398 y182", "x423 y126", "x298 y217", "x307 y276", "x375 y338"]
plantLandFront :=   ["x740 y451", "x698 y364", "x822 y294", "x845 y344", "x722 y220", "x649 y178", "x796 y183", "x169 y512", "x437 y339", "x638 y568"]
plantLandCenter :=  ["x710 y417", "x727 y309", "x885 y304", "x727 y305", "x700 y305", "x696 y306", "x703 y139", "x345 y299", "x602 y302", "x721 y523"]
strawMan :=         ["x579 y461", "x595 y354", "x759 y349", "x594 y355", "x572 y349", "x570 y349", "x575 y182", "x221 y355", "x476 y356", "x593 y570"]


loop {

    resetPosition()

    move()

    collect(plantLandCenter)
    
    Sleep 7000

    move()

    clickArray(strawMan)
    Sleep 7000

    clickAll("x294 y339") ; Trồng cây ngắn ngày
    Sleep 1000
    selectTree(treeName)
    Sleep 1000

    resetScreen()
    Sleep 200
    
    petBattle(A_Index)
    plantMaterial(material, A_Index)
}


resetPosition() {
    for acc in accountArray {
        acc.resetWindowSize()
    }

    resetScreen()

    sendAll("p")
    Sleep 500
    loop 2 {
        clickAll("x280 y238") ; Reset FPS về 20
        Sleep 200
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


dauPet(ahkIds) {
    resetScreen()
    clickAll("x1008 y357") ; Đấu pet
    Sleep 500

    x := 750
    y := 425

    enemies := "0,1,2,3,4,5,6,7,8,9"
    attackOrder := StrSplit(Sort(enemies, "Random N D,"), ",")

    loop 10 {
        clickAll("x" x " y" (y - attackOrder.get(A_Index) * 24))
        Sleep 500
    }

    resetScreen()
}

; trongTrangVien(tenNguyenLieu) {
;     KL  := "x335 y169"
;     KLH := "x606 y235"
;     G   := "x480 y165"
;     GT  := "x341 y270"
;     N   := "x607 y168"
;     PL  := "x481 y262"
;     V   := "x332 y218"
;     GV  := "x604 y264"
;     LT  := "x476 y228"
;     DT  := "x350 y326"

;     toaDo := KL
;     switch tenNguyenLieu
;     {
;         case "Kim Loại": 
;             toaDo := KL
;         case "Kim Loại Hiếm": 
;             toaDo := KLH
;         case "Gỗ": 
;             toaDo := G
;         case "Gỗ Tốt": 
;             toaDo := GT
;         case "Ngọc": 
;             toaDo := N
;         case "Pha Lê": 
;             toaDo := PL
;         case "Vải": 
;             toaDo := V
;         case "Gấm Vóc": 
;             toaDo := GV
;         case "Lông Thú": 
;             toaDo := LT
;         case "Da Thú": 
;             toaDo := DT
;     }
    
;     rootX := 205
;     rootY := 300
    
;     names := A_Args.get(1)
;     ahkIds := getAhkIds(names)
    
;     resetScreen()
    
;     clickAll("x1000 y330") ; trang vien
;     Sleep 3000
;     clickAll("x425 y489")  ; Click Nuôi Trồng
;     Sleep 1500
;     clickAll(toaDo)  ; Chọn Nguyên liệu
;     Sleep 1000
    
;     plantMaterials(rootX, rootY, ahkIds)
    
;     clickAll("x528 y493") ; Toàn bộ
;     Sleep 500
;     clickAll("x564 y307") ; Thu hoạch
;     Sleep 5000

;     resetScreen()
; }


; plantMaterials(rootX, rootY, ahkIds) {
;     x := rootX
;     y := rootY
    
;     loop 4 {
;         plantColumn(x, y, ahkIds)
;         x := x + 55
;         y := y + 33
;     }
; }

; plantColumn(rootX, rootY, ahkIds) {
;     x := rootX
;     y := rootY

;     loop 4 {
;         plantMaterial(x, y, ahkIds)
;         x := x + 55
;         y := y - 33
;     }
; }

; plantMaterial(x, y, sleepTime := 600) {
;     time := sleepTime / 6
;     clickAll("x" x " y" y) ; Click ruộng BOT
;     Sleep time
;     sendAll("{Enter}")
;     Sleep time
;     clickAll("x" (x + 28) " y" (y - 15)) ; Click ruộng TOP
;     Sleep time
;     sendAll("{Enter}")
;     Sleep time
;     clickAll("x" (x + 25) " y" y) ; Click ruộng MID
;     Sleep time
;     sendAll("{Enter}")
;     Sleep time
; }

; recover(channelCoordinate) {
;     if (channelCoordinate != "") {
;         clickAll("x529 y551")
;         Sleep 60000
;         clickAll(channelCoordinate)
;         Sleep 60000
;         clickAll("x400 y450") ; Chọn nhân vật đầu tiên
;         Sleep 500
;         clickAll("x500 y450") ; Chọn nhân vật thứ 2
;         Sleep 500
;         clickAll("x400 y550") ; Vào game
;         Sleep 60000
;     }
; }

; getChannelCoordinate(channelNumber) {
;     switch channelNumber {
;         case "1": return "x522 y240"
;         case "2": return "x522 y275"
;         case "3": return "x522 y310"
;         case "4": return "x522 y345"
;         case "5": return "x522 y380"
;         case "6": return "x522 y415"
;         case "7": return "x522 y450"
;         case "8": return "x522 y485"
;     }
; }