#Requires AutoHotkey v2.0
#Warn

/*
Distributed under the Unlicense <https://unlicense.org>
*/

#Include "Lib\HappyDay.ahk"

; Insert "happy <day_of_week>" with the trigger string "happyday", replicating the standard case conformance pattern.
:C:HAPPYDAY::
:C:Happyday::
: :happyday::
    {
        SendHappyDay(A_ThisHotkey)
    }
