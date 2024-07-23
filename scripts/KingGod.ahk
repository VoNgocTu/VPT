#Requires AutoHotkey v2.0
#SingleInstance Force

title := "BlueStacks App Player"

w := 607
h := 1080

ahkId := WinGetID(title)
codeArray := [
    "KingGodCartoon22",
    "KGCPlayLive4",
    "KingGodGift23",
    "EnjoyKingGodCollab",
    "JoinNowKgcGlobal",
    "ForumVisitorTYSO",
    "KingGodJuly2024",
]
codeDelete := "I agree to deactivate the account"

F1:: {
    global ahkId
    
    WinMove 0, 0, w, h, "ahk_id " ahkId

    deleteAcc()

    Sleep 1000
    ControlClick "x485 y198", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    ControlClick "x278 y889", "ahk_id " ahkId,,,, "NA"
    Sleep 500

    enterCode()

    Sleep 500
    ControlClick "x474 y147", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    ControlClick "x372 y193", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x292 y978", "ahk_id " ahkId,,,, "NA"
    Sleep 3000
    ControlClick "x474 y147", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    ControlClick "x101 y874", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    
    ControlClick "x459 y813", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x459 y813", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
}

F2:: {
    Sleep 1000
    ControlClick "x485 y198", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    ControlClick "x278 y889", "ahk_id " ahkId,,,, "NA"
    Sleep 500

    enterCode()

    Sleep 500
    ControlClick "x474 y147", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    ControlClick "x372 y193", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x292 y978", "ahk_id " ahkId,,,, "NA"
    Sleep 3000
    ControlClick "x474 y147", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    ControlClick "x101 y874", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    
    ControlClick "x459 y813", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x459 y813", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
}


enterCode() {
    global ahkId
    global codeArray
    Loop 7 {
        ControlClick "x286 y925", "ahk_id " ahkId,,,, "NA"
        Sleep 1000
        ControlClick "x226 y584", "ahk_id " ahkId,,,, "NA"
        Sleep 500
        Send codeArray[A_Index]
        Sleep 1000
        ControlClick "x226 y584", "ahk_id " ahkId,,,, "NA"
        Sleep 700
        ControlClick "x216 y652", "ahk_id " ahkId,,,, "NA"
        Sleep 700
        ControlClick "x255 y636", "ahk_id " ahkId,,,, "NA"
        Sleep 700
        ControlClick "x424 y652", "ahk_id " ahkId,,,, "NA"
        Sleep 700
    }
}


deleteAcc() {
    global ahkId

    Sleep 1000
    ControlClick "x485 y198", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    ControlClick "x278 y889", "ahk_id " ahkId,,,, "NA"
    Sleep 500

    ControlClick "x287 y775", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x212 y637", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    ControlClick "x251 y577", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    Send codeDelete
    Sleep 500
    ControlClick "x251 y577", "ahk_id " ahkId,,,, "NA"
    Sleep 500
    ControlClick "x209 y662", "ahk_id " ahkId,,,, "NA"
    Sleep 1500
    ControlClick "x287 y640", "ahk_id " ahkId,,,, "NA"
    Sleep 7500
    ControlClick "x400 y352", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x142 y565", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x136 y625", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x290 y756", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x283 y849", "ahk_id " ahkId,,,, "NA"
    Sleep 17000
    ControlClick "x537 y51", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x298 y549", "ahk_id " ahkId,,,, "NA"
    Sleep 10000
    ControlClick "x537 y51", "ahk_id " ahkId,,,, "NA"
    Sleep 1000
    ControlClick "x298 y549", "ahk_id " ahkId,,,, "NA"
    Sleep 3000
    ControlClick "x102 y920", "ahk_id " ahkId,,,, "NA"
    Sleep 1000

}