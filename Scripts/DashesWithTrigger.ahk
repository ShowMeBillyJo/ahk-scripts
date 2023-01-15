#Requires AutoHotkey v2.0
#Warn

#Include "Dashes.ahk"

; Insert a dash on the hotstring sequence of two or more hyphens. If the end char is a hyphen (ie, three hyphens in a
; row), write an em dash, else an en dash
:?X:--::SendText((A_EndChar = "-") ? X_EmDash : X_EnDash)

; Insert an en dash upon pressing Alt+[hyphen].
!-::SendEnDash()

; Insert an em dash upon pressing Shift+Alt+[hyphen].
+!-::SendEmDash()
