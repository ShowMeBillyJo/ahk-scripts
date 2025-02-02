#Requires AutoHotkey v2.0
#Warn

/*
Distributed under the Unlicense <https://unlicense.org>
*/

#Include "Lib\Autoclick.ahk"

; Start autoclicking when Win+Alt+{mouse button} are clicked and held. Win+Alt may be released, but {mouse button} must
; be held to keep autoclicking. Release {mouse button} to stop autoclicking.
#!LButton:: AutoclickWithHold("LButton")
#!RButton:: AutoclickWithHold("RButton")
#!MButton:: AutoclickWithHold("MButton")

AutoclickWithHold(MouseButton)
{
    A_MenuMaskKey := "vkE8" ; Specific to Win and Alt modifiers
    Autoclick(MouseButton)
}

; Start autoclicking when Shift+Win+Alt+{mouse button} are clicked. Click {mouse button} again to stop autoclicking.
+#!LButton Up:: AutoclickWithoutHold("LButton")
+#!RButton Up:: AutoclickWithoutHold("RButton")
+#!MButton Up:: AutoclickWithoutHold("MButton")

AutoclickWithoutHold(MouseButton)
{
    A_MenuMaskKey := "vkE8" ; Specific to Win and Alt modifiers
    Autoclick(MouseButton, False)
}