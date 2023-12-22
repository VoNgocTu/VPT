#Requires AutoHotkey v2.0
#Include libs\JSON.ahk


; ids := getProcessIds("Thiên,Địa,Nhân")
; RunWait "powershell .\ps1\Get-Process-IDs.ps1 -runtimePath ..\data\runtime.json -names " "Thiên,Địa,Nhân"
; ClipWait
; MsgBox("Process id list: " A_Clipboard " ?",, "YesNo")

; data := getProcessIds("Thiên,Địa,Nhân")
; MsgBox("Process id list: " data " ?",, "YesNo")


; MsgBox(arrayToString(getProcessIds("Mai,Lan,Cúc,Trúc")))
; x431 y355

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

arrayToString(strArray) {
    result := ""
    for str in strArray {
        result .= str ","
    }
    return RTrim(result, ",")
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

arrange(names, x := 0, y := 0, w := 1066, h := 724, xOffset := 100, yOffset := 200) {
    index := 0
    for id in getProcessIds(names) {
        if (index == 4) {
            index := 0
            x := x + 600
        }
        WinMove x + index * xOffset, y + index * yOffset, w, h, "ahk_pid " id
        index++
    }
}

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

getProcessIds(names, filePath := "..\data\runtime.json") {
    result := []

    nameArray := stringToArray(names)
    text := FileRead(filePath, "UTF-8")
    tabArray := jxon_load(&text)
    for name in nameArray {
        for tab in tabArray {
            for acc in tab["accList"] {
                if (acc["name"] == name) {
                    result.Push(acc["processId"])
                }
            }
        }
    }
    
    return result
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

