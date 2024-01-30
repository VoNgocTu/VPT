#Requires AutoHotkey v2.0
#include Utils.ahk
#SingleInstance Off

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

names := A_Args.get(1)
ahkIds := getAhkIds(names)

resetGui(ahkIds)
resetGui(ahkIds)

ControlClickAll(ahkIds, "x1000 y330") ; trang vien
Sleep 5000
ControlClickAll(ahkIds, "x425 y489")  ; Click Nuôi Trồng
Sleep 2000
ControlClickAll(ahkIds, LT)  ; Chọn Nguyên liệu
Sleep 2000

plantMaterials(ahkIds)


ControlClickAll(ahkIds, "x528 y493") ; Toàn bộ
Sleep 500
ControlClickAll(ahkIds, "x564 y307") ; Thu hoạch
Sleep 500
ControlClickAll(ahkIds, "x528 y493") ; Toàn bộ
Sleep 500
ControlClickAll(ahkIds, "x395 y403") ; Thu hoạch
Sleep 500

plantMaterials(ahkIds) {
    plantMaterial("x211 y298", ahkIds) ; 1
    plantMaterial("x230 y297", ahkIds) ; 1
    plantMaterial("x233 y311", ahkIds) ; 1

    plantMaterial("x263 y264", ahkIds) ; 2
    plantMaterial("x287 y261", ahkIds) ; 2
    plantMaterial("x285 y280", ahkIds) ; 2

    plantMaterial("x315 y236", ahkIds) ; 3
    plantMaterial("x341 y230", ahkIds) ; 3
    plantMaterial("x336 y246", ahkIds) ; 3

    plantMaterial("x370 y201", ahkIds) ; 4
    plantMaterial("x398 y197", ahkIds) ; 4
    plantMaterial("x394 y217", ahkIds) ; 4

    plantMaterial("x420 y239", ahkIds) ; 8
    plantMaterial("x452 y235", ahkIds) ; 8
    plantMaterial("x450 y256", ahkIds) ; 8

    plantMaterial("x366 y270", ahkIds) ; 7
    plantMaterial("x399 y265", ahkIds) ; 7
    plantMaterial("x396 y284", ahkIds) ; 7

    plantMaterial("x315 y301", ahkIds) ; 6
    plantMaterial("x349 y295", ahkIds) ; 6
    plantMaterial("x343 y317", ahkIds) ; 6

    plantMaterial("x263 y333", ahkIds) ; 5
    plantMaterial("x297 y326", ahkIds) ; 5
    plantMaterial("x289 y348", ahkIds) ; 5
}

plantMaterial(coordinates, ahkIds, sleepTime := 200) {
    ControlClickAll(ahkIds, coordinates) ; Click ruộng
    Sleep sleepTime/2
    ControlSendAll(ahkIds, "{Enter}")
    Sleep sleepTime/2
}
