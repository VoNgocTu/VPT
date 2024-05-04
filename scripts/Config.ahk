#Requires AutoHotkey v2.0
#Include libs\JSON.ahk

dataPath := A_MyDocuments "\VPT\data\"
configPath := dataPath "config.json" 
text := FileRead(configPath, "UTF-8")
config := jxon_load(&text)


title := config["flash"]["title"]
accountPath := dataPath config["accountsFile"]
; result := MsgBox(title)
; title := "Adobe Flash Player 32"