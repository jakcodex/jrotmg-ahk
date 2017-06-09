;;;;  default variables
GUILoaded := false

;;;;  draw the default gui
DrawDefaultGUI() {

    global config

    CreateGUI("DefaultGUI")

    GUISetFont("", "Calibri")
    GUISetFont(config["StyleH1"])
    GUIAddText("Welcome to the Realm Mini AHK setup script")

    GUISetFont(config["StyleText"])
    GUIAddLink("", "You can find online documentation and other help on <a href=""https://github.com/jakcodex/rotmg-mini-ahk/blob/master/README.md"">Github</a>")

    if ( !FileExist(config["DefaultUserConfiguration"]) ) {

        GUISetFont(config["StyleH2"])
        GUIAddLink("gNewInstallation", "<a id=""NewInstallation"">Setup New Installation</a>")

        GUISetFont(config["StyleText"])
        GUIAddText("New Installation will take you through setup and create a new configuration.")

        GUISetFont(config["StyleH2"])
        GUIAddLink("cRed gUserProvidesConfigPath", "<a id=""UserProvidesConfigPath"">Locate Existing Installation</a>")

        GUISetFont(config["StyleText"])
        GUIAddText("Setup could not locate an existing installation. Use this to find it.")

    } else {

        GUISetFont(config["StyleH2"])
        GUIAddLink("gNewInstallation", "<a id=""NewInstallation"">Reinstall Fresh Configuration</a>")

        GUISetFont(config["StyleText"])
        GUIAddText("New Installation will take you through setup and create a new configuration.")

        GUISetFont(config["StyleH2"])
        GUIAddLink("gUpgradeConfiguration", "<a id=""UpgradeConfiguration"">Upgrade Configuration</a>")

        GUISetFont(config["StyleText"])
        GUIAddText("Upgrade your current configuration and run through setup for any new configuration keys.")

        GUISetFont(config["StyleH2"])
        GUIAddLink("gUpgradeInstallation", "<a id=""UpgradeInstallation"">Upgrade Installation</a>")

        GUISetFont(config["StyleText"])
        GUIAddText("Upgrades your installation to the latest version and then runs configuration upgrade")
        GUIAddText("Requires Git installation on your local computer")

        GUISetFont(config["StyleH2"])
        GUIAddLink("gCreateBackup", "<a id=""UpgradeInstallation"">Create Backup</a>")

        GUISetFont(config["StyleText"])
        GUIAddText("Create a backup of configuration and direct screenshots.")

    }

    ShowGUI("DefaultGUI")

}

CreateGUI(GUIName, title=false) {

    global GUILoaded
    if ( GUILoaded != false ) {
        Gui, % GUILoaded . ": Destroy"
    }

    GUILoaded := GUIName
    title := ( title != false ) ? " - " . title : ""

    Gui, % GUIName . ": New", , % config["ProgramName"] . title

    Gui, % GUIName . ": " . config["WindowSize"]
    Gui, % GUIName . ": Color", 87b5ff

}

ShowGUI(GUIName, w=false, h=false) {

    global GUILoaded, config
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