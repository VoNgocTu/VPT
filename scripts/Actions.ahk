#Requires AutoHotkey v2.0

bugOnline(processId) {
    ahk_pid := "ahk_pid " processId

    ; Prevent ControlSend error.
    ControlClick "x521 y351", ahk_pid ; Click to center
    Sleep 300
    ControlClick "x521 y351", ahk_pid ; Click to center
    Sleep 300
    ControlClick "x521 y351", ahk_pid ; Click to center
    Sleep 300

    ControlSend "p", , ahk_pid
    Sleep 1000
    ControlClick "x564 y176", ahk_pid ; Nhân vật
    Sleep 1000
    ControlClick "x400 y450", ahk_pid ; Chọn nhân vật đầu tiên
    Sleep 1000
    ControlClick "x500 y450", ahk_pid ; Chọn nhân vật thứ 2
    Sleep 1000
    ControlClick "x400 y550", ahk_pid ; Vào game
    Sleep 1500
    WinClose ahk_pid
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


autoFarm(pidArray) {
    ahk_pid := "ahk_pid " pidArray.get(1)
    loop {
        move(ahk_pid, 5)
        regen(pidArray) 
    }
}

move(ahk_pid, step := 1, sleepTime := 1000)
{
    global pidArray
    loop step {
        ; Move Group 1
        ControlClick "x211 y555", ahk_pid
        Sleep sleepTime
        ControlClick "x231 y555", ahk_pid
        Sleep sleepTime
        ControlClick "x251 y555", ahk_pid
        resetAuto(pidArray) ; 1s
        regen(Array(ahk_pid))

        ; Move Group 2
        ControlClick "x311 y555", ahk_pid
        Sleep sleepTime
        ControlClick "x331 y555", ahk_pid
        Sleep sleepTime
        ControlClick "x351 y555", ahk_pid
        resetAuto(pidArray) ; 1s
        regen(Array(ahk_pid))
    }
}


regen(pidArray, sleepTime := 200) {
    for id in pidArray
    {
        ahk_pid := "ahk_pid " id
        ControlClick "x124 y23", ahk_pid
        Sleep sleepTime
        ControlClick "x103 y81", ahk_pid
        Sleep sleepTime
        ControlClick "x133 y81", ahk_pid
        Sleep sleepTime
    }
}

resetAuto(pidArray)
{
    for id in pidArray
    {
        ControlClick "x968 y355", "ahk_pid " id ; Click auto khi đang trong trận
        Sleep 200
    }
}


refreshUi(pidArray) {
    for id in pidArray
    {
        ControlClick "x968 y355", "ahk_pid " id ; Click gửi tin nhắn
        Sleep 200
    }
}