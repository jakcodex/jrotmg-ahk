;;;;
;;;;Nexus Screenshot Blackout Rectangle Positioning
;;  In order to blackout certain parts of the screenshot we need to position rectangles over the desired locations on
;;  the screenshot. The positions vary between windows and fullscreen mode. Furthermore, manually resizing the window
;;  will misplace rectangle positions as well.
;;
;;  This file outlines default rectangle positions for each filter for windows and fullscreen modes.
;;
;;  Positions are described using their distance from x0,y0 (upper left corner of the screen) in percentages.
;;;;

ScreenshotRectangles := {}

;;  hint: if you want to change the color away from black, do this instead:
;;  ScreenshotRectangles["goldandfame"] := {"color": "ff0000", ...}

if ( ScreenshotHideGoldAndFame == true )
    ScreenshotRectangles["goldandfame"] := {"x": 0.525, "y": 0.018, "width": 0.205, "height": 0.030}

if ( ScreenshotHideGuild == true )
    ScreenshotRectangles["guild"] := {"x": 0.070, "y": 0.014, "width": 0.300, "height": 0.030}

if ( ScreenshotHideStars == true )
    ScreenshotRectangles["stars"] := {"x": 0.006, "y": 0.010, "width": 0.063, "height": 0.042}

if ( ScreenshotHideUsername == true )
    ScreenshotRectangles["username"] := {"x": 0.755, "y": 0.335, "width": 0.208, "height": 0.036}

if ( ScreenshotHideMinimap == true )
    ScreenshotRectangles["minimap"] := {"x": 0.752, "y": 0.004, "width": 0.242, "height": 0.325}

if ( ScreenshotHideFame == true )
    ScreenshotRectangles["fame"] := {"x": 0.755, "y": 0.377, "width": 0.231, "height": 0.037}

if ( ScreenshotHidePartialHPAndMP == true )
    ScreenshotRectangles["hpandmp"] := {"x": 0.795, "y": 0.416, "width": 0.191, "height": 0.082}

if ( ScreenshotHideEquipment == true )
    ScreenshotRectangles["equipment"] := {"x": 0.755, "y": 0.500, "width": 0.231, "height": 0.080}

if ( ScreenshotHideInventory == true )
    ScreenshotRectangles["inventory"] := {"x": 0.755, "y": 0.582, "width": 0.231, "height": 0.240}

if ( ScreenshotHideUserlist == true )
    ScreenshotRectangles["userlist"] := {"x": 0.755, "y": 0.828, "width": 0.248, "height": 0.160}

if ( ScreenshotHideChat == true )
    ScreenshotRectangles["chat"] := {"x": 0.000, "y": 0.770, "width": 0.750, "height": 0.250}

;;  by default this filter draws a 0x0 tile
;;  each usage scenario must be configured thru the hotkey ctrl+alt+c individually
if ( ScreenshotHideCharacter == true )
    ScreenshotRectangles["character"] := {"x": 0, "y": 0, "width": 0, "height": 0}

;;  by default this filter draws a 0x0 tile
;;  each usage scenario must be configured thru the hotkey shift+alt+c individually
if ( ScreenshotHideCustom == true )
    ScreenshotRectangles["custom"] := {"x": 0, "y": 0, "width": 0, "height": 0}

;;  see this below? That's how it used to be. 4 different objects. I've ascended.
if ( ThisFeatureIs == "NotSupportedYet" && ScreenshotHideMajority == true ) {

    ScreenshotRectangles["majority"] := {"steam": {}, "flash": {}}
    ScreenshotRectangles["majority"]["steam"]["windowed"] := {"x": 0.640, "y": 0.063, "width": 0.060, "height": 0.030}
    ScreenshotRectangles["majority"]["steam"]["fullscreen"] := {"x": 0.130, "y": 0.130, "width": 0.600, "height": 0.600}

}