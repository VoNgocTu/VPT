#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk
SetControlDelay -1 


F11::Pause -1

names := A_Args.get(1)
tenNongSan := A_Args.get(2)
ahkIds := getAhkIds(names)

A_IconTip := "Trồng Nông Sản - " tenNongSan " - " names
coordinatesArray := []


loop {
    ControlSendAll(ahkIds, "{Escape}")
    Sleep 200
    ControlSendAll(ahkIds, "``")
    Sleep 500
    ControlClickAll(ahkIds, "x611 y268")
    Sleep 1000
    ControlClickAll(ahkIds, "x639 y288")
    Sleep 1500
    ControlSendAll(ahkIds, "{Escape}")
    Sleep 200
    ControlClickAll(ahkIds, "x883 y143") ; Thu hoạch
    Sleep 200
    ControlClickAll(ahkIds, "x853 y176") ; Thu hoạch
    Sleep 200
    ControlClickAll(ahkIds, "x892 y197") ; Thu hoạch
    Sleep 7000
    ControlClickAll(ahkIds, "x754 y302") ; Người rơm
    Sleep 1000
    ControlClickAll(ahkIds, "x294 y339") ; Trồng cây ngắn ngày
    Sleep 1000
    chonNongSan(tenNongSan)
    Sleep 500
}


chonNongSan(tenNongSan) {
    switch tenNongSan
    {
        case "LuaMach": 
            ControlClickAll(ahkIds, "x327 y343")
        case "LuaGao": 
            ControlClickAll(ahkIds, "x321 y360")
        case "Bap": 
            ControlClickAll(ahkIds, "x317 y384")
        case "KhoaiLang": 
            ControlClickAll(ahkIds, "x316 y414")
        case "DauPhong": 
            ControlClickAll(ahkIds, "x328 y434")
        case "DauNanh": 
            clickXuong(1)
            ControlClickAll(ahkIds, "x328 y434")
        case "CaiThao": 
            clickXuong(2)
            ControlClickAll(ahkIds, "x328 y434")
        case "CuCai": 
            clickXuong(3)
            ControlClickAll(ahkIds, "x328 y434")
        case "Cacao": 
            clickXuong(4)
            ControlClickAll(ahkIds, "x328 y434")
        case "CaoLuong": 
            clickXuong(5)
            ControlClickAll(ahkIds, "x328 y434")
        case "Muop": 
            clickXuong(6)
            ControlClickAll(ahkIds, "x328 y434")
        case "Bau": 
            clickXuong(7)
            ControlClickAll(ahkIds, "x328 y434")
        case "BongCai": 
            clickXuong(8)
            ControlClickAll(ahkIds, "x328 y434")
        case "HoangKimQua":
            clickXuong(9)
            ControlClickAll(ahkIds, "x328 y434")
    }

    Sleep 500
}

clickXuong(solan) {
    loop solan {
        ControlClickAll(ahkIds, "x435 y436")
        Sleep 500
    }
}