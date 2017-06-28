;;
;;  dev tools  ;;
;;

;;;;  list all vars
$^!v::
	if ( CheckRun() == true ) {

		Listvars

	} else {

		Send, ^!v

	}

	Return

^!f::
    isFullScreen := isWindowFullScreen(WinExist(ROTMGWindowName))
    MsgBox %isFullScreen%
    Return