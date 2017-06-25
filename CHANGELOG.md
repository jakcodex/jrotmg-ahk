## 0.0.16-alpha
+ Added configuration key "WatermarkTextColor" which controls the color of the watermark text
+ Screenshots now have a watermark placed in the upper right corner of the minimap

## 0.0.15
+ Added screenshot filter 'custom' which allows the user to hide an additional region of their choice
+ Added configuration key 'ScreenshotHideCustom' which controls if your custom region is hidden in screenshots
+ Added configuration key 'ScreenshotImageQuality' which controls the image quality of screenshots
+ Hotkey 'Shift+Alt+C': Select custom region for ScreenshotHideCustom configuration
+ Hotkey 'Ctrl+LShift+S': Toggle Screenshot Timelapse mode
+ Renamed Hotkey 'Ctrl+Shift+I' to 'Ctrl+RShift+I' for displaying Ignores List
+ Converted config pieces to contain metadata in addition to the variable data
+ Config pieces will enable/disable themselves automatically based on the runtime config
+ README.txt placed into config pieces folder to warn user against direct changes
+ New Feature: Screenshot Timelapse Mode - automatically record progress thru pictures easily
+ Nexus and Manual screenshots will be stored with timelapse photos when feature is enabled
+ Suspended Hotkey 'Ctrl+LShift+S' and 'Ctrl+Alt+E' due to triggering at random causing spooky situations
+ Added a mouse button panic script generator for the ultimate panic mode protection
+ Screenshots are now beautiful and run a bit faster with maximum quality set as default

## 0.0.14
+ Added configuration key 'ScreenshotEnabled' which enables or disables the nexus screenshots
+ Added configuration key 'ScreenshotHideGoldAndFame' which controls if the gold and fame are hidden in screenshots
+ Added configuration key 'ScreenshotHideGuild' which controls if guild is hidden in screenshots
+ Added configuration key 'ScreenshotHideStars' which controls if stars are hidden in screenshots
+ Added configuration key 'ScreenshotHideUsername' which controls if username is hidden in screenshots
+ Added configuration key 'ScreenshotHideMinimap' which controls if minimap is hidden in screenshots
+ Added configuration key 'ScreenshotHideFame' which controls if character fame is hidden in screenshots
+ Added configuration key 'ScreenshotHidePartialHPAndMP' which controls if HP/MP is partially hidden in screenshots
+ Added configuration key 'ScreenshotHideEquipment' which controls if equipment is hidden in screenshots
+ Added configuration key 'ScreenshotHideInventory' which controls if inventory is hidden in screenshots
+ Added configuration key 'ScreenshotHideUserlist' which controls if userlist is hidden in screenshots
+ Added configuration key 'ScreenshotHideChat' which controls if chat is hidden in screenshots
+ Added configuration key 'ScreenshotHideCharacter' which controls if your character is hidden in screenshots
+ Added configuration key 'ScreenshotSleepTimeout' which controls how long to wait before writing screenshots to disk
+ Added configuration key 'ROTMGWindowName' which should be set to the name of the window for your game
+ Hotkey 'Ctrl+Alt+N': Toggle Nexus Screenshot utility
+ Hotkey 'Ctrl+Alt+C': Select character position for ScreenshotHideCharacter configuration
+ Devkey 'Ctrl+Alt+F': Reports if game is in windows or full screen mode
+ Added static var 'ScreenshotRectangles' which defines the rectangle positions for various screenshot filters
+ Added screenshot filters which blackout portions of the screenshot to hide any pieces of image data
+ Blackout filters can be set to colors other than black on a per-filter basis
+ Recognizes Flash Projector and Steam windows and adjusts positioning for screenshot filters automatically
+ Character filter position set by user but data not stored permanently yet (must do it every script reload)
+ Added library 'json.ahk' for serializing variables
+ Added saving/loading config pieces using JSON (IgnoresDB and ScreenshotRectangles[character] moved over)
+ Began work on the setup.ahk script to manage installations of this software (preview only)

## 0.0.13
+ Hotkey '/': Resets screenshot wait timer
+ Nexus hotkey now sends the custom hotkey rather than 'r' all the time

## 0.0.12
* Hotkey "Ctrl+Alt+E" now reports time until a screenshot may be taken
+ Discovered the joys of $ which works better than Suspend
+ Caps lock now considered for a-z keys
+ Game hotkeys now customizable
+ Added Hotkey 'Ctrl+Printscreen': Saves a screenshot using configured method (direct, steam)
+ Added configuration key 'UserHotkeys_Nexus' which is a string defining the hotkey your Nexus is bound to
+ Added configuration key 'UserHotkeys_Printscreen' which is the hotkey you wish to bind saving screenshots to
+ A bit of code cleanup

## 0.0.11
* Replaced configuration key 'SteamMode' with 'ScreenshotImageMode'
* Added configuration key 'ScreenshotWaitTimer' which controls how often screenshots can be taken
* Added configuration key 'NexusPanicEnabled' which controls if the panic button is enabled on Nexus key
* Added configuration key 'NexusPanicCount' which is an integer specifying the keypresses required to trigger panic
* Added configuration key 'NexusKeyResetTime' which resets Nexus keypress counts after set time
* Hotkey 'r' now supports all new configuration keys
* Proper file structure adopted

## 0.0.10
* Hotkey 'g': Resets screenshot wait timer
* Hotkey 'Tab': Resets screenshot wait timer
* Hotkey 'NumpadEnter': Resets screenshot wait timer
* Moved 'rma-config.ahk' to 'includes/config.ahk'
* Moved 'gdi.ahk' to 'includes/gdi.ahk'
* Screenshots now save to folders prefixed with YYYY/MM/

## 0.0.9
* Ctrl+R will not take a screenshot

## 0.0.8
* Code cleaned up with comments added
