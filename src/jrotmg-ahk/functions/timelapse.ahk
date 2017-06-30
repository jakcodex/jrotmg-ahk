;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  timelapse functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  perform the timelapse action
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

;;  display gui to create new timelapse profile
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

;;  resume a stopped timelapse
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

;;  display a gui to choose which timelapse profile to use
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

;;  enable a timelapse profile
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

;;  display a gui to let the user delete a timelapse profile
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

;;  delete the specified profile from configuration
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