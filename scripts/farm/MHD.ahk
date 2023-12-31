#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Trúc,Mai,Bắp,Lan,Cúc", "..\..\data\runtime.json")
coordinatesArray := ["x119 y357", "x131 y440"]

farm(pidArray, coordinatesArray)