#Requires AutoHotkey v2.0
#Warn

/*
Distributed under the Unlicense <https://unlicense.org>
*/

; Autoclick if holding Win+Alt+[mouse button].

#!LButton:: Autoclick("LButton")

#!RButton:: Autoclick("RButton")

#!MButton:: Autoclick("MButton")

Autoclick(Button)
{
    A_MenuMaskKey := "vkE8"
    SetKeyDelay(15, 5) ; defaults are 10, -1
    while GetKeyState(Button, "P")
        SendEvent("{" Button "}")
}