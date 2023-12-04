pidArray := []

F9::{
    global pidArray
    pid := WinActive("Adobe Flash Player 32")
    pidArray.Push(pid)
}

F10::{
    global pidArray
    key_id := pidArray.get(1)
    loop {
        move(key_id, 4)
        regen(pidArray) 
    }
}


move(key_id, step := 1, sleepTime := 1000)
{
    global pidArray
    ahk_id := "ahk_id " key_id
    loop step {
        ; Move Group 1
        ControlClick "x211 y555", ahk_id
        Sleep sleepTime
        ControlClick "x231 y555", ahk_id
        Sleep sleepTime
        ControlClick "x251 y555", ahk_id
        resetAuto(pidArray) ; 1s
        regen([key_id])

        ; Move Group 2
        ControlClick "x311 y555", ahk_id
        Sleep sleepTime
        ControlClick "x331 y555", ahk_id
        Sleep sleepTime
        ControlClick "x351 y555", ahk_id
        resetAuto(pidArray) ; 1s
        regen([key_id])
    }
}


regen(pidArray, sleepTime := 200) {
    for id in pidArray
    {
        ahk_id := "ahk_id " id
        ControlClick "x124 y23", ahk_id
        Sleep sleepTime
        ControlClick "x103 y81", ahk_id
        Sleep sleepTime
        ControlClick "x133 y81", ahk_id
        Sleep sleepTime
    }
}


resetAuto(pidArray)
{
    for id in pidArray
    {
        ControlClick "x968 y355", "ahk_id " id ; Click auto khi đang trong trận
        Sleep 200
    }
}