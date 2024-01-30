#Requires AutoHotkey v2.0
#include Auto-Plant-Material.ahk

ids := WinGetList("Adobe Flash Player 10")
for id in ids
{
    ahk_id := "ahk_id " id
    autoTrangVien(ahk_id)
}
