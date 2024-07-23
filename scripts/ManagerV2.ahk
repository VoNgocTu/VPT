#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk
SetControlDelay -1 


totalGroup := 4
manageGroups := []
loop totalGroup {
    manageGroups.Push(config["manageGroups"][A_Index]["group"])
}
allAccountNames := arrayToString(manageGroups)
allAccountNames := arrayToString(trimArray(stringToArray(allAccountNames)))
log("INFO", "Manage accounts: " allAccountNames)


accIndex := 999999999
names := A_Args.get(1)
accounts := getAccounts(allAccountNames)
for account in accounts {
    account.isActive := InStr(names, account.name) != 0
}

activeAccountAhkIds := getActiveAccountAhkIds()

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

    global activeAccountAhkIds
    activeAccountAhkIds := getActiveAccountAhkIds()
    A_IconTip := "Manage:`n`n" getActiveAccountNames()
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

getActiveAccountNames() {
    global accounts
    nameArr := []
    for acc in accounts {
        if (acc.isActive) {
            nameArr.Push(acc.name)
        }
    }
    return arrayToString(nameArr)
}

getActiveAccountAhkIds() {
    global accounts
    ahkIdArr := []
    for acc in accounts {
        if (acc.isActive) {
            ahkIdArr.Push(acc.ahkId)
        }
    }
    return ahkIdArr
}

isActiveAccount(ahkId) {
    global accounts
    for acc in accounts {
        if (ahkId == acc.ahkId) {
            return acc.isActive
        }
    }
    log("ERROR", "Không thể tìm thấy ahkId trong danh sách account, ID: " ahkId)
    return false
}


; ahkIds := WingetList(title)

~F1:: {
    pauseToggle()

    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
    message := "OOOO`nOOOO - " getActiveAccountNames() "`nOOOO"
    if (isPaused()) {
        message := "XXXXX`nXXXXX - " getActiveAccountNames() "`nXXXXX"
    }

    ToolTip message, OutputVarX + 50, OutputVarY - 60 , 1
    SetTimer () => ToolTip(), -1000
}

~MButton:: {
    global accIndex
    global activeAccountAhkIds

    accIndex++
    index := Mod(accIndex, activeAccountAhkIds.Length) + 1
    
    showAccount(index)
}

showAccount(index) {
    global activeAccountAhkIds

    if (index < 0 || activeAccountAhkIds.Length < index) {
        return
    }
    
    WinActivate "ahk_id " activeAccountAhkIds[index]
    Sleep 50
}

~LButton:: {
    if (isPaused()) {
        return
    }

    global title
    try {
        WinGetTitle("A")
        ahkId := WinActive(title)
	}
	catch {
        Sleep 300
        ahkId := WinActive(title)
    }
    
    if (!isActiveAccount(ahkId)) {
        return
    }

    OutputVarX := 0
    OutputVarY := 0
    OutputVarWin := 0
    MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin

    mirrorClick(activeAccountAhkIds, "x" OutputVarX " y" OutputVarY, ahkId)
}

~!z:: {
    Run ".\arrange\Style-1.ahk " getActiveAccountNames()
}

~!x:: {
    Run ".\arrange\Style-2.ahk " getActiveAccountNames()
}

~!c:: {
    Run ".\arrange\Style-3.ahk " getActiveAccountNames()
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
    ; log("INFO", "Key received - " A_ThisHotkey)
    if (isPaused()) {
        return
    }

    global title
    try {
        WinGetTitle("A")
        ahkId := WinActive(title)
	}
	catch {
        Sleep 300
        ahkId := WinActive(title)
    }

    if (!isActiveAccount(ahkId)) {
        return
    }

    mirrorSend(activeAccountAhkIds, getOriginKey(A_ThisHotkey), ahkId) 
}


getOriginKey(thisKey) {
    key := SubStr(thisKey, 2, 999)
    if (StrLen(key) > 2) {
        key := "{" key "}"
    }
    return key
}


^r:: {
    Run "RegenAll.ahk"
}