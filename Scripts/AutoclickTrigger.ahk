#Requires AutoHotkey v2.0
#Warn

/*
Distributed under the Unlicense <https://unlicense.org>
*/

; Start autoclicking when Win+Alt+{mouse button} are clicked and held. Win+Alt may be released, but {mouse button} must
; be held to keep autoclicking. Release {mouse button} to stop autoclicking.
#!LButton:: AutoclickWithHold("LButton")
#!RButton:: AutoclickWithHold("RButton")
#!MButton:: AutoclickWithHold("MButton")

AutoclickWithHold(MouseButton)
{
    A_MenuMaskKey := "vkE8" ; Specific to Win and Alt modifiers
    SetKeyDelay(15, 5) ; defaults are 10, -1
    while GetKeyState(MouseButton, "P")
        SendEvent("{" MouseButton "}")
}

; Start autoclicking when Shift+Win+Alt+{mouse button} are clicked. Click {mouse button} again to stop autoclicking.
+#!LButton Up:: AutoclickWithoutHold("LButton")
+#!RButton Up:: AutoclickWithoutHold("RButton")
+#!MButton Up:: AutoclickWithoutHold("MButton")

AutoclickWithoutHold(MouseButton)
{
    A_MenuMaskKey := "vkE8" ; Specific to Win and Alt modifiers
    SetKeyDelay(15, 5) ; defaults are 10, -1
    while !GetKeyState(MouseButton, "P")
        SendEvent("{" MouseButton "}")
}