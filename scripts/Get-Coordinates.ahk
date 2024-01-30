#Requires AutoHotkey v2.0


~RButton Up:: {
    title := "Adobe Flash Player 10"
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

getCoordinates() {
    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
    return "x" OutputVarX " y" OutputVarY
}