#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Bông Xù,Tiny Tori,Thiên,Địa,Nhân", "..\..\data\runtime.json")
coordinatesArray := ["x210 y465", "x393 y466", "x291 y285"]


key_id := pidArray.get(1)
loop {
    move(pidArray, coordinatesArray, 2)
    resetAuto(pidArray)
    regen(pidArray) 
}