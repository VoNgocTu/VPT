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

petBattle(processId) {
    ahk_pid := "ahk_pid " processId

    ControlSend "{Escape}", , ahk_pid
    Sleep 200
    ControlSend "{Escape}", , ahk_pid
    Sleep 200
    ControlSend "{Escape}", , ahk_pid
    Sleep 200

    ControlClick "x1008 y360", ahk_pid ; Đấu pet
    Sleep 2000
    ControlClick "x460 y126", ahk_pid ; sửa đổi thiết lập 1
    Sleep 1000
    ControlClick "x447 y388", ahk_pid ; sửa đổi thiết lập 2
    Sleep 1500
    ControlClick "x523 y363", ahk_pid ; OK
    Sleep 500
    ControlClick "x750 y216", ahk_pid ; Đấu 1
    Sleep 500
    ControlClick "x750 y242", ahk_pid ; Đấu 2
    Sleep 500
    ControlClick "x750 y267", ahk_pid ; Đấu 3
    Sleep 500
    ControlClick "x750 y295", ahk_pid ; Đấu 4
    Sleep 500
}

autoPlant(processId) {
    ahk_pid := "ahk_pid " processId

    ControlSend "{Escape}", , ahk_pid
    Sleep 200
    ControlSend "{Escape}", , ahk_pid
    Sleep 200
    ControlSend "{Escape}", , ahk_pid
    Sleep 200

    ControlClick "x1000 y330", ahk_pid ; trang vien
    Sleep 5000
    ControlClick "x425 y489", ahk_pid ; Nuoi trong
    Sleep 2000
    ControlClick "x345 y178", ahk_pid ; Chọn Kim loại
    Sleep 2000

    plantMaterials(ahk_pid)
    plantMaterials(ahk_pid)
    plantMaterials(ahk_pid)

    ControlClick "x528 y493", ahk_pid ; Toàn bộ
    Sleep 500
    ControlClick "x398 y278", ahk_pid ; Thu hoạch
    Sleep 500
    ControlClick "x398 y278", ahk_pid ; Thu hoạch
    Sleep 5000
}

plantMaterials(processId) {
    ahk_pid := "ahk_pid " processId

    plantMaterial("x235 y299", ahk_pid) ; 1
    plantMaterial("x281 y262", ahk_pid) ; 2
    plantMaterial("x334 y231", ahk_pid) ; 3
    plantMaterial("x386 y197", ahk_pid) ; 4

    plantMaterial("x457 y236", ahk_pid) ; 8
    plantMaterial("x393 y266", ahk_pid) ; 7
    plantMaterial("x338 y300", ahk_pid) ; 6
    plantMaterial("x285 y328", ahk_pid) ; 5
}

plantMaterial(coordinates, ahk_pid, sleepTime := 400) {
    ControlClick coordinates, ahk_pid
    Sleep sleepTime/2
    ControlClick "x524 y371", ahk_pid ; OK when error
    Sleep sleepTime/2
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