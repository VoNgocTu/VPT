#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk
SetControlDelay -1 


F11::Pause -1

names := A_Args.get(1)
try {
    tenNguyenLieu := A_Args.get(3)
} catch {
    tenNguyenLieu := "Lông Thú"
}

try {
    channelCoordinate := getChannelCoordinate(A_Args.get(4))
} catch {
    channelCoordinate := ""
}
ahkIds := getAhkIds(names)

A_IconTip :=  " - Nhân vật: " names "`n - Trồng Cây Kim Tiền`n - Nguyên Liệu: " tenNguyenLieu


;                   ["    1    ", "    2    ", "    3    ", "    4    ", "    5    ", "    6    ", "    7    ", "    8    ", "    9    ", "   10    "] 
move_1 :=           ["x492 y351", "x453 y317", "x592 y278", "x538 y250", "x457 y194", "x398 y182", "x423 y126", "x298 y217", "x307 y276", "x375 y338"]
plantLandFront :=   ["x740 y451", "x698 y364", "x822 y294", "x845 y344", "x722 y220", "x649 y178", "x796 y183", "x169 y512", "x437 y339", "x638 y568"]
plantLandCenter :=  ["x710 y417", "x727 y309", "x885 y304", "x727 y305", "x700 y305", "x696 y306", "x703 y139", "x345 y299", "x602 y302", "x721 y523"]
strawMan :=         ["x579 y461", "x595 y354", "x759 y349", "x594 y355", "x572 y349", "x570 y349", "x575 y182", "x221 y355", "x476 y356", "x593 y570"]


; move_1 :=           ["x375 y338"]
; plantLandFront :=   ["x638 y568"]
; plantLandCenter :=  ["x721 y523"]
; strawMan :=         ["x593 y570"]





; ControlClickAll(ahkIds, "x729 y108") ; Tắt Cách chơi
; Sleep 200

loop {

    resetPosition(ahkIds)

    move(ahkIds)

    collect(ahkIds, plantLandCenter)
    
    Sleep 7000

    move(ahkIds)

    click(ahkIds, strawMan)
    Sleep 7000
    
    ControlClickAll(ahkIds, "x339 y390") ; Trồng nông sản đặc biệt
    Sleep 1000
    ControlClickAll(ahkIds, "x303 y339") ; Cây kim tiền
    Sleep 1000

    ; click(ahkIds, strawMan)
    ; Sleep 1000
    ; ControlClickAll(ahkIds, "x307 y412") ; Thao tác nông trường
    ; Sleep 1000
    ; ControlClickAll(ahkIds, "x303 y339") ; Sử dụng thuốc tăng trưởng
    ; Sleep 1000
    ; ControlSendAll(ahkIds, "{Enter}")
    ; Sleep 1000

    resetGui(ahkIds)
    Sleep 200
    
    if (Mod(A_Index, 10) == 1) {
        dauPet(ahkIds)
        trongTrangVien(ahkIds, tenNguyenLieu)
    }
}


resetPosition(ahkIds) {
    resetGui(ahkIds)
    Sleep 200

    ControlClickAll(ahkIds, "x267 y626") ; Chú Thích
    Sleep 100

    loop 5 {
        ControlClickAll(ahkIds, "x408 y627") ; Thu Nhỏ Khung Chat
        Sleep 100
    }

    ControlClickAll(ahkIds, "x924 y157") ; Tắt Q
    Sleep 200

    ControlClickAll(ahkIds, "x525 y486") ; Tắt hướng dẫn, mạng lag đôi khi kik trúng cái này
    Sleep 200
    ControlClickAll(ahkIds, "x491 y365") ; Giải trừ buff auto thám hiểm K1
    Sleep 200
    ControlClickAll(ahkIds, "x365 y626") ; Xoá Chat
    Sleep 200
}


move(ahkIds) {
    global move_1
    global plantLandFront

    resetGui(ahkIds)
    Sleep 200
    resetGui(ahkIds)
    Sleep 200

    ControlSendAll(ahkIds, "``")
    Sleep 2000
   
    click(ahkIds, move_1)
    Sleep 5000

    resetGui(ahkIds)
    Sleep 200
    resetGui(ahkIds)
    Sleep 200

    click(ahkIds, plantLandFront) ; Chạy tới trước mặt đất trồng cây
    Sleep 2000
}


collect(ahkIds, plantLandCenter) {
    for ahkId in ahkIds {
        coordinateArray := coordinateToArray(plantLandCenter.get(A_Index))
        x := coordinateArray.get(1)
        y := coordinateArray.get(2)
    
        offset := 40
        ControlClick "x" x + offset " y" y, "ahk_id " ahkId,,,, "NA"
        Sleep 200
        ControlClick "x" x - offset " y" y, "ahk_id " ahkId,,,, "NA"
        Sleep 200
        ControlClick "x" x " y" y + offset, "ahk_id " ahkId,,,, "NA"
        Sleep 200
        ControlClick "x" x " y" y - offset, "ahk_id " ahkId,,,, "NA"
    }
}


click(ahkIds, coordinateArray) {
    for ahkId in ahkIds {
        ControlClick coordinateArray.get(A_Index), "ahk_id " ahkId,,,, "NA"
    }
}


chonNongSan(ahkIds, tenNongSan) {
    toaDoNongSan := "x330 y430"
    switch tenNongSan
    {
        case "Lúa Mạch": 
            toaDoNongSan := "x330 y330"
        case "Lúa Gạo": 
            toaDoNongSan := "x330 y355"
        case "Bắp": 
            toaDoNongSan := "x330 y380"
        case "Khoai Lang": 
            toaDoNongSan := "x330 y405"
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

    ControlClickAll(ahkIds, toaDoNongSan)
    Sleep 500
}

clickDown(times) {
    loop times {
        ControlClickAll(ahkIds, "x435 y436")
        Sleep 500
    }
}


dauPet(ahkIds) {
    resetGui(ahkIds)
    ControlClickAll(ahkIds, "x1008 y357") ; Đấu pet
    Sleep 500

    x := 750
    y := 425

    enemies := "0,1,2,3,4,5,6,7,8,9"
    attackOrder := stringToArray(Sort(enemies, "Random N D,"))

    loop 10 {
        ControlClickAll(ahkIds, "x" x " y" (y - attackOrder.get(A_Index) * 24))
        Sleep 500
    }

    resetGui(ahkIds)
}

trongTrangVien(ahkIds, tenNguyenLieu) {
    KL  := "x335 y169"
    KLH := "x606 y235"
    G   := "x480 y165"
    GT  := "x341 y270"
    N   := "x607 y168"
    PL  := "x481 y262"
    V   := "x332 y218"
    GV  := "x604 y264"
    LT  := "x476 y228"
    DT  := "x350 y326"

    toaDo := KL
    switch tenNguyenLieu
    {
        case "Kim Loại": 
            toaDo := KL
        case "Kim Loại Hiếm": 
            toaDo := KLH
        case "Gỗ": 
            toaDo := G
        case "Gỗ Tốt": 
            toaDo := GT
        case "Ngọc": 
            toaDo := N
        case "Pha Lê": 
            toaDo := PL
        case "Vải": 
            toaDo := V
        case "Gấm Vóc": 
            toaDo := GV
        case "Lông Thú": 
            toaDo := LT
        case "Da Thú": 
            toaDo := DT
    }
    
    rootX := 205
    rootY := 300
    
    names := A_Args.get(1)
    ahkIds := getAhkIds(names)
    
    resetGui(ahkIds)
    
    ControlClickAll(ahkIds, "x1000 y330") ; trang vien
    Sleep 3000
    ControlClickAll(ahkIds, "x425 y489")  ; Click Nuôi Trồng
    Sleep 1500
    ControlClickAll(ahkIds, toaDo)  ; Chọn Nguyên liệu
    Sleep 1000
    
    plantMaterials(rootX, rootY, ahkIds)
    
    ControlClickAll(ahkIds, "x528 y493") ; Toàn bộ
    Sleep 500
    ControlClickAll(ahkIds, "x564 y307") ; Thu hoạch
    Sleep 5000

    resetGui(ahkIds)
}


plantMaterials(rootX, rootY, ahkIds) {
    x := rootX
    y := rootY
    
    loop 4 {
        plantColumn(x, y, ahkIds)
        x := x + 55
        y := y + 33
    }
}

plantColumn(rootX, rootY, ahkIds) {
    x := rootX
    y := rootY

    loop 4 {
        plantMaterial(x, y, ahkIds)
        x := x + 55
        y := y - 33
    }
}

plantMaterial(x, y, ahkIds, sleepTime := 600) {
    time := sleepTime / 6
    ControlClickAll(ahkIds, "x" x " y" y) ; Click ruộng BOT
    Sleep time
    ControlSendAll(ahkIds, "{Enter}")
    Sleep time
    ControlClickAll(ahkIds, "x" (x + 28) " y" (y - 15)) ; Click ruộng TOP
    Sleep time
    ControlSendAll(ahkIds, "{Enter}")
    Sleep time
    ControlClickAll(ahkIds, "x" (x + 25) " y" y) ; Click ruộng MID
    Sleep time
    ControlSendAll(ahkIds, "{Enter}")
    Sleep time
}

recover(ahkIds, channelCoordinate) {
    if (channelCoordinate != "") {
        ControlClickAll(ahkIds, "x529 y551")
        Sleep 60000
        ControlClickAll(ahkIds, channelCoordinate)
        Sleep 60000
        ControlClickAll(ahkIds, "x400 y450") ; Chọn nhân vật đầu tiên
        Sleep 500
        ControlClickAll(ahkIds, "x500 y450") ; Chọn nhân vật thứ 2
        Sleep 500
        ControlClickAll(ahkIds, "x400 y550") ; Vào game
        Sleep 60000
    }
}

getChannelCoordinate(channelNumber) {
    switch channelNumber {
        case "1": return "x522 y240"
        case "2": return "x522 y275"
        case "3": return "x522 y310"
        case "4": return "x522 y345"
        case "5": return "x522 y380"
        case "6": return "x522 y415"
        case "7": return "x522 y450"
        case "8": return "x522 y485"
    }
}