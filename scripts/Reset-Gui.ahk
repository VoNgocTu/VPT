#Requires AutoHotkey v2.0
#include Utils.ahk

ahkIds := getAhkIds(A_Args.get(1))
resetGui(ahkIds)