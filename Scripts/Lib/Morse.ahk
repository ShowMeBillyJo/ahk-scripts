#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn

/*
Morse Function (To detect single, double, triple or ... , short or long press)

Set patternSequence to 3 or even 2 for better performance. However, this will decrease the number of patterns detected.

Adapted from https://stackoverflow.com/a/77838645/3447
Reproduced under fair use. No rights reserved.

Distributed under the Unlicense <https://unlicense.org>
*/

Morse(Timeout := 200, PatternSequence := 10)
{
    global Pattern := ""
    Win := WinExist("A")
    RegExMatch(Hotkey := A_ThisHotkey, "\W$|\w*$", &Key)
    IsModifier := InStr(Hotkey, "Control") or InStr(Hotkey, "Alt") Or InStr(Hotkey, "Shift") Or InStr(Hotkey, "Win")
    CoordMode("Mouse", "Screen")
    MouseGetPos(&X1, &Y1, &Win1)
    Counter := 0

    loop (PatternSequence)
    {
        ; Disabling Alt menu acceleration / Windows Start menu
        if InStr(Hotkey, "Alt") Or InStr(Hotkey, "Win") ; Comment second condition if you need WIN key to open the start menu.
            Send("{Blind}{vkE8}")

        T := A_TickCount
        ErrorLevel := !KeyWait(Key[0])
        Pattern .= A_TickCount - T > Timeout
        MouseGetPos(&X2, &Y2, &Win2)

        ; Skipping the operation for modifiers, if another key is pressed or mouse is moved.
        if (IsModifier) And (((Win Key[0] Hotkey Win1) != (WinExist("A") A_PriorKey A_ThisHotkey Win2)) Or (30 < (X2 - X1) ** 2 + (Y2 - Y1) ** 2))
            Exit()

        ; Skipping the last KeyWait to improve speed!
        Counter += 1
        if (Counter = PatternSequence)
            return Pattern

        ; Waiting for the next key sequence to be pressed
        ErrorLevel := !KeyWait(Key[0], "DT" Timeout / 1500)
        if ErrorLevel
            return Pattern
    }
}