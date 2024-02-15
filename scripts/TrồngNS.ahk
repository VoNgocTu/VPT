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

A_IconTip := "Trồng Nông Sản - " tenNongSan " - " names
coordinatesArray := []


loop {
    resetGui(ahkIds)
    Sleep 500
    ControlSendAll(ahkIds, "``")
    Sleep 500
    ControlClickAll(ahkIds, "x611 y268")
    Sleep 1000
    ControlClickAll(ahkIds, "x639 y288")
    Sleep 1500
    resetGui(ahkIds)
    Sleep 200
    ControlClickAll(ahkIds, "x883 y143") ; Thu hoạch
    Sleep 200
    ControlClickAll(ahkIds, "x853 y176") ; Thu hoạch
    Sleep 200
    ControlClickAll(ahkIds, "x892 y197") ; Thu hoạch
    Sleep 7000
    ControlClickAll(ahkIds, "x754 y302") ; Người rơm
    Sleep 1000
    ControlClickAll(ahkIds, "x294 y339") ; Trồng cây ngắn ngày
    Sleep 1000
    chonNongSan(tenNongSan)
    Sleep 500
    
    if (A_Index == 1 || Mod(A_Index, 10) == 0) {
        dauPet(ahkIds)
        trongTrangVien(ahkIds, tenNguyenLieu)
    }
}


chonNongSan(tenNongSan) {
    switch tenNongSan
    {
        case "LuaMach": 
            ControlClickAll(ahkIds, "x327 y343")
        case "LuaGao": 
            ControlClickAll(ahkIds, "x321 y360")
        case "Bap": 
            ControlClickAll(ahkIds, "x317 y384")
        case "KhoaiLang": 
            ControlClickAll(ahkIds, "x316 y414")
        case "DauPhong": 
            ControlClickAll(ahkIds, "x328 y434")
        case "DauNanh": 
            clickXuong(1)
            ControlClickAll(ahkIds, "x328 y434")
        case "CaiThao": 
            clickXuong(2)
            ControlClickAll(ahkIds, "x328 y434")
        case "CuCai": 
            clickXuong(3)
            ControlClickAll(ahkIds, "x328 y434")
        case "Cacao": 
            clickXuong(4)
            ControlClickAll(ahkIds, "x328 y434")
        case "CaoLuong": 
            clickXuong(5)
            ControlClickAll(ahkIds, "x328 y434")
        case "Muop": 
            clickXuong(6)
            ControlClickAll(ahkIds, "x328 y434")
        case "Bau": 
            clickXuong(7)
            ControlClickAll(ahkIds, "x328 y434")
        case "BongCai": 
            clickXuong(8)
            ControlClickAll(ahkIds, "x328 y434")
        case "HoangKimQua":
            clickXuong(9)
            ControlClickAll(ahkIds, "x328 y434")
    }

    Sleep 500
}

clickXuong(solan) {
    loop solan {
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