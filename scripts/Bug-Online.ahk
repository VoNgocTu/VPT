#Requires AutoHotkey v2.0
#SingleInstance Off
#include VptUtils.ahk

names := A_Args.get(1)
utils := VptUtils()
accountArray := utils.getAccountArray(names)

utils.resetGui(accountArray)

utils.send(accountArray, "p")
Sleep 1000
utils.click(accountArray, "x564 y176") ; Nhân vật
Sleep 1000
utils.click(accountArray, "x400 y450") ; Chọn nhân vật đầu tiên
Sleep 1000
utils.click(accountArray, "x500 y450") ; Chọn nhân vật thứ 2
Sleep 1000
utils.click(accountArray, "x400 y550") ; Vào game
Sleep 1500

for acc in accountArray {
    WinClose acc.ahkId
}