#Requires AutoHotkey v2.0
#Include <JSON>

accList := JSON.Load(
"{
    \"accList\": [
        {
            \"index\": 1,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&vntu512@goid&47a6d8323a96f7f88bded56ce1311688\",
            \"owner\": \"Tú\",
            \"char\": \"DY\",
            \"name\": \"Bong Xu\"
        },
        {
            \"index\": 2,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&gg_vkhoa009@goid&74de28b1b50e8830f7db50340c46ce70\",
            \"owner\": \"Khoa\",
            \"char\": \"NC\",
            \"name\": \"Taylor\"
        },
        {
            \"index\": 3,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&qrac002@goid&d5f47142d4d6b1082fe8ad303a4a7020\",
            \"owner\": \"Khoa\",
            \"char\": \"HS\",
            \"name\": \"Siu\"
        },
        {
            \"index\": 4,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&qrac003@goid&4c76e613506961f969a981ef2a15b18d\",
            \"owner\": \"Khoa\",
            \"char\": \"TS\",
            \"name\": \"Hao\"
        },
        {
            \"index\": 5,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&ltcliff04@goid&ea0f47f6a80fa6f5403ee290c71edde2\",
            \"owner\": \"Tân\",
            \"char\": \"TS\",
            \"name\": \"Man\"
        },
        {
            \"index\": 6,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&ltcliff02@goid&9b20d5dc47710ddfa0e3cdc4d9a05898\",
            \"owner\": \"Tân\",
            \"char\": \"TS\",
            \"name\": \"Bap\"
        },
        {
            \"index\": 7,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&yui313@goid&dc6523ef48242438a482a8158816697b\",
            \"owner\": \"Yui\",
            \"char\": \"TS\",
            \"name\": \"Yui313.\"
        },
        {
            \"index\": 8,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&vntu_c_1@goid&d36c6a61e47527c3366308cefe456021\",
            \"owner\": \"Tú\",
            \"char\": \"NC\",
            \"name\": \"© Mai ®\"
        },
        {
            \"index\": 9,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&vntu_c_2@goid&936995ec0bfca876ddafd121a17db894\",
            \"owner\": \"Tú\",
            \"char\": \"NC\",
            \"name\": \"© Lan ®\"
        },
        {
            \"index\": 10,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&vntu_c_3@goid&4f13f2ace8792c01d34cc0d5e9a34edf\",
            \"owner\": \"Tú\",
            \"char\": \"NC\",
            \"name\": \"© Cúc ®\"
        },
        {
            \"index\": 11,
            \"link\": \"mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&vntu_c_4@goid&673e00dc2a6e948f6b7b4c0ab9ddc1cd\",
            \"owner\": \"Tú\",
            \"char\": \"NC\",
            \"name\": \"© Trúc ®\"
        }
    ]
}", reviver
)

reviver(this, key, value)
{
	; return value as is if you don't want to alter it
	return [value][1] ; for numeric values, preserve internally cached number
}

MyGui := Gui()
MyGui.Opt("Resize")
Tab := MyGui.Add("Tab3", "W300 H500", ["First Tab","Second Tab","Third Tab"])
Btn := MyGui.Add("Button", "W100 H30", "OK")

Btn.OnEvent("Click", openGame)
Btn.Name := "http://s3.vuaphapthuat.goplay.vn/s/s45/GameLoaders.swf?user=vntu_c_4@goid&pass=673e00dc2a6e948f6b7b4c0ab9ddc1cd&isExpand=true"


Tab.UseTab(2)
MyGui.Add("Radio", "vMyRadio", "Sample radio1")
MyGui.Add("Radio",, "Sample radio2")
Tab.UseTab(3)
MyGui.Add("Edit", "vMyEdit r5")  ; r5 means 5 rows tall.
Tab.UseTab()  ; i.e. subsequently-added controls will not belong to the tab control.
; Btn := MyGui.Add("Button", "default xm", "OK")  ; xm puts it at the bottom left corner.
; Btn.OnEvent("Click", ProcessUserInput)

; MyGui.OnEvent("Escape", ProcessUserInput)
MyGui.Show("W300 H500")

openGame(GuiCtrlObj, Info) {
    Run '"flashplayer_32.exe"' GuiCtrlObj.Name ''
}