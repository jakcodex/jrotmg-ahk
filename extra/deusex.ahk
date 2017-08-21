;;;;  I needed to put this somewhere and I didn't want to setup a new project
;;  a simple ahk script for deus ex single player cheat codes
;;  complete console list here: http://deusex.wikia.com/wiki/Deus_Ex_console_commands
;;  consider this a bonus :)

;;  activate cheats
$Numpad1::
    WinGetTitle, WindowTitle, A
    if ( WindowTitle == "Deus Ex" ) {

        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}set DeusEx.JCDentonMale bCheatsEnabled true{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}god{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}allammo{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}allenergy{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}iamwarren{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}allskills{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}allcredits{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}allaugs{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}allhealth{Enter}

    }
    Return

;;  give all ammo
$Numpad2::
    WinGetTitle, WindowTitle, A
    if ( WindowTitle == "Deus Ex" ) {

        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}allammo{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}allenergy{Enter}
        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}allcredits{Enter}

    }
    Return

;;  prepare a spawnmass
$Numpad3::
    WinGetTitle, WindowTitle, A
    if ( WindowTitle == "Deus Ex" ) {

        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}spawnmass{Space}

    }
    Return

;;  toggle playersonly
$Numpad4::
    WinGetTitle, WindowTitle, A
    if ( WindowTitle == "Deus Ex" ) {

        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}playersonly{Enter}

    }
    Return

;;  toggle ghost
$Numpad5::
    WinGetTitle, WindowTitle, A
    if ( WindowTitle == "Deus Ex" ) {

        if ( !Ghost )
            Ghost := false

        if ( Ghost == false ) {

            Ghost := true
            SendInput t{Backspace}{Backspace}{Backspace}{Backspace}ghost{Enter}

        } else {

            Ghost := false
            SendInput t{Backspace}{Backspace}{Backspace}{Backspace}walk{Enter}

        }

    }
    Return

;;  opensesame
$Numpad6::
    WinGetTitle, WindowTitle, A
    if ( WindowTitle == "Deus Ex" ) {

        SendInput t{Backspace}{Backspace}{Backspace}{Backspace}opensesame{Enter}

    }
    Return

;;  allow user to set a custom command
^Numpad7::
WinGetTitle, WindowTitle, A
    if ( WindowTitle == "Deus Ex" ) {

        if ( !UserCustomInput )
            UserCustomInput := ""

        InputBox, UserCustomInput, Command, Custom command, , , , , , , 30, % UserCustomInput
        CustomInput := "t{Backspace}{Backspace}{Backspace}{Backspace}" . UserCustomInput . "{Enter}"

    }
    Return

;;  send custom input if provided
$Numpad8::
    WinGetTitle, WindowTitle, A
    if ( WindowTitle == "Deus Ex" ) {

        if ( CustomInput ) {
            SendInput % CustomInput
        }

    }
    Return