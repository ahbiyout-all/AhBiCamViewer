Option Explicit

Dim WshShell, objFSO, strScriptPath, strAppRoot, strHtmlPath, strAppUrl
Dim arrBrowsers, browserPath, selectedBrowser, cmdToRun, i
Dim strUserDataDir, strDefaultDir, strPrefsPath

Set WshShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

strScriptPath = objFSO.GetParentFolderName(WScript.ScriptFullName)

' Check if index.html exists in same folder as script or in parent folder
If objFSO.FileExists(strScriptPath & "\index.html") Then
    strAppRoot = strScriptPath
Else
    strAppRoot = objFSO.GetParentFolderName(strScriptPath)
End If

strHtmlPath = strAppRoot & "\index.html"

' Convert Windows file path to file:/// URL format
strAppUrl = "file:///" & Replace(strHtmlPath, "\", "/")

' ---------------------------------------------------------------
' Prepare isolated user-data-dir with camera auto-allow preferences
' This replaces the deprecated --use-fake-ui-for-media-stream flag
' ---------------------------------------------------------------
strUserDataDir = WshShell.ExpandEnvironmentStrings("%LocalAppData%") & "\AhBiCamViewer_AppProfile"
strDefaultDir = strUserDataDir & "\Default"
strPrefsPath = strDefaultDir & "\Preferences"

' Create user-data-dir and Default profile folder if they don't exist
If Not objFSO.FolderExists(strUserDataDir) Then objFSO.CreateFolder(strUserDataDir)
If Not objFSO.FolderExists(strDefaultDir) Then objFSO.CreateFolder(strDefaultDir)

' Write Preferences file to auto-allow camera, microphone & multi-monitor window management for file:// URLs
Dim objPrefs, strPrefsJson
strPrefsJson = "{""profile"":{""content_settings"":{""exceptions"":{" & _
    """media_stream_camera"":{""file://,*"":{""expiration"":""0"",""setting"":1}}," & _
    """media_stream_mic"":{""file://,*"":{""expiration"":""0"",""setting"":1}}," & _
    """window_management"":{""file://,*"":{""expiration"":""0"",""setting"":1}}," & _
    """window_placement"":{""file://,*"":{""expiration"":""0"",""setting"":1}}" & _
    "}}}}"

If Not objFSO.FileExists(strPrefsPath) Then
    Set objPrefs = objFSO.CreateTextFile(strPrefsPath, True, False)
    objPrefs.Write strPrefsJson
    objPrefs.Close
    Set objPrefs = Nothing
Else
    ' Update Preferences if window_management is missing
    Dim objPrefsRead, existingContent
    Set objPrefsRead = objFSO.OpenTextFile(strPrefsPath, 1, False)
    existingContent = objPrefsRead.ReadAll
    objPrefsRead.Close
    Set objPrefsRead = Nothing
    If InStr(existingContent, "window_management") = 0 Then
        Set objPrefs = objFSO.CreateTextFile(strPrefsPath, True, False)
        objPrefs.Write strPrefsJson
        objPrefs.Close
        Set objPrefs = Nothing
    End If
End If

' Priority list for Chromium-based browsers supporting standalone --app mode
arrBrowsers = Array( _
    WshShell.ExpandEnvironmentStrings("%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"), _
    WshShell.ExpandEnvironmentStrings("%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"), _
    WshShell.ExpandEnvironmentStrings("%LocalAppData%\Microsoft\Edge\Application\msedge.exe"), _
    WshShell.ExpandEnvironmentStrings("%ProgramFiles%\Google\Chrome\Application\chrome.exe"), _
    WshShell.ExpandEnvironmentStrings("%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"), _
    WshShell.ExpandEnvironmentStrings("%LocalAppData%\Google\Chrome\Application\chrome.exe") _
)

selectedBrowser = ""
For i = 0 To UBound(arrBrowsers)
    browserPath = arrBrowsers(i)
    If objFSO.FileExists(browserPath) Then
        selectedBrowser = browserPath
        Exit For
    End If
Next

If selectedBrowser <> "" Then
    ' Launch as standalone chromeless desktop app window with isolated profile (camera pre-allowed)
    ' --use-fake-ui-for-media-stream auto-approves permission; --test-type suppresses unsupported flag infobar
    cmdToRun = """" & selectedBrowser & """ --app=""" & strAppUrl & """ --window-size=1280,800 --user-data-dir=""" & strUserDataDir & """ --use-fake-ui-for-media-stream --enable-features=WindowPlacement,WindowManagement --test-type"
    WshShell.Run cmdToRun, 1, False
Else
    ' Fallback to system default browser
    WshShell.Run """" & strHtmlPath & """", 1, False
End If
