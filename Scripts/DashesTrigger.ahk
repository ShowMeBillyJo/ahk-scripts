#Requires AutoHotkey v2.0
#Warn

/*
Distributed under the Unlicense <https://unlicense.org>
*/

#Include "Lib\Dashes.ahk"

; Insert a dash on the hotstring sequence of two or more hyphens. If the end char is a hyphen (ie, three hyphens in a
; row), write an em dash, else an en dash.
:?X:--:: SendText((A_EndChar = "-") ? X_EmDash : X_EnDash)

; Insert an en dash upon pressing Alt+[hyphen].
!-:: SendText(X_EnDash)

; Insert an em dash upon pressing Shift+Alt+[hyphen].
+!-:: SendText(X_EmDash)