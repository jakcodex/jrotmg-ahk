;;
;;  hotkeys
;;

;;;;  force close rotmg (oh shit button)
^esc::
	PanicCloseGame()
	Return

;;;;  display the contents of the saved ignore list
$^!t::

	if ( CheckRun() == true ) {

		users = ;
		for index, element in IgnoreList {
			users .= element . ", "
		}

		users := SubStr(users, 1, StrLen(users)-2)
		MsgBox % ( StrLen(users) == 0 ) ? "Ignored users: None" : "Ignored users: " . users

	} else {

		Send, ^!t

	}

	Return

;;;;  ignore the most recent user to send a pm
$^+v::

	if ( CheckRun() == true ) {

		;;;;get the most recent tell data
		Suspend On
		clipboard =  ;
		SendInput {Tab}
		SendInput ^a
		SendInput ^x
		ClipWait, 2
		Suspend Off

		;;;;identify the username
		FoundPos := RegExMatch(clipboard, "O)/tell ([a-zA-Z]+)", ignoreUser)
		if ( FoundPos > 0 && InArray(ignoreUser.1, IgnoreList) == false ) {

			;;;;ignore the user
			Suspend On
			SendInput % "/ignore " . ignoreUser.1
			SendInput {Enter}
			Suspend Off

			;;;;update ignorelist
			IgnoreList.Insert(ignoreUser.1)
			SaveConfigPiece("IgnoresDB", IgnoreList, false, "IgnoreList")

		} else {

            if ( FoundPos == 0 ) {
                SendInput, No users found
            }

            if ( FoundPos > 0 ) {
                SendInput, User already on ignores list
            }

		    Sleep 500
		    SendInput ^a
		    SendInput {Backspace}
		    SendInput {Enter}

		}

	} else {

		Send, ^+v

	}

	Return

;;;;  unignore the most recently ignored user
$^+z::
	if ( CheckRun() == true ) {

		if ( IgnoreList.MaxIndex() >= 0 ) {

			SendString := "/unignore " + IgnoreList[IgnoreList.MaxIndex()]
			clipboard = %SendString%
			SendInput {Enter}
			SendInput ^v
			SendInput {Enter}
			IgnoreList.remove(IgnoreList.MaxIndex())
			SaveConfigPiece("IgnoresDB", IgnoreList, false, "IgnoreList")

		} else {

            SendInput {Enter}
            SendInput, No users found
            Sleep 500
            SendInput ^a
            SendInput {Backspace}
            SendInput {Enter}

        }

	} else {

		Send, ^+z

	}

	Return

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
^!s::
	if ( CheckRun() == true ) {

		Run % ScreenshotFolder

	} else {

		Send, ^!s

	}
	Return

SaveScreen:

	;;  window info
	WinGetPos, X, Y, Width, Height, A
    WinGetTitle, WindowTitle, A
    ScreenMode := isWindowFullScreen(WinExist(WindowTitle))

    ;;  steam or flash
    GameWindow := ( RegExMatch(WindowTitle, "^Adobe Flash Player") ) ? "flash" : "steam"

    ;;  create the base image in memory
	pBitmap := Gdip_BitmapFromScreen(X "|" Y "|" Width "|" Height)
	Width := Gdip_GetImageWidth(pBitmap), Height := Gdip_GetImageHeight(pBitmap)
	PBitmapResized := Gdip_CreateBitmap(Round(Width), Round(Height)), G := Gdip_GraphicsFromImage(pBitmapResized)
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

            Dimensions := ( ScreenMode == 1 ) ? element[GameWindow]["fullscreen"] : element[GameWindow]["windowed"]

            ;;  only run positions thru the adjustment system if they're percentage-based
            ;;  absolutes can be passed through as-is where x,y > 1,1
            if ( Dimensions["x"] > 1 && Dimensions["y"] > 1 ) {

                pos := {"x": Dimensions["x"], "y": Dimensions["y"], "w": Dimensions["width"], "h": Dimensions["height"]}

            } else {

                pos := ScreenShotGeneratePositions(Width, Height, Dimensions, Adjustments)

            }

            Gdip_FillRectangle(G, filterBrush[element["color"]], pos["x"], pos["y"], pos["w"], pos["h"])

        }

    }

    ;;;;  clean up brushes
    for index, element in filterBrush {
        Gdip_DeleteBrush(element)
    }

    ;;;;  save file to disk and finish clean up
    DestinationFolder := ( TimelapseFolder == false ) ? ScreenshotFolder : TimelapseFolder
	Gdip_SaveBitmapToFile(PBitmapResized, DestinationFolder "\" A_YYYY "-" A_MM "-" A_DD "-" A_Hour "-" A_Min "-" A_Sec ".jpg")
	Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmapResized)
	Gdip_DisposeImage(pBitmap)



	Return

Exit:
	Gdip_Shutdown(pToken)
	ExitApp
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

            TakeScreenshot()
            PanicCloseGame()
            NexusKeyPresses = 0
            panicKeyPresses = 0

	    }

		if ( ScreenshotImageMode == "direct" ) {

			Send % NexusKeyValue

		}

		difference := A_Now - lastEnterKeypress
		if ( ScreenshotKeyMode == "single" && ScreenshotWaitTimer == true && difference > ScreenshotTypeTimeout ) {
		    TakeScreenshot()
        }
		if ( ScreenshotKeyMode == "single" && ScreenshotWaitTimer == false ) {
		    TakeScreenshot()
        }
		if ( ScreenshotKeyMode == "double" && ScreenshotWaitTimer == false && NexusKeyPresses == 2 ) {
		    TakeScreenshot()
		}
		if ( ScreenshotKeyMode == "double" && ScreenshotWaitTimer == true && NexusKeyPresses == 2 && difference > ScreenshotTypeTimeout ) {
		    TakeScreenshot()
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
$^!e::
	if ( CheckRun() == true ) {

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

	} else {

		Send, ^!e

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
~^<+s::
    if ( CheckRun() == true ) {

        if ( ScreenshotRecordingObject["enabled"] == true ) {

            ScreenshotRecordingObject["enabled"] := false
            MsgBox, , Time Lapse Disabled, Screenshot Timelapse has been disabled

        } else {

            ;;;;  get the name of this recording
            ActiveGameWindow := GetGameWindow()

            ;;;;  generate the gui
            Default_Name =
            Default_Interval =
            CreateGUI("Timelapse")
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
