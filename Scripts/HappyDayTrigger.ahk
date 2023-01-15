#Requires AutoHotkey v2.0
#Warn

#Include "HappyDay.ahk"

; Insert "happy <day_of_week>" with the trigger string "happyday", replicating the standard case conformance pattern.
:C:HAPPYDAY::
:C:Happyday::
: :happyday::
    {
        SendHappyDay(A_ThisHotkey)
    }
