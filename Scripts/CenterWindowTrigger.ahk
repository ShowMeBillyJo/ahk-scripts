#Requires AutoHotkey v2.0
#Warn

/*
Distributed under the Unlicense <https://unlicense.org>
*/

#Include "Lib\CenterWindow.ahk"

; Center the active window on its monitor upon pressing Win+Alt+Up. Use the built-in shortcuts Win+Shift+L and
; Win+Shift+R to move the window between monitors.
#!Up:: WinMoveToCenterOnCurrentMonitor("A")