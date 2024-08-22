#Requires AutoHotkey v2.0
#include Base.ahk
#SingleInstance Off
SetControlDelay -1 

materialName := A_Args.get(2)


petBattleCoordinateArray := []
loop 10 {
    petBattleCoordinateArray.Push("x750 y" 449 - 24 * A_Index)
}

loop {
    global cycle
    resetPosition()

    loop 4 {
        moveToHerbal_1()
        Sleep 30000
        petBattle(cycle)
        plantMaterial(materialName, cycle)
        cycle++
        Sleep 2000
    }
    
    loop 4 {
        moveToHerbal_2()
        Sleep 30000
        petBattle(cycle)
        plantMaterial(materialName, cycle)
        cycle++
        Sleep 2000
    }
    
}

moveToHerbal_1() {
    global accountArray
    loop 3 {
        utils.click(accountArray, "x" 117 + A_Index * 30 " y558")    
        Sleep 500
    }
}

moveToHerbal_2() {
    global accountArray
    loop 3 {
        utils.click(accountArray, "x" 117 + A_Index * 30 " y573")    
        Sleep 500
    }
}

resetPosition() {
    for acc in accountArray {
        acc.resetWindowSize()
    }

    utils.resetGui(accountArray)

    utils.send(accountArray, "p")
    Sleep 500
    loop 2 {
        utils.click(accountArray, "x280 y238") ; Reset FPS về 20
        Sleep 200
    }

    utils.resetGui(accountArray)

    utils.click(accountArray, "x237 y623") ; Chat Mật
    Sleep 100

    utils.click(accountArray, "x924 y157") ; Tắt Q
    Sleep 200

    utils.click(accountArray, "x491 y365") ; Giải trừ buff auto thám hiểm K1
    Sleep 200
}