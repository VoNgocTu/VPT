#Requires AutoHotkey v2.0
#include Config.ahk

F10::Pause -1
coordinates := ""

F11:: {
    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
    global coordinates
    coordinates := "x" OutputVarX " y" OutputVarY

    global title
    ahkId := WinActive(title)  
}

F12:: {
    global title
    ahkId := WinActive(title)
    loop {
        if (A_IsPaused) {
            return
        }
        
        global coordinates
        ControlClick coordinates, "ahk_id " ahkId,,,, "NA"
    }
}