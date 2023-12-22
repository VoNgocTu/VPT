#Requires AutoHotkey v2.0
#include Utils.ahk


~RButton Up:: {
    title := "Adobe Flash Player 32"
    ; title := "AutoHotkey v2 Help"
    pid := WinActive(title)
    if (pid == 0) {
        return
    }

    ; resetGui([pid])
    coordinates := getCoordinates()
    
    result := MsgBox("Copy toạ độ: " coordinates " ?",, "YesNo")
    if (result = "No") {
        return
    } else {
        A_Clipboard := coordinates
    }
}