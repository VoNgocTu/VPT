#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk
; #include Auto-Plant-Material.ahk
; #include Auto-Pet-Battle.ahk


names := A_Args.get(1)
ahkIds := getAhkIds(names)
channel := A_Args.get(2)
channelCoordinates := ""
channelArray := [
    "1 - x521 y238",
    "2 - x519 y276",
    "3 - x521 y307",
    "4 - x510 y344",
    "5 - x511 y377",
    "6 - x529 y413",
    "7 - x512 y444",
    "8 - x511 y477"
]

for ch in channelArray {
    if ( channel == SubStr(ch, 1, 1)) {
        channelCoordinates := SubStr(ch, 5, 999)
        ; MsgBox("Chọn kênh " channel ", Toạ độ: " channelCoordinates)
    }
}

; ControlSendAll(ahkIds, "p")
Sleep 30000 ; Chờ load game
ControlClickAll(ahkIds, "x525 y553") ; Bắt buộc
Sleep 30000 ; Chờ bắt buộc
ControlClickAll(ahkIds, channelCoordinates) ; Chọn Kênh
Sleep 1000
ControlClickAll(ahkIds, "x400 y450") ; Chọn nhân vật đầu tiên
Sleep 1000
ControlClickAll(ahkIds, "x500 y450") ; Chọn nhân vật thứ 2
Sleep 1000
ControlClickAll(ahkIds, "x400 y550") ; Vào game

; petBattle(ahk_pid)
; autoPlant(ahk_pid)
