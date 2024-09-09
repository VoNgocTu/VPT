#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk
#SingleInstance Off

names := A_Args.get(1)
; names := "Trúc,Mai,Bắp,Lan,Cúc"

A_IconTip := "Auto Farm - " names
pidArray := getProcessIds(names, "..\..\data\accountsV2.json")
; coordinatesArray := ["x425 y254", "x444 y378", "x574 y358", "x600 y267"]
coordinatesArray := []


F11::Pause -1

~RButton Up:: {
    global pidArray
    title := "Adobe Flash Player 10"
    pid := WinActive(title)
    if (pid == 0) {
        return
    }

    pid := pidArray.get(1)
    if (pid == 0) {
        return
    }

    coordinates := getCoordinates()
    
    global coordinatesArray
    if (coordinatesArray.Length == 0) {
        result := MsgBox("Xác nhận toạ độ ốc: " coordinates " ?",, "YesNo")
    }
    if (coordinatesArray.Length == 1) {
        result := MsgBox("Xác nhận toạ độ Ngư Dân: " coordinates " ?",, "YesNo")
    }
    if (coordinatesArray.Length == 2) {
        result := MsgBox("Xác nhận toạ độ Ngư Dân: " coordinates " ?",, "YesNo")
    }
    if (coordinatesArray.Length == 3) {
        result := MsgBox("Tất cả toạ độ đã được xác định, bạn có muốn lấy lại toạ độ?",, "YesNo")
        if (result = "No") {
            return
        } else {
            coordinatesArray := []
            result := MsgBox("Xác nhận toạ độ Ốc: " coordinates " ?",, "YesNo")
        }
    }

    if (result = "No") {
        return
    } else {
        coordinatesArray.Push(coordinates)
    }
}

F12::{
    global pidArray
    global coordinatesArray
    pid := pidArray.get(1)
    while (true) {
        if (A_IsPaused) {
            Sleep 5000
            return
        }    
        farm(pidArray, coordinatesArray)
    }
}
