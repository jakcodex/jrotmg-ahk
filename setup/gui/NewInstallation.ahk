DrawNewInstallationGUI() {

    global config, ChosenHotkey_Nexus

    CreateGUI("NewInstallationGUI", "New Installation Wizard")

    GUISetFont("", "Calibri")
    GUISetFont(config["StyleH1"])
    GUIAddText("New Installation Wizard")

    GUISetFont(config["StyleH2"])
    GUIAddTabs("General|Hotkeys|Nexus Screenshots|Panic Options", "w500 h300")

    GUISetFont(config["StyleText"])

    ;;;; general config settings on tab 1
    Gui, Tab, 1

    ;;  row 1
    GUIAddText("ROTMG Process Name", "x35 y103")
    GUIAddEdit("x35 y123 w200 CFF0000 r1 vUserConfig_ROTMGProcessName")

    GUIAddText("ROTMG Window Name", "x315 y103")
    GUIAddEdit("x315 y123 w200 CFF0000 r1 vUserConfig_ROTMGWindowName")

    ;;  row 2
    GUIAddText("Storage Path", "x35 y163")
    GUIAddEdit("x35 y183 w200 CFF0000 vUserConfig_StoragePath")

    ;;;;  hotkeys on tab 2
    Gui, Tab, 2

    ;;  row 1
    GUIAddText("Nexus", "x35 y103")
    GUIAddHotkey("r", "x35 y123 w200 CFF0000 vChosenHotkey_Nexus")

    GUIAddText("Panic Button", "x315 y103")
    GUIAddHotkey("^esc", "x315 y123 w200 vChosenHotkey_PanicButton")

    ;;  row 2
    GUIAddText("Show Ignores List", "x35 y163")
    GUIAddHotkey("^!t", "x35 y183 w200 CFF0000 vChosenHotkey_ShowIgnoresList")

    GUIAddText("Ignore Most Recent PM Sender", "x315 y163")
    GUIAddHotkey("^+v", "x315 y183 w200 vChosenHotkey_IgnoreMostRecentUser")

    ;;  row 3
    GUIAddText("Unignore Most Recently Ignored User", "x35 y223")
    GUIAddHotkey("^+z", "x35 y243 w200 CFF0000 vChosenHotkey_UnignoreMostRecentUser")

    GUIAddText("Open Screenshots Folder", "x315 y223")
    GUIAddHotkey("^!s", "x315 y243 w200 CFF0000 vChosenHotkey_OpenScreenshotFolder")

    ;;  row 4
    GUIAddText("Toggle Nexus Screenshot Status", "x35 y283")
    GUIAddHotkey("^!n", "x35 y303 w200 CFF0000 vChosenHotkey_ToggleNexusScreenshots")

    GUIAddText("Display Screenshot Cooldown", "x315 y283")
    GUIAddHotkey("^!e", "x315 y303 w200 CFF0000 vChosenHotkey_ShowNexusScreenshotCooldown")

    ;;;;  nexus screenshots on tab 3
    Gui, Tab, 3

    ;;  row 1
    GUIAddText("Nexus Screenshots Enabled", "x35 y103")
    GUIAddDropdownBox("Yes|No", "x35 y123 w200 CFF0000 Choose1 vUserConfig_ScreenshotEnabled")

    GUIAddText("Screenshot Image Mode", "x315 y103")
    GUIAddDropdownBox("Direct|Steam", "x315 y123 w200 CFF0000 Choose1 vUserConfig_ScreenshotImageMode")

    ;;  row 2
    GUIAddText("Enable Screenshot Wait Timer", "x35 y163")
    GUIAddDropdownBox("Yes|No", "x35 y183 w200 CFF0000 Choose1 vUserConfig_ScreenshotWaitTimer")

    GUIAddText("Save Sleep Timeout", "x315 y163")
    GUIAddSlider("2", "x315 y183 w200 vUserConfig_ScreenshotSleepTimeout Range0-10 ToolTip TickInterval1")

    ;;  row 3
    GUIAddText("Nexus Key Mode", "x35 y223")
    GUIAddDropdownBox("Single|Doouble", "x35 y243 w200 CFF0000 Choose1 vUserConfig_ScreenshotKeyMode")

    GUIAddText("Typing Cooldown", "x315 y223")
    GUIAddSlider("15", "x315 y243 w200 vUserConfig_ScreenshotTypeTimeout Range0-60 ToolTip TickInterval5")

    ;;  row 4
    GUIAddText("Hide Gold", "x35 y283")
    GUIAddDropdownBox("Yes|No", "x35 y303 w200 CFF0000 Choose2 vUserConfig_ScreenshotHideGold")

    ;;;;  panic options on tab 4
    Gui, Tab, 4

    ;;  row 1
    GUIAddText("Nexus Panic Enabled", "x35 y103")
    GUIAddDropdownBox("Yes|No", "x35 y123 w200 CFF0000 Choose2 vUserConfig_NexusPanicEnabled")

    GUIAddText("Nexus Panic Key Press Limit", "x315 y103")
    GUIAddSlider("4", "x315 y123 w200 vUserConfig_NexusPanicCount Range0-10 ToolTip TickInterval")

    ;;  row 2
    GUIAddText("Nexus Panic Reset Time", "x315 y163")
    GUIAddSlider("1", "x315 y183 w200 vUserConfig_NexusKeyResetTime Range0-5 ToolTip TickInterval1")

    ShowGUI("NewInstallationGUI", 555, 400)

}