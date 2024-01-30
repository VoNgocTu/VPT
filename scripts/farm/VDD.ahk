#Requires AutoHotkey v2.0
#SingleInstance Off
#include Farm-Actions.ahk
#include ../Utils.ahk


names := A_Args.get(1)
pidArray := getProcessIds(names, "..\..\data\runtime.json")

A_IconTip := "Auto VDD - " names
; coordinatesArray := ["x353 y140", "x798 y109", "x529 y342"]
; coordinatesArray := ["x695 y299", "x542 y459"]
coordinatesArray := ["x919 y183", "x772 y546"] ; Tầng 2

loop {
    move(pidArray, coordinatesArray, 1, 1500)
    resetAuto(pidArray)
    Sleep 500
    regen(pidArray, A_Index) 
}

~^F12::Pause -1