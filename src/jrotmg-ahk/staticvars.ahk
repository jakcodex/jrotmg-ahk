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
WatermarkPos := {"steam": {}, "flash": {}}
WatermarkPos["steam"]["fullscreen"] := {"x": 0.916, "y": 0.006}
WatermarkPos["steam"]["windowed"] := {"x": 0.800, "y": 0.050}
WatermarkPos["flash"]["fullscreen"] := {"x": 0.916, "y": 0.006}
WatermarkPos["flash"]["windowed"] := {"x": 0.800, "y": 0.079}
#Include src/jrotmg-ahk/rectangles.ahk
#Include, src/common/gui/guistaticvars.ahk

;;Gdip_FillRectangle
;;Gdip_DrawImage
;;Gdip_GetPixel
;;Gdip_CreateBitmapFromFile
;;Gdip_TextToGraphics