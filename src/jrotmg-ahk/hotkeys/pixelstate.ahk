;;  PixelState labels
<^Numpad8::
    MsgBox % JSON.Dump(PixelState.GetPixelByName("hp_100p"))
    Return

<^Numpad7::
    PixelState.hotkeys.ScreenCalibrationRequest()
    Return

ScreenCalibrationRequest:
    PixelState.tools.GetScreenPosDataByClick()
    Return