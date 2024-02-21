#Requires AutoHotkey v2.0
#include Utils.ahk

~F11::Pause -1

names := A_Args.get(1)
ahkIds := getAhkIds(names)

A_IconTip := "Dau Pet - "  names

dauPet(ahkIds)
resetGui(ahkIds)
Sleep 10000 

dauPet(ahkIds) {
    resetGui(ahkIds)
    ControlClickAll(ahkIds, "x1008 y357") ; Đấu pet
    Sleep 500

    x := 750
    y := 425

    loop 10 {
        ControlClickAll(ahkIds, "x" x " y" y)
        y := y - 24
        Sleep 500
    }
}