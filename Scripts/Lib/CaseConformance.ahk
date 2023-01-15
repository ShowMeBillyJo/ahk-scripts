#Requires AutoHotkey v2.0
#Warn

/*
Provide a base for replicating the standard hotstring case conformance pattern as closely as possible. For full
functionality, the hotstring trigger must be implemented in a pattern similar to the following:

    ; Insert "by the way" with the trigger string "btw", preserving the end char.
    :C:BTW::
    :C:Btw::
    : :btw::
        {
            ; Detect how the trigger string was typed
            typedCase := DetectTypedCase(A_ThisHotkey)

            ; Only capitalize "by" if the only capital letter in the trigger string was the first one
            greeting := (typedCase = X_CaseFirstUpper ? "B" : "b") "y the way" A_EndChar

            ; Convert the entire string to caps if the trigger string was itself all caps
            if typedCase = X_CaseUpper
                greeting := StrUpper(greeting)

            SendText(greeting)
        }

This library uses A_ThisHotkey as a proxy for the value the user actually typed. The algorithm ignores the hotstring
options (everything up to and including the second colon (:)), ensuring it acts only on the matching trigger string
("BTW", "Btw", or "btw"). Since the hotstrings "BTW" and "Btw" have case-sensitivity enabled while "btw" doesn't, this
results in the two specific cases (X_CaseUpper and X_CaseFirstUpper) and the default case (X_CaseLower) needed for case
conformance.

If the Trigger parameter is an empty string ("") after trimming, the phrase is rendered with X_CaseLower.

For more information about case conformance, see https://www.autohotkey.com/docs/v2/Hotstrings.htm#Options

Distributed under the Unlicense <https://unlicense.org>
*/

X_CaseUpper := "U"
X_CaseFirstUpper := "F"
X_CaseLower := "L"

DetectTypedCase(Trigger)
{
    ; Known issue from using IsUpper()/IsLower():
    ; If Trigger contains non-alpha symbols, will always return X_CaseLower

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
