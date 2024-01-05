#Requires AutoHotkey v2.0


exitLoop := false
coordinatesArray := []

F3:: {
    global exitLoop
    exitLoop := true
}

; F4:: {
;     ; title := "AutoHotkey v2 Help"
;     title := "Terminal"
;     id := WinActive(title)
;     ahk_id := "ahk_id " id

;     ControlSendText "aaaaaaaaaaaaa", , ahk_id
; }

F2::{
    global exitLoop
    exitLoop := false

    title := "Adobe Flash Player 32"
    ; title := "AutoHotkey v2 Help"
    ; title := "Untitled - Notepad"
    id := WinActive(title)
    ahk_id := "ahk_id " id

    global coordinatesArray

    index := 500
    loop 400 {

        ControlClick coordinatesArray.Get(1), ahk_id,,,, "NA" ; ô pass
        loop 4 {
            ControlSend "{Backspace}", , ahk_id
        }
        
        ControlSend index, , ahk_id
      
        ControlClick coordinatesArray.Get(2), ahk_id,,,, "NA" ; nút ok
        
        index--
        if (exitLoop) {
            return
        }
    }
}


~RButton Up:: {
    title := "Adobe Flash Player 32"
    ; title := "AutoHotkey v2 Help"
    ; title := "Untitled - Notepad"
    pid := WinActive(title)
    if (pid == 0) {
        return
    }

    coordinates := getCoordinates()
    
    global coordinatesArray
    if (coordinatesArray.Length == 0) {
        result := MsgBox("Xác nhận toạ độ ô nhập pass: " coordinates " ?",, "YesNo")
    }
    if (coordinatesArray.Length == 1) {
        result := MsgBox("Xác nhận toạ độ nút OK: " coordinates " ?",, "YesNo")
    }
    if (coordinatesArray.Length == 2) {
        result := MsgBox("Tất cả toạ độ đã được xác định, bạn có muốn lấy lại toạ độ?",, "YesNo")
        if (result = "No") {
            return
        } else {
            coordinatesArray := []
            result := MsgBox("Xác nhận toạ độ ô nhập pass: " coordinates " ?",, "YesNo")
        }
    }

    if (result = "No") {
        return
    } else {
        coordinatesArray.Push(coordinates)
    }
}

getCoordinates() {
    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
    return "x" OutputVarX " y" OutputVarY
}
