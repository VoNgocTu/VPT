#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk
SetControlDelay -1 


names := A_Args.get(1)
ahkIds := getAhkIds(names)

A_IconTip := "Trồng Nông Sản - " names
coordinatesArray := []


loop {
    ControlSendAll(ahkIds, "{Escape}")
    Sleep 200
    ControlSendAll(ahkIds, "``")
    Sleep 500
    ControlClickAll(ahkIds, "x611 y268")
    Sleep 1500
    ControlClickAll(ahkIds, "x639 y288")
    Sleep 2000
    ControlSendAll(ahkIds, "{Escape}")
    Sleep 200
    ControlClickAll(ahkIds, "x883 y143") ; Thu hoạch
    Sleep 200
    ControlClickAll(ahkIds, "x853 y176") ; Thu hoạch
    Sleep 200
    ControlClickAll(ahkIds, "x892 y197") ; Thu hoạch
    Sleep 7000
    ControlClickAll(ahkIds, "x754 y302") ; Người rơm
    Sleep 1000
    ControlClickAll(ahkIds, "x339 y390") ; Trồng nông sản đặc biệt
    Sleep 1000
    ControlClickAll(ahkIds, "x303 y339") ; Cây kim tiền
    Sleep 1000
    ControlClickAll(ahkIds, "x754 y302") ; Người rơm
    Sleep 1000
    ControlClickAll(ahkIds, "x307 y412") ; Thao tác nông trường
    Sleep 1000
    ControlClickAll(ahkIds, "x303 y339") ; Sử dụng thuốc tăng trưởng
    Sleep 1000
    ControlSendAll(ahkIds, "{Enter}")
    Sleep 200
}