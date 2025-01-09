#Requires AutoHotkey v2.0
#SingleInstance Off
#include Base.ahk


A_IconTip := "Auto VDD - " names
; coordinatesArray := ["x353 y140", "x798 y109", "x529 y342"]
coordinatesArray := ["x987 y555", "x33 y576"]
; coordinatesArray := ["x919 y183", "x772 y546"] ; Tầng 2

for acc in accountArray {
    acc.click("x191 y626") ; Click chat mật
}

loop {
    move(accountArray, coordinatesArray, 1, 1500)
    resetAuto(accountArray)
    Sleep 500
    regen(accountArray, A_Index) 
}

move(accountArray, coordinatesArray, step := 1, sleepTime := 1000)
{
    loop step {
        for coordinates in coordinatesArray {
            for account in accountArray {
                account.click(coordinates)
            }
            Sleep sleepTime
        }
    }
}

regen(accountArray, index := 0) {
    for account in accountArray {
        if (Mod(index, 2) == 0) {
            account.click("x93 y81") ; Regen pet
        } else {
            account.click("x124 y23") ; Regen char
        }
    }
}


resetAuto(accountArray, index := 0) {
    for account in accountArray {
        account.click("x968 y355") ; Click auto khi đang trong trận
        if (index == 0 || Mod(index, 5) == 0) {
            account.click("x1028 y603") ; Click auto khi Ngoài trận
            account.click("x1028 y603") ; Click auto khi Ngoài trận
        }
    }
}

~^F12::Pause -1