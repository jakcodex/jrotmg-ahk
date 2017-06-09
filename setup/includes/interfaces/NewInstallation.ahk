#Include setup/gui/NewInstallation.ahk

;;;; interface variables
ChosenHotkey_Nexus =
ChosenHotkey_PanicButton =
ChosenHotkey_ShowIgnoresList =
ChosenHotkey_IgnoreMostRecentUser =
ChosenHotkey_UnignoreMostRecentUser =
ChosenHotkey_OpenScreenshotFolder =
ChosenHotkey_ToggleNexusScreenshots =
ChosenHotkey_ShowNexusScreenshotCooldown =

UserConfig_ScreenshotEnabled =
UserConfig_ScreenshotSleepTimeout =
UserConfig_ScreenshotTypeTimeout =
UserConfig_ScreenshotImageMode =
UserConfig_ScreenshotKeyMode =
UserConfig_ScreenshotWaitTimer =
UserConfig_ScreenshotHideGold =
UserConfig_NexusPanicEnabled =
UserConfig_NexusPanicCount =
UserConfig_NexusKeyResetTime =
UserConfig_ROTMGProcessName =
UserConfig_ROTMGWindowName =
UserConfig_StoragePath =

;;;; run interface
NewInstallation(CtrlHwnd, GuiEvent, LinkIndex, HrefOrID) {
    DrawNewInstallationGUI()
}