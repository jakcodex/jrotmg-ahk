# ROTMG Mini AHK Script

## Usage

Required AutoHotKey from https://autohotkey.com/download/

##### Manual Mode (default)
Extract files to a folder and edit config.ahk if any changes are necessary then run jrotmg-quickstart.ahk.

##### Managed Mode
Extract files to a folder and run setup.ahk. Installation wizard will help you configure, upgrade, and backup your app.

## Features
1. Ignores Database for quickly ignoring spammers and later review
2. Panic button to force close the game in the event of lag, clicking outside the game, etc
3. Nexus Screenshotting
4. Nexus panic button

## Hotkeys

##### Ctrl+Shift+V
     Ignores last user to PM you and adds them to the ignores database

##### Ctrl+Shift+Z
     Unignores most recent entry in the ignores database

##### Ctrl+Escape
     Force closes the game process on your computer. This is the proverbial "Oh shit" button.

     In the event you lose control of the game window, lag, anything that prevents you from nexusing hit this button.

##### Ctrl+Alt+T
     Lists the names contained in the ignores database

##### Ctrl+Alt+S
     Opens the current screenshot folder for all nexusing screenshots

##### Ctrl+Alt+E
     Shows how long until next nexus screenshot is available

##### Ctrl+Alt+N
     Toggle Nexus Screenshot utility on/off

##### Ctrl+Alt+C
     Enable character screenshot filter mode (see below)
     
##### Shift+Alt+C
     Enable custom region screenshot filter mode (see below)

## Nexus Screenshotting
At its very basic and default configuration, when you hit the Nexus hotkey a screenshot will be taken at the same time.

It supports taking a printscreen of your game window or using Steam's F12 screenshot hotkey. Be aware that using Steam's
screenshot system causes a brief delay when nexusing.

The system attempts to not take screenshots while you are typing by detecting when you open the chat box. The wait timer
will prevent screenshots for a set period of time after the chat box opens up.

An alternative option is to switch to double mode. This mode requires that the Nexus key be double tapped to take a
screenshot.

##### Suspicious Cropping Mode
Filters are supported which blackout certain areas of screenshots. The following filters are supported:
1. Account Fame and Gold
2. Guild
3. Stars
4. Minimap
5. Username
6. Fame
7. Partial HP/MP (exposes leftmost side of bars)
8. Equipment
9. Inventory
10. User list
11. Chat
12. Character
13. Custom

The provided filters are configured using approximations of where the blackout tiles need to be positioned. If they do
not line up for you, then you can adjust the positions by editing the includes/rectangles.ahk file. Minor adjustments 
are possible thru the configuration key ScreenshotFilterAdjustments. Good luck if you attempt this. 

The character filter requires that you run hotkey Ctrl+Alt+C and click on your character. This needs to be repeated if
you switch between fullscreen and windowed mode, or between Steam and Flash Projector, or if you change between player
centered and off-center.

The custom filter requires that you run hotkey Shift+Alt+C and select the upper left and lower right boundaries of your
custom filter region. Same configuration rules apply as the character filter.

## Configuration
All settings, timeouts, and values are configurable from the config.ahk file. Example default configuration:

```autohotkey
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
```