#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Hạo,Mận,Bắp,00,01", "..\..\data\runtime.json")
coordinatesArray := ["x210 y465", "x393 y466", "x291 y285"]

farm(pidArray, coordinatesArray)