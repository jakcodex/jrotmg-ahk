;;  save configuration variable to disk in json format
SaveConfigPiece(piece, data, configEnableKey=false, programKey=false) {

    global ConfigPiecesFolder, JSON

    ;;  these might just simply be empty
    if ( configEnableKey == "" ) {
       configEnableKey := false
    }

    if ( programKey == "" ) {
        programKey := false
    }

    ;;  construct the object we're going to save
    object := {"data": data, "defaultValue": false}
    object["configKey"] := configEnableKey

    if ( programKey != false ) {
        object["programKey"] := programKey
    }

    ;;  convert to json and write the file
    jdata := JSON.Dump(object)
    file := FileOpen(ConfigPiecesFolder . "\" . piece . ".json", "w")
    file.Write(jdata)
    file.Close()
    Return

}

;;  load configuration variable from json on disk
LoadConfigPieces(piece=false) {

    global ConfigPiecesFolder, JSON, ScreenshotRectangles, IgnoreList
    if ( piece == false ) {
        piece := "*"
    }
    Loop Files, % ConfigPiecesFolder . "\" . piece . ".json"
    {

        ;;  all files take the form key-subkey-filter.json
        if ( RegExMatch(A_LoopFileFullPath, "O)([a-zA-Z0-9-]+).json$", matches) ) {

            ;;  open and read the file
            file := FileOpen(A_LoopFileFullPath, "r")
            data := file.Read()
            PieceKey := StrSplit(matches[1], "-")
            PieceData := JSON.Load(data)
            configKey := PieceData["configKey"]
            programKey := PieceData["programKey"]

            ;;  load the piece if no configKey provided, or if configKey == true
            if ( PieceData["configKey"] == false || %configKey% == true ) {

                ;;  there is a bit of manual work here to process keys
                if ( PieceKey[1] == "ScreenshotRectangles" ) {

                    if ( StrLen(data) > 0 ) {
                        ScreenshotRectangles[PieceData[2]] := PieceData["data"]
                    }

                ;;  some configs include instructions for building them within the system
                } else {

                    if ( %programKey% && PieceData["data"] ) {

                        %programKey% := PieceData["data"]

                    }

                }

            }

        }

    }

}