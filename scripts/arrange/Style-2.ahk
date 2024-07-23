#Requires AutoHotkey v2.0
#SingleInstance Force
#include ../Utils.ahk

names := A_Args.get(1)

index := 0
x := -10
y := -28
xOffset := 500
yOffset := 700
; xOffset := 789 ; 75%
; yOffset := 538 ; 75%
; w := xOffset
; h := yOffset

for (ahkid in getAhkIds(names)) {
    moveWindow ahkid, x, y
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

moveWindow(ahkId, x := 0, y := 0, w := 1066, h := 724) {
    WinMove x, y, w, h, "ahk_id " ahkId
}