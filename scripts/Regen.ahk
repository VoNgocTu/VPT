#Requires AutoHotkey v2.0

#include farm/Farm-Actions.ahk
#include Utils.ahk


; pidArray := getProcessIds("Bông Xù,00,01,03,05,Yui313,Tiny Tori,Thiên,Địa,Nhân", "..\..\data\runtime.json")
; pidArray := getProcessIds("Bông,Yui", "..\..\data\runtime.json")

; MsgBox(arrayToString(pidArray))

; F12::{
;     resetAuto(pidArray)
;     regen(pidArray) 
; }

; loop {
;     resetAuto(pidArray)
;     regen(pidArray) 
;     Sleep 5000
; }
names := A_Args.get(1)
pidArray := getProcessIds(names, "..\data\accountsV2.json")
F3:: {
    loop 2 {
        regen(pidArray, A_Index)
        Sleep 1000
    }
}