#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk
SetControlDelay -1 



names := A_Args.get(1)
nameArray := StrSplit(names, ",")
nameIndex := 999999999

ahkIds := getAhkIds(names)
; ahkIds := WingetList(title)

A_IconTip := "Mouse Mirror:`n`n" names

~Control & ~WheelUp:: {
    global ahkIds
    global nameIndex
    nameIndex--
    index := Mod(nameIndex, ahkIds.Length) + 1
    
    showAccount index
}

~Control & ~WheelDown:: {
    global nameIndex
    nameIndex++
    index := Mod(nameIndex, ahkIds.Length) + 1
    
    showAccount index
}

~F1:: {
    pauseToggle()
    if (isPaused()) {
        tooltipMessage("Pause Mirror - "  names)
    } else {
        tooltipMessage("Run Mirror - " names)
    }
    ; MsgBox("Is pause: " isPaused())
}

~MButton:: {
    global nameIndex
    nameIndex++
    index := Mod(nameIndex, ahkIds.Length) + 1
    
    showAccount index
}

showAccount(index) {
    global ahkids

    if (index < 0 || ahkids.Length < index) {
        return
    }
    
    WinActivate "ahk_id " ahkids.get(index)
    Sleep 50

    global nameArray
    ; tooltipMessage("Show acc: " nameArray.get(index) ".")
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
    global nameArray
    nameArray := stringToArray(names)
    accPerColumn := 4
    if (nameArray.Length < 4) {
        accPerColumn := nameArray.Length
    }
    
    ; Game Window Height: 724
    ; yOffset := 230 ; 2560 x 1440 => H = 1392 + 28 = 1420
    remainSpace := 1430 ; 2560 x 1440 => H = 1392 + 28 = 1420
    if (A_ScreenHeight == 1080) {
        remainSpace := 1070 ; 1920 x 1080 => H = 1032 + 28 = 1060
    }
    
    yOffset := (remainSpace - 724) / (accPerColumn - 1)
    if ( yOffset > 700 ) {
        yOffset := 700
    }

    xOffset := 100
    arrange names, -10, -28, , , xOffset, yOffset
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
    
    global ahkIds
    for (ahkid in ahkIds) {
        moveWindow ahkid, x, y
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

~!c:: {
    global ahkIds

    x := -10
    y := -28

    maxAccPerRow := 4
    accPerRow := maxAccPerRow
    if (ahkIds.Length <= maxAccPerRow) {
        accPerRow := ahkIds.Length
    }

    xOffset := Round((A_ScreenWidth - 1066) / (accPerRow - 1)) + 5
    yOffset := 0
    
    for (ahkId in ahkIds) {
        moveWindow ahkId, x, y

        x := x + xOffset

        if (A_Index / maxAccPerRow == 1) {
            ; x := -10
            xOffset := -xOffset
            x := x + xOffset
            y := 688
        }
    }
}


moveWindow(ahkId, x := 0, y := 0, w := 1066, h := 724) {
    WinMove x, y, w, h, "ahk_id " ahkId
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
    global title
    ahk_id_array := WingetList(title)

    regenPet(ahk_id_array)
    Sleep 3000
    regenChar(ahk_id_array)
}


regenChar(ahk_id_array) {
    for ahk_id in ahk_id_array {
        ControlClick "x124 y23", ahk_id,,,1, "NA"   ; Regen char
    }
}

regenPet(ahk_id_array) {
    for ahk_id in ahk_id_array {
        ControlClick "x93 y81", ahk_id,,,1, "NA"    ; Regen pet
    }
}