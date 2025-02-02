#Requires AutoHotkey v2.0
#Warn

/*
Send rapid-fire mouse clicks.

Distributed under the Unlicense <https://unlicense.org>
*/

Autoclick(MouseButton, WhileHeld := True)
{
    SetKeyDelay(15, 5) ; defaults are 10, -1
    while GetKeyState(MouseButton, "P") = WhileHeld
        SendEvent("{" MouseButton "}")
}