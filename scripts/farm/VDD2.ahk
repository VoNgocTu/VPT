#Requires AutoHotkey v2.0
#SingleInstance Off
#include Farm-Actions.ahk
#include ../Utils.ahk

; 1 name = 1 team.
names := A_Args.get(1)
log("", names)
pidArray := getProcessIds(names, "..\..\data\accountsV2.json")

A_IconTip := "Auto VDD - " names
coordinatesArray := ["x695 y299", "x542 y459"]

loop {
    moveAll(pidArray, coordinatesArray, 1, 1300)
    resetAuto(pidArray, A_Index)
    Sleep 500
    regen(pidArray, A_Index) 
}

~^F12::Pause -1