;;
;;  pathways and objects
;;

ConfigFolder := StoragePath . "\config"
ConfigPiecesFolder := ConfigFolder . "\pieces"
ScreenshotFolder := StoragePath . "\screenshots"
IgnoresDBFile := StoragePath . "\ignoresdb.csv"
IgnoreList := Object()
lastEnterKeypress := A_Now
lastRKeyPress := A_Now
NexusKeyPresses = 0
panicKeyPresses = 0
characterTrackingMode := false
#Include includes/rectangles.ahk