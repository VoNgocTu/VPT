#Requires AutoHotkey v2.0
#SingleInstance Force
#include VptUtils.ahk


title := "Adobe Flash Player 10"
flashPath := rootPath "tools\flashplayer_10.exe"
manageAccs := "Bông,Yui,Hạo,Mận,Siu,Sun,Lazy,Nhân"
accIndex := 999999999
utils := VptUtils()

G_IsPause := false
F1:: {
    pasueApp()
}

pasueApp(*) {
    global G_IsPause
    G_IsPause := !G_IsPause

    if (G_IsPause) {
        mirrorButton.Text := "Mirror - OFF"
        mirrorButton.SetFont("norm")
    } else {
        mirrorButton.Text := "Mirror - ON"
        mirrorButton.SetFont("norm bold")
        utils.click(mirrorAccountArray, "x875 y46")
    }
}

isPaused() {
    return G_IsPause
}


accountArray := utils.loadAccountArray()

mirrorAccountArray := []
manageAccountArray := []

; ============================ GUI ============================

MyGui := Gui()
MyGui.SetFont("s11 norm")


MyGui.Add("GroupBox", "w30 h400 Section" , "M")
count := 0
for acc in accountArray {
    if (InStr(manageAccs, acc.name)) {
        count++
        accCheck := MyGui.Add("Checkbox", "Xs+10 Ys+" count * 40 " w30 h30 v" acc.name, )
        accCheck.Text := "="
        accCheck.Name := acc.name
        accCheck.OnEvent("Click", accCheckbox_Click)
    }
}


accCheckbox_Click(GuiCtrlObj, Info) {
    global mirrorAccountArray

    name := GuiCtrlObj.Name
    if (GuiCtrlObj.Value) {
        for acc in accountArray {
            if (acc.name == name) {
                acc.updateStatus()
                if (acc.isActive) {
                    mirrorAccountArray.Push(acc)
                } else {
                    GuiCtrlObj.Value := 0
                }
            }
        } 
    } else {
        for acc in mirrorAccountArray {
            if (acc.name == name) {
                mirrorAccountArray.RemoveAt(A_Index)
            }
        }
    }
}

MyGui.Add("GroupBox", "Xs+27 Ys w70 h400 Section" , "Accounts")
count := 0
for acc in accountArray {
    if (InStr(manageAccs, acc.name)) {
        manageAccountArray.Push(acc)
        count++
        accButton := MyGui.Add("Button", "Xs+5 Ys+" count * 40 " w60 h30", acc.name)
        accButton.OnEvent("ContextMenu", accButton_ContextMenu)
        acc.button := accButton

        acc.updateStatus()
        accButton.OnEvent("Click", accButton_Click)
    }
}

accButton_Click(GuiCtrlObj, Info) {
    acc := utils.getAccount(GuiCtrlObj.Text)
    acc.updateStatus()
    if (acc.isActive) {
        acc.show()
    } else {
        Run flashPath " " acc.getLoginUrl(), , , &processId
        ahkId := WinWait("ahk_pid " processId)
        acc.ahkId := "ahk_id " ahkId
        acc.processId := "ahk_pid " processId
        utils.writeAccountArray(accountArray)

        acc.updateStatus()
    }
}

accButton_ContextMenu(GuiCtrlObj, Item, IsRightClick, X, Y) {
    contextMenu := Menu()
    acc := utils.getAccount(GuiCtrlObj.Text)
    contextMenu.Add("Ẩn", hideAcc.Bind(,,,acc))
    contextMenu.Add("Ẩn/Hiện Title", toggleTitleBar.Bind(,,,acc))
    contextMenu.Add("Nhận Thư", receiveMail.Bind(,,,acc))
    contextMenu.Add("Tắt", closeAcc.Bind(,,,acc))
    contextMenu.Show()
}

MyGui.Add("GroupBox", "Xs+72 Ys w110 h400 Section" , "Tính năng")
refreshButton           := MyGui.Add("Button", "Xs+5 Ys+40  w100 h30", "Refresh") 
mirrorButton            := MyGui.Add("Button", "Xs+5 Ys+80  w100 h30", "Mirror - ON")
plantButton             := MyGui.Add("Button", "Xs+5 Ys+120 w100 h30", "Trồng Trọt")
plantMaterialButton     := MyGui.Add("Button", "Xs+5 Ys+160 w100 h30", "Trang Viên")
petBattelButton         := MyGui.Add("Button", "Xs+5 Ys+200 w100 h30", "Đấu Pet")
bugOnlineButton         := MyGui.Add("Button", "Xs+5 Ys+320 w100 h30", "Bug Online")

refreshButton.onEvent("Click", refreshButton_Click)
refreshButton_Click(GuiCtrlObj, Info) {
    for acc in manageAccountArray {
        acc.updateStatus()
    }
}

mirrorButton.SetFont("norm bold")
mirrorButton.onEvent("Click", pasueApp)

plantButton.onEvent("Click", plantButton_Click)
plantButton_Click(GuiCtrlObj, Info) {
    plantGui.Show()
}

plantMaterialButton.onEvent("Click", plantMaterialButton_Click)
plantMaterialButton_Click(GuiCtrlObj, Info) {
    plantMaterialGui.Show()
}

petBattelButton.onEvent("Click", petBattelButton_Click)
petBattelButton_Click(GuiCtrlObj, Info) {
}

bugOnlineButton.onEvent("Click", bugOnlineButton_Click)
bugOnlineButton_Click(*) {
    if (mirrorAccountArray.Length) {
        Run ".\Bug-Online.ahk " getNames(mirrorAccountArray)
    }
}


hideAcc(ItemName, ItemPos, MyMenu, acc) {
    acc.hide()
}

toggleTitleBar(ItemName, ItemPos, MyMenu, acc) {
    acc.toggleTitleBar()
}

receiveMail(ItemName, ItemPos, MyMenu, acc) {
    acc.receiveMail()
}

closeAcc(ItemName, ItemPos, MyMenu, acc) {
    acc.close()
}

MyGui.Show()


plantGui := Gui()
selectedTree := ""
selectedMaterial := "Kim Loại"
plantGui.SetFont("s11 norm")

plantGui.Add("GroupBox", "w130 h450 Section" , "Cây trồng")
treeArray := ["Lúa Mạch", "Lúa Gạo", "Bắp", "Khoai Lang", "Đậu Phộng", "Đậu Nành", "Cải Thảo", "Củ Cải", "Cacao", "Cao Lương", "Mướp", "Bầu", "Bông Cải", "Hoàng Kim Quả"]
for tree in treeArray {
    radio := plantGui.Add("Radio", "Xs+10 Ys+" A_Index * 30 " vRadioTree" A_Index, tree)
    radio.OnEvent("Click", radioTree_Click)
}

radioTree_Click(GuiCtrlObj, Info) {
    global selectedTree
    selectedTree := GuiCtrlObj.Text
}

plantOkBtn := plantGui.Add("Button", "Xs+30 w100 h30", "OK")
plantOkBtn.OnEvent("Click", plantOkBtn_Click)
plantOkBtn_Click(*) {
    plantGui.Submit()
    Run "Plant.ahk `"" getNames(mirrorAccountArray) "`" `"" selectedTree "`" `"" selectedMaterial "`""
}

plantGui.Add("GroupBox", "Ys w130 h450 Section" , "Nguyên liệu")
materialArray := ["Kim Loại", "Kim Loại Hiếm", "Gỗ", "Gỗ Tốt", "Ngọc", "Pha Lê", "Vải", "Gấm Vóc", "Lông Thú", "Da Thú"]
for material in materialArray {
    radio := plantGui.Add("Radio", "Xs+10 Ys+" A_Index * 30 " vRadioMaterial" A_Index, material)
    radio.OnEvent("Click", radioMaterial_Click)
}

radioMaterial_Click(GuiCtrlObj, Info) {
    global selectedMaterial
    selectedMaterial := GuiCtrlObj.Text
}

plantCancelBtn := plantGui.Add("Button", "Xs w100 h30", "Cancel")
plantCancelBtn.OnEvent("Click", plantCancelBtn_Click)
plantCancelBtn_Click(*) {
    plantGui.Submit()
}

plantMaterialGui := Gui()

plantMaterialGui.Add("GroupBox", "w130 h330 Section" , "Nguyên liệu")
materialArray := ["Kim Loại", "Kim Loại Hiếm", "Gỗ", "Gỗ Tốt", "Ngọc", "Pha Lê", "Vải", "Gấm Vóc", "Lông Thú", "Da Thú"]
for material in materialArray {
    radio := plantMaterialGui.Add("Radio", "Xs+10 Ys+" A_Index * 30 " vRadioMaterial" A_Index, material)
    radio.OnEvent("Click", radioMaterial_Click)
}

plantMaterialOkBtn := plantMaterialGui.Add("Button", "Xs+30 w100 h30", "OK")
plantMaterialOkBtn.OnEvent("Click", plantMaterialOkBtn_Click)
plantMaterialOkBtn_Click(*) {
    plantGui.Submit()
    Run "PlantMaterial.ahk " getNames(mirrorAccountArray) " `"" selectedMaterial "`""
}

; ============================ GUI ============================

; ========================== MIRROR ===========================

~LButton:: {
    if (isPaused()) {
        return
    }

    MouseGetPos &x, &y, &id
    if (isAllowedToMirror(id)) {
        for acc in mirrorAccountArray {
            if (acc.ahkId != "ahk_id " id) { ; exclude current window
                acc.click("x" x " y" y)
            }
        }
    }
}

isAllowedToMirror(id) {
    WinGetPos &x, &y, &w, &h, id

    global mirrorAccountArray
    for acc in mirrorAccountArray {
        if ("ahk_id " id == acc.ahkId) {
            return acc.isActive
        }
    }

    return false
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
    
    if (isAllowedToMirror(id)) {
        for acc in mirrorAccountArray {
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
    Run ".\arrange\Style-1.ahk " getNames(mirrorAccountArray)
}

~!x:: {
    Run ".\arrange\Style-2.ahk " getNames(mirrorAccountArray)
}

~!c:: {
    Run ".\arrange\Style-3.ahk " getNames(mirrorAccountArray)
}

getNames(accountArray, delimiter := ",") {
    result := ""
    for acc in accountArray {
        result .= acc.name delimiter
    }
    return "`"" RTrim(result, delimiter) "`""
}

~MButton:: {
    global accIndex
    accIndex++
    if (mirrorAccountArray.Length == 0) {
        return
    }
    index := Mod(accIndex, mirrorAccountArray.Length) + 1   
    WinActivate mirrorAccountArray[index].ahkId
}

; ========================== ARRANGE ==========================



^r:: {
    Run "RegenAll.ahk"
}