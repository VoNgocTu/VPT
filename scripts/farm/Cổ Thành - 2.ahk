#Requires AutoHotkey v2.0
#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Thiên,Lazy,Địa,Nhân,Bông", "..\..\data\runtime.json")
coordinatesArray := ["x129 y457", "x129 y512"]

farm(pidArray, coordinatesArray)