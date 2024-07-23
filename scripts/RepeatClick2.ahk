#Requires AutoHotkey v2.0
#SingleInstance Force
; #include Config.ahk

F10::Pause -1


F12:: {
    title := "Adobe Flash Player 10"
    ahkId := WinActive(title)  
    loop {
        if (A_IsPaused) {
            return
        }

        OutputVarX := 0
        OutputVarY := 0
        OutputVarWin := 0
        MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
        
        global ahkId
        coordinates := "x" OutputVarX " y" OutputVarY
        ControlClick coordinates, "ahk_id " ahkId,,,, "NA"
        Sleep 100
    }
}
