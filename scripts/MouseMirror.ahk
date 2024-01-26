#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk
SetControlDelay -1 


; ~F1::
; ~RButton::{
;     global title
;     try {
;         WinGetTitle("A")
;         ahkId := WinActive(title)
; 	}
; 	catch {
;         Sleep 300
;         ahkId := WinActive(title)
;     }

;     global ahkIds
;     if (!isContains(ahkIds, ahkId)) {
;         return
;     }

;     Pause -1
;     if (A_IsPaused) {
;         ; tooltipMessage("Pause Mirror.")
;     } else {
;         tooltipMessage("Run Mirror.")
;     }
; }

title := "Adobe Flash Player 32"
; title := "AutoHotkey v2 Help"

groups := StrSplit(A_Args.get(1), "|")
if (groups.Length < 2) {
    groups.Push("Pause Mirror.")
}

lastGroupIndex := 0
names := groups.get(1)
lastNameIndex := 0
ahkIds := getAhkIds(names)
; ahkIds := WingetList(title)


~+1:: {
    Pause 0
    changeGroup(1)
}
~+2:: {
    Pause 0
    changeGroup(2)
}
~+3:: {
    Pause 0
    changeGroup(3)
}
~+4:: {
    Pause 0
    changeGroup(4)
}
~RButton & LButton::{
    Pause 0
    global groups
    global lastGroupIndex
    lastGroupIndex++

    if (groups.Length < lastGroupIndex) {
        lastGroupIndex := 1
    }

    changeGroup(lastGroupIndex)
}

changeGroup(index) {
    global groups
    global ahkIds
    global names
    global lastGroupIndex

    lastGroupIndex := index
    if (groups.Length < index) {
        return
    }

    names := groups.get(index)
    ahkIds := getAhkIds(names)
    tooltipMessage("Thay đổi group: " names ".")
}

tooltipMessage(message) {
    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin

    ToolTip ".`n.   " message "   .`n.", OutputVarX + 10, OutputVarY - 60 , 1
    SetTimer () => ToolTip(), -1000
}
yUI

~!`::{
    global names
    show names, 100
}
~!1::{
    showAccount(1)
}
~!2::{
    showAccount(2)
}
~!3::{
    showAccount(3)
}
~!4::{
    showAccount(4)
}
~!5::{
    showAccount(5)
}
~!6::{
    showAccount(6)
}
~MButton:: {
    global names
    global lastNameIndex
    nameArray := StrSplit(names, ",")

    lastNameIndex++
    if (nameArray.Length < lastNameIndex) {
        lastNameIndex := 1
    }

    name := nameArray.get(lastNameIndex)
    show name, 50
    ; tooltipMessage("Show acc: " name ".")
}

showAccount(index) {
    global names
    nameArray := StrSplit(names, ",")
    if (nameArray.Length < index) {
        return
    }
    name := nameArray.get(index)
    show name, 50
}

~Escape::
~Enter::
~Ctrl::
~Space::
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
    ; log("INFO", "Key received - " A_ThisHotkey)
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


getOriginKey(thisKey) {
    key := SubStr(thisKey, 2, 999)
    if (StrLen(key) > 2) {
        key := "{" key "}"
    }
    return key
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

XButton1:: 
~LButton & MButton:: {
    mirrorSend(ahkIds, "{Escape}")
}

~!z:: {
    global names
    arrange names, -10 , -28 , , , , 230
}

~LButton & RButton:: {
    global names
    hide names, 50
}