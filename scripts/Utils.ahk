#Requires AutoHotkey v2.0
#include Config.ahk
#Include libs\JSON.ahk


G_IsPause := false

pauseToggle() {
    global G_IsPause
    G_IsPause := !G_IsPause
}

isPaused() {
    global G_IsPause
    return G_IsPause
}


isContains(strArray, stringInput) {
    for str in strArray {
        if (str == stringInput) {
            return true
        }
    }
    return false
}

stringToArray(str, delimiter := ",") {
    return StrSplit(str, delimiter)
}

arrayToString(strArray, delimiter := ",") {
    result := ""
    for str in strArray {
        result .= str delimiter
    }
    return RTrim(result, delimiter)
}

coordinateToArray(coordinate) {
    strArray := stringToArray(coordinate, " ")
    return [SubStr(strArray.get(1), 2, 99), SubStr(strArray.get(2), 2, 99)]
}

getCoordinates() {
    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
    return "x" OutputVarX " y" OutputVarY
}

show(names, sleepTime := 1000) {
    for id in getProcessIds(names) {
        WinActivate "ahk_pid " id
        Sleep sleepTime
    }
}

hide(names, sleepTime := 1000) {
    for id in getProcessIds(names) {
        WinMinimize "ahk_pid " id
        Sleep sleepTime
    }
}

close(names, sleepTime := 1000) {
    for id in getProcessIds(names) {
        WinClose "ahk_pid " id
        Sleep sleepTime
    }
}

arrange3(names, x := 0, y := 0, w := 1066, h := 724, xOffset := 100, yOffset := 200) {
    index := 0
    for id in getProcessIds(names) {
        if (index == 4) {
            index := 0
            x := x + 350
        }
        WinMove x + index * xOffset, y + index * yOffset, w, h, "ahk_pid " id
        index++
    }
}

arrange2(names, x := 0, y := 0, w := 1066, h := 724, xOffset := 0, yOffset := -30) {
    index := 0
    for id in getProcessIds(names) {
        if (index == 2) {
            index := 0
            x := x + 500
            y := 0
        } else {
            y := index * h
        }
        WinMove x + index * xOffset, y + index * yOffset, w, h, "ahk_pid " id
        index++
    }
}

; move(name, x := 0, y := 0, w := 1066, h := 724) {
;     WinMove x, y, w, h, "ahk_pid " getProcessIds(name).get(1)
; }


getAhkIds(names) {
    ahkIds := []
    for id in getProcessIds(names) {
        ahk_id := WinExist("ahk_pid" id)
        if (ahk_id != 0) {
            ahkIds.Push(ahk_id)
        }
    }
    return ahkIds
}

getProcessIds(names) {
    result := []
    for name in stringToArray(names) {
        for acc in getAccountArray() {
            if (acc["name"] == name) {
                result.Push(acc["processId"])
            }
        }
    }
    
    return result
}

getNameFromAhkIds(ahkIds) {
    result := []
    for pid in convertToProcessIds(ahkIds) {
        log("Info", arrayToString(convertToProcessIds(ahkIds)))
        for acc in getAccountArray() {
            try {
                processId := acc["processId"]
            } catch as e {
                processId := 99999
            }

            if (processId == pid) {
                result.Push(acc["name"])
            }
        }
    }

    return arrayToString(result)
}


convertToProcessIds(ahkIds) {
    result := []
    for id in ahkIds {
        result.Push(WinGetPID("ahk_id " id))
    }

    return result
}


getAccountArray(filePath := accountPath) {
    text := FileRead(filePath, "UTF-8")
    return jxon_load(&text)
}

getAccounts(names) {
    accounts := []
    processIds := getProcessIds(names)
    for accName in stringToArray(names) {
        account := { name: accName, 
                     isActive: false, 
                     ahkId: WinExist("ahk_pid" processIds[A_Index]) }
        accounts.Push(account)
    }
    return accounts
}


; exclude current screen when currentWindowId is set.
mirrorClick(ahkIds, coordinates, currentWindowId := 0) {
    for id in ahkIds {
        if (id != currentWindowId) { ; exclude current screen
            ControlClick coordinates, "ahk_id " id,,,, "NA"
        }
    }
}

ControlClickAll(ahkIds, coordinates) 
{
    for id in ahkIds {
        ControlClick coordinates, "ahk_id " id,,,, "NA"
    }
}

; exclude current screen when currentWindowId is set.
mirrorSend(ahkIds, key, currentWindowId := 0) {
    for id in ahkIds {
        if (id != currentWindowId) { ; exclude current screen
            ControlSend key, , "ahk_id " id
        }
    }
}

ControlSendAll(ahkIds, key) 
{
    for id in ahkIds {
        ControlSend key, , "ahk_id " id
    }
}

resetGui(ahkIds) {
    ControlClickAll(ahkIds, "x1028 y45")
    ControlSendAll(ahkIds, "{Escape}") 
}

RunWaitOne(command) {
    shell := ComObject("WScript.Shell")
    exec := shell.Exec(A_ComSpec " /C " command)
    return exec.StdOut.ReadAll()
}

trimArray(arr) {

    newArr := []

    for e in arr {
        if (!isContains(newArr, e)) {
            newArr.push(e)
        }
    }

    return newArr
}

log(level, message, filePath := "") {
    if (filePath == "") {
        global logPath
        filePath := logPath
    }
    ts := FormatTime(, "yyyy-MM-dd HH:mm:ss.") substr(A_TickCount,-3)
    FileAppend ts " - " level " - " message "`n", filePath
}


tooltipMessage(message) {
    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin

    ToolTip ".`n.   " message "   .`n.", OutputVarX + 10, OutputVarY - 60 , 1
    SetTimer () => ToolTip(), -1000
}