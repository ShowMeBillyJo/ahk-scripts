#Requires AutoHotkey v2.0
#Warn

/*
Distributed under the Unlicense <https://unlicense.org>
*/

#Include "Lib\CaseConformance.ahk"
#Include "Lib\HappyDay.ahk"

; Insert "happy <day_of_week>" with the trigger string "happyday" while replicating the standard case conformance
; functionality.
:C:HAPPYDAY::
:C:Happyday::
: :happyday::
{
    ; Detect how the trigger string was typed
    typedCase := DetectTypedCase(ThisHotkey)
    SendText(GetHappyDay(typedCase) A_EndChar)
}