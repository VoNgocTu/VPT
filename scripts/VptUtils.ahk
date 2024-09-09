#Requires AutoHotkey v2.0
#include classes/account.ahk
#include Config.ahk
#Include libs\JSON.ahk



class VptUtils {
    accDataPath := ""
    charset := ""
    accountArray := []

    __New(accDataPath := rootPath "\data\accountsV3.json", charset := "UTF-8") {
        this.accDataPath := accDataPath
        this.charset := charset
    }

    getAccountArray(accountNames := "", isReadNewData := false) {
        if (this.accountArray.Length == 0 || isReadNewData) {
            this.accountArray := this.loadAccountArray()
        }

        result := []
        for acc in this.accountArray {
            if (StrLen(accountNames) == 0 || InStr(accountNames, acc.name)) {
                result.Push(acc)
            }
        }

        this.log("Accounts: " this.getNames(this.accountArray))
        return result
    }

    getNames(accountArray, delimiter := ",") {
        result := ""
        for acc in accountArray {
            result .= acc.name delimiter
        }
        return "`"" RTrim(result, delimiter) "`""
    }

    loadAccountArray() {
        json := FileRead(this.accDataPath, this.charset)
        mapArray := Jxon_Load(&json)

        result := []
        for acc in mapArray {
            result.Push(Account(acc))
        }
        return result
    }

    writeAccountArray(accountArray) {
        mapArray := []
        for acc in accountArray {
            mapArray.Push(acc.toMap())
        }

        FileDelete this.accDataPath
        FileEncoding this.charset
        FileAppend Jxon_Dump(mapArray, "", 3), this.accDataPath
    }

    getAccount(name) {    
        for acc in this.accountArray {
            if (acc.name == name) {
                this.log("Tìm được account: " acc.toString())
                return acc
            }
        }

        error := "Không thể tìm thấy acc theo tên: `"" name "`", Tên có độ dài: " StrLen(name) " ký tự."
        this.log(error)
        MsgBox error
    }
    
    click(accountArray, coordinate) {
        for acc in accountArray {
            acc.click(coordinate)
        }
    }
    
    send(accountArray, key) {
        for acc in accountArray {
            acc.send(key)
        }
    }

    resetGui(accountArray) {
        for acc in accountArray {
            acc.resetGui()
        }
    }
    
    log(message, level := "INFO", filePath := "") {
        if (filePath == "") {
            global logPath
            filePath := logPath "/vpt-account-" FormatTime(, "yyyy-MM-dd") ".log"
        }
        ts := FormatTime(, "yyyy-MM-dd HH:mm:ss.") substr(A_TickCount,-3)
        FileEncoding this.charset
        FileAppend ts " - " level " - " message "`n", filePath
    }

    tooltipMessage(message) {
        MouseGetPos &x, &y, &id

        ToolTip ".`n.   " message "   .`n.", x + 10, y - 60 , 1
        SetTimer () => ToolTip(), -1000
    }
}