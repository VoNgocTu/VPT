#Requires AutoHotkey v2.0
#SingleInstance Force

#include Farm-Actions.ahk
#include ../Utils.ahk


pidArray := getProcessIds("Long,Phụng,Bông,Lân,Quy", "..\..\data\runtime.json")
coordinatesArray := ["x210 y465", "x393 y466", "x291 y285"]

farm(pidArray, coordinatesArray)