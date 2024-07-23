#Requires AutoHotkey v2.0
#SingleInstance Off
#include Farm-Actions.ahk
#include ../Utils.ahk

; 1 name = 1 team.
names := A_Args.get(1)
pidArray := getProcessIds(names)

A_IconTip := "Auto VDD - " names
coordinatesArray := ["x99 y519", "x993 y551"]

loop 1600 {
    moveAll(pidArray, coordinatesArray, 1, 1000)
    resetAuto(pidArray, A_Index)
    Sleep 500
    regen(pidArray, A_Index) 
}

ahkIds := getAhkIds(names)
resetGui(ahkIds)

; ControlSendAll(ahkIds, "p")
; Sleep 1000
; ControlClickAll(ahkIds, "x564 y176") ; Nhân vật
; Sleep 1000
; ControlClickAll(ahkIds, "x400 y450") ; Chọn nhân vật đầu tiên
; Sleep 1000
; ControlClickAll(ahkIds, "x500 y450") ; Chọn nhân vật thứ 2
; Sleep 1000
; ControlClickAll(ahkIds, "x400 y550") ; Vào game
; Sleep 1500

; for id in ahkIds {
;     WinClose "ahk_id " id
; }


~^F12::Pause -1