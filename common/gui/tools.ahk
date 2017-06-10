;;;;  default variables
GUILoaded := false

CreateGUI(GUIName, title=false) {

    global GUILoaded, GUIConfig
    if ( GUILoaded != false ) {
        Gui, % GUILoaded . ": Destroy"
    }

    GUILoaded := GUIName
    title := ( title != false ) ? " - " . title : ""

    Gui, % GUIName . ": New", , % GUIConfig["ProgramName"] . title

    Gui, % GUIName . ": " . GUIConfig["WindowSize"]
    Gui, % GUIName . ": Color", 87b5ff

}

ShowGUI(GUIName, w=false, h=false) {

    global GUILoaded, GUIConfig
    if ( h != false && w != false ) {
        AddOnOptions := "W" . w . " H" . h
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
    Gui, Add, DropDownList, % options, % list
    Return

}

GUIAddSlider(default, options="", GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, Add, Slider, % options, % default
    Return

}

GUIAddEdit(options, default="", GUIName=false) {

    global GUILoaded
    if ( GUIName == false ) GUIName := GUILoaded
    Gui, Add, Edit, % options, % default
    Return

}