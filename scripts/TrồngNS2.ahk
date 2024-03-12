#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk
SetControlDelay -1 


F11::Pause -1

names := A_Args.get(1)
tenNongSan := A_Args.get(2)
try {
    tenNguyenLieu := A_Args.get(3)
} catch {
    tenNguyenLieu := "Lông Thú"
}
ahkIds := getAhkIds(names)

A_IconTip :=  " - Nhân vật: " names "`n - Trồng Nông Sản: " tenNongSan "`n - Nguyên Liệu: " tenNguyenLieu

move_1 :=           ["x579 y457", "x493 y347", "x590 y277", "x590 y277"]
move_2 :=           ["x524 y363", "x475 y337", "x605 y260", "x643 y294"]
plantLandFront :=   ["x579 y457", "x651 y278", "x470 y269", "x798 y174"]
plantLandCenter :=  ["x622 y416", "x612 y298", "x608 y303", "x886 y259"]
strawMan :=         ["x492 y464", "x483 y348", "x479 y343", "x755 y304"]


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


; ControlClickAll(ahkIds, "x729 y108") ; Tắt Cách chơi
; Sleep 200

loop {
    ControlClickAll(ahkIds, "x525 y486") ; Tắt hướng dẫn, mạng lag đôi khi kik trúng cái này
    Sleep 200
    ControlClickAll(ahkIds, "x491 y365") ; Giải trừ buff auto thám hiểm K1
    Sleep 200

    move(ahkIds)

    for ahkId in ahkIds {
        coordinateArray := coordinateToArray(plantLandCenter.get(A_Index))
        x := coordinateArray.get(1)
        y := coordinateArray.get(2)
    
        ControlClick "x" x + 80 " y" y, "ahk_id " ahkId,,,, "NA"
        Sleep 200
        ControlClick "x" x - 80 " y" y, "ahk_id " ahkId,,,, "NA"
        Sleep 200
        ControlClick "x" x " y" y + 50, "ahk_id " ahkId,,,, "NA"
        Sleep 200
        ControlClick "x" x " y" y - 50, "ahk_id " ahkId,,,, "NA"
    }
    
    Sleep 7000

    move(ahkIds)

    click(ahkIds, strawMan)
    Sleep 1000
    ControlClickAll(ahkIds, "x294 y339") ; Trồng cây ngắn ngày
    Sleep 1000
    chonNongSan(ahkIds, tenNongSan)
    Sleep 1000

    resetGui(ahkIds)
    Sleep 200
    
    if (A_Index == 1 || Mod(A_Index, 10) == 0) {
        dauPet(ahkIds)
        trongTrangVien(ahkIds, tenNguyenLieu)
    }
}


move(ahkIds) {
    global move_1
    global move_2
    global plantLandFront

    resetGui(ahkIds)
    Sleep 200

    ControlSendAll(ahkIds, "``")
    Sleep 500
   
    ; click(ahkIds, move_1)
    ; Sleep 3000
    click(ahkIds, move_2)
    Sleep 6000

    resetGui(ahkIds)
    Sleep 200

    click(ahkIds, plantLandFront) ; Chạy tới trước mặt đất trồng cây
    Sleep 1000
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