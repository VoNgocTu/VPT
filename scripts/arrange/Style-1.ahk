#Requires AutoHotkey v2.0
#SingleInstance Force
#include ../Base.ahk


accPerColumn := 4

if (accountArray.Length < 4) {
    accPerColumn := accountArray.Length
}

; Game Window Height: 724
; yOffset := 230 ; 2560 x 1440 => H = 1392 + 28 = 1420

remainSpace := 1430 ; 2560 x 1440 => H = 1392 + 28 = 1420
if (A_ScreenHeight == 1080) {
    remainSpace := 1070 ; 1920 x 1080 => H = 1032 + 28 = 1060
}

yOffset := (remainSpace - 724) / (accPerColumn - 1)
if ( yOffset > 700 ) {
    yOffset := 700
}

xOffset := 100
arrange accountArray, -10, -28, , , xOffset, yOffset


arrange(accountArray, x := 0, y := 0, w := 1066, h := 724, xOffset := 100, yOffset := 200) {
    index := 0
    for acc in accountArray {
        if (index == 4) {
            index := 0
            x := x + 350
        }
        WinMove x + index * xOffset, y + index * yOffset, w, h, acc.ahkId
        index++
    }
}