#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk


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

totalGroup := 4
manageGroups := []
loop totalGroup {
    manageGroups.Push(config["manageGroups"][A_Index]["group"])
}
allAccountNames := arrayToString(manageGroups)
allAccountNames := arrayToString(trimArray(stringToArray(allAccountNames)))
log("INFO", "Manage accounts: " allAccountNames)


activeAccountNames := A_Args.get(1)
accounts := []

for accName in stringToArray(allAccountNames) {
    account := {name: accName, isActive: InStr(activeAccountNames, accName) != 0 }
    accounts.Push(account)
}


MyMenu := Menu()
generateMenu()


generateMenu() {
    global accounts
    global MyMenu
    MyMenu.Delete()

    manageGroupsMenu := Menu()
    for group in manageGroups {
        manageGroupsMenu.Add group, changeGroupHandler
    }
    MyMenu.Add "Groups", manageGroupsMenu

    for acc in accounts {
        prefix := "x  "
        if (!acc.isActive) {
            prefix := "   "
        }
        MyMenu.Add prefix . acc.name, toggleAccountHandler
    }
}

toggleAccountHandler(name, *) {
    global accounts
    originName := StrReplace(StrReplace(name, "   "), "x  ")

    for acc in accounts {
        if (acc.name == originName) {
            acc.isActive := !acc.isActive
        }
    }
    generateMenu()
}

changeGroupHandler(groupName, *) {
    global accounts
    groupAccounts := stringToArray(groupName)
    for acc in accounts {
        acc.isActive := isContains(groupAccounts, acc.name)
    }
    generateMenu()
}

closeMenu(*) {
    
}

F2:: {
    global MyMenu
    MyMenu.show()
}

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