#Requires AutoHotkey v2.0
#SingleInstance Force
#include ../Utils.ahk


; names := A_Args.get(1)
ids := stringToArray(A_Args.get(1))

x := -10
y := -28

maxAccPerRow := 4
accPerRow := maxAccPerRow
if (ids.Length <= maxAccPerRow) {
    accPerRow := ids.Length
}

xOffset := Round((A_ScreenWidth - 1066) / (accPerRow - 1)) + 5
yOffset := 0

for (ahkId in ids) {
    moveWindow ahkId, x, y

    x := x + xOffset

    if (A_Index / maxAccPerRow == 1) {
        xOffset := -xOffset
        x := x + xOffset
        y := 688
    }
}

moveWindow(ahkId, x := 0, y := 0, w := 1066, h := 724) {
    WinMove x, y, w, h, ahkId
}