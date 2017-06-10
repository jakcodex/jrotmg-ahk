;;
;;  pathways and objects
;;

ConfigFolder := StoragePath . "\config"
ConfigPiecesFolder := ConfigFolder . "\pieces"
ScreenshotFolder := StoragePath . "\screenshots"
IgnoreList := []
lastEnterKeypress := A_Now
lastRKeyPress := A_Now
NexusKeyPresses = 0
panicKeyPresses = 0
characterTrackingMode := false
customFilterTrackingMode := false
customFilter := {"pos": [], "index": 0}
ScreenshotRecordingObject := {"enabled": false, "name": "", "GameWindow": false}
TimelapseFolder := false
ActiveGameWindow := false
if ( !GameProcessName ) {
    GameProcessName := false
}
#Include includes/rectangles.ahk

;;;;  GUI things
GUIConfig := {}

;;  window style formatting
GUIConfig["WindowSize"] := "+Resize "
GUIConfig["WindowDefaultWidth"] := "auto"
GUIConfig["WindowDefaultHeight"] := "auto"

;;  text style formatting
GUIConfig["StyleH1"] := "w700 s22 c002550"
GUIConfig["StyleH2"] := "w700 s16 c00408c"
GUIConfig["StyleH3"] := "w700 s12 c00408c"
GUIConfig["StyleText"] := "w300 s12 cBlack"