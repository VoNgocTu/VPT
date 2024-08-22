class Account {
    name := ""
    char := ""
    isActive := false
    ahkId := 0
    processId := 0
    originLink := ""
    
    server   := ""
    username := ""
    password := ""

    originWidth := 1066
    originHeight := 724
    reduceHeight := 703 ; 724 - 21px (21px is expand space of game screen)
    multiples := 1
    button := ""

    __New(accountMap) {
        try {
            this.ahkId := accountMap["ahkId"]
            if (!InStr(this.ahkId, "ahk_id ")) {
                this.ahkId := "ahk_id " this.ahkId
            }
        } catch {
            this.ahkId := 0
        }

        try {
            this.processId := accountMap["processId"]
            if (!InStr(this.processId, "ahk_pid ")) {
                this.processId := "ahk_pid " this.processId
            }
        } catch {
            this.processId := 0
        }

        this.name := accountMap["name"]
        this.char := accountMap["char"]
        this.originLink := accountMap["originLink"]

        this.extractLinkData()
    }

    extractLinkData() {
        RegExMatch(this.originLink, ".*\/s\/(.*)\/index.php&([^&]*)&([^&]*).*", &matches)
        if (matches == "") {
            RegExMatch(this.originLink, ".*\/s\/(.*)\/GameLoaders?.swf\?user=([^&]*)&pass=([^&]*).*", &matches)
        }

        this.server := matches[1]
        this.username := matches[2]
        this.password := matches[3]    
    }

    resetWindowSize() {
        style := WinGetStyle(this.ahkId)
        if (style & 0xC00000) {
            WinMove , , this.originWidth, this.originHeight, this.ahkId
        } else {
            ; Remove border 2px and title height 25px
            WinMove , , (this.originWidth - 2), (this.originHeight - 25), this.ahkId
        }
    }

    resetGui() {
        this.click("x875 y46")
        this.send("{Escape}")
        
    }

    click(coordinate) {
        ControlClick coordinate, this.ahkId,,,, "NA"
    }

    send(key) {
        ControlSend key, , this.ahkId
    }

    show(sleepTime := 50) {
        WinActivate this.ahkId
        Sleep sleepTime
    }


    hide(sleepTime := 50) {
        WinMinimize this.ahkId
        Sleep sleepTime
    }


    close() {
        WinClose this.ahkId
    }


    receiveMail() {
        id := this.ahkId
        this.receiveMailAction("x355 y207", id, 500)
        this.receiveMailAction("x355 y227", id, 500)
        this.receiveMailAction("x355 y247", id, 500)
        this.receiveMailAction("x355 y267", id, 500)
        this.receiveMailAction("x355 y287", id, 500)
        this.receiveMailAction("x355 y307", id, 500)
        this.receiveMailAction("x355 y327", id, 500)
        this.receiveMailAction("x355 y347", id, 500)
        this.receiveMailAction("x355 y367", id, 500)
        this.receiveMailAction("x355 y387", id, 500)
        this.receiveMailAction("x355 y407", id, 500)
        this.receiveMailAction("x355 y427", id, 500)

        this.click("x227 y457") ; click checkbox
        Sleep 250
        this.click("x283 y453") ; xoá
        Sleep 250
        this.send("{Enter}")
        Sleep 250
        this.click("x227 y457") ; click checkbox
        Sleep 250
    }


    receiveMailAction(coordinates, id, delay := 500) {
        this.click(coordinates) ; mail
        Sleep delay / 2
        this.click("x700 y398") ; Nhận
        Sleep delay / 2
    }


    updateStatus() {
        this.isActive := WinExist(this.ahkId) > 0
        if (this.isActive) {
            this.button.setFont("norm bold")
        } else {
            this.button.setFont("norm")
        }
    }


    showInformation() {
        MsgBox this.toString()
    }


    getLoginUrl(urlPattern := "https://s3-vuaphapthuat.goplay.vn/s/{0}/GameLoaders.swf?user={1}&pass={2}&version=0.9.9a33.342&isExpand=true&nothing=true") {
        result := urlPattern
        result := RegExReplace(result, "\{0\}", this.server)
        result := RegExReplace(result, "\{1\}", this.username)
        result := RegExReplace(result, "\{2\}", this.password)
        return result
    }


    toggleTitleBar() {
        WinSetStyle "^0xC00000", this.ahkId
        style := WinGetStyle(this.ahkId)
        if (style & 0xC00000) {
            WinMove , , this.originWidth * this.multiples, this.originHeight * this.multiples, this.ahkId
        } else {
            ; Remove border 2px and title height 25px
            WinMove , , (this.originWidth - 2) * this.multiples, (this.reduceHeight - 25) * this.multiples, this.ahkId
        }
    }


    toMap() {
        accountMap := Map()
        accountMap.Set("name", this.name)
        accountMap.Set("char", this.char)
        accountMap.Set("ahkId", this.ahkId)
        accountMap.Set("processId", this.processId)
        accountMap.Set("originLink", this.originLink)
        accountMap.Set("link", this.getLoginUrl())

        return accountMap       
    }
    

    toString() {
        return "name: " this.name ", char: " this.char ", isActive: " this.isActive ", ahkId: " this.ahkId
    }
}