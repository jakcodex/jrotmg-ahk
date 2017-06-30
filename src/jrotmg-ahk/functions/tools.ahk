InArray(needle, haystack) {

    for index, element in haystack {
        if ( element == needle ) {
            Return true
        }
    }
    Return false

}

ObjectCount(object) {

    value = 0
    for index, element in object {
        value++
    }
    Return value

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

ForwardKey(key) {

	Suspend on
	Send, %key%
	Suspend off

}