#Requires AutoHotkey v2.0
#Warn

/*
Output the phrase "happy <day_of_week>", replicating the standard case conformance pattern as closely as possible. For
full functionality, the hotstring trigger must be implemented in a pattern similar to the following:

    ; Insert "happy <day_of_week>" with the trigger string "happyday".
    :C:HAPPYDAY::
    :C:Happyday::
    : :happyday::
    {
        SendHappyDay(ThisHotkey)
    }

For more information about this implementation of case conformance, see CaseConformance.ahk

Distributed under the Unlicense <https://unlicense.org>
*/

#Include "CaseConformance.ahk"

SendHappyDay(Trigger?)
{
    SendText(HappyDay(Trigger?))
}

HappyDay(Trigger := "")
{
    ; Detect how the trigger string was typed
    typedCase := DetectTypedCase(Trigger)

    ; Only capitalize "happy" if the only capital letter in the trigger string was the first one
    greeting := (typedCase = X_CaseFirstUpper ? "H" : "h") "appy " A_DDDD A_EndChar

    ; Convert the entire string to caps if the trigger string was itself all caps
    if typedCase = X_CaseUpper
        greeting := StrUpper(greeting)

    return greeting
}