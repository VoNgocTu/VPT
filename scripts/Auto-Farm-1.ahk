pidArray := []

F9::{
    global pidArray
    pid := WinActive("Adobe Flash Player 32")
    pidArray.Push(pid)
}

F10::{
    global pidArray
    ahk_id := "ahk_id " pidArray.get(1)
    loop {
        loop 8 {
            move(ahk_id, 5)
            regenAll() 
        }
        
        resetAutoAttack()
    }
}


move(ahk_id, step := 1, sleepTime := 1000)
{
    loop step {
        ; Group 1
        ControlClick "x211 y555", ahk_id
        Sleep sleepTime
        ControlClick "x231 y555", ahk_id
        Sleep sleepTime
        ControlClick "x251 y555", ahk_id
        autoCombatAll() ; 1s

        ; Group 2
        ControlClick "x311 y555", ahk_id
        Sleep sleepTime
        ControlClick "x331 y555", ahk_id
        Sleep sleepTime
        ControlClick "x351 y555", ahk_id
        autoCombatAll() ; 1s

        ; Đảm bảo pet của acc kéo ko bao giờ hết mana
        regenMain(ahk_id)
    }
}

stop(ahk_id)
{
    ControlClick "x521 y351", ahk_id
}

resetAutoAttack() {
    global pidArray
    ids := pidArray
    for id in ids
    {
        ControlClick "x1026 y608", "ahk_id " id ; auto outside combat
        ControlClick "x1026 y608", "ahk_id " id ; auto outside combat
    }
}

regenMain(main_id, sleepTime := 200) {
    ControlClick "x124 y23", main_id
    Sleep sleepTime
    ControlClick "x103 y81", main_id
    Sleep sleepTime
    ControlClick "x133 y81", main_id
    Sleep sleepTime
}


regenAll(sleepTime := 200) {
    global pidArray
    ids := pidArray
    for id in ids
    {
        ahk_id := "ahk_id " id
        ControlClick "x124 y23", ahk_id
        Sleep sleepTime
        ControlClick "x103 y81", ahk_id
        Sleep sleepTime
    }
}


autoCombatAll()
{
    global pidArray
    ids := pidArray
    for id in ids
    {
        ControlClick "x968 y355", "ahk_id " id ; Click auto khi đang trong trận, fix lỗi reset auto không thành công
        Sleep 200
    }
}
; ControlClick "x124 y23", ahk_id ; Bơm máu mana nhân vật
; ControlClick "x93 y81", ahk_id ; Bơm máu mana pet
; ControlClick "x103 y81", ahk_id ; Bơm máu mana pet
; ControlClick "x113 y81", ahk_id ; Bơm máu mana pet
; ControlClick "x133 y81", ahk_id ; Bơm máu mana pet
; ControlClick "x133 y81", ahk_id ; Bơm máu mana pet