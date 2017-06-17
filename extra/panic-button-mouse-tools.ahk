;;;;
;;  JROTMG-AHK Mouse Panic Button Setup Utility
;;;;

;;  vars
User_ROTMGProcessNameSteam := false
User_ROTMGProcessNameFlash := false
GSubSubmit = SetupUtility.submit

;;  we'll be needing these
#Include ../src/common/gui/tools.ahk
#Include ../src/common/gui/guistaticvars.ahk
#Include ../src/common/lib/json.ahk
#Include ../src/common/tools/config-loader.ahk
#Include ../src/common/tools/fs.ahk

;;  sure - why not use a class
class SetupUtility {

    static programName := "Mouse Panic Button Setup Utility"
    static gsubSubmit := SetupUtility.submit

    main() {

        global GUIConfig, User_ROTMGProcessNameSteam, User_ROTMGProcessNameFlash, GUICallback

        CreateGUI("SetupUtilityMain", "Mouse Setup Utility")
        GUISetFont(GUIConfig["StyleH1"])
        GUIAddText(this.programName)

        GUISetFont(GUIConfig["StyleText"])
        GUIAddText("Welcome to the external panic button setup utility. `n`nEven if you don't use the AHK script, a mouse panic button is essential to survival in a world of lag and errors.", "+Wrap w600")

        GUISetFont(GUIConfig["StyleH2"])
        GUIAddText("Step One - Obtain ROTMG Process Name")

        GUISetFont(GUIConfig["StyleText"])
        GUIAddText("You may configure this for Steam, Flash, or both. `n`nOpen your ROTMG game and hit Ctrl+Alt+P. Record the value here.")
        GUISetFont("cBlack")
        GUIAddEdit("vUser_ROTMGProcessNameSteam w300", "Steam")
        GUIAddEdit("vUser_ROTMGProcessNameFlash w300", "Flash Projector")

        GUICallback := RegisterCallback("SetupUtility.submit")
        GUIAddButton("Generate Panic Program", "gGUISubmit Default")

        ShowGUI("SetupUtilityMain", 640, 440)

        Return

    }

    submit(a=false, b=false, c=false, d=false) {

        global GUIConfig, User_ROTMGProcessNameSteam, User_ROTMGProcessNameFlash, JSON

        ;;  prepare to write the file
        path = %APPDATA%\jrotmg-ahk
        PanicFileLocation := path . "\mouse-panic-button.bat"
        PanicFileContents := ""

        ;;  generate the file
        RowCount = 0
        for index, element in ["User_ROTMGProcessNameSteam", "User_ROTMGProcessNameFlash"] {

            if ( %element% != false && %element% != "Steam" && %element% != "Flash Projector" ) {
                PanicFileContents := PanicFileContents . "taskkill /f /im """ . %element% . """`n"
                RowCount++
            }

        }

        CreateGUI("SetupUtilitySubmit", "Mouse Setup Utility")

        GUISetFont(GUIConfig["StyleH1"])

        if ( PanicFileContents == "" ) {

            GUIAddText("Invalid Input Supplied")

            GUISetFont(GUIConfig["StyleText"])
            GUIAddText("The supplied input was not valid. `n`nYou must provide the process name of the running ROTMG game. `n`nPlease rerun this program.", "+Wrap w580")
            ShowGUI("SetupUtilitySubmit", 640, 195)

        } else {

            if ( filesystem.write(PanicFileLocation, PanicFileContents) ) {

                GUIAddText("Step Two - Setup Mouse Button")

                GUISetFont(GUIConfig["StyleText"])
                GUIAddText("In your mouse settings, pick your button of choice and set it to run a program. `n`nPoint it to this location:", "+Wrap w580")

                GUISetFont("cBlack")
                GUIAddEdit("w580", PanicFileLocation)

                GUISetFont(GUIConfig["StyleH3"] . " cWhite")
                GUIAddText("File contents")

                GUISetFont(GUIConfig["StyleText"] . " cBlack")
                GUIAddEdit("w580 r" . RowCount, PanicFileContents)

                HeightAdjustment := ( RowCount == 1 ) ? 0 : 25*(RowCount-1)
                ShowGUI("SetupUtilitySubmit", 640, 280+HeightAdjustment)

            } else {

                GUIAddText("Failed to Save File")

                GUISetFont(GUIConfig["StyleText"])
                GUIAddText("Could not save to `n`n" . PanicFileLocation)
                ShowGUI("SetupUtilitySubmit", 640, 125)

            }

        }

        return

    }

}

;;  run the program
SetupUtility.main()

;;  help users identify process names with a hotkey
^!p::
    WinGet, GameProcessName, ProcessName, A
    InputBox, vGameProcessName, Window Process Name, , , , 100, , , , , % GameProcessName
    Return

GuiClose:
GuiEscape:
ExitApp
