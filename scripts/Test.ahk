#Requires AutoHotkey v2.0

F1::Pause -1

~LButton:: {
    if (A_IsPaused) {
        return
    }


    try
	{
        WinGetTitle("A")
		id := WinGetPID("A")
	}
	catch
    {
        Sleep 150
        id := WinGetPID("A")
    }
    ; id := WinGetPID("ahk_id 526260")

    MsgBox("Window is active - " id)
}

; if (WinActive("AutoHotkey v2 Help") != 0) {
;     MsgBox("Window is active - " title)
; } else {
;     MsgBox("Window is not active - " title)
; }
