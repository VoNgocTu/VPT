title := "Adobe Flash Player 32"
ControlSend "p", , title
Sleep 1000
ControlClick "x564 y176", title ; Nhân vật
Sleep 1000
ControlClick "x400 y450", title ; Chọn nhân vật đầu tiên
Sleep 1000
ControlClick "x500 y450", title ; Chọn nhân vật thứ 2
Sleep 1000
ControlClick "x400 y550", title ; Vào game
Sleep 1500
WinClose title

; a::{
; }
; b::{
;     ControlClick "x500 y450", title ; Select Char 2
; }
; c::{
;     ControlClick "x600 y450", title ; Select Char 3
; }


; Sleep 5000
