#Requires AutoHotkey v2.0
#SingleInstance Off

ids := StrSplit(A_Args.get(1), ",")

for id in ids {
    ahk_pid := "ahk_pid " id
    autoPlant(ahk_pid)
}

autoPlant(ahk_pid) {
    ControlSend "{Escape}", , ahk_pid
    Sleep 200
    ControlSend "{Escape}", , ahk_pid
    Sleep 200
    ControlSend "{Escape}", , ahk_pid
    Sleep 200

    ControlClick "x1000 y330", ahk_pid ; trang vien
    Sleep 5000
    ControlClick "x425 y489", ahk_pid ; Nuoi trong
    Sleep 2000
    ControlClick "x345 y178", ahk_pid ; Chọn Kim loại
    Sleep 2000

    plantMaterials(ahk_pid)
    plantMaterials(ahk_pid)
    plantMaterials(ahk_pid)

    ControlClick "x528 y493", ahk_pid ; Toàn bộ
    Sleep 500
    ControlClick "x398 y278", ahk_pid ; Thu hoạch
    Sleep 500
    ControlClick "x398 y278", ahk_pid ; Thu hoạch
    Sleep 5000
}

plantMaterials(ahk_pid) {
    plantMaterial("x235 y299", ahk_pid) ; 1
    plantMaterial("x281 y262", ahk_pid) ; 2
    plantMaterial("x334 y231", ahk_pid) ; 3
    plantMaterial("x386 y197", ahk_pid) ; 4

    plantMaterial("x457 y236", ahk_pid) ; 8
    plantMaterial("x393 y266", ahk_pid) ; 7
    plantMaterial("x338 y300", ahk_pid) ; 6
    plantMaterial("x285 y328", ahk_pid) ; 5
}

plantMaterial(coordinates, ahk_pid, sleepTime := 400) {
    ControlClick coordinates, ahk_pid
    Sleep sleepTime/2
    ControlClick "x524 y371", ahk_pid ; OK when error
    Sleep sleepTime/2
}
