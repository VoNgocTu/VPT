#Requires AutoHotkey v2.0
#include Utils.ahk

ahkIds := getAhkIds("Mận")
F1::{
    ControlClickAll(ahkIds, "x19 y216")
    Sleep 500
    ControlClickAll(ahkIds, "x49 y237")
}