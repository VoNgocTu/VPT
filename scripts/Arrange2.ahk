#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk


names := stringToArray(A_Args.get(1))
; ids := WinGetList("Adobe Flash Player 10")
; ids := WinGetList("AutoHotkey v2 Help")



index := 0
x := -10
y := -28
; xOffset := 1050
; yOffset := 714
xOffset := 789 ; 75%
yOffset := 538 ; 75%
w := xOffset
h := yOffset
for (name in names) {
; for (id in ids) {
    move name, x, y, w, h
    ; move id, x, y
    y := y + yOffset - 7
    if (index > 0 && Mod(index, 2) == 1) {
        x := x + xOffset - 15
        y := -28
    }

    index++
    if (index > 3) {
        index := 0
        x := -10
        y := -28
    }
}

move(id, x := 0, y := 0, w := 1066, h := 724) {
    WinMove x, y, w, h, "ahk_pid " getProcessIds(name).get(1)
    ; WinMove x, y, w, h, "ahk_id " id
}