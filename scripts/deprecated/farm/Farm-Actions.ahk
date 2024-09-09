#Requires AutoHotkey v2.0
SetControlDelay -1 

farm(pidArray, coordinatesArray) {
    loop {
        move(pidArray, coordinatesArray, 1, 1500)
        resetAuto(pidArray, A_Index)
        regen(pidArray, A_Index) 
    }
}

move(pidArray, coordinatesArray, step := 1, sleepTime := 1000)
{
    ahk_id := "ahk_pid " pidArray.get(1)
    loop step {
        for coordinates in coordinatesArray {
            ControlClick coordinates, ahk_id,,,, "NA"
            Sleep sleepTime
        }
    }
}

moveAll(pidArray, coordinatesArray, step := 1, sleepTime := 1000)
{
    loop step {
        for coordinates in coordinatesArray {
            for id in pidArray {
                ahk_id := "ahk_pid " id
                ControlClick coordinates, ahk_id,,,, "NA"
            }
            Sleep sleepTime
        }
    }
}

; If index == 0 regen for char
; If index == 1 regen for pet
; Cannot regen char and pet at the same time
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


resetAuto(pidArray, index := 0) {
    for id in pidArray {
        ControlClick "x968 y355", "ahk_pid " id,,,, "NA" ; Click auto khi đang trong trận
        if (index == 0 || Mod(index, 5) == 0) {
            ControlClick "x1028 y603", "ahk_pid " id,,,2, "NA" ; Click auto khi Ngoài trận
        }
    }
}