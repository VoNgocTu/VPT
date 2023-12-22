#Requires AutoHotkey v2.0
#include Utils.ahk

; pidArray := getAhkIds("Nhân,Lazy,Thiên,Địa")
pidArray := getAhkIds("Lazy")

; ControlClickAll([keyId], "x34 y660")
keyId := pidArray.get(1)
; ControlClickAll([keyId], "x105 y659")
Sleep 1000
Send "{Alt up}[@N|5042|Dược Thảo Cấp 3]{Alt down}"
; ControlClick "x378 y655", "ahk_id " keyId,,,, "U"


; ControlClickAll([keyId], "x380 y656")
; ControlClickAll([keyId], "x105 y659")
; ControlSendAll([keyId], "/w [@PID|3270|Thiên]")
; ControlClickAll([keyId], "x380 y656")
; ControlClickAll([keyId], "x105 y659")
; ControlSendAll([keyId], "/w [@PID|3270|Thiên]")
; ControlClickAll([keyId], "x380 y656")
; ControlClickAll([keyId], "x105 y659")
; ControlSendAll([keyId], "/w [@PID|3270|Thiên]")
; ControlClickAll([keyId], "x380 y656")
; ControlSendAll([keyId], "{Enter}")
; ControlClickAll([keyId], "x105 y659")
; ControlSendAll([keyId], "/w " "⚶   Địa   ⚶ " "  a")
; ControlClickAll([keyId], "x380 y656")
; ; ControlSendAll([keyId], "{Enter}")
; ControlClickAll([keyId], "x105 y659")
; ControlSendAll([keyId], "/w " "⚶  Nhân  ⚶ " "  a")
; ControlClickAll([keyId], "x380 y656")
; ; ControlSendAll([keyId], "{Enter}")
; ControlClickAll([keyId], "x105 y659")
; ControlSendAll([keyId], "/w " "Lazy Tori  " "  a")
; ControlClickAll([keyId], "x380 y656")
; ControlSendAll([keyId], "{Enter}")


