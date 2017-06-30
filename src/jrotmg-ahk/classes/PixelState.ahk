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
    GetPixel(x, y, screenshot=false) {

        ;;  grab the pixel
        pBitmap := this.GetBitmap()
        pixel := Gdip_GetPixel(pBitmap, x, y)
        Gdip_FromARGB(pixel, A, R, G, B)

        ;;  debugging
        this.SetPixel(pBitmap, 255, 255, 255, 255, x, y)

        ;;  cleanup and return
        if ( this.Debug == true || screenshot == true) {
            this.SaveImage(pBitmap)
        }
        Gdip_DisposeImage(pBitmap)
        Return {"A": A, "R": R, "B": B, "G": G}

    }

    ;;  determine x,y coordinates via relative positioning and forward to GetPixel
    GetPixelByPos(xPercent, yPercent, screenshot=false) {

        WinGetPos, X, Y, Width, Height, A
        xPixel := Round(Width*xPercent)
        yPixel := Round(Height*yPercent)
        Return this.GetPixel(xPixel, yPixel, screenshot)

    }

    ;;  determine x,y coordinates via a named entry in the PixelMap and forward to GetPixelByPos
    GetPixelByName(PixelName, screenshot=false) {

        global JSON, PixelMap
        WinGetTitle, WindowTitle, A
        ScreenMode := this.tools.GetScreenMode(WindowTitle)
        GameWindow := this.tools.GetGameWindow(WindowTitle)
        PixelData := PixelMap[PixelName][GameWindow][ScreenMode]
        Return ( PixelData["x"] > 1 ) ? this.GetPixel(PixelData["x"], PixelData["y"], screenshot) : this.GetPixelByPos(PixelData["x"], PixelData["y"], screenshot)

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