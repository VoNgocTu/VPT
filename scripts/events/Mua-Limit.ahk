#Requires AutoHotkey v2.0
#include Utils.ahk

A_IconTip := "abc"

actionCoordinates := ""
ahkIds := []

~RButton Up:: {
    if (A_IsPaused) {
        return
    }

    title := "Adobe Flash Player 10"
    ahkId := WinActive(title)
    if (ahkId == 0) {
        return
    }

    coordinates := getCoordinates()
    
    result := MsgBox("Xác nhận toạ độ món cần mua: " coordinates " ?",, "YesNo")
    if (result = "No") {
        return
    } else {
        global actionCoordinates
        global ahkIds

        ahkIds := [ahkId]
        actionCoordinates := coordinates
    }
}


F12:: {
    global actionCoordinates
    global ahkIds
    
    loop {
        ControlClickAll(ahkIds, actionCoordinates)
        ControlSendAll(ahkIds, "{Enter}")
        ControlClickAll(ahkIds, "x489 y382")
    }
}

F11::Pause -1