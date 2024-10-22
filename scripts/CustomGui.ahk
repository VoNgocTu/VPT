#Requires AutoHotkey v2.0

class CustomGui {
    cGui := Gui()
    debugControl := 0
    numberC1Btn := 0
    numberC2Btn := 0
    numberC3Btn := 0
    
    __New() {
        this.cGui.OnEvent("Close", (*) => ExitApp())
        this.cGui.SetFont("s11 norm")
    }

    Add(controlType, options, text?) {
        return this.cGui.Add(controlType, options, text?)
    }

    AddDebug(options := "x10 w150 h200 ReadOnly") {
        this.debugControl := this.cGui.Add("Edit", options)
        return this.debugControl
    }

    Show(coordinate?) {
        this.cGui.Show(coordinate?)
    }

    Submit() {
        this.cGui.Submit()
    }

    getAhkId() {
        return this.cGui.Hwnd
    }

    newC1Button(name, callback?) {
        btn := this.cGui.Add("Button", "x10 y" (10 + 35 * this.numberC1Btn++) " w150 h30", name)
        btn.OnEvent("Click", callback?)
        return btn
    }

    newC2Button(name, callback) {
        btn := this.cGui.Add("Button", "x160 y" (10 + 35 * this.numberC2Btn++) " w150 h30", name)
        btn.OnEvent("Click", callback)
        return btn
    }

    newC3Button(name, callback) {
        btn := this.cGui.Add("Button", "x310 y" (10 + 35 * this.numberC3Btn++) " w150 h30", name)
        btn.OnEvent("Click", callback)
        return btn
    }
}