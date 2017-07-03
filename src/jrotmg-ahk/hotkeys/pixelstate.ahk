;;  PixelState labels

;;  prompt user for x,y and return pixel data
<^Numpad5::
    if ( Debug == true && CheckRun() == true ) {

        pBitmap := PixelState.GetBitmap()
        InputBox, x, Pixel X Position, , ,
        InputBox, y, Pixel Y Position, , ,
        PixelData := ""
        if ( RegExMatch(x, "^0\.[0-9]{1,4}$") )
            if ( RegExMatch(y, "^0\.[0-9]{1,4}$") )
                PixelData := PixelState.GetPixelByPos(x, y, pBitmap)
        ;;  absolute positions are an integer
        else if ( RegExMatch(x, "^[0-9]*$") )
             if ( RegExMatch(y, "^[0-9]*$") )
                 PixelData := PixelState.GetPixel(x, y, pBitmap)
        PixelState.DestroyBitmap(pBitmap)
        MsgBox % JSON.Dump(PixelData)

    }
    Return

;;  prompt user for PixelName or PixelGroup and return pixel state data
<^Numpad6::
    if ( Debug == true && CheckRun() == true ) {

        pBitmap := PixelState.GetBitmap()
        InputBox, StateName, Pixel or Group Name
        StateData := ( PixelGroups[StateName] ) ? PixelState.GetPixelGroupState(StateName, pBitmap) : PixelState.GetPixelState(StateName, pBitmap)
        MsgBox % JSON.Dump(StateData)
        PixelState.DestroyBitmap(pBitmap)

    }
    Return

;;  toggle screen calibration
<^Numpad7::
    if ( CheckRun() == true )
        PixelState.hotkeys.ScreenCalibrationRequest()
    Return

;;  report the hp_*p pixel states
<^Numpad9::
    if ( Debug == true && CheckRun() == true ) {

        pBitmap := PixelState.GetBitmap()
        MsgBox % "100: " . PixelState.GetPixelState("hp_100p", pBitmap) . "`n75: " . PixelState.GetPixelState("hp_75p", pBitmap) . "`n50: " . PixelState.GetPixelState("hp_50p", pBitmap) . "`n25: " . PixelState.GetPixelState("hp_25p", pBitmap) . "`n0: " . PixelState.GetPixelState("hp_0p", pBitmap)
        PixelState.DestroyBitmap(pBitmap)

    }
    Return

ScreenCalibrationRequest:
    if ( CheckRun() == true )
        PixelState.tools.GetScreenPosDataByClick()
    Return