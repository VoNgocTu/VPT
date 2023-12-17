#Requires AutoHotkey v2.0
SetControlDelay -1 

pidArray := []
coordinatesArray := []

title := "Adobe Flash Player 32"

F9::{
    global pidArray
    pid := WinActive("Adobe Flash Player 32")
    pidArray.Push(pid)
}

F10::{
    global pidArray
    key_id := pidArray.get(1)
    loop {
        move(key_id, 99, 1500)
    }
}

~RButton Up:: {
    if (A_IsPaused) {
        return
    }

    global title
    pid := WinActive(title)
    if (pid == 0) {
        return
    }

    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
    coordinates := "x" OutputVarX " y" OutputVarY
    
    result := MsgBox("Thêm toạ độ: " coordinates " vào danh sách?",, "YesNo")
    if (result = "No") {
        return
    } else {
        coordinatesArray.Push(coordinates)
    }
}

move(key_id, step := 1, sleepTime := 1000)
{
    global pidArray
    global coordinatesArray
    ahk_id := "ahk_id " key_id
    loop step {
        ; regen(pidArray) 
        for coordinates in coordinatesArray {
            ControlClick coordinates, ahk_id,,,, "NA"
            Sleep sleepTime
        }
        resetAuto(pidArray)
        Sleep 500
        ; regen([key_id])
    }
}


regen(pidArray) {
    index := 0
    for id in pidArray {
        ahk_id := "ahk_id " id
        ControlClick "x124 y23", ahk_id,,,, "D"
        Sleep 50
        ControlClick "x124 y23", ahk_id,,,, "U"
        Sleep 50

        ControlClick "x103 y81", ahk_id,,,, "D"
        Sleep 100
        ControlClick "x103 y81", ahk_id,,,, "U"
        Sleep 100
        if (index == 0) {
            loop 4 {
                ControlClick "x103 y81", ahk_id,,,, "D"
                Sleep 100
                ControlClick "x103 y81", ahk_id,,,, "U"
                Sleep 100
            }
        }
        index++
    }
}


resetAuto(pidArray)
{
    for id in pidArray
    {
        ControlClick "x968 y355", "ahk_id " id,,,, "NA" ; Click auto khi đang trong trận
    }
}