#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Bắp", "..\..\data\runtime.json")
coordinatesArray := ["x695 y299", "x542 y459"]
; coordinatesArray := ["x338 y244", "x695 y299", "x542 y459"]


key_id := pidArray.get(1)
loop {
    move(pidArray, coordinatesArray, 1, 1500)
    resetAuto(pidArray)
    Sleep 500
    regen(pidArray, A_Index) 
}