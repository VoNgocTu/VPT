pidArray := []

F11::{
    winTitle := "Adobe Flash Player 32"
    pid := WinActive(winTitle)

    global pidArray
    pidArray.Push(pid)
}

F12::{
    global pidArray
    ahk_id := "ahk_id " pidArray.get(1)
    while (true) {
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        regen(ahk_id)

        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        regen(ahk_id)
        
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        regen(ahk_id)
        
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        regen(ahk_id)
        
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        regen(ahk_id)
        
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        regen(ahk_id)
        
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        regen(ahk_id)
        
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        move(ahk_id)
        regen(ahk_id)
        
        Sleep 7000
        resetAutoAttack()
    }
}


move(ahk_id)
{
    ControlClick "x211 y555", ahk_id
    Sleep 2000
    ControlClick "x311 y555", ahk_id
    Sleep 2000
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
        ControlClick "x1026 y608", "ahk_id " id
        ControlClick "x1026 y608", "ahk_id " id
    }
}

regen(main_id, sleepTime := 200) {
    Sleep 5000 ; Wait for combat end
    stop(main_id)

    global pidArray
    ids := pidArray
    for id in ids
    {
        ahk_id := "ahk_id " id
        ControlClick "x124 y23", ahk_id ; Bơm máu mana nhân vật
        Sleep sleepTime
        ControlClick "x93 y81", ahk_id ; Bơm máu mana pet
        Sleep sleepTime
        ControlClick "x103 y81", ahk_id ; Bơm máu mana pet
        Sleep sleepTime
        ControlClick "x113 y81", ahk_id ; Bơm máu mana pet
        Sleep sleepTime
        ControlClick "x133 y81", ahk_id ; Bơm máu mana pet
        Sleep sleepTime
        ControlClick "x133 y81", ahk_id ; Bơm máu mana pet
        Sleep sleepTime
    }
}