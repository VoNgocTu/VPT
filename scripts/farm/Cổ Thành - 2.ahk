#Requires AutoHotkey v2.0
#SingleInstance Force

#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Nhân,Thiên,Yui,Lazy,Địa", "..\..\data\runtime.json")
coordinatesArray := ["x210 y465", "x393 y466", "x291 y285"]
; coordinatesArray := ["x129 y457", "x129 y512"]

farm(pidArray, coordinatesArray)