#SingleInstance Off
#include Utils.ahk

ahkIds := getAhkIds(A_Args.get(1))

resetGui(ahkIds);

ControlSendAll(ahkIds, "p")
Sleep 1000
ControlClickAll(ahkIds, "x564 y176") ; Nhân vật
Sleep 1000
ControlClickAll(ahkIds, "x400 y450") ; Chọn nhân vật đầu tiên
Sleep 1000
ControlClickAll(ahkIds, "x500 y450") ; Chọn nhân vật thứ 2
Sleep 1000
ControlClickAll(ahkIds, "x400 y550", ahk_id ; Vào game
Sleep 1500

for id in ahkIds {
    WinClose "ahk_id " id
}