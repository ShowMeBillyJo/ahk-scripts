#Requires AutoHotkey v2.0
#Warn

/*
Helpers for disambiguating en and em dashes, eg in fixed-width fonts.
*/

X_EnDash := "–"
X_EmDash := "—"

SendEnDash()
{
    SendText(X_EnDash)
}

SendEmDash()
{
    SendText(X_EmDash)
}
