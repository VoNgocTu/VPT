#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Trúc,Mai,Lan,Cúc,Yui", "..\..\data\runtime.json")
coordinatesArray := ["x138 y445", "x142 y510"]

farm(pidArray, coordinatesArray)