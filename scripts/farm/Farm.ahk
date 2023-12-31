#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk

names := A_Args.get(1)
; names := "Trúc,Mai,Bắp,Lan,Cúc"
pidArray := getProcessIds(names, "..\..\data\runtime.json")
coordinatesArray := ["x119 y357", "x131 y440"]

farm(pidArray, coordinatesArray)