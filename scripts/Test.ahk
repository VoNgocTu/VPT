#Requires AutoHotkey v2.0
#include Utils.ahk
#SingleInstance Force
; Persistent


~F1::Pause -1

MyMenu := Menu()
MyMenu.Add "X", closeMenu
MyMenu.Add "Item 1", MenuHandler
MyMenu.Add "Item 2", MenuHandler
MyMenu.Add  ; Add a separator line.

; Create another menu destined to become a submenu of the above menu.
Submenu1 := Menu()
Submenu1.Add "Item A", MenuHandler
Submenu1.Add "Item B", MenuHandler

; Create a submenu in the first menu (a right-arrow indicator). When the user selects it, the second menu is displayed.
MyMenu.Add "My Submenu", Submenu1

MyMenu.Add  ; Add a separator line below the submenu.
MyMenu.Add "Item 3", MenuHandler  ; Add another menu item beneath the submenu.

MenuHandler(Item, *) {
    MsgBox "You selected " Item
}

closeMenu(*) {
    
}


~RButton:: {
    ; MsgBox("Width:" A_ScreenWidth ", Height: " A_ScreenHeight)
    global MyMenu
    MyMenu.Show
}



; ~LButton:: {
;     if (A_IsPaused) {
;         return
;     }


;     try
; 	{
;         WinGetTitle("A")
; 		id := WinGetPID("A")
; 	}
; 	catch
;     {
;         Sleep 150
;         id := WinGetPID("A")
;     }
;     ; id := WinGetPID("ahk_id 526260")

;     MsgBox("Window is active - " id)
; }

; if (WinActive("AutoHotkey v2 Help") != 0) {
;     MsgBox("Window is active - " title)
; } else {
;     MsgBox("Window is not active - " title)
; }
