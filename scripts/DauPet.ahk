#Requires AutoHotkey v2.0
#include Utils.ahk
#SingleInstance Off

~F11::Pause -1

names := A_Args.get(1)
ahkIds := getAhkIds(names)

A_IconTip := "Dau Pet - "  names

loop 562 {
; loop 130 {
    dauPet(ahkIds)
    ; resetGui(ahkIds)
    Sleep 10000 
}

resetGui(ahkIds)

ControlSendAll(ahkIds, "p")
Sleep 1000
ControlClickAll(ahkIds, "x564 y176") ; Nhân vật
Sleep 1000
ControlClickAll(ahkIds, "x400 y450") ; Chọn nhân vật đầu tiên
Sleep 1000
ControlClickAll(ahkIds, "x500 y450") ; Chọn nhân vật thứ 2
Sleep 1000
ControlClickAll(ahkIds, "x400 y550") ; Vào game
Sleep 1500

for id in ahkIds {
    WinClose "ahk_id " id
}


dauPet(ahkIds) {
    ; resetGui(ahkIds)
    ; ControlClickAll(ahkIds, "x1008 y357") ; Đấu pet
    Sleep 500

    x := 750
    y := 425

    loop 10 {
        ControlClickAll(ahkIds, "x" x " y" y)
        y := y - 24
        Sleep 500
    }
}