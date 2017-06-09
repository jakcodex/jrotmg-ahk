;;;;  game hotkeys
UserHotkeys_Nexus = r
UserHotkeys_Printscreen = ^PrintScreen

;;;;  enable or disable the nexus screenshot utility
;;  accepts boolean: true, false
ScreenshotEnabled := true

;;;;  time in seconds the screenshot system should wait to save the image (minimizes nexus delay)
;;  accepts integers: 0, 1, 2, 3, 4, etc
;;  only used when ScreenshotImageMode = direct
ScreenshotSleepTimeout = 2

;;;;  time in seconds after opening chat that nexus screenshots will not be taken
;;  accepts integers: 0, 1, 2, 3, 4, etc
ScreenshotTypeTimeout = 15

;;;;  which method should the screenshot be taken with
;;  accepts string: direct, steam
ScreenshotImageMode = direct

;;;;  which key mode to trigger screenshots (single or double)
;;  accepts string: single, double
ScreenshotKeyMode = single

;;;;  enable or disable the screenshot wait timer (prevents screenshots while typing)
;;  accepts boolean: true, false
ScreenshotWaitTimer := true

;;;;  enable or disable the filter to hide gold
ScreenshotHideGoldAndFame := false

;;;;  enable or disable the filter to hide your guild
ScreenshotHideGuild := false

;;;;  enable or disable the filter to hide your stars
ScreenshotHideStars := false

;;;;  enable or disable the filter to hide your username
ScreenshotHideUsername := false

;;;;  enable or disable the filter to hide the minimap
ScreenshotHideMinimap := false

;;;;  enable or disable the filter to hide your character fame
ScreenshotHideFame := false

;;;;  enable or disable the filter to show only partial hp/mp bar
ScreenshotHidePartialHPAndMP := false

;;;;  enable or disable the filter to hide your equipment
ScreenshotHideEquipment := false

;;;;  enable or disable the filter to hide your inventory
ScreenshotHideInventory := false

;;;;  enable or disable the filter to hide the userlist
ScreenshotHideUserlist := false

;;;;  enable or disable the filter to hide chat
ScreenshotHideChat := false

;;;;  enable or disable the filter to hide majority of the screen
;;  not yet supported  ;;
;;  ScreenshotHideMajority := false

;;;;  enable or disable the filter to hide the character
ScreenshotHideCharacter := false

;;;;  manually adjust positioning if it's slightly off
;;  accepts object like: {"x": 0, "y": 0, "width": 0, "height": 0}
ScreenshotFilterAdjustments := {"x": 0, "y": 0, "width": 0, "height": 0}

;;;;  control the size of the character blackout filter
;;  accepts object like: {"windowed": {"width": 0, "height": 0}, "fullscreen": {"width": 0, "height": 0}}
ScreenshotCharacterFilterPositioning := {"windowed": {"width": 80, "height": 80}, "fullscreen": {"width": 130, "height": 130}}

;;;;  enable or disable the nexus panic button (closes the game if triggered)
;;  accepts boolean: true, false
NexusPanicEnabled := false

;;;;  number of times nexus button must be hit to trigger NexusPanic mode
;;  accepts integers: 0, 1, 2, 3, 4, etc
NexusPanicCount = 5

;;;;  number of seconds after nexus keypresses to reset counters to 0
;;  accepts integers: 0, 1, 2, 3, 4, etc
NexusKeyResetTime = 1

;;;;  name of the process responsible for rotmg
;;  Steam - Realm of the Mad God.exe
;;  Flash Projector (example) - flashplayer_22.exe
;ROTMGProcessName = Realm of the Mad God.exe
ROTMGProcessName = flashplayer_22_sa.exe

;;;;  name of the rotmg window
;;  Steam - Realm of the Mad God
;;  Flash Projector (example) - Adobe Flash Player 22
;ROTMGWindowName = Realm of the Mad God
ROTMGWindowName = Adobe Flash Player 22

;;;;  path to store program data
;;;;  defaults to "C:\Users\<YourUsername>\AppData\Roaming\jrotmg-ahk"
StoragePath = %APPDATA%\jrotmg-ahk