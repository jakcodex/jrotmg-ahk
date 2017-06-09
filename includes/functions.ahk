;;
;;  functions
;;

InArray(needle, haystack) {

    for index, element in haystack {
        if ( element == needle ) {
            Return true
        }
    }
    Return false

}

SaveConfigPiece(piece, data, configEnableKey=false) {

    global ConfigPiecesFolder, JSON

    object := {"data": data}
    if ( configEnableKey != false ) {
        object["configKey"] := configEnableKey
    }

    jdata := JSON.Dump(object)
    file := FileOpen(ConfigPiecesFolder . "\" . piece . ".json", "w")
    file.Write(jdata)
    file.Close()
    Return

}

LoadConfigPieces(piece=false) {

    global ConfigPiecesFolder, JSON, ScreenshotRectangles, IgnoreList
    if ( piece == false ) {
        piece := "*"
    }
    Loop Files, % ConfigPiecesFolder . "\" . piece . ".json"
    {

        ;;  all files take the form key-subkey.json
        if ( RegExMatch(A_LoopFileFullPath, "O)([a-zA-Z0-9-]+).json$", matches) ) {

            ;;  open and read the file
            file := FileOpen(A_LoopFileFullPath, "r")
            data := file.Read()
            PieceKey := StrSplit(matches[1], "-")
            PieceData := JSON.Load(data)
            configKey := PieceData["configKey"]

            ;;  load the piece if no configKey provided, or if configKey == true
            if ( PieceData["configKey"] == false || %configKey% == true ) {

                ;;  there is a bit of manual work here to process keys
                if ( PieceKey[1] == "ScreenshotRectangles" ) {

                    if ( StrLen(data) > 0 canLoad == true) {
                        ScreenshotRectangles[PieceData[2]] := PieceData["data"]
                    }

                } else if ( PieceKey[1] == "IgnoresDB" ) {

                    IgnoreList := ( PieceData["data"] ) ? PieceData["data"] : []

                }

            }

        }

    }

}

CheckRun() {

	global ROTMGProcessName
	WinGetTitle, WindowTitle, A
	FoundPos := RegExMatch(WindowTitle, "(Realm of the Mad God|Adobe Flash Player)")
	return ( FoundPos > 0 ) ? true : false

}

ForwardKey(key) {

	Suspend on
	Send, %key%
	Suspend off

}

TakeScreenshot() {

    global ScreenshotImageMode
    if ( ScreenshotImageMode == "direct" ) {

        Send, ^!{PrintScreen}

    } else if ( ScreenshotImageMode == "steam" ) {

        Send, {F12}

    }

    Return

}

ScreenShotGeneratePositions(Width, Height, Dimensions, Adjustments) {

    result := {}
    result["x"] := Round((Width*Dimensions["x"])+Adjustments["x"], 0)
    result["y"] := Round((Height*Dimensions["y"])+Adjustments["y"], 0)
    result["w"] := Round((Width*Dimensions["width"])+Adjustments["width"], 0)
    result["h"] := Round((Height*Dimensions["height"])+Adjustments["height"], 0)
    Return result

}

PanicCloseGame() {

    global ROTMGProcessName
    Run, taskkill "/f" "/im" "%ROTMGProcessName%"
    Return

}

isWindowFullScreen(WinID) {
    ;checks if the specified window is full screen
    ;use WinExist of another means to get the Unique ID (HWND) of the desired window

    if ( !WinID )
        return

    WinGet, style, Style, ahk_id %WinID%
    ; 0x800000 is WS_BORDER.
    ; 0x20000000 is WS_MINIMIZE.
    ; no border and not minimized
    retVal := (style & 0x20800000) ? 0 : 1
    Return, retVal
}