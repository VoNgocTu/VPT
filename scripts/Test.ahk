#Requires AutoHotkey v2.0

F1::Pause -1

~LButton:: {
    if (A_IsPaused) {
        return
    }


    try
	{
		title := WinGetTitle("A")
	}
	catch
    {
    }
    Sleep 150
    title := WinGetTitle("A")

    MsgBox("Window is active - " title)
}

; if (WinActive("AutoHotkey v2 Help") != 0) {
;     MsgBox("Window is active - " title)
; } else {
;     MsgBox("Window is not active - " title)
; }
