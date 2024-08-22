#Requires AutoHotkey v2.0
#SingleInstance Off

; title := "Adobe Flash Player 32"
title := "Adobe Flash Player 10"
; title := "BlueStacks App Player"
; title := "AutoHotkey v2 Help"

~RButton Up:: {
    pid := WinActive(title)
    if (pid == 0) {
        return
    }

    MouseGetPos &x, &y, &id
    coordinates := "x" x " y" y
    
    result := MsgBox("Copy toạ độ: " coordinates " ?",, "YesNo")
    if (result = "No") {
        return
    } else {
        A_Clipboard := coordinates
    }
}