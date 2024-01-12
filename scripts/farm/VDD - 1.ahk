#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


; pidArray := getProcessIds("Thiên,Bông", "..\..\data\runtime.json")
pidArray := getProcessIds("Mai,Lan,Cúc,Trúc", "..\..\data\runtime.json")
; pidArray := getProcessIds("Long,Lân,Quy,Phụng,Mai", "..\..\data\runtime.json")
coordinatesArray := ["x695 y299", "x542 y459"]
; coordinatesArray := ["x338 y244", "x695 y299", "x542 y459"]

loop {
    ; move(pidArray, coordinatesArray, 1, 1500)
    resetAuto(pidArray)
    regen(pidArray, A_Index) 
    Sleep 5000
}