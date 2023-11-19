F12::{
    winTitle := "Adobe Flash Player 32"
    pid := WinActive(winTitle)
    cycle := 0
    while (true) {
        getQuest(pid)
        
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000

        regen(pid)

        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000

        regen(pid)

        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000

        regen(pid)

        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000
        ControlClick "x167 y556", "ahk_id " pid ; Chọn ốc 
        Sleep 2000

        regen(pid)

        ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
        Sleep 2000
        ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
        Sleep 2000
        ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
        Sleep 2000
        ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
        Sleep 2000
        ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
        Sleep 2000

        regen(pid)

        ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
        Sleep 2000
        ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
        Sleep 2000
        ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
        Sleep 2000

        regen(pid)
        
        resetAutoAttack()

        removeQuest(pid)
    }
}

getQuest(pid) {
    ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
    Sleep 300
    ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
    Sleep 300
    ControlClick "x270 y558", "ahk_id " pid ; chọn ngư phu
    Sleep 300
    ControlClick "x333 y333", "ahk_id " pid ; chọn nhiệm vụ
    Sleep 300
    ControlClick "x333 y333", "ahk_id " pid ; chọn nhiệm vụ
    Sleep 300
    ControlClick "x304 y421", "ahk_id " pid ; Nhận
    Sleep 300
    ControlClick "x304 y421", "ahk_id " pid ; Nhận
    Sleep 300
}

removeQuest(pid) {
    ControlClick "x333 y333", "ahk_id " pid ; chọn nhiệm vụ
    Sleep 300
    ControlClick "x333 y333", "ahk_id " pid ; chọn nhiệm vụ
    Sleep 300
    ControlClick "x328 y418", "ahk_id " pid ; bỏ
    Sleep 300
    ControlClick "x328 y418", "ahk_id " pid ; bỏ
    Sleep 300
    ControlClick "x508 y372", "ahk_id " pid ; xác nhận
    Sleep 300
    ControlClick "x508 y372", "ahk_id " pid ; xác nhận
    Sleep 300
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

resetAutoAttack() {
    ids := WinGetList("Adobe Flash Player 32")
    for id in ids
    {
        ControlClick "x1026 y608", "ahk_id " id
        ControlClick "x1026 y608", "ahk_id " id
    }
}