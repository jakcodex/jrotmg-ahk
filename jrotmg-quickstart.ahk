;;;;JROTMG Mini AHK Script
;;;;Jakisaurus
;;;;version=0.0.15-alpha
;;;;Quick Start launcher
;;  User this launcher if you are not using the setup utility
;;  Appropriate for default program usage and users managing their installations

#Include, config.ahk
#Include, src/jrotmg-ahk/staticvars.ahk
#Include, src/jrotmg-ahk/bindings.ahk
#Include, src/jrotmg-ahk/json.ahk
#Include, src/jrotmg-ahk/gdi.ahk
#Include, src/jrotmg-ahk/functions.ahk
#Include, src/jrotmg-ahk/startup.ahk
#Include, src/jrotmg-ahk/hotkeys.ahk
#Include, src/jrotmg-ahk/devkeys.ahk
	
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