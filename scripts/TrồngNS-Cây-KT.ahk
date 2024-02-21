#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk
SetControlDelay -1 




names := A_Args.get(1)
try {
    tenNguyenLieu := A_Args.get(2)
} catch {
    tenNguyenLieu := "Lông Thú"
}
ahkIds := getAhkIds(names)

A_IconTip := "Trồng Cây Kim Tiền - " names
coordinatesArray := []


loop {
    ControlSendAll(ahkIds, "{Escape}")
    Sleep 200
    ControlSendAll(ahkIds, "``")
    Sleep 500
    ControlClickAll(ahkIds, "x611 y268")
    Sleep 1500
    ControlClickAll(ahkIds, "x639 y288")
    Sleep 2000
    ControlSendAll(ahkIds, "{Escape}")
    Sleep 200
    ControlClickAll(ahkIds, "x883 y143") ; Thu hoạch
    Sleep 200
    ControlClickAll(ahkIds, "x853 y176") ; Thu hoạch
    Sleep 200
    ControlClickAll(ahkIds, "x892 y197") ; Thu hoạch
    Sleep 7000
    ControlClickAll(ahkIds, "x754 y302") ; Người rơm
    Sleep 1000
    ControlClickAll(ahkIds, "x339 y390") ; Trồng nông sản đặc biệt
    Sleep 1000
    ControlClickAll(ahkIds, "x303 y339") ; Cây kim tiền
    Sleep 1000
    ControlClickAll(ahkIds, "x754 y302") ; Người rơm
    Sleep 1000
    ControlClickAll(ahkIds, "x307 y412") ; Thao tác nông trường
    Sleep 1000
    ControlClickAll(ahkIds, "x303 y339") ; Sử dụng thuốc tăng trưởng
    Sleep 1000
    ControlSendAll(ahkIds, "{Enter}")
    Sleep 200

    if (A_Index == 1 || Mod(A_Index, 10) == 0) {
        dauPet(ahkIds)
        trongTrangVien(ahkIds, tenNguyenLieu)
    }
}


dauPet(ahkIds) {
    resetGui(ahkIds)
    ControlClickAll(ahkIds, "x1008 y357") ; Đấu pet
    Sleep 500

    x := 750
    y := 425

    loop 10 {
        ControlClickAll(ahkIds, "x" x " y" y)
        y := y - 24
        Sleep 500
    }
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