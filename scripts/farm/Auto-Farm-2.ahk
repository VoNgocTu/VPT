#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Yui313,Tiny Tori,Thiên,Địa,Nhân", "..\..\data\runtime.json")
coordinatesArray := ["x210 y465", "x393 y466", "x291 y285"]


key_id := pidArray.get(1)
loop {
    move(pidArray, coordinatesArray, 1, 1500)
    ; resetAuto(pidArray)
    ; Sleep 500
    ; regen(pidArray) 
}