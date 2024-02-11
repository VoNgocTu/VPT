#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk
SetControlDelay -1 


title := "Adobe Flash Player 10"
; title := "AutoHotkey v2 Help"

groups := StrSplit(A_Args.get(1), "|")
if (groups.Length < 2) {
    ; groups.Push("Pause Mirror.")
}

lastGroupIndex := 0
names := groups.get(1)
lastNameIndex := 0
ahkIds := getAhkIds(names)
; ahkIds := WingetList(title)


~F1:: {
    Pause -1
    if (A_IsPaused) {
        ; tooltipMessage("Pause Mirror.")
    } else {
        tooltipMessage("Run Mirror - " names)
    }
}

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
    yOffset := 230 ; 2560 x 1440
    if (A_ScreenHeight == 1080) {
        yOffset := 117 ; 1920 x 1080
    }
    arrange names, -10 , -28 , , , , yOffset
}

~!x:: {
    index := 0
    x := -10
    y := -28
    xOffset := 500
    yOffset := 700
    ; xOffset := 789 ; 75%
    ; yOffset := 538 ; 75%
    ; w := xOffset
    ; h := yOffset
    global names
    nameArray := stringToArray(names)
    for (name in nameArray) {
    ; for (id in ids) {
        move name, x, y
        ; move id, x, y
        y := y + yOffset - 7
        if (index > 0 && Mod(index, 2) == 1) {
            x := x + xOffset - 15
            y := -28
        }

        index++
        if (index > 3) {
            index := 0
            x := -10
            y := -28
        }
    }

}
move(name, x := 0, y := 0, w := 1066, h := 724) {
    WinMove x, y, w, h, "ahk_pid " getProcessIds(name).get(1)
    ; WinMove x, y, w, h, "ahk_id " id
}

XButton2:: 
~LButton & RButton:: {
    global names
    hide names, 50
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