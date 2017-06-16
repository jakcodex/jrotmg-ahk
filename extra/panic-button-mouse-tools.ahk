;;;;
;;  JROTMG-AHK Mouse Panic Button Setup Utility
;;;;

;;  we'll be needing this
#Include ../src/common/gui/tools.ahk
#Include ../src/common/gui/guistaticvars.ahk

;;  sure - why not use a class
class SetupUtility {

    static programName := "Mouse Panic Button Setup Utility"

    main() {

        global GUIConfig
        CreateGUI("SetupUtilityMain", "Mouse Setup Utility", "+MinSize640x100 +MaxSize640x800 +Wrap +Resize")
        GUISetFont(GUIConfig["StyleH1"])
        GUIAddText(this.programName)

        GUISetFont(GUIConfig["StyleText"])
        GUIAddText("Welcome to the external panic button setup utility. Even if you don't use the AHK script, a mouse panic button is essential to survival in a world of lag and errors.")

        ShowGUI("SetupUtilityMain", "auto")

    }

}

;;  run the program
SetupUtility.main()