#Requires AutoHotkey v2.0
#include Utils.ahk

; ahkIds := getAhkIds("Mai,Lan,Cúc,Trúc")
; ahkIds := getAhkIds("Bông")
names := A_Args.get(1)
ahkIds := getAhkIds(names)
F2::{
    ControlClickAll(ahkIds, "x19 y216")
    Sleep 500
    ControlClickAll(ahkIds, "x49 y237")
}