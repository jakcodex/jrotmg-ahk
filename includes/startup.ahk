;;
;;  startup tasks
;;

#SingleInstance, Force
SetBatchLines, -1

;;;;  create our base storage directory and load the ignores database
if ( !FileExist(StoragePath) ) {

	FileCreateDir, %StoragePath%

}

;;;;  make screenshot folders if necessary
if ( !FileExist(ScreenshotFolder) ) {

	FileCreateDir, %ScreenshotFolder%

}

;;;;  check year folder
ScreenshotFolder := ScreenshotFolder . "\" . A_YYYY
if ( !FileExist(ScreenshotFolder) ) {

	FileCreateDir, %ScreenshotFolder%

}

;;;;  check month folder
ScreenshotFolder := ScreenshotFolder . "\" . A_MM
if ( !FileExist(ScreenshotFolder) ) {

	FileCreateDir, %ScreenshotFolder%

}

;;;;  check config folder
if ( !FileExist(ConfigFolder) ) {

	FileCreateDir, %ConfigFolder%

}

;;;;  check config pieces folder
if ( !FileExist(ConfigPiecesFolder) ) {

	FileCreateDir, %ConfigPiecesFolder%

}

;;;;  load all config files in the pieces folder
LoadConfigPieces()

;;
;;  GDI+ things
;;

If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}
OnExit, Exit

Hotkey, ^!PrintScreen, SaveScreen, On
Return