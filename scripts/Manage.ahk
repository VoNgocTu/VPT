#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk

SetControlDelay -1 

F1::Pause -1

names := stringToArray(A_Args.get(1))
status := "SHOW" ; SHOW/HIDE
ahkIds := getAhkIds(A_Args.get(1))
title := "Adobe Flash Player 32"

; MsgBox("Show 1 and 2")

~LButton:: {
    if (A_IsPaused) {
        return
    }

    global title
    ahkId := WinActive(title)
    if (ahkId == 0) {
        return
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

~!1::{
    global names
    if (names.Length < 1) {
        return
    }
    name := names.get(1)
    show name
}

~!2::{
    global names
    if (names.Length < 2) {
        return
    }
    name := names.get(2)
    show name
}

~!3::{
    global names
    if (names.Length < 3) {
        return
    }
    name := names.get(3)
    show name
}

~!4::{
    global names
    if (names.Length < 4) {
        return
    }
    name := names.get(4)
    show name
}

~!5::{
    global names
    if (names.Length < 5) {
        return
    }
    name := names.get(5)
    show name
}

~!6::{
    global names
    if (names.Length < 6) {
        return
    }
    name := names.get(6)
    show name
}

; Arrange
; w := 1066, h := 724
~^+1::{
    index := 0
    x := 0
    y := -28
    xOffset := 100
    yOffset := 200
    global names
    for (name in names) {
        if (index > 0 && Mod(index, 4) == 0) {
            x := x + 600
        }
        move name, x + index * xOffset, y + index * yOffset
        index++
    }
}


~^+2::{
    index := 0
    x := 0
    y := -28
    xOffset := 1066
    yOffset := 724
    global names
    for (name in names) {
        if (Mod(index, 2) == 0) {
            x := x + xOffset
        } else {
            y := y + yOffset
        }
        move name, x, y
        index++
    }
}

~^`::{
    global names
    global status
    for id in getProcessIds(arrayToString(names)) {
        if (status == "SHOW") {
            WinMinimize "ahk_pid " id
            status := "HIDE"
        } else {
            WinActivate "ahk_pid " id
            status := "SHOW"
        }
    }
}