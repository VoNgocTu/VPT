#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk
#SingleInstance Off

names := A_Args.get(1)
; names := "Trúc,Mai,Bắp,Lan,Cúc"
pidArray := getProcessIds(names, "..\..\data\runtime.json")
; coordinatesArray := ["x425 y254", "x444 y378", "x574 y358", "x600 y267"]
coordinatesArray := ["x259 y148", "x570 y184", "x512 y323"]

farm(pidArray, coordinatesArray)