#Requires AutoHotkey v2.0
#SingleInstance Force
#include Utils.ahk


names := A_Args.get(1)
tenNongSan := A_Args.get(2)
try {
    tenNguyenLieu := A_Args.get(3)
} catch {
    tenNguyenLieu := "Lông Thú"
}
ahkIds := getAhkIds(names)

A_IconTip :=  " - Nhân vật: " names "`n - Trồng Nông Sản: " tenNongSan "`n - Nguyên Liệu: " tenNguyenLieu
MsgBox(A_IconTip)
A_IconTip :=  " - Nhân vật: " tenNongSan "`n - Trồng Nông Sản: " tenNongSan "`n - Nguyên Liệu: " tenNongSan
MsgBox(A_IconTip)