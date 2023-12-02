ahk_id := "ahk_pid " A_Args.get(1)

; Prevent ControlSend error.
ControlClick "x521 y351", ahk_id ; Click to center
Sleep 300
ControlClick "x521 y351", ahk_id ; Click to center
Sleep 300
ControlClick "x521 y351", ahk_id ; Click to center
Sleep 300

ControlSend "p", , ahk_id
Sleep 1000
ControlClick "x564 y176", ahk_id ; Nhân vật
Sleep 1000
ControlClick "x400 y450", ahk_id ; Chọn nhân vật đầu tiên
Sleep 1000
ControlClick "x500 y450", ahk_id ; Chọn nhân vật thứ 2
Sleep 1000
ControlClick "x400 y550", ahk_id ; Vào game
Sleep 1500
WinClose ahk_id