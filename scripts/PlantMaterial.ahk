#Requires AutoHotkey v2.0
#include Base.ahk
#SingleInstance Off
SetControlDelay -1 

materialName := A_Args.get(2)

plantMaterial(materialName)