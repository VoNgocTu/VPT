#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk


; names := "Bông"
; ahkIds := getAhkIds(names)
; try {
;     channelCoordinate := getChannelCoordinate(A_Args.get(4))
; }
; channelCoordinate := getChannelCoordinate(A_Args.get(1))

accountIndex := 999999999

~Control & ~WheelUp:: {
    global accountIndex
    accountIndex++
    
    tooltipMessage("Account index: " accountIndex " - Account: " (Mod(accountIndex, 4) + 1))
}

~Control & ~WheelDown:: {
    global accountIndex
    accountIndex--
    
    tooltipMessage("Account index: " accountIndex " - Account: " (Mod(accountIndex, 4) + 1))
}

tooltipMessage(message) {
    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin

    ToolTip ".`n.   " message "   .`n.", OutputVarX + 10, OutputVarY - 60 , 1
    SetTimer () => ToolTip(), -1000
}


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