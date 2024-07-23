#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk
SetControlDelay -1 

names := A_Args.get(1)
nameArray := StrSplit(names, ",")
nameIndex := 999999999

ahkIds := getAhkIds(names)
; ahkIds := WingetList(title)

~F1:: {
    pauseToggle()

    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
    message := "OOOO`nOOOO - " names "`nOOOO"
    if (isPaused()) {
        message := "XXXXX`nXXXXX - " names "`nXXXXX"
    }

    ToolTip message, OutputVarX + 50, OutputVarY - 60 , 1
    SetTimer () => ToolTip(), -1000
}

A_IconTip := "Manage:`n`n" names

~Control & ~WheelUp:: {
    global ahkIds
    global nameIndex
    nameIndex--
    index := Mod(nameIndex, ahkIds.Length) + 1
    
    showAccount(index)
}

~Control & ~WheelDown:: {
    global nameIndex
    nameIndex++
    index := Mod(nameIndex, ahkIds.Length) + 1
    
    showAccount(index)
}

~MButton:: {
    global nameIndex
    nameIndex++
    index := Mod(nameIndex, ahkIds.Length) + 1
    
    showAccount(index)
}

showAccount(index) {
    global ahkids

    if (index < 0 || ahkids.Length < index) {
        return
    }
    
    WinActivate "ahk_id " ahkids.get(index)
    Sleep 50
}

~LButton:: {
    if (isPaused()) {
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

~!z:: {
    global names
    Run ".\arrange\Style-1.ahk " names
}

~!x:: {
    global names
    Run ".\arrange\Style-2.ahk " names
}

~!c:: {
    global names
    Run ".\arrange\Style-3.ahk " names
}


~WheelDown::
~WheelUp::
~Escape::
~Enter::
~Space::
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
    ; log("INFO", "Key received - " A_ThisHotkey)
    if (isPaused()) {
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


^r:: {
    Run "RegenAll.ahk"
}