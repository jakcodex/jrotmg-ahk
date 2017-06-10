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
if ( !GameProcessName ) {
    GameProcessName := false
}
#Include includes/rectangles.ahk