#Requires AutoHotkey v2.0
#Warn

/*
Distributed under the Unlicense <https://unlicense.org>
*/

#Include "Lib\CaseConformance.ahk"
#Include "Lib\HappyDay.ahk"

; Insert "happy <day_of_week>" with the trigger string "happyday" while replicating the standard case conformance
; functionality and preserving the end char.
:CX:HAPPYDAY:: SendHappyDay(X_CaseUpper)
:CX:Happyday:: SendHappyDay(X_CaseFirstUpper)
: X:happyday:: SendHappyDay(X_CaseLower)

SendHappyDay(OutputCase)
{
    SendText(GetHappyDay(OutputCase) A_EndChar)
}