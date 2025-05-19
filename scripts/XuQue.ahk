#Requires AutoHotkey v2.0
#SingleInstance Force
#include Base.ahk
SetControlDelay -1 

utils := VptUtils()

A_IconTip := "Xú Quẻ - Nhân vật: " names


PL_4000  := "x180 y550"
PL_5000  := "x315 y550"
PL_7000  := "x450 y550"
PL_9000  := "x585 y550"
PL_12000 := "x720 y550"

G1_1  := "x212 y200"
G1_2  := "x324 y200"
G1_3  := "x436 y200"
G1_4  := "x548 y200"
G1_5  := "x760 y200"
G1_6  := "x772 y200"
G1_7  := "x884 y200"
G2_1  := "x212 y310"
G2_2  := "x324 y310"
G2_3  := "x436 y310"
G2_4  := "x548 y310"
G2_5  := "x760 y310"
G2_6  := "x772 y310"
G2_7  := "x884 y310"

~F11::Pause -1

loop {
    if (A_IsPaused) {
        Sleep 5000
        return
    } 

    clickObject(PL_12000)
    clickObject(PL_9000)
    clickObject(PL_7000)
    clickObject(PL_5000)
    clickObject(PL_4000)
    clickObject(PL_4000)

    clickObject(G2_7)
    clickObject(G2_6)
    clickObject(G2_5)
    clickObject(G2_4)
    clickObject(G2_3)
    clickObject(G2_2)
    clickObject(G2_1)

    clickObject(G1_7)
    clickObject(G1_6)
    clickObject(G1_5)
    clickObject(G1_4)
    clickObject(G1_3)
    clickObject(G1_2)
    clickObject(G1_1)
}


clickObject(coordinates) {
    clickAll(coordinates)
    clickAll("x544 y363")
    ; ControlSendAll(ahkIds, "{Enter}")   
}

clickAll(coordiante) {
    for acc in accountArray {
        acc.click(coordiante)
    }
    Sleep 100
}