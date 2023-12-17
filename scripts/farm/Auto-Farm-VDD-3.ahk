#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("00,Mận", "..\..\data\runtime.json")
coordinatesArray := ["x353 y140", "x798 y109", "x529 y342"]


key_id := pidArray.get(1)
loop {
    move(pidArray, coordinatesArray, 2, 1000)
    resetAuto(pidArray)
    regen(pidArray, A_Index) 
}