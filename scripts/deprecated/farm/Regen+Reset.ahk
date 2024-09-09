#Requires AutoHotkey v2.0

names := A_Args.get(1)
pidArray := [24884]
loop {
    resetAuto(pidArray)
    regen(pidArray, A_Index)
    Sleep 3000
}

resetAuto(pidArray, index := 0) {
    for id in pidArray {
        ControlClick "x968 y355", "ahk_pid " id,,,, "NA" ; Click auto khi đang trong trận
        if (index == 0 || Mod(index, 5) == 0) {
            ControlClick "x1028 y603", "ahk_pid " id,,,2, "NA" ; Click auto khi Ngoài trận
        }
    }
}

regen(pidArray, index := 0) {
    for id in pidArray {
        ahk_id := "ahk_pid " id
        if (Mod(index, 2) == 0) {
            ControlClick "x93 y81", ahk_id,,,1, "NA"    ; Regen pet
        } else {
            ControlClick "x124 y23", ahk_id,,,1, "NA"   ; Regen char
        }
    }
}