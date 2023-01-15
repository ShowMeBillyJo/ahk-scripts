#Requires AutoHotkey v2.0
#Warn

/*
Center a window on its monitor following the parameter conventions of the built-in Win functions.

For information about WinTitle and related parameters, see https://www.autohotkey.com/docs/v2/misc/WinTitle.htm

Adapted from https://www.autohotkey.com/boards/viewtopic.php?p=78862#p78862
*/

WinMoveToCenterOnCurrentMonitor(WinTitle?, WinText?, ExcludeTitle?, ExcludeText?)
{
    ; Get a window handle using the specified parameters, then get its current width/height
    windowHandle := WinExist(WinTitle?, WinText?, ExcludeTitle?, ExcludeText?)
    WinGetPos( , , &windowWidth, &windowHeight)

    ; Get info about the monitor the window is on
    monitorHandle := DllCall("MonitorFromWindow", "Ptr", windowHandle, "UInt", 0x2)
    monitorInfo := Buffer(40), NumPut("Int", 40, monitorInfo)
    DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", monitorInfo)

    ; Read out the monitor's work surface
    monitorWorkLeft := NumGet(monitorInfo, 20, "Int")
    monitorWorkTop := NumGet(monitorInfo, 24, "Int")
    monitorWorkRight := NumGet(monitorInfo, 28, "Int")
    monitorWorkBottom := NumGet(monitorInfo, 32, "Int")

    ; Calculate the target X/Y coordinates, then move the window
    targetX := monitorWorkLeft + (monitorWorkRight - monitorWorkLeft) // 2 - windowWidth // 2
    targetY := monitorWorkTop + (monitorWorkBottom - monitorWorkTop) // 2 - windowHeight // 2
    WinMove(targetX, targetY, ,)
}
