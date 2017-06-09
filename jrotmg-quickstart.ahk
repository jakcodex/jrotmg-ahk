;;;;JROTMG Mini AHK Script
;;;;Jakisaurus
;;;;version=0.0.15-beta
;;;;Quick Start launcher
;;  User this launcher if you are not using the setup utility
;;  Appropriate for default program usage and users managing their installations

#Include, config.ahk
#Include, includes/staticvars.ahk
#Include, includes/bindings.ahk
#Include, includes/json.ahk
#Include, includes/gdi.ahk
#Include, includes/functions.ahk
#Include, includes/startup.ahk
#Include, includes/hotkeys.ahk
#Include, includes/devkeys.ahk
	
;;;;
;; additional credits
;;;;
;; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
;; https://autohotkey.com/board/topic/32267-crazy-scripting-screencapturetobmp-21l/
;;;;
;; Check window full screen code snip by Derrick 05/15/09
;; https://autohotkey.com/board/topic/38882-detect-fullscreen-application/
;;;;
;; JSON serializer by cocobelgica
;; https://github.com/cocobelgica/AutoHotkey-JSON