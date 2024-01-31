#Requires AutoHotkey v2.0
#include Utils.ahk

; arrange(names, x := 0, y := 0, w := 1066, h := 724, xOffset := 100, yOffset := 200) 
; arrange A_Args.get(1), -10 , -28 , , , , 117  ; Screen 1920
; arrange A_Args.get(1), -10 , -28 , , , , 230  ; Screen 2560

names := A_Args.get(1)
yOffset := 230 ; 2560 x 1440
if (A_ScreenHeight == 1080) {
    yOffset := 117 ; 1920 x 1080
}
arrange names, -10 , -28 , , , , yOffset