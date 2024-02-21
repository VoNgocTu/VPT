#Requires AutoHotkey v2.0
#SingleInstance Off
#include Farm-Actions.ahk
#include ../Utils.ahk

; 1 name = 1 team.
names := A_Args.get(1)
pidArray := getProcessIds(names, "..\..\data\accountsV2.json")

A_IconTip := "Auto VDD - " names
coordinatesArray := ["x99 y519", "x993 y551"]

loop {
    moveAll(pidArray, coordinatesArray, 1, 1000)
    resetAuto(pidArray, A_Index)
    Sleep 500
    regen(pidArray, A_Index) 
}

~^F12::Pause -1