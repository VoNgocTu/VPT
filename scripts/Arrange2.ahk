#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk


names := stringToArray(A_Args.get(1))
; ids := WinGetList("Adobe Flash Player 32")
; ids := WinGetList("AutoHotkey v2 Help")

index := 0
x := -10
y := -28
xOffset := 1050
yOffset := 714
for (name in names) {
; for (id in ids) {
    move name, x, y
    ; move id, x, y
    y := y + yOffset
    if (index > 0 && Mod(index, 2) == 1) {
        x := x + xOffset
        y := -28
    }
    index++
}

move(id, x := 0, y := 0, w := 1066, h := 724) {
    WinMove x, y, w, h, "ahk_pid " getProcessIds(name).get(1)
    ; WinMove x, y, w, h, "ahk_id " id
}