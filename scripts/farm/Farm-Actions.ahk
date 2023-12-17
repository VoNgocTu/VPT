#Requires AutoHotkey v2.0
SetControlDelay -1 

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

; If index == 0 regen for char
; If index == 1 regen for pet
; Cannot regen char and pet at the same time
regen(pidArray, index := 0) {
    
    for id in pidArray {
        ahk_id := "ahk_pid " id
        if (Mod(index, 2)) {
            ControlClick "x93 y81", ahk_id,,,1, "NA"    ; Regen pet
        } else {
            ControlClick "x124 y23", ahk_id,,,2, "NA"   ; Regen char
        }
    
        
        
        ; ControlClick "x93 y81", ahk_id,,,1, "D"
        ; Sleep 200
        ; ControlClick "x93 y81", ahk_id,,,1, "U"
        ; Sleep 200
        ; Sleep 100
        ; ControlClick "x103 y81", ahk_id,,,1, "D"
        ; Sleep 200
        ; ControlClick "x103 y81", ahk_id,,,1, "U"
        ; Sleep 100
        ; ControlClick "x113 y81", ahk_id,,,1, "D"
        ; Sleep 100
        ; ControlClick "x113 y81", ahk_id,,,1, "U"
        ; Sleep 100
        ; ControlClick "x123 y81", ahk_id,,,1, "D"
        ; Sleep 100
        ; ControlClick "x123 y81", ahk_id,,,1, "U"
        ; Sleep 100
        ; ControlClick "x133 y81", ahk_id,,,1, "NA"
        ; if (index == 0) {
        ;     ControlClick "x103 y81", ahk_id,,,4, "NA"
        ; }
    }
}


resetAuto(pidArray) {
    for id in pidArray {
        ControlClick "x968 y355", "ahk_pid " id,,,, "NA" ; Click auto khi đang trong trận
        ControlClick "x1028 y603", "ahk_pid " id,,,2, "NA" ; Click auto khi Ngoài trận
    }
}