#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk
#Include libs\JSON.ahk


title := "Adobe Flash Player 10"
flashPath := "..\tools\flashplayer_10.exe"
manageAccs := "Bông,Yui,Hạo,Mận,Siu,Sun,Lazy,Nhân"
accIndex := 999999999

F1:: {
    pasueApp()
}

pasueApp(*) {
    pauseToggle()
    if (G_IsPause) {
        mirrorButton.Text := "Mirror - OFF"
        mirrorButton.SetFont("norm italic")
    } else {
        mirrorButton.Text := "Mirror - ON"
        mirrorButton.SetFont("norm bold")
        for acc in mirrorAccObjectArray {
            acc.click("x875 y46")
        }
    }
}

accMapArray := loadAccMapArray()
accObjectArray := convertToAccObjectArray(accMapArray)

mirrorAccObjectArray := []
manageAccObjectArray := []

; ============================ GUI ============================

MyGui := Gui()
MyGui.SetFont("s11 norm italic")

MyGui.Add("GroupBox", "w206 h115 Section" , "Tính năng")

refreshButton := MyGui.Add("Button", "Xs+3 Ys+18 w100 h30", "Refresh") 
refreshButton.SetFont("norm bold")
refreshButton.onEvent("Click", refreshButton_Click)

mirrorButton := MyGui.Add("Button", "Xs+103 Ys+18 w100 h30", "Mirror - ON")
mirrorButton.SetFont("norm bold")
mirrorButton.onEvent("Click", pasueApp)

plantButton := MyGui.Add("Button", "Xs+3 Ys+48 w100 h30", "Trồng Trọt")
plantButton.SetFont("norm bold")
plantButton.onEvent("Click", plantButton_Click)

plantMaterialButton := MyGui.Add("Button", "Xs+103 Ys+48 w100 h30", "Trang Viên")
plantMaterialButton.SetFont("norm bold")
plantMaterialButton.onEvent("Click", plantMaterialButton_Click)

petBattelButton := MyGui.Add("Button", "Xs+3 Ys+78 w100 h30", "Đấu Pet")
petBattelButton.SetFont("norm bold")
petBattelButton.onEvent("Click", petBattelButton_Click)


MyGui.Add("GroupBox", "Xs w30 h400 Section" , "M")
count := 0
for acc in accObjectArray {
    if (InStr(manageAccs, acc.name)) {
        count++
        accCheck := MyGui.Add("Checkbox", "Xs+10 Ys+" count * 40 " w30 h30 v" acc.name, )
        accCheck.Text := "="
        accCheck.Name := acc.name
        accCheck.OnEvent("Click", accCheckbox_Click)
    }
}
MyGui.Add("GroupBox", "Xs+27 Ys w165 h400 Section" , "Accounts")
count := 0
for acc in accObjectArray {
    if (InStr(manageAccs, acc.name)) {
        manageAccObjectArray.Push(acc)
        count++
        accButton := MyGui.Add("Button", "Xs+5 Ys+" count * 40 " w150 h30", "XXX - " acc.name)
        accButton.OnEvent("ContextMenu", accButton_ContextMenu)
        acc.button := accButton

        acc.updateStatus()
        accButton.OnEvent("Click", accButton_Click)
    }
}

refreshButton_Click(GuiCtrlObj, Info) {
    for acc in manageAccObjectArray {
        acc.updateStatus()
    }
}

accCheckbox_Click(GuiCtrlObj, Info) {
    global mirrorAccObjectArray

    name := GuiCtrlObj.Name
    if (GuiCtrlObj.Value) {
        for acc in accObjectArray {
            if (acc.name == name) {
                mirrorAccObjectArray.Push(acc)
            }
        } 
    } else {
        for acc in mirrorAccObjectArray {
            if (acc.name == name) {
                mirrorAccObjectArray.RemoveAt(A_Index)
            }
        }
    }
}

accButton_Click(GuiCtrlObj, Info) {
    acc := getAcc(GuiCtrlObj.Text)
    acc.updateStatus()
    if (acc.isActive) {
        acc.show()
    } else {
        Run flashPath " " acc.getLoginUrl(), , , &processId
        ahkId := WinWait("ahk_pid " processId)
        acc.ahkId := ahkId
        acc.processId := "ahk_pid " processId
        updateAccData(accObjectArray)

        acc.updateStatus()
    }
}

accButton_ContextMenu(GuiCtrlObj, Item, IsRightClick, X, Y) {
    contextMenu := Menu()
    acc := getAcc(GuiCtrlObj.Text)
    contextMenu.Add("Ẩn", hideAcc.Bind(,,,acc))
    contextMenu.Add("Ẩn/Hiện Title", toggleTitleBar.Bind(,,,acc))
    contextMenu.Add("Bug online", bugOnline.Bind(,,,acc))
    contextMenu.Add("Nhận Thư", receiveMail.Bind(,,,acc))
    contextMenu.Add("Tắt", closeAcc.Bind(,,,acc))
    contextMenu.Show()
}

plantButton_Click(GuiCtrlObj, Info) {
}

plantMaterialButton_Click(GuiCtrlObj, Info) {
}

petBattelButton_Click(GuiCtrlObj, Info) {
}

hideAcc(ItemName, ItemPos, MyMenu, acc) {
    acc.hide()
}

toggleTitleBar(ItemName, ItemPos, MyMenu, acc) {
    acc.toggleTitleBar()
}

bugOnline(ItemName, ItemPos, MyMenu, acc) {
    acc.bugOnline()
}

receiveMail(ItemName, ItemPos, MyMenu, acc) {
    acc.receiveMail()
}

closeAcc(ItemName, ItemPos, MyMenu, acc) {
    acc.close()
}

MyGui.Show()

; ============================ GUI ============================

; ========================== MIRROR ===========================

~LButton:: {
    if (isPaused()) {
        return
    }

    MouseGetPos &x, &y, &id
    
    if (isAllowedToMirror(ahkId)) {
        for acc in mirrorAccObjectArray {
            if (acc.ahk_id != "ahk_id " id) { ; exclude current window
                acc.click("x" x " y" y)
            }
        }
    }
}

isAllowedToMirror(id) {
    WinGetPos &x, &y, &w, &h, id

    global mirrorAccObjectArray
    for acc in mirrorAccObjectArray {
        if (id == acc.ahkId) {
            return acc.isActive
        }
    }

    return false
}

getAhkIdArray(accObjectArray) {
    result := []
    for acc in accObjectArray {
        result.Push(acc.ahkId)
    }
    return result
}


~WheelDown::
~WheelUp::
~Escape::
~Enter::
~Space::
~Ctrl::
~`::
~1::
~2::
~3::
~4::
~5::
~6::
~7::
~8::
~9::
~a::
~b::
~c::
~d::
~e::
~f::
~g::
~h::
~i::
~j::
~k::
~l::
~m::
~n::
~o::
~p::
~q::
~r::
~s::
~t::
~u::
~v::
~w::
~x::
~y::
~z:: {
    if (isPaused()) {
        return
    }

    MouseGetPos &x, &y, &id
    
    if (isAllowedToMirror(ahkId)) {
        for acc in mirrorAccObjectArray {
            if (acc.ahkId != "ahk_id " id) { ; exclude current screen
                acc.send(getOriginKey(A_ThisHotkey))
            }
        }
    }
}


getOriginKey(thisKey) {
    key := SubStr(thisKey, 2, 999)
    if (StrLen(key) > 2) {
        key := "{" key "}"
    }
    return key
}


; ========================== MIRROR ===========================


; ========================== ARRANGE ==========================

~!z:: {
    Run ".\arrange\Style-1.ahk " arrayToString(getAhkIdArray(mirrorAccObjectArray))
}

~!x:: {
    Run ".\arrange\Style-2.ahk " arrayToString(getAhkIdArray(mirrorAccObjectArray))
}

~!c:: {
    Run ".\arrange\Style-3.ahk " arrayToString(getAhkIdArray(mirrorAccObjectArray))
}

~MButton:: {
    global accIndex
    accIndex++
    index := Mod(accIndex, mirrorAccObjectArray.Length) + 1   
    WinActivate "ahk_id " mirrorAccObjectArray[index].ahkId
}

; ========================== ARRANGE ==========================



^r:: {
    Run "RegenAll.ahk"
}