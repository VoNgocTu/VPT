#Requires AutoHotkey v2.0

F12::{
    title := "Adobe Flash Player 10"
    ; title := "AutoHotkey v2 Help"
    pid := WinActive(title)
    if (pid == 0) {
        return
    }
    
    id := "ahk_id " pid
    receiveMail("x355 y207", id, 500)
    receiveMail("x355 y227", id, 500)
    receiveMail("x355 y247", id, 500)
    receiveMail("x355 y267", id, 500)
    receiveMail("x355 y287", id, 500)
    receiveMail("x355 y307", id, 500)
    receiveMail("x355 y327", id, 500)
    receiveMail("x355 y347", id, 500)
    receiveMail("x355 y367", id, 500)
    receiveMail("x355 y387", id, 500)
    receiveMail("x355 y407", id, 500)
    receiveMail("x355 y427", id, 500)

    ControlClick "x227 y457", id,,,, "NA" ; click checkbox
    Sleep 250
    ControlClick "x283 y453", id,,,, "NA" ; xoá
    Sleep 250
    ControlSend "{Enter}", , id
    Sleep 250
    ControlClick "x227 y457", id,,,, "NA" ; click checkbox
    Sleep 250
}


receiveMail(coordinates, id, delay := 500) {
    ControlClick coordinates, id,,,, "NA" ; mail
    Sleep delay / 2
    ControlClick "x700 y398", id,,,, "NA" ; Nhận
    Sleep delay / 2
}