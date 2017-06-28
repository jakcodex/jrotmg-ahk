;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  PixelState class
;;;;;;;;;;;;;;;;;;;;;;;;;;;

class PixelState {

    static PixelMap := {}
    static SaveImageFolder =
    static Debug := false

    init(options=false) {

        if ( options != false ) {

            for index, element in options {

                this[index] := element

            }

        }

        ;;  upper right edge of the hp bar
        this.PixelMap["hp_100p"] := {"steam": {}, "flash": {}}
        this.PixelMap["hp_100p"]["steam"] := {"windowed": {}, "fullscreen": {"x": 0.984, "y": 0.425}}

    }

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
    GetPixelByPos(xPercent, yPercent) {

        WinGetPos, X, Y, Width, Height, A
        xPixel := Round(Width*xPercent)
        yPixel := Round(Height*yPercent)
        Return this.GetPixel(xPixel, yPixel)

    }

    ;;  determine x,y coordinates via a named entry in the PixelMap and forward to GetPixelByPos
    GetPixelByName(PixelName) {

        global JSON
        WinGetTitle, WindowTitle, A
        ScreenMode := this.tools.GetScreenMode(WindowTitle)
        GameWindow := this.tools.GetGameWindow(WindowTitle)
        PixelData := this.PixelMap[PixelName][GameWindow][ScreenMode]
        Return ( PixelData["x"] > 1 ) ? this.GetPixel(PixelData["x"], PixelData["y"]) : this.GetPixelByPos(PixelData["x"], PixelData["y"])

    }

    ;;  change the specified pixel to the new color
    SetPixel(ByRef pBitmap, a, r, g, b, x, y) {

        argb := Gdip_ToARGB(a, r, g, b)
        Gdip_SetPixel(pBitmap, x, y, argb)

    }

    ;;  save the in-memory bitmap to disk
    SaveImage(ByRef pBitmap) {

        global StoragePath
        this.SaveImageFolder := StoragePath . "/pixelstatetmp"

        NewFolder := this.SaveImageFolder
        if ( !FileExist(NewFolder) ) {
            FileCreateDir, %NewFolder%
        }

        Gdip_SaveBitmapToFile(pBitmap, NewFolder . "\" . A_YYYY . "-" . A_MM . "-" . A_DD "-" . A_Hour . "-" . A_Min . "-" . A_Sec . ".jpg", 100)

    }

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;  pixelstate hotkeys
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    class hotkeys {

        static ScreenCalibrationStatus := false
        
        ;;  
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
                MsgBox % JSON.Dump({"pos": {"xAbs": x, "yAbs": y, "xRel": Round(x/Width, 3), "yRel": Round(y/Height, 3)}}) . "`n" . JSON.Dump({"pixel": pixel}) . "`n" . JSON.Dump({"argb": Gdip_ToARGB(pixel["A"], pixel["R"], pixel["G"], pixel["B"])})

            }

        }

    }

}

;;  class initialization
PixelState.init({"Debug": true})

;;  PixelState labels
<^Numpad7::
    ;;MsgBox % JSON.Dump(PixelState.GetPixelByName("hp_100p"))
    PixelState.hotkeys.ScreenCalibrationRequest()
    Return

ScreenCalibrationRequest:
    PixelState.tools.GetScreenPosDataByClick()
    Return