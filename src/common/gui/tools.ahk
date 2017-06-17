CreateGUI(GUIName, title=false, options=false) {

    global GUILoaded, GUIConfig
    if ( GUILoaded != false ) {
        Gui, % GUILoaded . ": Destroy"
    }

    GUILoaded := GUIName

    Gui, % GUIName . ": New", , % title
    ;Gui, % GUIName . ": +AlwaysOnTop"
    Gui, % GUIName . ": " . GUIConfig["WindowSize"]
    Gui, % GUIName . ": Color", % GUIConfig["BackgroundColor"]

    if ( options != false ) {
        Gui, % GuiName . ": " . options
    }

}

ShowGUI(GUIName, w=false, h=false) {

    global GUILoaded, GUIConfig
    if ( h != false && w != false ) {
        AddOnOptions := "W" . w . " H" . h
    } else if ( h != false ) {
        if ( w == "auto" ) {
            AddOnOptions := "AutoSize"
        } else {
            AddOnOptions := "W" . w
        }
    } else if ( w != false ) {
        AddOnOptions := "H" . h
    } else {
        AddOnOptions =
    }

    if ( GUILoaded ) {
        Gui, % GUILoaded . ": Cancel"
    }

    if ( GUIName ) {

        Gui, % GUIName . ": Show", % "Center " . AddOnOptions

    } else {

        Gui, Show, Center

    }

}

GUISetFont(style, font="", GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": Font", % style, % font
    Return

}

GUIAddLink(gsubs, string, GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": Add", Link, % gsubs, % string
    Return

}

GUIAddText(string, options="", GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": Add", Text, % options, % string
    Return

}

GUISetOptions(options, GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": " . options
    Return

}

GUIAddHotkey(hotkey, options, GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": Add", Hotkey, % options, % hotkey
    Return

}

GUIAddTabs(tabs, options="", GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": Add", Tab, % options, % tabs
    Return

}

GUIAddDropdownBox(list, options, GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": Add", DropDownList, % options, % list
    Return

}

GUIAddSlider(default, options="", GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": Add", Slider, % options, % default
    Return

}

GUIAddEdit(options, default="", GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": Add", Edit, % options, % default
    Return

}

GUIAddSubmit(GUIName=false, NoHide=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    NoHide := ( NoHide == false ) ? "" : "NoHide"
    Gui, % GUIName . ": Submit", % NoHide

}

GUIAddButton(text, options="", GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, % GUIName . ": Add", Button, % options, % text

}

GUISubmit(a=false, b=false) {

    global GUICallback
    Gui, Submit
    if ( GUICallback != false ) {
        DllCall(GUICallback)
    }
    Return

}