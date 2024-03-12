#Requires AutoHotkey v2.0

title := "Adobe Flash Player 10"

F10::Pause -1

F11:: {
    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
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
        
        ControlClick coordinates, "ahk_id " ahkId,,,, "NA"
    }
}