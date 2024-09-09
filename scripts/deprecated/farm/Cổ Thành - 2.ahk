#Requires AutoHotkey v2.0
#SingleInstance Force

#include Farm-Actions.ahk
#include ../Utils.ahk

names := "Nhân,Thiên,Bông,Lazy,Địa"
A_IconTip := "Cổ Thành - " names
pidArray := getProcessIds(names, "..\..\data\accountsV2.json")
coordinatesArray := ["x210 y465", "x393 y466", "x291 y285"]

farm(pidArray, coordinatesArray)