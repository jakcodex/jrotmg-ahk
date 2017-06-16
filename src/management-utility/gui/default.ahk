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