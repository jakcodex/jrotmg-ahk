;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  PixelState Map
;;;;;;;;;;;;;;;;;;;;;;;;;
PixelMap := {"settings": {}}
PixelMap.settings.ARGBTolerance := 135000
PixelMap.settings.RGBTolerance := 10

;;  hp bar positions
PixelState.PixelMapConfig("hp_100p", ["flash", "steam"], "fullscreen", 0.983, 0.426, 4292883508)
PixelState.PixelMapConfig("hp_75p", ["flash", "steam"], "fullscreen", 0.929, 0.426, 4292883508)
PixelState.PixelMapConfig("hp_50p", ["flash", "steam"], "fullscreen", 0.873, 0.426, 4292883508)
PixelState.PixelMapConfig("hp_25p", ["flash", "steam"], "fullscreen", 0.819, 0.426, 4292883508)
PixelState.PixelMapConfig("hp_0p", ["flash", "steam"], "fullscreen", 0.766, 0.426, 4292883508)

;;
;;  control points
;;  static points that are typically present

;;  chat box top line
PixelState.PixelMapConfig("chatbox_top1", ["flash", "steam"], "fullscreen", 0.000, 0.9667, 4294967295)
PixelState.PixelMapConfig("chatbox_top2", ["flash", "steam"], "fullscreen", 0.125, 0.9667, 4294967295)
PixelState.PixelMapConfig("chatbox_top3", ["flash", "steam"], "fullscreen", 0.250, 0.9667, 4294967295)
PixelState.PixelMapConfig("chatbox_top4", ["flash", "steam"], "fullscreen", 0.375, 0.9667, 4294967295)

;;  chat box bottom line
PixelState.PixelMapConfig("chatbox_bottom1", ["flash", "steam"], "fullscreen", 0.000, 0.9963, 4294967295)
PixelState.PixelMapConfig("chatbox_bottom2", ["flash", "steam"], "fullscreen", 0.125, 0.9963, 4294967295)
PixelState.PixelMapConfig("chatbox_bottom3", ["flash", "steam"], "fullscreen", 0.250, 0.9963, 4294967295)
PixelState.PixelMapConfig("chatbox_bottom4", ["flash", "steam"], "fullscreen", 0.375, 0.9963, 4294967295)

;;  chat box l/r sides
PixelState.PixelMapConfig("chatbox_side1", ["flash", "steam"], "fullscreen", 0.0000, 0.9731, 4294967295)
PixelState.PixelMapConfig("chatbox_side2", ["flash", "steam"], "fullscreen", 0.7474, 0.9731, 4294967295)

;;  chat box often obstructed pixels
PixelState.PixelMapConfig("chatbox_top6", ["flash", "steam"], "fullscreen", 0.700, 0.9667, 4294967295)

;;  vertical black border separating the game from right column
PixelState.PixelMapConfig("controlpoint75_1", ["flash", "steam"], "fullscreen", 0.7495, 0.100, 4278190081, 0, 0)
PixelState.PixelMapConfig("controlpoint75_2", ["flash", "steam"], "fullscreen", 0.7495, 0.250, 4278190081, 0, 0)
PixelState.PixelMapConfig("controlpoint75_3", ["flash", "steam"], "fullscreen", 0.7495, 0.400, 4278190081, 0, 0)
PixelState.PixelMapConfig("controlpoint75_4", ["flash", "steam"], "fullscreen", 0.7495, 0.550, 4278190081, 0, 0)
PixelState.PixelMapConfig("controlpoint75_5", ["flash", "steam"], "fullscreen", 0.7495, 0.700, 4278190081, 0, 0)
PixelState.PixelMapConfig("controlpoint75_6", ["flash", "steam"], "fullscreen", 0.7495, 0.850, 4278190081, 0, 0)
PixelState.PixelMapConfig("controlpoint75_7", ["flash", "steam"], "fullscreen", 0.7495, 0.950, 4278190081, 0, 0)

;;
;;  ui sprites
;;  pixels for various ui elements
;;

;;  account gold icon
PixelState.PixelMapConfig("account_gold1", ["flash", "steam"], "fullscreen", 0.7099, 0.0333, 4292141824)
PixelState.PixelMapConfig("account_gold2", ["flash", "steam"], "fullscreen", 0.7193, 0.0417, 4291483904)

;;  account fame icon
PixelState.PixelMapConfig("account_fame1", ["flash", "steam"], "fullscreen", 0.6302, 0.0278, 4292956928)
PixelState.PixelMapConfig("account_fame2", ["flash", "steam"], "fullscreen", 0.6458, 0.0241, 4294284032)

;;  account star icon
PixelState.PixelMapConfig("account_star1", ["flash", "steam"], "fullscreen", 0.0536, 0.0185, [4287207389, 4281355482, 4290782764, 4294349341, 4294967040, 4294967295])
PixelState.PixelMapConfig("account_star2", ["flash", "steam"], "fullscreen", 0.0474, 0.0278, [4287207389, 4281355482, 4290782764, 4294349341, 4294967040, 4294967295])
PixelState.PixelMapConfig("account_star3", ["flash", "steam"], "fullscreen", 0.0620, 0.0259, [4287207389, 4281355482, 4290782764, 4294349341, 4294967040, 4294967295])
PixelState.PixelMapConfig("account_star4", ["flash", "steam"], "fullscreen", 0.0484, 0.0389, [4287207389, 4281355482, 4290782764, 4294349341, 4294967040, 4294967295])
PixelState.PixelMapConfig("account_star5", ["flash", "steam"], "fullscreen", 0.0589, 0.0398, [4287207389, 4281355482, 4290782764, 4294349341, 4294967040, 4294967295])

;;  minimap zoon icons
PixelState.PixelMapConfig("minimap_top1", ["flash", "steam"], "fullscreen", 0.9771, 0.0287, [4286545791, 4294967295])
PixelState.PixelMapConfig("minimap_top2", ["flash", "steam"], "fullscreen", 0.9818, 0.0287, [4286545791, 4294967295])
PixelState.PixelMapConfig("minimap_top3", ["flash", "steam"], "fullscreen", 0.9802, 0.0241, [4286545791, 4294967295])

PixelState.PixelMapConfig("minimap_bottom1", ["flash", "steam"], "fullscreen", 0.9755, 0.0426, [4286545791, 4294967295])
PixelState.PixelMapConfig("minimap_bottom2", ["flash", "steam"], "fullscreen", 0.9818, 0.0444, [4286545791, 4294967295])
PixelState.PixelMapConfig("minimap_bottom3", ["flash", "steam"], "fullscreen", 0.9844, 0.0398, [4286545791, 4294967295])

;;  nexus ui icon
PixelState.PixelMapConfig("uinexusicon_1", ["flash", "steam"], "fullscreen", 0.9667, 0.3426, [4294704123, 4294629250], 20)
PixelState.PixelMapConfig("uinexusicon_2", ["flash", "steam"], "fullscreen", 0.9745, 0.3380, [4294704123, 4294629250], 20)
PixelState.PixelMapConfig("uinexusicon_3", ["flash", "steam"], "fullscreen", 0.9823, 0.3435, [4293783021, 4294629250], 20)
PixelState.PixelMapConfig("uinexusicon_4", ["flash", "steam"], "fullscreen", 0.9661, 0.3611, [4293783021, 4293708667], 20)
PixelState.PixelMapConfig("uinexusicon_5", ["flash", "steam"], "fullscreen", 0.9839, 0.3611, [4293783021, 4293708667], 20)
PixelState.PixelMapConfig("uinexusicon_6", ["flash", "steam"], "fullscreen", 0.9745, 0.3528, 4278650631)

;;  options ui icon
PixelState.PixelMapConfig("uioptionsicon_1", ["flash", "steam"], "fullscreen", 0.9656, 0.3444, [4294704123, 4293577080], 20)
PixelState.PixelMapConfig("uioptionsicon_2", ["flash", "steam"], "fullscreen", 0.9714, 0.3389, [4294704123, 4293773945], 20)
PixelState.PixelMapConfig("uioptionsicon_3", ["flash", "steam"], "fullscreen", 0.9719, 0.3472, [4294704123, 4294563458], 20)
PixelState.PixelMapConfig("uioptionsicon_4", ["flash", "steam"], "fullscreen", 0.9745, 0.3491, [4294704123, 4294498435], 20)
PixelState.PixelMapConfig("uioptionsicon_5", ["flash", "steam"], "fullscreen", 0.9776, 0.3537, [4294440951, 4294431874], 20)
PixelState.PixelMapConfig("uioptionsicon_6", ["flash", "steam"], "fullscreen", 0.9781, 0.3611, [4293914607, 4293840252], 20)
PixelState.PixelMapConfig("uioptionsicon_7", ["flash", "steam"], "fullscreen", 0.9828, 0.3537, [4294440951, 4294431872], 20)

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

;;  in-game control states
PixelGroups.controlpoint75_full := {"controlpoint75_1": true, "controlpoint75_2": true, "controlpoint75_3": true, "controlpoint75_4": true, "controlpoint75_5": true, "controlpoint75_6": true, "controlpoint75_7": true}

;;  various realm ui states
PixelGroups.AccountGold := {"account_gold1": true, "account_gold2": true}
PixelGroups.AccountFame := {"account_fame1": true, "account_fame2": true}
PixelGroups.AccountStar := {"account_star1": true, "account_star2": true, "account_star3": true, "account_star4": true, "account_star5": true}
PixelGroups.MinimapZoom := {"minimap_top1": true, "minimap_top2": true, "minimap_top3": true, "minimap_bottom1": true, "minimap_bottom2": true, "minimap_bottom3": true}
PixelGroups.UINexusButton := {"uinexusicon_1": true, "uinexusicon_2": true, "uinexusicon_3": true, "uinexusicon_4": true, "uinexusicon_5": true, "uinexusicon_6": true}
PixelGroups.UIOptionsButton := {"uioptionsicon_1": true, "uioptionsicon_2": true, "uioptionsicon_3": true, "uioptionsicon_4": true, "uioptionsicon_5": true, "uioptionsicon_6": true, "uioptionsicon_7": true}
PixelGroups.ChatBox := {"chatbox_top1": true, "chatbox_top2": true, "chatbox_top3": true, "chatbox_top4": true, "chatbox_bottom1": true, "chatbox_bottom2": true, "chatbox_bottom3": true, "chatbox_bottom4": true, "chatbox_side1": true}
PixelGroups.ChatBoxUnobstructed := {"chatbox_top1": true, "chatbox_top2": true, "chatbox_bottom1": true, "chatbox_bottom2": true, "chatbox_side1": true}
;; omg so many pixels -- everything above is mapped to fullscreen windows

PixelGroups.OptionsScreen := {"options_white1": true, "options_white2": true, "options_white3": true, "options_white4": true, "options_gray1": true, "options_gray2": true, "options_gray3": true}
PixelGroups.HomeVolume := {"home_volume1": true, "home_volume2": true, "home_volume3": true, "home_volume4": true, "home_volume5": true, "home_volume6": true}
PixelGroups.LoadingScreen := {"loading_black1": true, "loading_black2": true, "loading_black3": true, "loading_black4": true, "loading_black7": true, "loading_black6": true, "loading_black7": true}
PixelGroups.LoadingBar := {"loadingbar_gray1": true, "loadingbar_gray2": true, "loadingbar_gray3": true, "loadingbar_gray4": true, "loadingbar_white1": true, "loadingbar_white2": true, "loadingbar_white3": true}

;;  composite groups (a group of groups)
PixelGroups.InNexus := {"MinimapZoom": true, "AccountGold": true, "AccountFame": true, "AccountStar": true, "UIOptionsButton": true}
PixelGroups.InARealm := {"MinimapZoom": true, "AccountGold": true, "AccountFame": true, "UINexusButton": true}
PixelGroups.GreenScreen := {"HomeVolume": true, "LoadingBar": true, "AccountFame": false, "AccountGold": false}
PixelGroups.CharScreen := {"HomeVolume": true, "AccountStar": true, "AccountFame": true, "AccountGold": true}