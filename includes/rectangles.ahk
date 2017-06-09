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

if ( ScreenshotHideGoldAndFame == true ) {

    ;;  hint: if you want to change the color away from black, do this instead:
    ;;  ScreenshotRectangles["goldandfame"] := {"color": "ff0000"}

    ScreenshotRectangles["goldandfame"] := {"steam": {}, "flash": {}}

    ;;  steam rectangles
    ScreenshotRectangles["goldandfame"]["steam"]["windowed"] := {"x": 0.525, "y": 0.063, "width": 0.200, "height": 0.030}
    ScreenshotRectangles["goldandfame"]["steam"]["fullscreen"] := {"x": 0.525, "y": 0.018, "width": 0.205, "height": 0.030}

    ;;  flash rectangles
    ScreenshotRectangles["goldandfame"]["flash"]["windowed"] := {"x": 0.525, "y": 0.089, "width": 0.200, "height": 0.030}
    ScreenshotRectangles["goldandfame"]["flash"]["fullscreen"] := {"x": 0.525, "y": 0.018, "width": 0.205, "height": 0.030}

}

if ( ScreenshotHideGuild == true ) {

    ScreenshotRectangles["guild"] := {"steam": {}, "flash": {}}

    ;;  steam rectangles
    ScreenshotRectangles["guild"]["steam"]["windowed"] := {"x": 0.079, "y": 0.059, "width": 0.295, "height": 0.030}
    ScreenshotRectangles["guild"]["steam"]["fullscreen"] := {"x": 0.070, "y": 0.014, "width": 0.300, "height": 0.030}

    ;;  flash rectangles
    ScreenshotRectangles["guild"]["flash"]["windowed"] := {"x": 0.079, "y": 0.087, "width": 0.295, "height": 0.030}
    ScreenshotRectangles["guild"]["flash"]["fullscreen"] := {"x": 0.070, "y": 0.014, "width": 0.300, "height": 0.030}

}

if ( ScreenshotHideStars == true ) {

    ScreenshotRectangles["stars"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["stars"]["steam"]["windowed"] := {"x": 0.015, "y": 0.055, "width": 0.062, "height": 0.042}
    ScreenshotRectangles["stars"]["steam"]["fullscreen"] := {"x": 0.006, "y": 0.010, "width": 0.063, "height": 0.042}

    ;;  flash
    ScreenshotRectangles["stars"]["flash"]["windowed"] := {"x": 0.015, "y": 0.082, "width": 0.062, "height": 0.042}
    ScreenshotRectangles["stars"]["flash"]["fullscreen"] := {"x": 0.006, "y": 0.010, "width": 0.063, "height": 0.042}

}

if ( ScreenshotHideUsername == true ) {

    ScreenshotRectangles["username"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["username"]["steam"]["windowed"] := {"x": 0.753, "y": 0.357, "width": 0.200, "height": 0.039}
    ScreenshotRectangles["username"]["steam"]["fullscreen"] := {"x": 0.755, "y": 0.335, "width": 0.208, "height": 0.036}

    ;;  flash
    ScreenshotRectangles["username"]["flash"]["windowed"] := {"x": 0.753, "y": 0.381, "width": 0.200, "height": 0.035}
    ScreenshotRectangles["username"]["flash"]["fullscreen"] := {"x": 0.755, "y": 0.335, "width": 0.208, "height": 0.036}

}

if ( ScreenshotHideMinimap == true ) {

    ScreenshotRectangles["minimap"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["minimap"]["steam"]["windowed"] := {"x": 0.750, "y": 0.050, "width": 0.236, "height": 0.306}
    ScreenshotRectangles["minimap"]["steam"]["fullscreen"] := {"x": 0.752, "y": 0.004, "width": 0.242, "height": 0.325}

    ;;  flash
    ScreenshotRectangles["minimap"]["flash"]["windowed"] := {"x": 0.748, "y": 0.076, "width": 0.240, "height": 0.300}
    ScreenshotRectangles["minimap"]["flash"]["fullscreen"] := {"x": 0.752, "y": 0.004, "width": 0.242, "height": 0.325}

}

if ( ScreenshotHideFame == true ) {

    ScreenshotRectangles["fame"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["fame"]["steam"]["windowed"] := {"x": 0.753, "y": 0.400, "width": 0.226, "height": 0.035}
    ScreenshotRectangles["fame"]["steam"]["fullscreen"] := {"x": 0.755, "y": 0.377, "width": 0.231, "height": 0.037}

    ;;  flash
    ScreenshotRectangles["fame"]["flash"]["windowed"] := {"x": 0.753, "y": 0.423, "width": 0.226, "height": 0.029}
    ScreenshotRectangles["fame"]["flash"]["fullscreen"] := {"x": 0.755, "y": 0.377, "width": 0.231, "height": 0.037}

}

if ( ScreenshotHidePartialHPAndMP == true ) {

    ScreenshotRectangles["hpandmp"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["hpandmp"]["steam"]["windowed"] := {"x": 0.795, "y": 0.437, "width": 0.184, "height": 0.077}
    ScreenshotRectangles["hpandmp"]["steam"]["fullscreen"] := {"x": 0.795, "y": 0.416, "width": 0.191, "height": 0.082}

    ;;  flash
    ScreenshotRectangles["hpandmp"]["flash"]["windowed"] := {"x": 0.795, "y": 0.459, "width": 0.183, "height": 0.065}
    ScreenshotRectangles["hpandmp"]["flash"]["fullscreen"] := {"x": 0.795, "y": 0.416, "width": 0.191, "height": 0.082}

}

if ( ScreenshotHideEquipment == true ) {

    ScreenshotRectangles["equipment"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["equipment"]["steam"]["windowed"] := {"x": 0.753, "y": 0.517, "width": 0.226, "height": 0.080}
    ScreenshotRectangles["equipment"]["steam"]["fullscreen"] := {"x": 0.755, "y": 0.500, "width": 0.231, "height": 0.080}

    ;;  flash
    ScreenshotRectangles["equipment"]["flash"]["windowed"] := {"x": 0.753, "y": 0.532, "width": 0.226, "height": 0.073}
    ScreenshotRectangles["equipment"]["flash"]["fullscreen"] := {"x": 0.755, "y": 0.500, "width": 0.231, "height": 0.080}

}

if ( ScreenshotHideInventory == true ) {

    ScreenshotRectangles["inventory"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["inventory"]["steam"]["windowed"] := {"x": 0.753, "y": 0.599, "width": 0.226, "height": 0.224}
    ScreenshotRectangles["inventory"]["steam"]["fullscreen"] := {"x": 0.755, "y": 0.582, "width": 0.231, "height": 0.240}

    ;;  flash
    ScreenshotRectangles["inventory"]["flash"]["windowed"] := {"x": 0.753, "y": 0.613, "width": 0.226, "height": 0.216}
    ScreenshotRectangles["inventory"]["flash"]["fullscreen"] := {"x": 0.755, "y": 0.582, "width": 0.231, "height": 0.240}

}

if ( ScreenshotHideUserlist == true ) {

    ScreenshotRectangles["userlist"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["userlist"]["steam"]["windowed"] := {"x": 0.753, "y": 0.832, "width": 0.238, "height": 0.144}
    ScreenshotRectangles["userlist"]["steam"]["fullscreen"] := {"x": 0.755, "y": 0.828, "width": 0.248, "height": 0.160}

    ;;  flash
    ScreenshotRectangles["userlist"]["flash"]["windowed"] := {"x": 0.753, "y": 0.840, "width": 0.238, "height": 0.144}
    ScreenshotRectangles["userlist"]["flash"]["fullscreen"] := {"x": 0.755, "y": 0.828, "width": 0.248, "height": 0.160}

}

if ( ScreenshotHideChat == true ) {

    ScreenshotRectangles["chat"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["chat"]["steam"]["windowed"] := {"x": 0.010, "y": 0.770, "width": 0.735, "height": 0.218}
    ScreenshotRectangles["chat"]["steam"]["fullscreen"] := {"x": 0.000, "y": 0.770, "width": 0.750, "height": 0.250}

    ;;  flash
    ScreenshotRectangles["chat"]["flash"]["windowed"] := {"x": 0.010, "y": 0.778, "width": 0.735, "height": 0.208}
    ScreenshotRectangles["chat"]["flash"]["fullscreen"] := {"x": 0.000, "y": 0.770, "width": 0.750, "height": 0.250}

}

if ( ScreenshotHideCharacter == true ) {

    ;;  by default this filter draws a 0x0 tile
    ;;  each usage scenario must be configured thru the hotkey ctrl+alt+c individually

    ScreenshotRectangles["character"] := {"steam": {}, "flash": {}}

    ;;  steam
    ScreenshotRectangles["character"]["steam"]["windowed"] := {"x": 0, "y": 0, "width": 0, "height": 0}
    ScreenshotRectangles["character"]["steam"]["fullscreen"] := {"x": 0, "y": 0, "width": 0, "height": 0}

    ;;  flash
    ScreenshotRectangles["character"]["flash"]["windowed"] := {"x": 0, "y": 0, "width": 0, "height": 0}
    ScreenshotRectangles["character"]["flash"]["fullscreen"] := {"x": 0, "y": 0, "width": 0, "height": 0}

}

if ( ThisFeatureIs == "NotSupportedYet" && ScreenshotHideMajority == true ) {

    ScreenshotRectangles["majority"] := {"steam": {}, "flash": {}}
    ScreenshotRectangles["majority"]["steam"]["windowed"] := {"x": 0.640, "y": 0.063, "width": 0.060, "height": 0.030}
    ScreenshotRectangles["majority"]["steam"]["fullscreen"] := {"x": 0.130, "y": 0.130, "width": 0.600, "height": 0.600}

}