#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk
#SingleInstance Force

action := ""
coordinatesArray := ["x695 y299", "x542 y459"]
MyGui := Gui()

~RButton Up:: {
    title := "Adobe Flash Player 32"
    ; title := "AutoHotkey v2 Help"
    pid := WinActive(title)
    if (pid == 0) {
        return
    }

    ; resetGui([pid])
    coordinates := getCoordinates()
    
    result := MsgBox("Copy toạ độ: " coordinates " ?",, "YesNo")
    if (result = "No") {
        return
    } else {
        A_Clipboard := coordinates
    }
}


F1:: {
    global action
    action := "Click chuột phải vào acc để đưa vào danh sách auto. Acc đầu tiên sẽ là Key, F1 lần nữa để chọn lại."  
    MsgBox(action)

    global MyGui
    MyGui := Gui()
    Tab := MyGui.Add("Tab3",, ["First Tab","Second Tab","Third Tab"])
    MyGui.Add("Checkbox", "vMyCheckbox", "Sample checkbox") 
    Tab.UseTab(2)
    MyGui.Add("Radio", "vMyRadio", "Sample radio1")
    MyGui.Add("Radio",, "Sample radio2")
    Tab.UseTab(3)
    MyGui.Add("Edit", "vMyEdit r5")  ; r5 means 5 rows tall.
    Tab.UseTab()  ; i.e. subsequently-added controls will not belong to the tab control.
    Btn := MyGui.Add("Button", "default xm", "OK")  ; xm puts it at the bottom left corner.
    Btn.OnEvent("Click", ProcessUserInput)
    MyGui.OnEvent("Close", ProcessUserInput)
    MyGui.OnEvent("Escape", ProcessUserInput)
    MyGui.Show()
    

    ; Btn := MyGui.Add("Button", "default xm", "OK")
    ; Btn.OnEvent("Click", ProcessUserInput)
    ; MyGui.Show()
}


ProcessUserInput(*)
{
    global MyGui
    Saved := MyGui.Submit()  ; Save the contents of named controls into an object.
    MsgBox("You entered:`n" Saved.MyCheckbox "`n" Saved.MyRadio "`n" Saved.MyEdit)
}

F2:: {
    global action
    action := "Chọn toạ độ mặc định."
    MsgBox(action)
}

F3:: {
    global action
    action := "Cick chuột phải vào màn hình của Key để chọn toạ độ để di chuyển."  
    MsgBox(action)
}

F4:: {
    global action
    action := "Chạy auto."  
    MsgBox(action)
}


; getCoordinates() {
;     OutputVarX := 0
;     OutputVarY := 0
;     OutputVarWin := 0
;     MouseGetPos &OutputVarX, &OutputVarY, &OutputVarWin
;     return "x" OutputVarX " y" OutputVarY
; }


; names := A_Args.get(1)
; names := "Trúc,Mai,Bắp,Lan,Cúc"
; pidArray := getProcessIds(names, "..\..\data\runtime.json")
; coordinatesArray := ["x425 y254", "x444 y378", "x574 y358", "x600 y267"]
; coordinatesArray := ["x259 y148", "x570 y184", "x512 y323"]

; farm(pidArray, coordinatesArray)