#Requires AutoHotkey v2.0
#Warn

/*
Patterns and helpers for replicating the standard hotstring case conformance experience as closely as possible. For more
information about case conformance, see https://www.autohotkey.com/docs/v2/Hotstrings.htm#Options

For complete functionality, the hotstrings should be implemented similarly to one of the following patterns. In these
examples, the trigger string "btw" will result in the output string "by the way, <username>".

    ;
    ; Pattern 1: Execute the hotstrings individually, and explicitly specify the output case for each.
    ;
    :CX:BTW:: SendBtw(X_CaseUpper)
    :CX:Btw:: SendBtw(X_CaseFirstUpper)
    : X:btw:: SendBtw(X_CaseLower)

    SendBtw(OutputCase)
    {
        ; TODO Convert the output string to the desired case
        s := "by the way, " A_UserName

        SendText(s A_EndChar)
    }

    ;
    ; Pattern 2: Stack the hotstrings, and use the detected case of ThisHotkey for the output conversion.
    ;
    :C:BTW::
    :C:Btw::
    : :btw::
    {
        ; Detect how the trigger string was typed
        typedCase := DetectTypedCase(TrimHotstringOptions(ThisHotkey))

        ; TODO Convert the output string to the desired case
        s := "by the way, " A_UserName

        SendText(s A_EndChar)
    }

Since the hotstrings "BTW" and "Btw" have case-sensitivity enabled while "btw" doesn't, this results in the two specific
cases (X_CaseUpper and X_CaseFirstUpper) and the default case (X_CaseLower) needed for case conformance.

Case conversion can be done using the StrToCase() helper function or a bespoke algorithm. StrToCase() may be more
readable, whereas bespoke algorithms can be more efficient and flexible. To address the TODOs above, a pattern such as
one of the following can be used:

    ;
    ; Pattern 1: Use the StrToCase() helper function to convert an output string to the desired case.
    ;
    {
        ; ...

        ; TODO Convert the output string to the desired case
        s := StrToCase("by the way, " A_UserName, OutputCase)

        ; ...
    }

    ;
    ; Pattern 2: Use a bespoke algorithm to convert an output string to the desired case.
    ;
    {
        ; ...

        ; TODO Convert the output string to the desired case
        s := (OutputCase = X_CaseFirstUpper ? "B" : "b") "y the way, " A_UserName
        if OutputCase = X_CaseUpper
            s := StrUpper(s)

        ; ...
    }

Distributed under the Unlicense <https://unlicense.org>
*/

/*
Constant values representing the typed case of a string.
*/
X_CaseUpper := "U"
X_CaseFirstUpper := "F"
X_CaseLower := "L"

/*
Attempts to detect the typed case of a string. It returns one of 3 constant values: X_CaseUpper, X_CaseFirstUpper, and
X_CaseLower (default).

Known issue from using IsUpper()/IsLower(): If String contains non-alpha symbols, will always return X_CaseLower.
*/
DetectTypedCase(String)
{
    ; Trim whitespace
    s := Trim(String)

    sLen := StrLen(s)

    ; All caps
    if sLen >= 1 && IsUpper(s)
        return X_CaseUpper

    ; Only first letter is capitalized
    if sLen >= 2 && IsUpper(SubStr(s, 1, 1)) && IsLower(SubStr(s, 2))
        return X_CaseFirstUpper

    ; All other "cases" ;) including empty string ("")
    return X_CaseLower
}

/*
Trim hotstring options from a string. Options are everything up to and including the second preceding colon (:).
*/
TrimHotstringOptions(Hotstring)
{
    hsParts := StrSplit(Hotstring, ":")
    return hsParts.Length = 0 ? "" : hsParts[hsParts.Length]
}

/*
Convert the string to a specific case. OutputCase should be one of the X_Case* constants. If OutputCase is X_CaseUpper,
the entire string will be converted to uppercase. If OutputCase is X_CaseFirstUpper, only the first letter will be
converted to uppercase and the rest of the string will be converted to lowercase. Otherwise, the entire string will be
converted to lowercase.
*/
StrToCase(String, OutputCase)
{
    sLen := StrLen(String)

    ; If there's nothing to convert, just short-circuit the rest of the function
    if sLen = 0
        return ""

    ; When case is FirstUpper and length is 1, it's the same as converting the whole string to Upper
    if OutputCase = X_CaseUpper or (OutputCase = X_CaseFirstUpper and sLen = 1)
        return StrUpper(String)

    if OutputCase = X_CaseFirstUpper
        ; Length will always be > 1 here because of the other FirstUpper check above
        return StrUpper(SubStr(String, 1, 1)) StrLower(SubStr(String, 2))

    return StrLower(String)
}