#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk



ahk_id_array := WingetList(title)
tooltipMessage("Regen for - " getNameFromAhkIds(ahk_id_array))
regenPet(ahk_id_array)
Sleep 3000
regenChar(ahk_id_array)


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