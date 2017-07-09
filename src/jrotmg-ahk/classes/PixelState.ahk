;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  PixelState class
;;;;;;;;;;;;;;;;;;;;;;;;;;;

class PixelState {

    static Debug := true
    static LogFolder := "logs\PixelState"
    static LogFile := "pixelstate-main.log"
    static GameStates := ["InRealm", "InNexus", "InChar", "InBlackLoading", "InVault", "InMain", "InOptions"]

    ;;  run a task to check if jobs need to be ran
    BackgroundTasksMain(options=false) {

        global PixelTrack, LowHPBeep

        if ( CheckRun() == true ) {

            Debug := this.Debug
            for key, value in options {
                %key% := value
            }

            ;;  destroy the old screenshot
            if ( PixelTrack.SharedBitmap != false )
                this.DestroyBitmap(PixelTrack.SharedBitmap, Debug)

            ;;  take a new screenshot
            PixelTrack.SharedBitmap := this.GetBitmap()
            PixelTrack.SharedBitmapTime := A_Now

            ;;;;  process actions

            ;;  get current game location
            PixelTrack.CurrentLocation := this.GetGameState(PixelTrack.SharedBitmap)

            ;;  get current hp
            PixelTrack.CurrentHP := this.check.PlayerHP(PixelTrack.SharedBitmap)

            ;;  process low hp beep
            if ( (LowHPBeep > 0 && RegExMatch(PixelTrack.CurrentHP, "^[0-9]*$") && PixelTrack.CurrentLocation == "InNexus") || PixelTrack.CurrentHP == "" ) {

                ;;  turn on the beep if hp is low and not unknown
                if ( PixelTrack.CurrentHP <= LowHPBeep && PixelTrack.CurrentHP != "") {

                    if ( PixelTrack.LowHPBeep == false ) {

                        PixelTrack.LowHPBeep := true
                        SetTimer, PixelStateLowHPBeep, 1000

                    }

                } else {

                    if ( PixelTrack.LowHPBeep == true ) {

                        PixelTrack.LowHPBeep := false
                        SetTimer, PixelStateLowHPBeep, off

                    }

                }

            }

        }

        return true

    }

    ;;  determine the current state of the game (which screen the user is on)
    GetGameState(ByRef pBitmap=false) {

        BitmapProvided := ( pBitmap == false ) ? false : true

        if ( pBitmap == false )
            pBitmap := this.GetBitmap()

        ;;  loop thru each state
        for index, StateName in this.GameStates {

            ;;  check the group state
            if ( this.GetPixelGroupState(StateName, pBitmap) == true ) {

                if ( BitmapProvided == false )
                    this.DestroyBitmap(pBitmap)

                return StateName

            }

        }

        if ( BitmapProvided == false )
            this.DestroyBitmap(pBitmap)

        ;;  no states were valid
        return "Unknown"

    }

    ;;  return a bitmap of the active window
    GetBitmap() {

        WinGetPos, X, Y, Width, Height, A
        return Gdip_BitmapFromScreen(X "|" Y "|" Width "|" Height)

    }

    ;;  complete image debug processing and dispose the screenshot
    DestroyBitmap(ByRef pBitmap, Debug="") {

        global PixelTrack
        if ( Debug == "" )
            Debug := this.Debug

        if ( Debug == true && PixelTrack.debug[pBitmap] ) {

            ;;  add the pixels
            for index, PixelData in PixelTrack.debug[pBitmap] {

                Gdip_SetPixel(pBitmap, PixelData.x, PixelData.y, PixelData.argb)

            }

            this.SaveImage(pBitmap)
            PixelTrack.debug[pBitmap] := ""

        }

        Gdip_DisposeImage(pBitmap)

    }

    ;;  change the specified pixel to the new color
    SetPixel(ByRef pBitmap, a, r, g, b, x, y) {

        global PixelTrack
        argb := Gdip_ToARGB(a, r, g, b)

        if ( !PixelTrack.debug[pBitmap] )
            PixelTrack.debug[pBitmap] := []

        PixelTrack.debug[pBitmap].push({"x": x, "y": y, "argb": argb})

    }

    ;;  get the pixel argb value at the specified x,y coordinates
    GetPixel(x, y, ByRef pBitmap=false, screenshot=false) {

        ;;  grab the pixel
        BitmapProvided := ( pBitmap == false ) ? false : true
        if ( pBitmap == false )
            pBitmap := this.GetBitmap()

        ;;  get the argb data
        argb := Gdip_GetPixel(pBitmap, x, y)
        Gdip_FromARGB(argb, A, R, G, B)

        ;;  debugging
        if ( this.Debug == true )
            this.SetPixel(pBitmap, 255, 255, 255, 255, x, y)

        ;;  potential cleanup
        if ( BitmapProvided == false ) {

            if ( screenshot == true )
                this.SaveImage(pBitmap)

            this.DestroyBitmap(pBitmap)
            pBitmap := false

        }

        Return {"A": A, "R": R, "B": B, "G": G, "number": argb}

    }

    ;;  determine x,y coordinates via relative positioning and forward to GetPixel
    GetPixelByPos(xPercent, yPercent, ByRef pBitmap=false, screenshot=false) {

        if ( pBitmap != false ) {

            Width := Gdip_GetImageWidth(pBitmap)
            Height := Gdip_GetImageHeight(pBitmap)

        } else {

            WinGetPos, X, Y, Width, Height, A

        }

        xPixel := Round(Width*xPercent)
        yPixel := Round(Height*yPercent)
        Return this.GetPixel(xPixel, yPixel, pBitmap, screenshot)

    }

    ;;  determine x,y coordinates via a named entry in the PixelMap and forward to GetPixelByPos
    GetPixelByName(PixelName, ByRef pBitmap=false, screenshot=false) {

        global PixelMap, WindowTitle

        ScreenMode := this.tools.GetScreenMode(WindowTitle)
        GameWindow := this.tools.GetGameWindow(WindowTitle)
        if ( PixelMap[PixelName][GameWindow][ScreenMode] ) {

            PixelData := PixelMap[PixelName][GameWindow][ScreenMode]

            ;;  relative positions are a float
            if ( RegExMatch(PixelData["x"], "^0\.[0-9]{1,4}$") )
                if ( RegExMatch(PixelData["y"], "^0\.[0-9]{1,4}$") )
                    return this.GetPixelByPos(PixelData["x"], PixelData["y"], pBitmap, screenshot)
            ;;  absolute positions are an integer
            else if ( RegExMatch(PixelData["x"], "^[0-9]*$") )
                 if ( RegExMatch(PixelData["y"], "^[0-9]*$") )
                     return this.GetPixel(PixelData["x"], PixelData["y"], pBitmap, screenshot)

            ;;  getting this far means there was an error
            return ""

        } else {
            return ""
        }

    }

    ;;  determine if a pixel is "on" or not
    GetPixelState(PixelName, ByRef pBitmap=false, screenshot=false) {

        global PixelMap, WindowTitle
        ScreenMode := this.tools.GetScreenMode(WindowTitle)
        GameWindow := this.tools.GetGameWindow(WindowTitle)
        if ( PixelMap[PixelName][GameWindow][ScreenMode] ) {

            MapData := PixelMap[PixelName]
            PixelData := this.GetPixelByName(PixelName, pBitmap)

            ;;  a pixel could be multiple colors
            for index, ARGBNumber in MapData.settings.argb {

                ARGBDiff := Round(PixelData["number"]-ARGBNumber)
                RGB := this.RGBFromARGB(ARGBNumber)
                if ARGBDiff < 0
                    ARGBDiff := Round(ARGBDiff/-1)

                RDiff := Round(PixelData["R"]-RGB["R"])
                if RDiff < 0
                    RDiff := Round(RDiff/-1)

                GDiff := Round(PixelData["G"]-RGB["G"])
                if GDiff < 0
                    GDiff := Round(GDiff/-1)

                BDiff := Round(PixelData["B"]-RGB["B"])
                if BDiff < 0
                    BDiff := Round(BDiff/-1)

                ;;  tolerance levels are set once or per index
                RGBTolerance := ( MapData.settings.RGBTolerance[index] ) ? MapData.settings.RGBTolerance[index] : MapData.settings.RGBTolerance[1]
                ARGBTolerance := ( MapData.settings.ARGBTolerance[index] ) ? MapData.settings.ARGBTolerance[index] : MapData.settings.ARGBTolerance[1]

                ;;  exact argb number match, argb number tolerance threshold, or rgb thresholds qualify
                if ( PixelData["number"] == ARGBNumber || ARGBDiff <= ARGBTolerance || (RDiff <= RGBTolerance && GDiff <= RGBTolerance && BDiff <= RGBTolerance) ) {

                    return true

                }

            }

            ;;  no matches
            return false

        } else {
            return ""
        }

    }

    ;;  return the overall state of a group of pixels
    GetPixelGroupState(PixelGroupNames, ByRef pBitmap=false, screenshot=false) {

        global PixelGroups, PixelMap, JSON

        BitmapProvided := ( pBitmap == false ) ? false : true

        ;;  we should support multiple groups being specified, so let's convert it if it's a string
        if ( PixelGroupNames.MinIndex() == "" )
            PixelGroupNames := [PixelGroupNames]

        ;;  loop thru our groups list
        for index, PixelGroup in PixelGroupNames {

            ;;  if the named group doesn't exist then maybe it was a custom list
            if ( PixelGroups[PixelGroup] ) {

                if ( pBitmap == false )
                    pBitmap := this.GetBitmap()

                ;;  loop thru the group's members and check their values
                for PixelName, ExpectedValue in PixelGroups[PixelGroup] {

                    ;;  if the PixelName matches the name of a group, then process the group instead
                    if ( PixelGroups[PixelName] ) {

                        ;;  same comments as in the else
                        result := this.GetPixelGroupState(PixelName, pBitmap)
                        if ( result != ExpectedValue ) {

                            if ( BitmapProvided == false )
                                this.DestroyBitmap(pBitmap, screenshot)

                            ;;  blank responses are sent in the event a named pixel doesn't exist
                            if ( result == "" )
                                return ""
                            else
                                return false
                        }

                    } else {

                        ;;  instant failure if any value doesn't match
                        ;;  in the near future let's support a failure option instead of just returning false every time
                        result := this.GetPixelState(PixelName, pBitmap)
                        if ( result != ExpectedValue ) {

                            if ( BitmapProvided == false )
                                this.DestroyBitmap(pBitmap, screenshot)

                            ;;  blank responses are sent in the event a named pixel doesn't exist
                            if ( result == "" )
                                return ""
                            else
                                return false
                        }

                    }

                }

            ;;  {"pixelname": value, ...} maybe?
            } else {

                LoopCount := 0
                for PixelName, ExpectedValue in PixelGroup {

                    ;;  the named pixel must exist
                    LoopCount++
                    if ( PixelMap[PixelName] ) {

                        result := this.GetPixelState(PixelName, pBitmap)
                        if ( result != ExpectedValue ) {

                            if ( BitmapProvided == false )
                                this.DestroyBitmap(pBitmap, screenshot)

                            ;;  blank responses are sent in the event a named pixel doesn't exist
                            if ( result == "" )
                                return ""
                            else
                                return false
                        }

                    } else {

                        if ( BitmapProvided == false )
                            this.DestroyBitmap(pBitmap, screenshot)

                        return ""

                    }

                }

                ;;  did not understand the request
                if ( LoopCount == 0 )
                    return ""

            }

        }

        if ( BitmapProvided == false )
            this.DestroyBitmap(pBitmap, screenshot)

        ;;  it must have passed
        return true

    }

    ;;  return rgb values from argb number
    RGBFromARGB(argb) {

        Gdip_FromARGB(argb, A, R, G, B)
        return {"A": A, "R": R, "G": G, "B": B}

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

    ;;  add data to the pixel map
    PixelMapConfig(PixelName, GameWindowList, ScreenModeList, x, y, argb=false, RGBTolerance=false, ARGBTolerance=false) {

        global PixelMap

        ;;  sanity checks
        if x is not number
            return false

        if y is not number
            return false

        if argb != false
            if argb is not number
                if argb.MinIndex() == ""
                    return false

        if ARGBTolerance != false
            if ARGBTolerance is not number
                return false

        if RGBTolerance != false
            if RGBTolerance is not number
                return false

        if GameWindowList == "settings"
            return false

        if GameWindowList.MinIndex() = ""
            GameWindowList := [GameWindowList]

        if ScreenModeList.MinIndex() = ""
            ScreenModeList := [ScreenModeList]

        ;;  build the default object
        if !PixelMap[PixelName]
            PixelMap[PixelName] := {"settings": {"ARGBTolerance": [PixelMap.settings.ARGBTolerance], "RGBTolerance": [PixelMap.settings.RGBTolerance]}}

        ;;  convert argb value to array if not already
        if argb is number
            argb := [argb]

        if argb != false
            PixelMap[PixelName].settings.argb := argb

        ;;  convert argbtolerance value to array if not already
        if ARGBTolerance is number
            ARGBTolerance := [ARGBTolerance]

        if ARGBTolerance != false
            PixelMap[PixelName].settings.ARGBTolerance := ARGBTolerance

        ;;  convert rgbtolerance value to array if not already
        if RGBTolerance is number
            RGBTolerance := [RGBTolerance]

        if RGBTolerance != false
            PixelMap[PixelName].settings.RGBTolerance := RGBTolerance

        ;;  set the positional data
        for index, GameWindow in GameWindowList {

            if !PixelMap[PixelName][GameWindow]
                PixelMap[PixelName][GameWindow] := {}

            ;;  lazy man here, but index isn't used so whatever
            for index, ScreenMode in ScreenModeList {

                PixelMap[PixelName][GameWindow][ScreenMode] := {"x": x, "y": y}

            }

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
                PixelObject := {"pos": {"xAbs": x, "yAbs": y, "xRel": Round(x/Width, 4), "yRel": Round(y/Height, 4)}, "pixel": pixel, "argb": Gdip_ToARGB(pixel["A"], pixel["R"], pixel["G"], pixel["B"])}
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

        ;;  calculation the actual positions based on input
        ScreenShotGeneratePositions(Width, Height, Dimensions, Adjustments) {

            result := {}
            result["x"] := Round((Width*Dimensions["x"])+Adjustments["x"], 0)
            result["y"] := Round((Height*Dimensions["y"])+Adjustments["y"], 0)
            result["w"] := Round((Width*Dimensions["width"])+Adjustments["width"], 0)
            result["h"] := Round((Height*Dimensions["height"])+Adjustments["height"], 0)
            Return result

        }

        ;;  take and process a screenshot
        TakeScreenshot(mode=false, ByRef pBitmap=false, excludeFilters=false) {

            ;;  defaults
            global pToken, ScreenshotSleepTimeout, ScreenshotFilterAdjustments, ScreenshotRectangles, WatermarkPos, WatermarkTextColor, ScreenshotFolder, TimelapseFolder, DestinationFolder, ScreenshotImageQuality, ScreenshotImageMode, ScreenshotWaitPixelCheck, ScreenshotChatboxGrace, lastEnterKeypress, TimelapseSharedBitmap

            if ( ScreenshotImageMode == "direct" ) {

                ;;  window info
                WinGetPos, X, Y, Width, Height, A
                WinGetTitle, WindowTitle, A

                ;;  screenshot mode info
                BitmapProvided := ( pBitmap == false ) ? false : true
                ScreenMode := this.GetScreenMode(WindowTitle)
                GameWindow := this.GetGameWindow(WindowTitle)

                ;;  timelapse can optionally use the most recent shared bitmap
                if ( mode == "automatic_timelapse" && TimelapseSharedBitmap == true && BitmapProvided == false ) {

                    pBitmap := PixelTrack.SharedBitmap
                    BitmapProvided := true

                }

                ;;  create the base image in memory
                if ( pBitmap == false )
                    pBitmap := PixelState.GetBitmap()

                ;;  pixelstate - if it was triggered automatically by typing check if the chatbox is present
                if ( mode == "automatic_typing" && ScreenshotWaitPixelCheck == true && (A_Now-lastEnterKeypress > ScreenshotChatboxGrace) )
                    if ( PixelState.GetPixelGroupState("ChatBoxUnobstructed", pBitmap) == true )
                        return PixelState.DestroyBitmap(pBitmap)

                ;;  pixelstate - timelapse should only take screenshots in realms
                ;;  pixels not yet mapped
                ;;if mode == "automatic_timelapse"
                ;;    if PixelState.GetPixelGroupState("TimelapseControl", pBitmap) == true
                ;;        return false

                Width := Gdip_GetImageWidth(pBitmap), Height := Gdip_GetImageHeight(pBitmap)
                G := Gdip_GraphicsFromImage(pBitmap)
                Gdip_DrawImage(G, pBitmap, 0, 0, Round(Width), Round(Height), 0, 0, Width, Height)

                ;;  sleep for specified time before beginning image processing and disk activity
                Sleep ScreenshotSleepTimeout*1000

                ;;;;  prepare screenshot filters

                ;;  maybe the user knows better and provided their own
                if ( !Adjustments && ScreenshotFilterAdjustments ) {
                    Adjustments := ScreenshotFilterAdjustments
                }

                ;;  the default action is to do no adjustments
                if ( !Adjustments ) {
                    Adjustments := {"x": 0, "y": 0, "width": 0, "height": 0}
                }

                ;;  create the filter brush
                filterBrush := {"default": Gdip_BrushCreateSolid(0xff000000)}

                ;;  process all active filters
                for index, element in ScreenshotRectangles {

                    ;;  check if there is a custom color provided
                    if ( element["color"] && !filterBrush[element["color"]] ) {

                        element["color"] := "0xff" . element["color"]
                        filterBrush[element["color"]] := Gdip_BrushCreateSolid(element["color"])

                    }

                    ;;  set our default color
                    if ( !element["color"] ) {
                        element["color"] := "default"
                    }

                    ;;  only process filters if they're configured for this game window
                    if ( element[GameWindow] ) {

                        Dimensions := element[GameWindow][ScreenMode]

                        ;;  only run positions thru the adjustment system if they're percentage-based
                        ;;  absolutes can be passed through as-is where x,y > 1,1
                        if ( Dimensions["x"] > 1 && Dimensions["y"] > 1 ) {

                            pos := {"x": Dimensions["x"], "y": Dimensions["y"], "w": Dimensions["width"], "h": Dimensions["height"]}

                        } else {

                            pos := this.ScreenShotGeneratePositions(Width, Height, Dimensions, Adjustments)

                        }

                        Gdip_FillRectangle(G, filterBrush[element["color"]], pos["x"], pos["y"], pos["w"], pos["h"])

                    }

                }

                ;;;;  draw watermark
                WatermarkObject := WatermarkPos[GameWindow][ScreenMode]
                Gdip_TextToGraphics(G, "JROTMG-AHK/Screenshot", "X" . Round(WatermarkObject["x"]*Width) . " Y" . Round(WatermarkObject["y"]*Height) . " C" . WatermarkTextColor)

                ;;;;  clean up brushes
                for index, element in filterBrush {
                    Gdip_DeleteBrush(element)
                }

                ;;;;  save file to disk
                DestinationFolder := ( TimelapseFolder == false ) ? ScreenshotFolder : TimelapseFolder
                Gdip_SaveBitmapToFile(pBitmap, DestinationFolder "\" A_YYYY "-" A_MM "-" A_DD "-" A_Hour "-" A_Min "-" A_Sec ".jpg", ScreenshotImageQuality)

                ;;  cleanup
                Gdip_DeleteGraphics(G)
                if BitmapProvided == false
                    Gdip_DisposeImage(pBitmap)

            } else if ( ScreenshotImageMode == "steam" ) {

                Send, {F12}

            }

            return true

        }

    }

    class check {

        PlayerHP() {

            global JSON, PixelTrack
            pBitmap := PixelTrack.SharedBitmap
            Pixels := ["hp_0p", "hp_10p", "hp_20p", "hp_30p", "hp_40p", "hp_50p","hp_60p", "hp_70p","hp_80p", "hp_90p","hp_100p"]
            HPIndex := false
            LowIndex := false
            ControlPixels := PixelState.GetPixelGroupState({"controlpoint75_4": true, "controlpoint75_5": true, "controlpoint75_6": true}, pBitmap)
            ObstructionCheck := false

            ;;  first pass - gather pixel data and check if we need to look for obstruction
            for index, PixelName in Pixels {

                PixelData := PixelState.GetPixelState(PixelName, pBitmap)

                ;;  track the lowest pixel to fail
                if ( PixelData == false && LowIndex == false )
                    LowIndex := index

                ;;  no obstruction then no concerns
                if ( PixelData == true && ControlPixels == true )
                    HPIndex := index

                ;;  pixeldata and control pixels missing indicates an obstruction
                if ( PixelData == false && ControlPixels == false )
                    ObstructionCheck := true

                ;;  previous obstructions might mean higher pixels show up
                if ( PixelData == true && (ObstructionCheck == true || ControlPixels == false) ) {

                    ;;  lower pixels were found but a higher one was
                    ;;  obstruction is resolved
                    if ( index > HPIndex ) {

                        ;;  reset LowIndex is this is higher
                        if ( index >= LowIndex )
                            LowIndex := false

                        HPIndex := index
                        ObstructionCheck := false

                    }

                }

            }

            PixelTrack.DestroyBitmap(pBitmap)

            ;;  the actual default value is the maxindex of the pixels object
            if ( LowIndex == false )
                LowIndex := Pixels.MaxIndex()

            ;;  no pixels were detected
            if ( HPIndex == false )
                ObstructionCheck := true

            ;;  no obstruction, full hp bar, or all further hp pixels are off
            if ( ObstructionCheck == false || HPIndex == Pixels.MaxIndex() || (HPIndex != false && HPIndex <= LowIndex) ) {

                return Round((HPIndex/Pixels.MaxIndex())*100)

            } else {

                return ""

            }

        }

    }

}