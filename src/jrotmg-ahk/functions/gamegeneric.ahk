;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  jrotmg basic app functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  check if the currently active window is a valid GameWindow
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

;;  return the GameWindow type
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

;;  force close the game process with a Windows command
PanicCloseGame() {

    global GameProcessName
    Run, taskkill "/f" "/im" "%GameProcessName%"
    Return

}