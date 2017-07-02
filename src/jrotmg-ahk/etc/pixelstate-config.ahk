;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  PixelState Map
;;;;;;;;;;;;;;;;;;;;;;;;;
PixelMap := {"settings": {}}
PixelMap.settings.ARGBTolerance := 135000
PixelMap.settings.RGBTolerance := 10

;;  hp bar positions
PixelState.PixelMapConfig(PixelMap, "hp_100p", "steam", "fullscreen", 0.983, 0.426, 4292883508)
PixelState.PixelMapConfig(PixelMap, "hp_75p", "steam", "fullscreen", 0.929, 0.426, 4292883508)
PixelState.PixelMapConfig(PixelMap, "hp_50p", "steam", "fullscreen", 0.873, 0.426, 4292883508)
PixelState.PixelMapConfig(PixelMap, "hp_25p", "steam", "fullscreen", 0.819, 0.426, 4292883508)
PixelState.PixelMapConfig(PixelMap, "hp_0p", "steam", "fullscreen", 0.767, 0.426, 4292883508)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  PixelState Groups
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PixelGroups := {}

;;  hp bar states
PixelGroups.HPBarRightExposed := {"hp_100p": true} ;; could be useful for identifying when the hp bar is obstructed
PixelGroups.HPBarFull := {"hp_100p": true, "hp_75p": true, "hp_50p": true, "hp_25p": true, "hp_0p": true}
PixelGroups.HPBar75 := {"hp_100p": false, "hp_75p": true, "hp_50p": true, "hp_25p": true, "hp_0p": true}
PixelGroups.HPBar50 := {"hp_100p": false, "hp_75p": false, "hp_50p": true, "hp_25p": true, "hp_0p": true}
PixelGroups.HPBar25 := {"hp_100p": false, "hp_75p": false, "hp_50p": false, "hp_25p": true, "hp_0p": true}
PixelGroups.HPBar0 := {"hp_100p": false, "hp_75p": false, "hp_50p": false, "hp_25p": false, "hp_0p": true}

;;  various realm ui states
PixelGroups.AccountGold := {"account_gold1": true, "account_gold2": true}
PixelGroups.AccountFame := {"account_fame1": true, "account_fame2": true}
PixelGroups.AccountStar := {"account_star1": true, "account_star2": true, "account_star3": true, "account_star4": true, "account_star5": true}
PixelGroups.MinimapZoom := {"minimap_upperpoint1": true, "minimap_upperpoint2": true, "minimap_lowerpoint1": true, "minimap_lowerpoint2": true, "minimap_lowerpoint3": true}
PixelGroups.UINexusButton := {"uinexusbutton_black1": true, "uinexusbutton_black2": true, "uinexusbutton_black3": true, "uinexusbutton_white1": true, "uinexusbutton_white2": true}
PixelGroups.UIOptionsButton := {"uioptionsbutton_white1": true, "uioptionsbutton_white2": true, "uioptionsbutton_white3": true, "uioptionsbutton_gray1": true, "uioptionsbutton_gray2": true}
PixelGroups.OptionsScreen := {"options_white1": true, "options_white2": true, "options_white3": true, "options_white4": true, "options_gray1": true, "options_gray2": true, "options_gray3": true}
PixelGroups.HomeVolume := {"home_volume1": true, "home_volume2": true, "home_volume3": true, "home_volume4": true, "home_volume5": true, "home_volume6": true}
PixelGroups.LoadingScreen := {"loading_black1": true, "loading_black2": true, "loading_black3": true, "loading_black4": true, "loading_black7": true, "loading_black6": true, "loading_black7": true}p
PixelGroups.LoadingBar := {"loadingbar_gray1": true, "loadingbar_gray2": true, "loadingbar_gray3": true, "loadingbar_gray4": true, "loadingbar_white1": true, "loadingbar_white2": true, "loadingbar_white3": true}

;;  composite groups (a group of groups)
PixelGroups.InNexus := {"MinimapZoom": true, "AccountGold": true, "AccountFame": true, "AccountStar": true, "UIOptionsButton": true}
PixelGroups.InARealm := {"MinimapZoom": true, "AccountGold": true, "AccountFame": true, "UINexusButton": true}
PixelGroups.GreenScreen := {"HomeVolume": true, "LoadingBar": true, "AccountFame": false, "AccountGold": false}
PixelGroups.CharScreen := {"HomeVolume": true, "AccountStar": true, "AccountFame": true, "AccountGold": true}