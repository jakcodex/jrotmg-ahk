#Include config.ahk
#Include src/jrotmg-ahk/etc/staticvars.ahk
#Include src/jrotmg-ahk/etc/bindings.ahk
#Include src/jrotmg-ahk/functions.ahk
#Include src/common/gui/tools.ahk
#Include src/jrotmg-ahk/etc/startup.ahk
#Include src/jrotmg-ahk/classes.ahk
#Include src/jrotmg-ahk/etc/pixelstate-config.ahk
SetTimer, PixelStateBackgroundTasks, % Round(PixelStateTasksFrequency*1000)
#Include src/jrotmg-ahk/hotkeys.ahk