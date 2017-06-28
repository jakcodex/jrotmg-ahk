;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  PixelState class
;;;;;;;;;;;;;;;;;;;;;;;;;;;

class PixelState {

    static PixelMap := {}
    static SaveImageFolder =

    init() {

        ;;  upper right edge of the hp bar
        this.PixelMap["hp_100p"] := {"steam": {}, "flash": {}}
        this.PixelMap["hp_100p"]["steam"] := {"windowed": {}, "fullscreen": {"x": 0.981, "y": 0.425}}

    }

    ;;  return a bitmap of the active window
    GetBitmap() {

        WinGetPos, X, Y, Width, Height, A
        return Gdip_BitmapFromScreen(X "|" Y "|" Width "|" Height)

    }

    ;;  get the pixel argb value at the specified x,y coordinates
    GetPixel(x, y) {

        ;;  grab the pixel
        pBitmap := this.GetBitmap()
        pixel := Gdip_GetPixel(pBitmap, x, y)
        Gdip_FromARGB(pixel, A, R, G, B)

        ;;  debugging
        this.SetPixel(pBitmap, 255, 255, 255, 255, x, y)

        ;;  cleanup and return
        this.SaveImage(pBitmap)
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
        Return this.GetPixelByPos(PixelData["x"], PixelData["y"])

    }

    SetPixel(ByRef pBitmap, a, r, g, b, x, y) {

        argb := Gdip_ToARGB(a, r, g, b)
        Gdip_SetPixel(pBitmap, x, y, argb)

    }

    SaveImage(ByRef pBitmap) {

        global StoragePath
        this.SaveImageFolder := StoragePath . "/pixelstatetmp"

        NewFolder := this.SaveImageFolder
        if ( !FileExist(NewFolder) ) {
            FileCreateDir, %NewFolder%
        }

        Gdip_SaveBitmapToFile(pBitmap, NewFolder . "\" . A_YYYY . "-" . A_MM . "-" . A_DD "-" . A_Hour . "-" . A_Min . "-" . A_Sec . ".jpg", 100)

    }

    class tools {

        GetScreenMode(WindowTitle) {

            Return ( isWindowFullScreen(WinExist(WindowTitle)) == 1 ) ? "fullscreen" : "windowed"

        }

        GetGameWindow(WindowTitle) {

            Return ( RegExMatch(WindowTitle, "^Adobe Flash Player") ) ? "flash" : "steam"

        }

    }

}

PixelState.init()