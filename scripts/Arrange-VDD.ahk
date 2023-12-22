#Requires AutoHotkey v2.0
#include Utils.ahk

; arrange A_Args.get(1)
names := "Bông,Thiên,Yui,Địa,Hạo,Nhân,Mận,Lazy"
arrange2(names)

arrange2(names, x := 0, y := 0, w := 1066, h := 724, xOffset := 0, yOffset := -30) {
    index := 0
    for id in getProcessIds(names) {
        if (index == 2) {
            index := 0
            x := x + 500
            y := 0
        } else {
            y := index * h
        }
        WinMove x + index * xOffset, y + index * yOffset, w, h, "ahk_pid " id
        index++
    }
}