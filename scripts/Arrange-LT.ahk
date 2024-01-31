#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk


names := stringToArray(A_Args.get(1))
; ids := WinGetList("Adobe Flash Player 10")
; ids := WinGetList("AutoHotkey v2 Help")

; Total accounts: 8

index := 0
originY := 80

xOffset := 100
yOffset := 80

x := -10 + xOffset * 3
y := originY


for (name in names) {
    move name, x, y
    y := y + yOffset
    if (index < 4) {
        x := x - xOffset
    } else {
        x := x + xOffset
    }

    if (index == 3) {
        x := A_ScreenWidth - 1066 - xOffset * 3 + 10
        y := originY
    }
    index++
}

move(id, x := 0, y := 0, w := 1066, h := 724) {
    WinMove x, y, w, h, "ahk_pid " getProcessIds(name).get(1)
    ; WinMove x, y, w, h, "ahk_id " id
}