;;
;;  pathways and objects
;;

#Include src/common/lib/json.ahk
#Include src/jrotmg-ahk/etc/rectangles.ahk
#Include src/common/gui/guistaticvars.ahk

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
WindowTitle := false
if ( !GameProcessName ) {
    GameProcessName := false
}
WatermarkPos := {"x": 0.916, "y": 0.006}

;;Gdip_FillRectangle
;;Gdip_DrawImage
;;Gdip_GetPixel
;;Gdip_CreateBitmapFromFile
;;Gdip_TextToGraphics