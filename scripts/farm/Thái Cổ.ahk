#Requires AutoHotkey v2.0
#SingleInstance Force
#include Farm-Actions.ahk
#include ../Utils.ahk


names := A_Args.get(1)
pidArray := getProcessIds(names)
ahkIds := []
for id in pidArray {
    ahk_id := WinExist("ahk_pid" id)
    if (ahk_id != 0) {
        ahkIds.Push(ahk_id)
    }
}

A_IconTip := "Auto Thái Cổ - " names


loop {
    keyId := ahkIds.Get(1)
    loop 10 {
        ControlClick "x209 y573", "ahk_id " keyId,,,1, "NA" ; Click Thái Cổ
        Sleep 1000
    }
    
    resetGui([keyId])
    ControlSend "Q", , "ahk_id " keyId
    Sleep 1000
    ControlClick "x209 y573", "ahk_id " keyId,,,1, "NA" ; Click Bỏ
    Sleep 500
    ControlClick "x491 y372", "ahk_id " keyId,,,1, "NA" ; Click Xác Nhận
    Sleep 500
    resetGui([keyId])
    
    resetAuto(pidArray)
    Sleep 500
    regen(pidArray, A_Index) 
}

~^F12::Pause -1