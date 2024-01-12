#Requires AutoHotkey v2.0

#include Utils.ahk

ahkIds := getAhkIds("Bông,Hạo,Mận")

loop {
    ; mirrorClick(ahkIds, "x450 y311")
    ; Sleep 100
    ; mirrorClick(ahkIds, "x451 y387")
    ; Sleep 100
    ; mirrorClick(ahkIds, "x696 y190")
    ; Sleep 100
    
    ; mirrorClick(ahkIds, "x661 y528")
    ; Sleep 100
    ; ControlSendAll(ahkIds, "{Enter}")
    ; Sleep 100
    
    
    mirrorClick(ahkIds, "x448 y264")
    ; Sleep 100
    ControlSendAll(ahkIds, "{Enter}")
    ; Sleep 100
    mirrorClick(ahkIds, "x372 y262")
    ; Sleep 100
    ControlSendAll(ahkIds, "{Enter}")
    ; Sleep 100
    mirrorClick(ahkIds, "x315 y266")
    ; Sleep 100
    ControlSendAll(ahkIds, "{Enter}")
    ; Sleep 100
    mirrorClick(ahkIds, "x254 y262")
    ; Sleep 100
    ControlSendAll(ahkIds, "{Enter}")
    ; Sleep 100
    mirrorClick(ahkIds, "x185 y263")
    ; Sleep 100
    ControlSendAll(ahkIds, "{Enter}")
    ; Sleep 100
}

