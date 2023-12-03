#Requires AutoHotkey v2.0
#SingleInstance Off
#include Auto-Plant-Material.ahk
#include Auto-Pet-Battle.ahk


ahk_pid := "ahk_pid " A_Args.get(1)


Sleep 90000 ; Chờ load game
ControlClick "x525 y553", ahk_pid ; Bắt buộc
Sleep 60000 ; Chờ bắt buộc
ControlClick "x525 y341", ahk_pid ; chọn kênh 4
Sleep 1000
ControlClick "x400 y450", ahk_pid ; Chọn nhân vật đầu tiên
Sleep 1000
ControlClick "x500 y450", ahk_pid ; Chọn nhân vật thứ 2
Sleep 1000
ControlClick "x400 y550", ahk_pid ; Vào game
Sleep 60000 ; Chờ vào game

petBattle(ahk_pid)
autoPlant(ahk_pid)
