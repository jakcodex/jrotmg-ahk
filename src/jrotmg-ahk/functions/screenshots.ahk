;;  trigger a screenshot
TakeScreenshot(mode=false) {

    global ScreenshotImageMode
    if ( ScreenshotImageMode == "direct" ) {

        Send, ^!{PrintScreen}

    } else if ( ScreenshotImageMode == "steam" ) {

        Send, {F12}

    }

    Return

}

;;  calculation the actual positions based on input
ScreenShotGeneratePositions(Width, Height, Dimensions, Adjustments) {

    result := {}
    result["x"] := Round((Width*Dimensions["x"])+Adjustments["x"], 0)
    result["y"] := Round((Height*Dimensions["y"])+Adjustments["y"], 0)
    result["w"] := Round((Width*Dimensions["width"])+Adjustments["width"], 0)
    result["h"] := Round((Height*Dimensions["height"])+Adjustments["height"], 0)
    Return result

}