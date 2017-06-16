GuiClose(GuiHwnd) {  ; Declaring this parameter is optional.
    MsgBox 4,, Are you sure you want to close the wizard?
    ifMsgBox No
        return true  ; true = 1
}