#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Lan", "..\..\data\runtime.json")
; coordinatesArray := ["x210 y465", "x393 y466", "x291 y285"]
coordinatesArray := ["x628 y481", "x456 y522", "x412 y358"]

farm(pidArray, coordinatesArray)