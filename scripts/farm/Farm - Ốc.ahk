#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk
#SingleInstance Force

names := "Trúc,Long,Lân,Quy,Phụng"
pidArray := getProcessIds(names, "..\..\data\runtime.json")
coordinatesArray := []

F11::Pause -1


~RButton Up:: {
    global pidArray
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

        getQuest(pid)
        
        loop 5 {
            ControlClick coordinatesArray.Get(1), "ahk_pid " pid ; Chọn ốc 
            Sleep 2000
        }

        regen(pidArray, A_Index) 

        loop 5 {
            ControlClick coordinatesArray.Get(2), "ahk_pid " pid ; chọn ngư phu
            Sleep 2000
        }
        
        removeQuest(pid)

        resetAuto(pidArray)
        regen(pidArray, A_Index) 
    }
}

getQuest(pid) {
    ControlClick coordinatesArray.Get(2), "ahk_pid " pid ; chọn ngư phu
    Sleep 2000
    ControlClick "x333 y333", "ahk_pid " pid ; chọn nhiệm vụ
    Sleep 1000
    ControlClick "x304 y421", "ahk_pid " pid ; Nhận
    Sleep 1000
}

removeQuest(pid) {
    ControlClick "x333 y333", "ahk_pid " pid ; chọn nhiệm vụ
    Sleep 1000
    ControlClick "x328 y418", "ahk_pid " pid ; bỏ
    Sleep 1000
    ControlClick "x508 y372", "ahk_pid " pid ; xác nhận
    Sleep 1000
}
