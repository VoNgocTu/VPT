#Requires AutoHotkey v2.0
#SingleInstance Force


; ============================ GUI ============================

MyGui := Gui()
MyGui.SetFont("s11 norm")


MyGui.Add("Text",, "Tên*:")
MyGui.Add("Text",, "Server:")
MyGui.Add("Text",, "Link*:")
MyGui.Add("Edit", "vName ym")
MyGui.Add("Edit", "vServer")
MyGui.Add("Edit", "vLink")
MyGui.Add("Button", "default", "Tạo file *.bat").OnEvent("Click", btnGenerate_click)

MyGui.Show()

btnGenerate_click(*) {
    Saved := MyGui.Submit()  ; Save the contents of named controls into an object.
    name := Saved.Name
    link := Saved.Link
    server := Saved.Server

    loginUrl := getLoginUrl(link, server)
    batContent := ":: Origin link: " link "`n"
    batContent := batContent "`"flashplayer_32.exe`" " "`"" loginUrl "`""
    batFileName := name ".bat"
    
    try {
        FileDelete batFileName
    } catch Error as e {
        
    }
    FileAppend batContent, batFileName

    MsgBox("File " Saved.Name ".bat đã được tạo ra.")
}


getLoginUrl(link, server := "", urlPattern := "https://s3-vuaphapthuat.goplay.vn/s/{0}/GameLoaders.swf?user={1}&pass={2}&version=0.9.9a33.342&isExpand=true&nothing=true") {
    RegExMatch(link, ".*\/s\/(.*)\/index.php&([^&]*)&([^&]*).*", &matches)
    if (matches == "") {
        RegExMatch(link, ".*\/s\/(.*)\/GameLoaders?.swf\?user=([^&]*)&pass=([^&]*).*", &matches)
    }

    if (server == "") 
        server := matches[1]

    if (!InStr(server, "s"))
        server := "s" server

    username := matches[2]
    password := matches[3] 

    result := urlPattern
    result := RegExReplace(result, "\{0\}", server)
    result := RegExReplace(result, "\{1\}", username)
    result := RegExReplace(result, "\{2\}", password)
    return result
}
