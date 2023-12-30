#Requires AutoHotkey v2.0
#SingleInstance Off
#include Utils.ahk


names := stringToArray(A_Args.get(1))

index := 0
x := 0
y := -28
xOffset := 1066
yOffset := 724
for (name in names) {
    if (Mod(index, 2) == 0) {
        x := x + xOffset
    } else {
        y := y + yOffset
    }
    move name, x, y
    index++
}