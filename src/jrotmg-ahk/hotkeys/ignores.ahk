;;;;  display the contents of the saved ignore list
$^!t::

	if ( CheckRun() == true ) {

		users = ;
		for index, element in IgnoreList {
			users .= element . ", "
		}

		users := SubStr(users, 1, StrLen(users)-2)
		MsgBox % ( StrLen(users) == 0 ) ? "Ignored users: None" : "Ignored users: " . users

	} else {

		Send, ^!t

	}

	Return

;;;;  ignore the most recent user to send a pm
$^+v::

	if ( CheckRun() == true ) {

		;;;;get the most recent tell data
		Suspend On
		clipboard =  ;
		SendInput {Tab}
		SendInput ^a
		SendInput ^x
		ClipWait, 2
		Suspend Off

		;;;;identify the username
		FoundPos := RegExMatch(clipboard, "O)/tell ([a-zA-Z]+)", ignoreUser)
		if ( FoundPos > 0 && InArray(ignoreUser.1, IgnoreList) == false ) {

			;;;;ignore the user
			Suspend On
			SendInput % "/ignore " . ignoreUser.1
			SendInput {Enter}
			Suspend Off

			;;;;update ignorelist
			IgnoreList.Insert(ignoreUser.1)
			SaveConfigPiece("IgnoresDB", IgnoreList, false, "IgnoreList")

		} else {

            if ( FoundPos == 0 ) {
                SendInput, No users found
            }

            if ( FoundPos > 0 ) {
                SendInput, User already on ignores list
            }

		    Sleep 500
		    SendInput ^a
		    SendInput {Backspace}
		    SendInput {Enter}

		}

	} else {

		Send, ^+v

	}

	Return

;;;;  unignore the most recently ignored user
$^+z::
	if ( CheckRun() == true ) {

		if ( IgnoreList.MaxIndex() >= 0 ) {

			SendString := "/unignore " + IgnoreList[IgnoreList.MaxIndex()]
			clipboard = %SendString%
			SendInput {Enter}
			SendInput ^v
			SendInput {Enter}
			IgnoreList.remove(IgnoreList.MaxIndex())
			SaveConfigPiece("IgnoresDB", IgnoreList, false, "IgnoreList")

		} else {

            SendInput {Enter}
            SendInput, No users found
            Sleep 500
            SendInput ^a
            SendInput {Backspace}
            SendInput {Enter}

        }

	} else {

		Send, ^+z

	}

	Return