F12::{
    winTitle := "Adobe Flash Player 32"
    pid := WinActive(winTitle)
    cycle := 0
    while (true) {
        move(pid)
        move(pid)
        move(pid)
        move(pid)
        move(pid)
        Sleep 5000
        regen(pid)
        move(pid)
        move(pid)
        move(pid)
        move(pid)
        move(pid)
        Sleep 5000
        regen(pid)
        Sleep 7000
        resetAutoAttack()
    }
}


move(pid)
{
    ControlClick "x211 y555", "ahk_id " pid
    Sleep 2000
    ControlClick "x311 y555", "ahk_id " pid
    Sleep 2000
    ; ControlClick "x588 y326", "ahk_id " pid
    ; Sleep 1500
    ; ControlClick "x222 y350", "ahk_id " pid
    ; Sleep 1500
}

resetAutoAttack() {
    ids := WinGetList("Adobe Flash Player 32")
    for id in ids
    {
        ControlClick "x1026 y608", "ahk_id " id
        ControlClick "x1026 y608", "ahk_id " id
    }
}

regen(pid, sleepTime := 200) {
    ControlClick "x124 y23", "ahk_id " pid ; Bơm máu mana nhân vật
    Sleep sleepTime
    ControlClick "x93 y81", "ahk_id " pid ; Bơm máu mana pet
    Sleep sleepTime
    ControlClick "x103 y81", "ahk_id " pid ; Bơm máu mana pet
    Sleep sleepTime
    ControlClick "x113 y81", "ahk_id " pid ; Bơm máu mana pet
    Sleep sleepTime
    ControlClick "x133 y81", "ahk_id " pid ; Bơm máu mana pet
    Sleep sleepTime
    ControlClick "x133 y81", "ahk_id " pid ; Bơm máu mana pet
    Sleep sleepTime
}