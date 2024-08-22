#Requires AutoHotkey v2.0
#SingleInstance Force

configFileName := "Config.ahk"


GetFullPathName(path) {
    cc := DllCall("GetFullPathNameW", "str", path, "uint", 0, "ptr", 0, "ptr", 0, "uint")
    DllCall("GetFullPathNameW", "str", path, "uint", cc, "ptr", buf := Buffer(cc*2), "ptr", 0, "uint")
    return StrGet(buf)
}


FileDelete configFileName
config := 
(
    "#Requires AutoHotkey v2.0 `n`n`n"
    
    "title := `"Adobe Flash Player 10`" `n"
    "rootPath := `"" GetFullPathName(A_WorkingDir "\..\") "`" `n"
    "scriptPath := `"" A_WorkingDir "`" `n"
    "logPath := `"" A_WorkingDir "\logs`" `n"
)
FileAppend config, configFileName

