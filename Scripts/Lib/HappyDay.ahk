#Requires AutoHotkey v2.0
#Warn

/*
Output the phrase "happy <day_of_week>", with options for replicating the standard case conformance pattern as closely
as possible. For more information about this implementation of case conformance, see CaseConformance.ahk

Distributed under the Unlicense <https://unlicense.org>
*/

#Include "CaseConformance.ahk"

GetHappyDay(OutputCase)
{
    ; By default, the phrase will be returned in all lowercase
    ; Only capitalize "happy" if the case conformance is FirstUpper
    greeting := (OutputCase = X_CaseFirstUpper ? "H" : "h") "appy " A_DDDD

    ; Convert the entire string to caps if the case conformance is Upper
    if OutputCase = X_CaseUpper
        greeting := StrUpper(greeting)

    return greeting
}