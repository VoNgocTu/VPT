ids := WinGetList("Adobe Flash Player 32")
for id in ids
{
    ControlClick "x1026 y608", "ahk_id " id
    ControlClick "x1026 y608", "ahk_id " id
}