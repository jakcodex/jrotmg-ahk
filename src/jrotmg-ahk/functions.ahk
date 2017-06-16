;;
;;  functions
;;

InArray(needle, haystack) {

    for index, element in haystack {
        if ( element == needle ) {
            Return true
        }
    }
    Return false

}

ObjectCount(object) {

    value = 0
    for index, element in object {
        value++
    }
    Return value

}

SaveConfigPiece(piece, data, configEnableKey=false, programKey=false) {

    global ConfigPiecesFolder, JSON

    ;;  these might just simply be empty
    if ( configEnableKey == "" ) {
       configEnableKey := false
    }

    if ( programKey == "" ) {
        programKey := false
    }

    ;;  construct the object we're going to save
    object := {"data": data, "defaultValue": false}
    object["configKey"] := configEnableKey

    if ( programKey != false ) {
        object["programKey"] := programKey
    }

    ;;  convert to json and write the file
    jdata := JSON.Dump(object)
    file := FileOpen(ConfigPiecesFolder . "\" . piece . ".json", "w")
    file.Write(jdata)
    file.Close()
    Return

}

LoadConfigPieces(piece=false) {

    global ConfigPiecesFolder, JSON, ScreenshotRectangles, IgnoreList
    if ( piece == false ) {
        piece := "*"
    }
    Loop Files, % ConfigPiecesFolder . "\" . piece . ".json"
    {

        ;;  all files take the form key-subkey-filter.json
        if ( RegExMatch(A_LoopFileFullPath, "O)([a-zA-Z0-9-]+).json$", matches) ) {

            ;;  open and read the file
            file := FileOpen(A_LoopFileFullPath, "r")
            data := file.Read()
            PieceKey := StrSplit(matches[1], "-")
            PieceData := JSON.Load(data)
            configKey := PieceData["configKey"]
            programKey := PieceData["programKey"]

            ;;  load the piece if no configKey provided, or if configKey == true
            if ( PieceData["configKey"] == false || %configKey% == true ) {

                ;;  there is a bit of manual work here to process keys
                if ( PieceKey[1] == "ScreenshotRectangles" ) {

                    if ( StrLen(data) > 0 ) {
                        ScreenshotRectangles[PieceData[2]] := PieceData["data"]
                    }

                ;;  some configs include instructions for building them within the system
                } else {

                    if ( %programKey% && PieceData["data"] ) {

                        %programKey% := PieceData["data"]

                    }

                }

            }

        }

    }

}

CheckRun() {

	global GameProcessName, ROTMGWindowName
	WinGetTitle, WindowTitle, A
	FoundPos := RegExMatch(WindowTitle, "(Realm of the Mad God|Adobe Flash Player)")
	if ( FoundPos > 0 ) {

        WinGet, GameProcessName, ProcessName, A
        ROTMGWindowName := WindowTitle
        return true

    } else {

        return false

    }

}

ForwardKey(key) {

	Suspend on
	Send, %key%
	Suspend off

}

TakeScreenshot() {

    global ScreenshotImageMode
    if ( ScreenshotImageMode == "direct" ) {

        Send, ^!{PrintScreen}

    } else if ( ScreenshotImageMode == "steam" ) {

        Send, {F12}

    }

    Return

}

ScreenShotGeneratePositions(Width, Height, Dimensions, Adjustments) {

    result := {}
    result["x"] := Round((Width*Dimensions["x"])+Adjustments["x"], 0)
    result["y"] := Round((Height*Dimensions["y"])+Adjustments["y"], 0)
    result["w"] := Round((Width*Dimensions["width"])+Adjustments["width"], 0)
    result["h"] := Round((Height*Dimensions["height"])+Adjustments["height"], 0)
    Return result

}

PanicCloseGame() {

    global GameProcessName
    Run, taskkill "/f" "/im" "%GameProcessName%"
    Return

}

isWindowFullScreen(WinID) {
    ;checks if the specified window is full screen
    ;use WinExist of another means to get the Unique ID (HWND) of the desired window

    if ( !WinID )
        return

    WinGet, style, Style, ahk_id %WinID%
    ; 0x800000 is WS_BORDER.
    ; 0x20000000 is WS_MINIMIZE.
    ; no border and not minimized
    retVal := (style & 0x20800000) ? 0 : 1
    Return, retVal
}

GetGameWindow() {

    WinGetTitle, WindowTitle, A
    if ( RegExMatch(WindowTitle, "^Adobe Flash Player") ) {

        Return "flash"

    } else if ( RegExMatch(WindowTitle, "^Realm of the Mad God") ) {

        Return "steam"

    } else {

        Return false

    }

}

ScreenshotTimelapseTimer() {

    global ScreenshotRecordingObject, ScreenshotImageMode, ScreenshotFolder, TimelapseFolder

    if ( ScreenshotRecordingObject["enabled"] == true && ScreenshotImageMode == "direct" ) {

        ;;  only run if the window matches startup parameters
        if ( GetGameWindow() == ScreenshotRecordingObject["profiles"][ScreenshotRecordingObject["name"]]["GameWindow"] ) {

            TimelapseFolder := ScreenshotFolder . "\timelapse-" . ScreenshotRecordingObject["name"]
            if ( !FileExist(TimelapseFolder) ) {

                FileCreateDir, %TimelapseFolder%

            }
            Send, ^!{PrintScreen}


        }

    } else {

        SetTimer,, Delete

    }

}

TimelapseCreateNew(a, b, c, d) {

    global GUILoaded, ScreenshotRecordingObject, ActiveGameWindow
    if ( GUILoaded != false ) {
        Gui, % GUILoaded . ": Cancel"
        GUILoaded := false
    }

    InputBox, RecordingName, Name this Recording, Provide a name for this timelapse recording`Accepted values are: a-zA-Z0-9-_ and space, , auto, 140, , , , , % ScreenshotRecordingObject["name"]
    if ( ErrorLevel == 0 && RegExMatch(RecordingName, "^[a-zA-Z0-9-_ ]+$") ) {

        ;;;;  get the interval of this recording
        InputBox, RecordingInterval, How often should screenshots be taken, What is the delay between screenshots in seconds?, , , , , , , , 5
        if ( ErrorLevel == 0 && RegExMatch(RecordingInterval, "^[1-9]\d*?$")  ) {

            MsgBox, , Time Lapse Created, % "Screenshot Timelapse is created`n`nName: " . RecordingName . "`nLoop Interval: " . RecordingInterval . " seconds"
            ScreenshotRecordingObject["enabled"] := false
            ScreenshotRecordingObject["name"] := RecordingName
            if ( !ScreenshotRecordingObject["profiles"] ) {
                ScreenshotRecordingObject["profiles"] := {}
            }
            ScreenshotRecordingObject["profiles"][RecordingName] := {}
            ScreenshotRecordingObject["profiles"][RecordingName]["interval"] := Round(RecordingInterval*1000)
            ScreenshotRecordingObject["profiles"][RecordingName]["GameWindow"] := ActiveGameWindow
            ;SetTimer, ScreenshotTimelapseTimer, % ScreenshotRecordingObject["profiles"][RecordingName]["interval"]
            SaveConfigPiece("TimelapseConfig", ScreenshotRecordingObject, false, "ScreenshotRecordingObject")

        } else {

            if ( ErrorLevel  != 1 ) {
                MsgBox, , Input Error, % "Error: You provided an invalid response`n`n`" . RecordingInterval . "`n`nAccepted values are 1, 2, 3, 4, ..."
            }

        }

    } else {

        if ( ErrorLevel != 1 ) {
            MsgBox, , Input Error, % "Error: You provided an invalid response`n`n`" . RecordingName . "`n`nAccepted values are a-zA-Z0-9-_ and space"
        }

    }

    Return

}

TimelapseResume(a, b, c, d) {

    global GUILoaded, ScreenshotRecordingObject
    if ( GUILoaded != false ) {
        Gui, % GUILoaded . ": Cancel"
        GUILoaded := false
    }

    if ( ScreenshotRecordingObject["enabled"] == false ) {

        ScreenshotRecordingObject["enabled"] := true
        SetTimer, ScreenshotTimelapseTimer, % ScreenshotRecordingObject["profiles"][ScreenshotRecordingObject["name"]]["interval"]

    } else {

        MsgBox, Cannot resume timelapse as it is already running!

    }

    Return

}

TimelapseChooseProfile(a, b, c, d) {

    global GUILoaded, GUIConfig, ScreenshotRecordingObject
    if ( GUILoaded != false ) {
        Gui, % GUILoaded . ": Cancel"
        GUILoaded := false
    }

    CreateGUI("TimelapseProfile", "Timelapse Profile Selection")
    GUISetFont("", "Calibri")
    GUISetFont(GUIConfig["StyleH1"])
    GUIAddText("Timelapse Screenshot Profile Selection")

    GUISetFont(GUIConfig["StyleH3"])

    for index, element in ScreenshotRecordingObject["profiles"] {

        GUIAddLink("gTimelapseEnableProfile xs+10", "<a id=""" . index . """>" . index . "</a>")

    }

    ShowGUI("TimelapseProfile")

    Return

}

TimelapseEnableProfile(a, b, c, d) {

    global GUILoaded, ScreenshotRecordingObject

    if ( GUILoaded != false ) {
        Gui, % GUILoaded . ": Cancel"
        GUILoaded := false
    }

    if ( ScreenshotRecordingObject["profiles"][d] ) {

        ScreenshotRecordingObject["enabled"] := true
        ScreenshotRecordingObject["name"] := d
        SetTimer, ScreenshotTimelapseTimer, % ScreenshotRecordingObject["profiles"][d]["interval"]
        SaveConfigPiece("TimelapseConfig", ScreenshotRecordingObject, false, "ScreenshotRecordingObject")
        MsgBox, , Timelapse Screenshot Mode Enabled, % "Successfully enabled timelapse mode - " . d

    } else {

        MsgBox % "Selected profile """ . d . """ does not exist"

    }

}

TimelapseChooseDeleteProfile(a, b, c, d) {

    global GUILoaded, GUIConfig, ScreenshotRecordingObject
    if ( GUILoaded != false ) {
        Gui, % GUILoaded . ": Cancel"
        GUILoaded := false
    }

    CreateGUI("TimelapseDelete", "Timelapse Delete Profile")
    GUISetFont("", "Calibri")
    GUISetFont(GUIConfig["StyleH1"])
    GUIAddText("Timelapse Screenshot Profile Deletion")

    GUISetFont(GUIConfig["StyleH3"])

    for index, element in ScreenshotRecordingObject["profiles"] {

        GUIAddLink("gTimelapseDeleteProfile xs+10", "<a id=""" . index . """>" . index . "</a>")

    }

    ShowGUI("TimelapseDelete")

    Return


}

TimelapseDeleteProfile(a, b, c, d) {

    global GUILoaded, GUIConfig, ScreenshotRecordingObject
    if ( GUILoaded != false ) {
        Gui, % GUILoaded . ": Cancel"
        GUILoaded := false
    }

   ScreenshotRecordingObject["profiles"].delete(d)
    SaveConfigPiece("TimelapseConfig", ScreenshotRecordingObject, false, "ScreenshotRecordingObject")

    MsgBox, , Timelapse Profile Deleted, % "Deleted timelapse profile - " . d

    Return

}