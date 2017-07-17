;;;;  game hotkeys
UserHotkeys_Nexus = r
UserHotkeys_Printscreen = ^PrintScreen

;;;;  enable or disable the nexus screenshot utility
;;  accepts boolean: true, false
ScreenshotEnabled := true

;;;;  time in seconds the screenshot system should wait to save the image (minimizes nexus delay)
;;  accepts integers: 0, 1, 2, 3, 4, etc
;;  only used when ScreenshotImageMode = direct
ScreenshotSleepTimeout = 1

;;;;  time in seconds after opening chat that nexus screenshots will not be taken
;;  accepts integers: 0, 1, 2, 3, 4, etc
ScreenshotTypeTimeout = 5

;;;;  which method should the screenshot be taken with
;;  accepts string: direct, steam
ScreenshotImageMode = direct

;;;;  quality of the screenshot image
;;  accepts integers: 0 - 100
ScreenshotImageQuality = 100

;;;;  which key mode to trigger screenshots (single or double)
;;  accepts string: single, double
ScreenshotKeyMode = single

;;;;  enable or disable the screenshot wait timer (prevents screenshots while typing)
;;  accepts boolean: true, false
ScreenshotWaitTimer := true

;;;;  enable or disable checking for chatbox pixels to prevent typing screenshots
;;  accepts boolean: true, false
ScreenshotWaitPixelCheck := true

;;;;  how many seconds after a chatbox opens for it to invalidate screenshots
;;  accepts integers: 0-10
ScreenshotChatboxGrace = 2

;;;;  which locations disable the automatic nexus hotkey screenshot
;;  accepts an array: ["Value1", "Value2", ...]
ScreenshotNexusDisallowedLocations := ["InMain", "InChar", "InNexus", "InVault", "Unknown"]

;;;;  enable or disable the filter to hide gold
ScreenshotHideGoldAndFame := true

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

;;;;  enable or disable the filter to display your custom blackout filter
ScreenshotHideCustom := false

;;;;  manually adjust positioning if it's slightly off
;;  accepts object like: {"x": 0, "y": 0, "width": 0, "height": 0}
ScreenshotFilterAdjustments := {"x": 0, "y": 0, "width": 0, "height": 0}

;;;;  control the size of the character blackout filter
;;  accepts object like: {"windowed": {"width": 0, "height": 0}, "fullscreen": {"width": 0, "height": 0}}
ScreenshotCharacterFilterPositioning := {"windowed": {"width": 80, "height": 80}, "fullscreen": {"width": 130, "height": 130}}

;;;;  control the opacity and color of the watermark
;;  accepts a string with the following format: XXYYYYYY
;;  XX is the opacity (00 is 0%; FF is 100%)
;;  YYYYYY is the hexidecimal color code you desire
;;  to disable the watermark, set opacity to 00
WatermarkTextColor = BBFFFFFF

;;;;  control whether or not timelapse uses the shared bitmap
;;  accepts boolean: true, false
TimelapseSharedBitmap := true

;;;;  set which locations timelapse photos won't occur
;;  accepts an array: ["Value1", "Value2", ...] (default is to set it equal to the ScreenshotNexusDisallowedLocations key)
TimelapseDisallowedLocations := ScreenshotNexusDisallowedLocations

;;;;  how frequently to run PixelState background jobs
;;  accepts integers: 0-100 (0 disables)
PixelStateTasksFrequency = 1

;;;;  how many shared bitmaps to keep in memory
;;  accepts integers: 1-100 (default is 5)
PixelStateSharedBitmapKeep = 5

;;;;  enable or disable the nexus panic button (closes the game if triggered)
;;  accepts boolean: true, false
NexusPanicEnabled := false

;;;;  number of times nexus button must be hit to trigger NexusPanic mode
;;  accepts integers: 0, 1, 2, 3, 4, etc
NexusPanicCount = 5

;;;;  number of seconds after nexus keypresses to reset counters to 0
;;  accepts integers: 0, 1, 2, 3, 4, etc
NexusKeyResetTime = 1

;;;;  path to store program data
;;;;  defaults to "C:\Users\<YourUsername>\AppData\Roaming\jrotmg-ahk"
StoragePath = %APPDATA%\jrotmg-ahk

;;;;  debugging mode enabled or not
Debug := true

;;;;  play low hp beep at this hp value (out of 100)
;;  accepts integers, 0-100 (0 disables)
LowHPBeep := 45

;;;;  file to play when low hp is detected
;;  accepts strings like /src/jrotmg-ahk/media/somebeep.wav or C:\Users\Me\My Music\Somebeep.wav
LowHPBeepAudio = src/jrotmg-ahk/media/Zelda1_LowHealth.wav