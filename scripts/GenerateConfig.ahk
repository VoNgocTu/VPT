#Requires AutoHotkey v2.0
#SingleInstance Force

configFileName := "Config.ahk"


GetFullPathName(path) {
    cc := DllCall("GetFullPathNameW", "str", path, "uint", 0, "ptr", 0, "ptr", 0, "uint")
    DllCall("GetFullPathNameW", "str", path, "uint", cc, "ptr", buf := Buffer(cc*2), "ptr", 0, "uint")
    return StrGet(buf)
}

rootPath := GetFullPathName(A_WorkingDir "\..")
manageAccs := [
    "Bông" , "Blade"   ,
    "Yui"  , "Icypen"  ,
    "Hạo"  , "Koha"    ,
    "Mận"  , "Lowji"   ,
    "Siu"  , "Mýt"     ,
    "Lazy" , "Sun"     ,
]

manageAccsStr := ""
for acc in manageAccs {
    if (A_Index > 1) 
        manageAccsStr := manageAccsStr ","
    manageAccsStr := manageAccsStr acc
}



FileDelete configFileName

; Continuation section
config := 
(
    "#Requires AutoHotkey v2.0 `n`n`n"
    
    "manageAccs := `"" manageAccsStr "`" `n"
    "rootPath := `"" rootPath "`" `n"
    "title := `"Adobe Flash Player 10`" `n"
    "flashPath := rootPath `"\tools\flashplayer_10.exe`" `n"
    "logPath := rootPath `"\logs`" `n"
    "scriptPath := rootPath `"\scripts`" `n"
)

FileEncoding "UTF-8"
FileAppend config, configFileName

