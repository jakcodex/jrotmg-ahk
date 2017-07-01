;;  PixelState labels
<^Numpad4::
    MsgBox % PixelState.GetPixelGroupState("HPBarFull")
    Return

<^Numpad9::
    pBitmap := PixelState.GetBitmap()
    MsgBox % "100: " . PixelState.GetPixelState("hp_100p") . "`n75: " . PixelState.GetPixelState("hp_75p") . "`n50: " . PixelState.GetPixelState("hp_50p") . "`n25: " . PixelState.GetPixelState("hp_25p") . "`n0: " . PixelState.GetPixelState("hp_0p")
    Gdip_DisposeImage(pBitmap)
    Return

<^Numpad8::
    pBitmap := PixelState.GetBitmap()
    p100 := PixelState.GetPixelByName("hp_100p", pBitmap)
    p75 := PixelState.GetPixelByName("hp_75p", pBitmap)
    p50 := PixelState.GetPixelByName("hp_50p", pBitmap)
    p25 := PixelState.GetPixelByName("hp_25p", pBitmap)
    p0 := PixelState.GetPixelByName("hp_0p", pBitmap)
    PixelState.Logging("PixelState/hp_test", JSON.Dump(p100))
    PixelState.Logging("PixelState/hp_test", JSON.Dump(p75))
    PixelState.Logging("PixelState/hp_test", JSON.Dump(p50))
    PixelState.Logging("PixelState/hp_test", JSON.Dump(p25))
    PixelState.Logging("PixelState/hp_test", JSON.Dump(p0))
    PixelState.SaveImage(pBitmap)
    Gdip_DisposeImage(pBitmap)
    Return

<^Numpad7::
    PixelState.hotkeys.ScreenCalibrationRequest()
    Return

ScreenCalibrationRequest:
    PixelState.tools.GetScreenPosDataByClick()
    Return