;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  PixelState class
;;;;;;;;;;;;;;;;;;;;;;;;;;;

class PixelState {

    static PixelMap := {}

    main() {

        ;;  upper right edge of the hp bar
        this.PixelMap["hp_100p"] := {"steam": {}, "flash": {}}
        this.PixelMap["hp_100p"]["steam"] := {"windowed": {}, "fullscreen": {"x": 0.983, "y": 0.423}}

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
        Gdip_DisposeImage(pBitmap)
        Gdip_FromARGB(pixel, A, R, G, B)
        Return {"A": A, "R": R, "B": B, "G": G}

    }

    ;;  determine x,y coordinates via relative positioning and forward to GetPixel
    GetPixelByPos(xPercent, yPercent) {

        WinGetPos, X, Y, Width, Height, A
        xPixel := Round(Width*xPercent)
        yPixel := Round(Height*yPercent)
        Return this.GetPixel(xPixel, yPixel)

    }

    GetPixelByName(PixelName) {

        global JSON
        WinGetTitle, WindowTitle, A
        ScreenMode := this.GetScreenMode(WindowTitle)
        GameWindow := this.GetGameWindow(WindowTitle)
        PixelData := this.PixelMap[PixelName][GameWindow][ScreenMode]
        Return this.GetPixelByPos(PixelData["x"], PixelData["y"])

    }

    GetScreenMode(WindowTitle) {

        Return ( isWindowFullScreen(WinExist(WindowTitle)) == 1 ) ? "fullscreen" : "windowed"

    }

    GetGameWindow(WindowTitle) {

        Return ( RegExMatch(WindowTitle, "^Adobe Flash Player") ) ? "flash" : "steam"

    }

}