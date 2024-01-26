#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk
SetControlDelay -1 

F1::Pause -1

title := "Adobe Flash Player 32"
; title := "AutoHotkey v2 Help"

; ahkIds := getAhkIds(A_Args.get(1))
ahkIds := []
; ahkIds := WingetList(title)


~Escape::
~Enter::
~Ctrl::
~`::
~1::
~2::
~3::
~4::
~5::
~6::
~7::
~8::
~9::
~a::
~b::
~c::
~d::
~e::
~f::
~g::
~h::
~i::
~j::
~k::
~l::
~m::
~n::
~o::
~p::
~q::
~r::
~s::
~t::
~u::
~v::
~w::
~x::
~y::
~z:: {
    if (A_IsPaused) {
        return
    }

    global title
    try {
        WinGetTitle("A")
        ahkId := WinActive(title)
	}
	catch {
        Sleep 300
        ahkId := WinActive(title)
    }

    global ahkIds
    if (!isContains(ahkIds, ahkId)) {
        return
    }

    mirrorSend(ahkIds, getOriginKey(A_ThisHotkey), ahkId) 
}

~LButton:: {
    if (A_IsPaused) {
        return
    }

    global title
    try {
        WinGetTitle("A")
        ahkId := WinActive(title)
	}
	catch {
        Sleep 300
        ahkId := WinActive(title)
    }
    
    global ahkIds
    if (!isContains(ahkIds, ahkId)) {
        return
    }

    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin

    mirrorClick(ahkIds, "x" OutputVarX " y" OutputVarY, ahkId)
}



getOriginKey(thisKey) {
    key := SubStr(thisKey, 2, 999)
    if (StrLen(key) > 2) {
        key := "{" key "}"
    }
    return key
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
    
    global ahkIds
    if (!isContains(ahkIds, pid)) {        
        ToolTip "Phát hiện cửa sổ game mới pid: " pid ". Đã thêm vào danh sách mirror", OutputVarX - 20, OutputVarY - 30 , 1
        SetTimer () => ToolTip(), -1000
        ahkIds.Push(pid)
    }
}

