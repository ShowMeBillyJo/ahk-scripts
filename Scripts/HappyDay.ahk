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
            SendHappyDay(A_ThisHotkey)
        }

This script uses A_ThisHotkey as a proxy for the value the user actually typed. The algorithm ignores the hotstring
options (everything up to and including the second colon (:)), ensuring it acts only on the matching trigger string
("HAPPYDAY", "Happyday", or "happyday"). Since the hotstrings "HAPPYDAY" and "Happyday" have case-sensitivity enabled
while "happyday" doesn't, this results in the two specific cases (X_CaseUpper and X_CaseFirstUpper) and the default case
(X_CaseLower) needed for case conformance.

If the Trigger parameter is unset or an empty string (""), the phrase is rendered in X_CaseLower.

Distributed under the Unlicense <https://unlicense.org>
*/

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

X_CaseUpper := "U"
X_CaseFirstUpper := "F"
X_CaseLower := "L"

DetectTypedCase(Trigger)
{
    ; Known issue: If Trigger contains non-alpha symbols, will always return X_CaseLower

    ; Trim options from the trigger, if present
    ; Required for compatibility with A_ThisHotkey workaround
    triggerString := TrimHotstringOptions(Trigger)

    ; Trim whitespace
    triggerString := Trim(triggerString)

    triggerLen := StrLen(triggerString)

    ; All caps
    if triggerLen >= 1 && IsUpper(triggerString)
        return X_CaseUpper

    ; Only first letter is capitalized
    if triggerLen >= 2 && IsUpper(SubStr(triggerString, 1, 1)) && IsLower(SubStr(triggerString, 2))
        return X_CaseFirstUpper

    ; All other "cases" ;)
    return X_CaseLower
}

TrimHotstringOptions(Trigger)
{
    triggerParts := StrSplit(Trigger, ":")
    return triggerParts.Length = 0 ? "" : triggerParts[triggerParts.Length]
}
