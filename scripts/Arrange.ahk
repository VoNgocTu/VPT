#Requires AutoHotkey v2.0
#include Utils.ahk

; arrange(names, x := 0, y := 0, w := 1066, h := 724, xOffset := 100, yOffset := 200) 
; arrange A_Args.get(1), -10 , -28 , , , , 117  ; Screen 1920
; arrange A_Args.get(1), -10 , -28 , , , , 230  ; Screen 2560

names := A_Args.get(1)
nameArray := stringToArray(names)
accPerColumn := 4
if (nameArray.Length < 4) {
    accPerColumn := nameArray.Length
}

; maxYOffset 724
; yOffset := 230 ; 2560 x 1440 => H = 1392 + 28 = 1420
remainSpace := 1430 ; 2560 x 1440 => H = 1392 + 28 = 1420
if (A_ScreenHeight == 1080) {
    remainSpace := 1070 ; 1920 x 1080 => H = 1032 + 28 = 1060
}

yOffset := (remainSpace - 724) / (accPerColumn - 1)
if ( yOffset > 700 ) {
    yOffset := 700
}

arrange names, -10 , -28 , , , , yOffset