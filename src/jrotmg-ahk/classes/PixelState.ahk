;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  PixelState class
;;;;;;;;;;;;;;;;;;;;;;;;;;;

class PixelState {

    static Debug := true
    static LogFolder := "logs\PixelState"
    static LogFile := "pixelstate-main.log"

    ;;  return a bitmap of the active window
    GetBitmap() {

        WinGetPos, X, Y, Width, Height, A
        return Gdip_BitmapFromScreen(X "|" Y "|" Width "|" Height)

    }

    ;;  get the pixel argb value at the specified x,y coordinates
    GetPixel(x, y, ByRef pBitmap=false, screenshot=false) {

        ;;  grab the pixel
        if ( pBitmap == false ) {
            pBitmap := this.GetBitmap()
        }
        pixel := Gdip_GetPixel(pBitmap, x, y)
        Gdip_FromARGB(pixel, A, R, G, B)

        ;;  debugging
        this.SetPixel(pBitmap, 255, 255, 255, 255, x, y)

        ;;  cleanup and return
        if ( pBitmap == false ) {

            if ( this.Debug == true || screenshot == true) {
                this.SaveImage(pBitmap)
            }
            Gdip_DisposeImage(pBitmap)

        }
        Return {"A": A, "R": R, "B": B, "G": G, "number": pixel}

    }

    ;;  determine x,y coordinates via relative positioning and forward to GetPixel
    GetPixelByPos(xPercent, yPercent, ByRef pBitmap=false, screenshot=false) {

        WinGetPos, X, Y, Width, Height, A
        xPixel := Round(Width*xPercent)
        yPixel := Round(Height*yPercent)
        Return this.GetPixel(xPixel, yPixel, pBitmap, screenshot)

    }

    ;;  determine x,y coordinates via a named entry in the PixelMap and forward to GetPixelByPos
    GetPixelByName(PixelName, ByRef pBitmap=false, screenshot=false) {

        global JSON, PixelMap

        if ( PixelMap[PixelName] ) {

            WinGetTitle, WindowTitle, A
            ScreenMode := this.tools.GetScreenMode(WindowTitle)
            GameWindow := this.tools.GetGameWindow(WindowTitle)
            PixelData := PixelMap[PixelName][GameWindow][ScreenMode]
            Return ( PixelData["x"] > 1 ) ? this.GetPixel(PixelData["x"], PixelData["y"], pBitmap, screenshot) : this.GetPixelByPos(PixelData["x"], PixelData["y"], pBitmap, screenshot)

        } else {
            return false
        }

    }

    ;;  determine if a pixel is "on" or not
    GetPixelState(PixelName, ByRef pBitmap=false, screenshot=false) {

        global PixelMap
        if ( PixelMap[PixelName] ) {

            PixelData := this.GetPixelByName(PixelName, pBitmap)
            ARGBDiff := Round(PixelData["number"]-PixelMap[PixelName].meta.argb)
            if ARGBDiff < 0
                ARGBDiff := Round(ARGBDiff/-1)

            RDiff := Round(PixelData["R"]-PixelMap[PixelName].meta.rgb[1])
            if RDiff < 0
                RDiff := Round(RDiff/-1)

            GDiff := Round(PixelData["G"]-PixelMap[PixelName].meta.rgb[2])
            if GDiff < 0
                GDiff := Round(GDiff/-1)

            BDiff := Round(PixelData["B"]-PixelMap[PixelName].meta.rgb[3])
            if BDiff < 0
                BDiff := Round(BDiff/-1)

            ;;  exact argb number match, argb number tolerance threshold, or rgb thresholds qualify
            if ( PixelData["number"] == PixelMap[PixelName].meta.argb || ARGBDiff <= PixelMap.settings.ARGBTolerance || (RDiff <= PixelMap.settings.RGBTolerance && GDiff <= PixelMap.settings.RGBTolerance && BDiff <= PixelMap.settings.RGBTolerance) ) {

                return true

            } else {

                return false

            }

        } else {
            return false
        }

    }

    ;;  return the overall state of a group of pixels
    GetPixelGroupState(PixelGroupNames, ByRef pBitmap=false, screenshot=false) {

        global PixelGroups

        ;;  we should support multiple groups being specified, so let's convert it if it's a string
        if ( PixelGroupNames.MinIndex() == "" ) {
            PixelGroupNames := [PixelGroupNames]
        }

        ;;  loop thru our groups list
        for index, PixelGroup in PixelGroupNames {

            ;;  if the named group doesn't exist then abandon all hope
            if ( PixelGroups[PixelGroup] ) {

                if ( pBitmap == false ) {
                    pBitmap := this.GetBitmap()
                }

                ;;  loop thru the group's members and check their values
                for PixelName, ExpectedValue in PixelGroups[PixelGroup] {

                    ;;  if the PixelName matches the name of a group, then process the group instead
                    if ( PixelGroups[PixelName] ) {

                        ;;  same comments as in the else
                        if ( this.GetPixelGroupState(PixelName, pBitmap) != ExpectedValue ) {
                            return false
                        }

                    } else {

                        ;;  instant failure if any value doesn't match
                        ;;  in the near future let's support a failure option instead of just returning false every time
                        if ( this.GetPixelState(PixelName, pBitmap) != ExpectedValue ) {
                            return false
                        }

                    }

                }

                if ( pBitmap == false ) {
                    Gdip_DisposeImage(pBitmap)
                }

                ;;  it must have passed
                return true

            } else {
                return false
            }

        }

    }

    ;;  change the specified pixel to the new color
    SetPixel(ByRef pBitmap, a, r, g, b, x, y) {

        argb := Gdip_ToARGB(a, r, g, b)
        Gdip_SetPixel(pBitmap, x, y, argb)

    }

    ;;  save the in-memory bitmap to disk
    SaveImage(ByRef pBitmap) {

        global StoragePath
        NewFolder := StoragePath . "\pixelstatetmp"
        if ( !FileExist(NewFolder) ) {
            FileCreateDir, %NewFolder%
        }

        Gdip_SaveBitmapToFile(pBitmap, NewFolder . "\" . A_YYYY . "-" . A_MM . "-" . A_DD "-" . A_Hour . "-" . A_Min . "-" . A_Sec . ".jpg", 100)

    }

    Logging(location, message, level="debug") {

        global StoragePath
        LogFolder := StoragePath . "\" . this.LogFolder
        LogFile := LogFolder . "\" . this.LogFile
        if ( RegExMatch(LogFile, "^.*?\.log$") ) {

            NewFolder := LogFolder
            if ( !FileExist(NewFolder) ) {
                FileCreateDir, %NewFolder%
            }

            FileAppend, % "[" A_YYYY "-" A_MM "-" A_DD " " A_Hour ":" A_Min ":" A_Sec "] [" location "] [" level "] " message "`n", % LogFile

        }

    }

    GetState(name) {

        global PixelStateProfile

    }

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;  pixelstate hotkeys
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    class hotkeys {

        static ScreenCalibrationStatus := false

        ;;  toggle calibration on/off
        ScreenCalibrationRequest() {

            this.ScreenCalibrationStatus := ( this.ScreenCalibrationStatus == true ) ? false : true
            if ( this.ScreenCalibrationStatus == true ) {
                Hotkey, ~LButton, ScreenCalibrationRequest, On
            } else {
                Hotkey, ~LButton, ScreenCalibrationRequest, Off
            }

        }

    }

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;  pixelstate tools
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;
    class tools {

        ;;  get the current window state of the game
        GetScreenMode(WindowTitle) {

            Return ( isWindowFullScreen(WinExist(WindowTitle)) == 1 ) ? "fullscreen" : "windowed"

        }

        ;;  determine if this is flash or steam
        GetGameWindow(WindowTitle) {

            Return ( RegExMatch(WindowTitle, "^Adobe Flash Player") ) ? "flash" : "steam"

        }

        ;;  get screen positional data for the mouse location
        GetScreenPosDataByClick() {

            global JSON
            run := CheckRun()

            if ( CheckRun() == true ) {

                WinGetPos, WinX, WinY, Width, Height, A
                MouseGetPos, x, y
                pixel := PixelState.GetPixel(x, y)
                PixelObject := {"pos": {"xAbs": x, "yAbs": y, "xRel": Round(x/Width, 3), "yRel": Round(y/Height, 3)}, "pixel": pixel, "argb": Gdip_ToARGB(pixel["A"], pixel["R"], pixel["G"], pixel["B"])}
                message1 := "Absolute x,y: " . PixelObject["pos"]["xAbs"] . "," . PixelObject["pos"]["yAbs"]
                message2 := "Relative x,y: " . PixelObject["pos"]["xRel"] . "," . PixelObject["pos"]["yRel"]
                message3 := "Pixel ARGB Values: " . PixelObject["pixel"]["A"] . " " . PixelObject["pixel"]["R"] . " " . PixelObject["pixel"]["G"] . " " . PixelObject["pixel"]["B"]
                message4 := "Pixel ARGB Number: " . PixelObject["argb"] . "`n"
                PixelState.Logging("PixelState/ScreenCalibration", message1)
                PixelState.Logging("PixelState/ScreenCalibration", message2)
                PixelState.Logging("PixelState/ScreenCalibration", message3)
                PixelState.Logging("PixelState/ScreenCalibration", message4)
                MsgBox % message1 . "`n" . message2 . "`n" . message3 . "`n" . message4

            }

        }

    }

}