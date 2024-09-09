#Requires AutoHotkey v2.0
#SingleInstance Force
#include VptUtils.ahk
SetControlDelay -1 

utils := VptUtils()

accountArray := []
names := A_Args.get(1)
for acc in utils.getAccountArray() {
    if (InStr(names, acc.name)) {
        accountArray.Push(acc)
    }
}

petBattleCoordinateArray := []
loop 10 {
    petBattleCoordinateArray.Push("x750 y" 449 - 24 * A_Index)
}

loop {
    resetPosition()

    loop 4 {
        moveToHerbal_1()
        Sleep 30000
        petBattle(A_Index)
        Sleep 2000
    }
    
    loop 4 {
        moveToHerbal_2()
        Sleep 30000
        petBattle(A_Index)
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




petBattle(index) {
    global accountArray
    global petBattleCoordinateArray

    utils.click(accountArray, "x1008 y357") ; Mở Đấu pet
    Sleep 500
    utils.click(accountArray, petBattleCoordinateArray[index])
    Sleep 500
    utils.click(accountArray, "x1008 y357") ; Tắt Đấu pet
}



; Đấu pet
; Trồng trang viên






; names := "Bông"
; ahkIds := getAhkIds(names)
; try {
;     channelCoordinate := getChannelCoordinate(A_Args.get(4))
; }
; channelCoordinate := getChannelCoordinate(A_Args.get(1))

; G_IsPause := false

; ~F1:: {
;     global G_IsPause
;     G_IsPause := !G_IsPause
; }

; isPaused() {
;     global G_IsPause
;     return G_IsPause
; }

; Close other ahk script

; DetectHiddenWindows True

; id := ""

; F1:: {
;     global id
;     Run "Get-Coordinates.ahk", , , &processId
;     id := WinWait("ahk_pid " processId)
; }

; F2:: {
;     try {
;         WinClose "Get-Coordinates.ahk ahk_class AutoHotkey" 
;     } catch {
        
;     }
; }

; Close other ahk script


; F12:: {
;     ; coordinate := getCoordinates()
;     ; coordinateArray := coordinateToArray(coordinate)
;     ; ToolTip ".`n.   " coordinate "   .`n.", coordinateArray.Get(1) + 10, coordinateArray.Get(2) - 60 , 1
;     ; SetTimer () => ToolTip(), -1000

;     title := "Adobe Flash Player 10"
    
;     pid := WinActive(title)
;     if (pid == 0) {
;         return
;     }

;     ControlClick "x793 y14", "ahk_id " pid,,,, "D"
;     Sleep 1000
;     ControlClick "x23 y190", "ahk_id " pid,,,, "U"
; }

; Ctrl & Up:: {
;     loop GetKeyState("Up", "P") {
;         WinGetPos &X, &Y, &W, &H, "AutoHotkey v2 Help"
;         WinMove X, Y - 10, W, H, "AutoHotkey v2 Help"
;     }
; }

; ~Ctrl & ~Down:: {
;     WinGetPos &X, &Y, &W, &H, "AutoHotkey v2 Help"
;     WinMove X, Y + 10, W, H, "AutoHotkey v2 Help"
; }

; ~Ctrl & ~Left:: {
;     WinGetPos &X, &Y, &W, &H, "AutoHotkey v2 Help"
;     WinMove X - 10, Y, W, H, "AutoHotkey v2 Help"
; }

; ~Ctrl & ~Right:: {
;     WinGetPos &X, &Y, &W, &H, "AutoHotkey v2 Help"
;     WinMove X + 10, Y, W, H, "AutoHotkey v2 Help"
; }


; F12:: {
;     global channelCoordinate
;     global ahkIds

;     if (channelCoordinate == null) {
;         MsgBox("no channel")
;     }
        

;     loop 48 {
;         ControlClickAll(ahkIds, "x529 y551")
;         Sleep 500
;         ControlClickAll(ahkIds, channelCoordinate)
;         Sleep 500
;         ControlClickAll(ahkIds, "x400 y450") ; Chọn nhân vật đầu tiên
;         Sleep 500
;         ControlClickAll(ahkIds, "x500 y450") ; Chọn nhân vật thứ 2
;         Sleep 500
;         ControlClickAll(ahkIds, "x400 y550") ; Vào game
;         Sleep 500
;     }
; }


; getChannelCoordinate(channelNumber) {
;     switch channelNumber {
;         case "1": return "x522 y240"
;         case "2": return "x522 y275"
;         case "3": return "x522 y310"
;         case "4": return "x522 y345"
;         case "5": return "x522 y380"
;         case "6": return "x522 y415"
;         case "7": return "x522 y450"
;         case "8": return "x522 y485"
;     }
; }