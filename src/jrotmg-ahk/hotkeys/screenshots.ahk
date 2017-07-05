;;;;  track enter usage for screen shot system
~Enter::
	if ( CheckRun() == true ) lastEnterKeypress := A_Now
	Return

~NumpadEnter::
	if ( CheckRun() == true ) lastEnterKeypress := A_Now
	Return


;;;;  track gchat usage and treat it as an Enter
~g::
	if ( CheckRun() == true ) lastEnterKeypress := A_Now
	Return

;;;;  track pchat usage and treat it as an Enter
~Tab::
	if ( CheckRun() == true ) lastEnterKeypress := A_Now
	Return

~/::
    if ( CheckRun() == true ) lastEnterKeypress := A_Now
    Return

;;;;  open the screenshot folder in explorer
;;^!s::
;;	if ( CheckRun() == true ) {
;;
;;		Run % ScreenshotFolder
;;
;;	} else {
;;
;;		Send, ^!s
;;
;;	}
;;	Return

SaveScreen:
    PixelState.tools.TakeScreenshot()
	Return

;;;;  take a screenshot on nexus and panic if necessary
NexusScreenshot:

    global UserHotkeys_Nexus
	GetKeyState, ControlState, Control
	GetKeyState, CapsLockState, CapsLock, T

	if ( CapsLockState == "U" ) {

	    StringLower, NexusKeyValue, UserHotkeys_Nexus

	} else {

	    StringUpper, NexusKeyValue, UserHotkeys_Nexus

	}

	if ( CheckRun() == true && ControlState == "U" && ScreenshotEnabled == true ) {

        if ( A_Now - lastRKeyPress >= NexusKeyResetTime ) {

            NexusKeyPresses = 0
            panicKeyPresses = 0

        }

        lastRKeyPress := A_Now
	    NexusKeyPresses++
	    panicKeyPresses++

	    if ( NexusPanicEnabled == true && (panicKeyPresses >= NexusPanicCount) ) {

            PixelState.tools.TakeScreenshot()
            PanicCloseGame()
            NexusKeyPresses = 0
            panicKeyPresses = 0

	    }

		if ( ScreenshotImageMode == "direct" ) {

			Send % NexusKeyValue

		}

		difference := A_Now - lastEnterKeypress
		if ( ScreenshotKeyMode == "single" && ScreenshotWaitTimer == true && difference > ScreenshotTypeTimeout ) {
		    PixelState.tools.TakeScreenshot("automatic_typing")
        }
		if ( ScreenshotKeyMode == "single" && ScreenshotWaitTimer == false ) {
		    PixelState.tools.TakeScreenshot("automatic_typing")
        }
		if ( ScreenshotKeyMode == "double" && ScreenshotWaitTimer == false && NexusKeyPresses == 2 ) {
		    PixelState.tools.TakeScreenshot("automatic_typing")
		}
		if ( ScreenshotKeyMode == "double" && ScreenshotWaitTimer == true && NexusKeyPresses == 2 && difference > ScreenshotTypeTimeout ) {
		    PixelState.tools.TakeScreenshot("automatic_typing")
		}

		if ( ScreenshotImageMode == "steam" ) {

		    Send % NexusKeyValue

		}

        NexusKeyPresses = 0
        lastEnterKeypress := A_Now

	} else {

		Send % NexusKeyValue

	}

	Return

^!n::
    ScreenshotEnabled := ( ScreenshotEnabled == true ) ? false : true
    Return

;;;;   display time since last enter keypress
~^!e::
    if ( IsEnabledNot == true ) {
	;;if ( CheckRun() == true ) {

        if ( ScreenshotEnabled == true ) {

            if ( A_Now - lastEnterKeypress >= ScreenshotTypeTimeout ) {

                MsgBox, Seconds until screenshot can be taken: Now

            } else {

                timeLeft := ScreenshotTypeTimeout - (A_Now - lastEnterKeypress)
                MsgBox % "Seconds until screenshot can be taken: " . timeLeft

            }

        } else {

            MsgBox, Nexus Screenshotting is disabled. Press Ctrl+Alt+N to enable it.

        }

	}
	Return

$+!c::
    if ( CheckRun() == true ) {

        if ( ScreenshotHideCustom == true ) {
            MsgBox, First click the upper left boundary of the box you wish to create
            customFilterTrackingMode := true
        } else {
            MsgBox, You can only calibrate the custom filter position when ScreenshotHideCustom is enabled
        }

    }
    Return

$^!c::
    if ( CheckRun() == true ) {

        if ( ScreenshotHideCharacter == true ) {
            MsgBox, Click the center of your character to calibrate the screenshot filter
            characterTrackingMode := true
        } else {
            MsgBox, You can only calibrate the character filter position when ScreenshotHideCharacter is enabled
        }

    }
    Return

~LButton up::
    if ( CheckRun() == true ) {

        ;;  process mouse tracking for character tracking mode
        if ( characterTrackingMode == true ) {

            ;;  window info
            WinGetPos, X, Y, Width, Height, A
            WinGetTitle, WindowTitle, A
            ScreenMode := isWindowFullScreen(WinExist(WindowTitle))

            ;;  steam or flash
            GameWindow := ( RegExMatch(WindowTitle, "^Adobe Flash Player") ) ? "flash" : "steam"

            ;;  get mouse position
            MouseGetPos, x, y

            ;;  update the appropriate rectangle
            w := ScreenshotCharacterFilterPositioning[( ScreenMode == 1 ) ? "fullscreen" : "windowed"]["width"]
            h := ScreenshotCharacterFilterPositioning[( ScreenMode == 1 ) ? "fullscreen" : "windowed"]["height"]
            ScreenshotRectangles["character"][GameWindow]["windowed"] := {"x": x-Round(w/2), "y": y-Round(h/2), "width": w, "height": h}
            ScreenshotRectangles["character"][GameWindow]["fullscreen"] := {"x": x-Round(w/2), "y": y-Round(h/2), "width": w, "height": h}

            SaveConfigPiece("ScreenshotRectangles-character", ScreenshotRectangles["character"], "ScreenshotHideCharacter")

            ;;  disable tracking mode
            characterTrackingMode := false

        ;;  process mouse tracking for customer filter tracking
        } else if ( customFilterTrackingMode == true ) {

            ;;  window info
            WinGetPos, X, Y, Width, Height, A
            WinGetTitle, WindowTitle, A
            ScreenMode := isWindowFullScreen(WinExist(WindowTitle))

            ;;  steam or flash
            GameWindow := ( RegExMatch(WindowTitle, "^Adobe Flash Player") ) ? "flash" : "steam"

            ;;  get mouse position
            MouseGetPos, x, y
            customFilter["pos"][customFilter["index"]] := {"x": x, "y": y}

            if ( customFilter["index"] == 0 ) {

                customFilter["index"] := 1
                MsgBox, Now click the lower right corner of the box you wish to create

            } else if ( customFilter["index"] == 1 ) {

                ;;  update the appropriate rectangle
                w := customFilter["pos"][1]["x"]-customFilter["pos"][0]["x"]
                h := customFilter["pos"][1]["y"]-customFilter["pos"][0]["y"]
                ScreenshotRectangles["custom"][GameWindow][( ScreenMode == 1 ) ? "fullscreen" : "windowed"] := {"x": customFilter["pos"][0]["x"], "y": customFilter["pos"][0]["y"], "width": w, "height": h}
                SaveConfigPiece("ScreenshotRectangles-custom", ScreenshotRectangles["custom"])

                MsgBox,  Your custom filter has been created and saved!
                customFilterTrackingMode := false
                customFilter["index"] := 0

            }

        }

    }
    Return

;;;;  screenshot timelapse toggle
^<+s::
    if ( CheckRun() == true ) {

        if ( ScreenshotRecordingObject["enabled"] == true ) {

            ScreenshotRecordingObject["enabled"] := false
            TimelapseFolder := false
            MsgBox, , Time Lapse Disabled, Screenshot Timelapse has been disabled

        } else {

            ;;;;  get the name of this recording
            ActiveGameWindow := GetGameWindow()

            ;;;;  generate the gui
            Default_Name =
            Default_Interval =
            CreateGUI("Timelapse", "Timelapse Mode Configuration")
            GUISetFont("", "Calibri")
            GUISetFont(GUIConfig["StyleH1"])
            GUIAddText("Timelapse Screenshot Configuration")

            GUISetFont(GUIConfig["StyleH2"])

            if ( StrLen(ScreenshotRecordingObject["name"]) > 0 ) {

                GUIAddLink("gTimelapseResume", "Resume Timelapse Profile - <a id=""NewTimelapse"">" . ScreenshotRecordingObject["name"] . "</a>")

            }

            GUISetFont(GUIConfig["StyleH3"])
            GUIAddLink("gTimelapseCreateNew", "<a id=""NewTimelapse"">Create New Timelapse Configuration</a>")

            if ( ObjectCount(ScreenshotRecordingObject["profiles"]) > 0 ) {

                GUIAddLink("gTimelapseChooseProfile", "<a id=""ResumeTimelapse"">Choose Existing Timelapse Configuration</a>")
                GUIAddLink("gTimelapseChooseDeleteProfile", "<a id=""DeleteTimelapse"">Delete an Existing Timelapse Configuration</a>")

            }

            ShowGUI("Timelapse")

        }

    }
    Return
