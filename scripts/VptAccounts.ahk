#Requires AutoHotkey v2.0
#SingleInstance Force
#include VptUtils.ahk


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

utils.correctAccountsData()
accountArray := utils.getAccountArray(manageAccs)
mirrorAccountArray := []

; ============================ GUI ============================

MyGui := Gui()
MyGui.OnEvent("Close", (*) => ExitApp())
MyGui.SetFont("s11 norm")


MyGui.Add("GroupBox", "w205 h300 Section" , "Accounts")
for acc in accountArray {
    column := Round(A_Index / 2)
    if (Mod(A_Index, 2) == 1) {
        accCheck := MyGui.Add("Checkbox", "Xs+10 Ys+" column * 40 " w30 h30 v" acc.name)
        accButton := MyGui.Add("Button", "Xs+40 Ys+" column * 40 " w60 h30", acc.name)
    } else {
        accCheck := MyGui.Add("Checkbox", "Xs+110 Ys+" column * 40 " w30 h30 v" acc.name)
        accButton := MyGui.Add("Button", "Xs+140 Ys+" column * 40 " w60 h30", acc.name)
    }

    accCheck.Text := ""
    accCheck.Name := acc.name
    accCheck.OnEvent("Click", accCheckbox_Click)
    
    accButton.OnEvent("ContextMenu", accButton_ContextMenu)
    acc.button := accButton
    accButton.OnEvent("Click", accButton_Click)

    acc.updateStatus()
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
    contextMenu.Add("Copy Link", copyLoginUrl.Bind(,,,acc))
    contextMenu.Add("Tắt", closeAcc.Bind(,,,acc))
    contextMenu.Show()
}

MyGui.Add("GroupBox", "Xs+210 Ys w110 h300 Section" , "Tính năng")
refreshButton           := MyGui.Add("Button", "Xs+5 Ys+40  w100 h30", "Refresh") 
mirrorButton            := MyGui.Add("Button", "Xs+5 Ys+80  w100 h30", "Mirror - ON")
plantButton             := MyGui.Add("Button", "Xs+5 Ys+120 w100 h30", "Trồng Trọt")
plantMaterialButton     := MyGui.Add("Button", "Xs+5 Ys+160 w100 h30", "Trang Viên")
petBattelButton         := MyGui.Add("Button", "Xs+5 Ys+200 w100 h30", "Đấu Pet")
farmVDDPartyButton      := MyGui.Add("Button", "Xs+5 Ys+240 w100 h30", "Farm VDD Nhóm")
farmVDDSingleButton     := MyGui.Add("Button", "Xs+5 Ys+280 w100 h30", "Farm VDD Đơn")
; bugOnlineButton         := MyGui.Add("Button", "Xs+5 Ys+320 w100 h30", "Bug Online")
; editLinkButton          := MyGui.Add("Button", "Xs+5 Ys+360 w100 h30", "Edit Link")

refreshButton.onEvent("Click", refreshButton_Click)
refreshButton_Click(GuiCtrlObj, Info) {
    Reload()
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
    if (mirrorAccountArray.Length)
        Run ".\Pet-Battle.ahk " getNames(mirrorAccountArray)
}

farmVDDPartyButton.onEvent("Click", farmVDDPartyButton_Click)
farmVDDPartyButton_Click(GuiCtrlObj, Info) {
    if (mirrorAccountArray.Length)
        Run ".\FarmVDDParty.ahk " getNames(mirrorAccountArray)
}

farmVDDSingleButton.onEvent("Click", farmVDDSingleButton_Click)
farmVDDSingleButton_Click(GuiCtrlObj, Info) {
    if (mirrorAccountArray.Length)
        Run ".\FarmVDD.ahk " getNames(mirrorAccountArray)
}

; bugOnlineButton.onEvent("Click", bugOnlineButton_Click)
; bugOnlineButton_Click(*) {
;     if (mirrorAccountArray.Length)
;         Run ".\Bug-Online.ahk " getNames(mirrorAccountArray)
; }

; editLinkButton.onEvent("Click", editLinkButton_Click)
; listAccountForEdit := []
; editLinkButton_Click(*) {
;     ListAccountGui := Gui()
;     ListAccount := ListAccountGui.Add("ListView", "r20 w800", ["Tên", "Class", "Link"])
;     listAccountForEdit := utils.loadAccountArray()
;     for acc in listAccountForEdit
;         ListAccount.Add(, acc.name, acc.char, acc.originLink)

;     ListAccount.ModifyCol  ; Auto-size each column to fit its contents.
;     ListAccount.ModifyCol(2, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.
;     ListAccount.OnEvent("DoubleClick", ListAccount_DoubleClick)
;     ListAccountGui.Show()    
; }

; ListAccount_DoubleClick(ListAccount, RowNumber)
; {
;     name := ListAccount.GetText(RowNumber)
;     selectedAccount := ""
;     for acc in listAccountForEdit {
;         if (acc.name == name) {
;             selectedAccount := acc
;         }
;     }

;     EditAccountGui := Gui()
;     EditAccountGui.SetFont("s11 norm")

;     EditAccountGui.Add("Text",, "Tên*:")
;     EditAccountGui.Add("Text",, "Char:")
;     EditAccountGui.Add("Text",, "Link*:")
;     EditAccountGui.Add("Edit", "vName ym w500", selectedAccount.name)
;     EditAccountGui.Add("Edit", "vChar w500", selectedAccount.char)
;     EditAccountGui.Add("Edit", "vLink w500", selectedAccount.originLink)
;     EditAccountGui.Add("Button", "default", "Save").OnEvent("Click", btnSave_click.Bind(,,,selectedAccount))
;     EditAccountGui.Show()

;     btnSave_click(ItemName, ItemPos, MyMenu, acc) {
;         Saved := EditAccountGui.Submit()  ; Save the contents of named controls into an object.
;         selectedAccount.name := Saved.Name
;         selectedAccount.char := Saved.Char
;         selectedAccount.originLink := Saved.Link
;         utils.writeAccountArray(listAccountForEdit)
;     }
; }





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

copyLoginUrl(ItemName, ItemPos, MyMenu, acc) {
    A_Clipboard := acc.getLoginUrl()
}

MyGui.Show()


plantGui := Gui()
selectedTree := ""
selectedMaterial := "Kim Loại"
plantGui.SetFont("s11 norm")

plantGui.Add("GroupBox", "w130 h450 Section" , "Cây trồng")
treeArray := ["Cây Kim Tiền", "Lúa Mạch", "Lúa Gạo", "Bắp", "Khoai Lang", "Đậu Phộng", "Đậu Nành", "Cải Thảo", "Củ Cải", "Cacao", "Cao Lương", "Mướp", "Bầu", "Bông Cải", "Hoàng Kim Quả"]
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
    if (mirrorAccountArray.Length > 0) 
        Run ".\arrange\Style-1.ahk " getNames(mirrorAccountArray)
}

~!x:: {
    if (mirrorAccountArray.Length > 0) 
        Run ".\arrange\Style-2.ahk " getNames(mirrorAccountArray)
}

~!c:: {
    if (mirrorAccountArray.Length > 0) 
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
    if mirrorAccountArray.Length == 0
        return
    
    global accIndex
    accIndex++
    index := Mod(accIndex, mirrorAccountArray.Length) + 1   
    WinActivate mirrorAccountArray[index].ahkId
}

; ========================== ARRANGE ==========================



^r:: {
    Run "RegenAll.ahk"
}