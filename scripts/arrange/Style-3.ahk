#Requires AutoHotkey v2.0
#SingleInstance Force
#include ../Utils.ahk


names := A_Args.get(1)
ahkIds := getAhkIds(names)

x := -10
y := -28

maxAccPerRow := 4
accPerRow := maxAccPerRow
if (ahkIds.Length <= maxAccPerRow) {
    accPerRow := ahkIds.Length
}

xOffset := Round((A_ScreenWidth - 1066) / (accPerRow - 1)) + 5
yOffset := 0

for (ahkId in ahkIds) {
    moveWindow ahkId, x, y

    x := x + xOffset

    if (A_Index / maxAccPerRow == 1) {
        xOffset := -xOffset
        x := x + xOffset
        y := 688
    }
}

moveWindow(ahkId, x := 0, y := 0, w := 1066, h := 724) {
    WinMove x, y, w, h, "ahk_id " ahkId
}