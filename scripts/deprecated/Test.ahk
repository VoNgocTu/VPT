#Requires AutoHotkey v2.0
#include Utils.ahk
#SingleInstance Force
; Persistent


~F1::Pause -1




; MyMenu := Menu()
; MyMenu.Add "X", closeMenu
; MyMenu.Add "Item 1", MenuHandler
; MyMenu.Add "Item 2", MenuHandler
; MyMenu.Add  ; Add a separator line.

; Create another menu destined to become a submenu of the above menu.
; Submenu1 := Menu()
; Submenu1.Add "Item A", MenuHandler
; Submenu1.Add "Item B", MenuHandler

; Create a submenu in the first menu (a right-arrow indicator). When the user selects it, the second menu is displayed.
; MyMenu.Add "My Submenu", Submenu1

; MyMenu.Add  ; Add a separator line below the submenu.
; MyMenu.Add "Item 3", MenuHandler  ; Add another menu item beneath the submenu.

; MenuHandler(Item, *) {
;     MsgBox "You selected " Item
; }

; closeMenu(*) {
    
; }


arrayTest := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

rootX := 205
rootY := 300

landCoordinates := stringToArray(getLandCoordinates(rootX, rootY, 2))
plantCoordinatesMatrix := []
for landCoordinate in landCoordinates {
    plantCoordinatesMatrix.Push(getPlantCoordinateArray(landCoordinate))
}

; Click location
;................
;..x.............
;................
;........x.......
;................
;..x............. ; landCoordinate
;................

index := 1

~F12:: {
    ; MsgBox("Width:" A_ScreenWidth ", Height: " A_ScreenHeight)
    ; global MyMenu
    ; MyMenu.Show

    ; title := "Adobe Flash Player 10"
    ; title := "AutoHotkey v2 Help"


    ; winId := WinExist(title)
    global coordinates
    global index
    
    item := Mod(index, 8)
    if (item == 0) {
        item := 8
    }
    result := MsgBox("Index: " index " - Coordinate: " item " - " arrayToString(plantCoordinatesMatrix.get(item)),, "YesNo")
    if (result == "Yes") {
        title := "Adobe Flash Player 10"
        ahkId := WinActive(title)
        matrixClick(plantCoordinatesMatrix.get(item), ["ahk_id " ahkid])
    }
    index++
}

getLandCoordinates(rootX, rootY, columnNumber := 2) {
    x := rootX
    y := rootY
    
    coordinates := ""
    loop columnNumber {
        coordinates := coordinates getLandColumnCoordinates(x, y) ","
        x := x + 55
        y := y + 33
    }
    return removeLastComma(coordinates)
}

getLandColumnCoordinates(rootX, rootY) {
    x := rootX
    y := rootY

    coordinates := ""
    loop 4 {
        coordinates := coordinates x "|" y ","
        x := x + 55
        y := y - 33
    }
    return removeLastComma(coordinates)
}

getPlantCoordinateArray(input, sleepTime := 600) {
    root := stringToArray(input, "|")
    x := root.get(1)
    y := root.get(2)
    return ["x" x " y" y, "x" (x + 28) " y" (y - 15), "x" (x + 25) " y" y]
}

removeLastComma(str) {
    lastCommaPos := InStr(str, ",", 0, 1, 99)  ; get position of last occurrence of ","
    return SubStr(str, 1, lastCommaPos - 1)  ; get substring from start to last comma
}

matrixClick(coordinates, ahkIds, sleepTime := 600) {
    time := sleepTime / 6
    for coordinate in coordinates {
        ControlClickAll(ahkIds, "x" x " y" y)
        Sleep time
        ControlSendAll(ahkIds, "{Enter}")
        Sleep time
    }
}


trongTrangVien(ahkIds, tenNguyenLieu) {
    KL  := "x335 y169"
    KLH := "x606 y235"
    G   := "x480 y165"
    GT  := "x341 y270"
    N   := "x607 y168"
    PL  := "x481 y262"
    V   := "x332 y218"
    GV  := "x604 y264"
    LT  := "x476 y228"
    DT  := "x350 y326"

    toaDo := KL
    switch tenNguyenLieu
    {
        case "Kim Loại": 
            toaDo := KL
        case "Kim Loại Hiếm": 
            toaDo := KLH
        case "Gỗ": 
            toaDo := G
        case "Gỗ Tốt": 
            toaDo := GT
        case "Ngọc": 
            toaDo := N
        case "Pha Lê": 
            toaDo := PL
        case "Vải": 
            toaDo := V
        case "Gấm Vóc": 
            toaDo := GV
        case "Lông Thú": 
            toaDo := LT
        case "Da Thú": 
            toaDo := DT
    }
    
    rootX := 205
    rootY := 300
    
    names := A_Args.get(1)
    ahkIds := getAhkIds(names)
    
    resetGui(ahkIds)
    
    ControlClickAll(ahkIds, "x1000 y330") ; trang vien
    Sleep 3000
    ControlClickAll(ahkIds, "x425 y489")  ; Click Nuôi Trồng
    Sleep 1500
    ControlClickAll(ahkIds, toaDo)  ; Chọn Nguyên liệu
    Sleep 1000
    
    plantMaterials(rootX, rootY, ahkIds)
    
    ControlClickAll(ahkIds, "x528 y493") ; Toàn bộ
    Sleep 500
    ControlClickAll(ahkIds, "x564 y307") ; Thu hoạch
    Sleep 5000

    resetGui(ahkIds)
}


plantMaterials(rootX, rootY, ahkIds) {
    x := rootX
    y := rootY
    
    loop 4 {
        plantColumn(x, y, ahkIds)
        x := x + 55
        y := y + 33
    }
}

plantColumn(rootX, rootY, ahkIds) {
    x := rootX
    y := rootY

    loop 4 {
        plantMaterial(x, y, ahkIds)
        x := x + 55
        y := y - 33
    }
}

plantMaterial(x, y, ahkIds, sleepTime := 600) {
    time := sleepTime / 6
    ControlClickAll(ahkIds, "x" x " y" y) ; Click ruộng BOT
    Sleep time
    ControlSendAll(ahkIds, "{Enter}")
    Sleep time
    ControlClickAll(ahkIds, "x" (x + 28) " y" (y - 15)) ; Click ruộng TOP
    Sleep time
    ControlSendAll(ahkIds, "{Enter}")
    Sleep time
    ControlClickAll(ahkIds, "x" (x + 25) " y" y) ; Click ruộng MID
    Sleep time
    ControlSendAll(ahkIds, "{Enter}")
    Sleep time
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
