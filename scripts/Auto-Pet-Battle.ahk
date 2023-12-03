
ahk_pid := "ahk_pid " A_Args.get(1)
petBattle(ahk_pid)

petBattle(ahk_pid) {
    ControlSend "{Escape}", , ahk_pid
    Sleep 200
    ControlSend "{Escape}", , ahk_pid
    Sleep 200
    ControlSend "{Escape}", , ahk_pid
    Sleep 200

    ControlClick "x1008 y360", ahk_pid ; Đấu pet
    Sleep 2000
    ControlClick "x460 y126", ahk_pid ; sửa đổi thiết lập 1
    Sleep 1000
    ControlClick "x447 y388", ahk_pid ; sửa đổi thiết lập 2
    Sleep 1500
    ControlClick "x523 y363", ahk_pid ; OK
    Sleep 500
    ControlClick "x750 y216", ahk_pid ; Đấu 1
    Sleep 500
    ControlClick "x750 y242", ahk_pid ; Đấu 2
    Sleep 500
    ControlClick "x750 y267", ahk_pid ; Đấu 3
    Sleep 500
    ControlClick "x750 y295", ahk_pid ; Đấu 4
    Sleep 500
}