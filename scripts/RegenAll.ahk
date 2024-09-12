#Requires AutoHotkey v2.0
#include Config.ahk
#SingleInstance Force



ahkIdArray := WingetList(title)
regenPet(ahkIdArray)
Sleep 3000
regenChar(ahkIdArray)


regenChar(ahkIdArray) {
    for ahk_id in ahkIdArray {
        ControlClick "x124 y23", ahk_id,,,1, "NA"   ; Regen char
    }
}

regenPet(ahkIdArray) {
    for ahk_id in ahkIdArray {
        ControlClick "x93 y81", ahk_id,,,1, "NA"    ; Regen pet
    }
}