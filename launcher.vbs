Option Explicit

Dim WshShell, objFSO, strScriptPath, strAppRoot, strHtmlPath, strAppUrl
Dim arrBrowsers, browserPath, selectedBrowser, cmdToRun, i
Dim strUserDataDir, strDefaultDir, strPrefsPath

Set WshShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

strScriptPath = objFSO.GetParentFolderName(WScript.ScriptFullName)

' Check if HTML files exist in same folder as script or in parent folder
If objFSO.FileExists(strScriptPath & "\아비캠뷰어_(AhBiCamViewer).html") Or objFSO.FileExists(strScriptPath & "\index.html") Then
    strAppRoot = strScriptPath
Else
    strAppRoot = objFSO.GetParentFolderName(strScriptPath)
End If

strHtmlPath = strAppRoot & "\index.html"
If objFSO.FileExists(strAppRoot & "\아비캠뷰어_(AhBiCamViewer).html") Then
    strHtmlPath = strAppRoot & "\아비캠뷰어_(AhBiCamViewer).html"
ElseIf objFSO.FileExists(strAppRoot & "\(AhBiYout)_공용_실물화상기_보기.html") Then
    strHtmlPath = strAppRoot & "\(AhBiYout)_공용_실물화상기_보기.html"
ElseIf objFSO.FileExists(strAppRoot & "\교실용_실물화상기.html") Then
    strHtmlPath = strAppRoot & "\교실용_실물화상기.html"
End If

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

' Write Preferences file to auto-allow camera & microphone for file:// URLs
If Not objFSO.FileExists(strPrefsPath) Then
    Dim objPrefs
    Set objPrefs = objFSO.CreateTextFile(strPrefsPath, True, False)
    objPrefs.Write "{""profile"":{""content_settings"":{""exceptions"":{" & _
        """media_stream_camera"":{""file://,*"":{""expiration"":""0"",""setting"":1}}," & _
        """media_stream_mic"":{""file://,*"":{""expiration"":""0"",""setting"":1}}" & _
        "}}}}"
    objPrefs.Close
    Set objPrefs = Nothing
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
    cmdToRun = """" & selectedBrowser & """ --app=""" & strAppUrl & """ --window-size=1280,800 --user-data-dir=""" & strUserDataDir & """ --use-fake-ui-for-media-stream --test-type"
    WshShell.Run cmdToRun, 1, False
Else
    ' Fallback to system default browser
    WshShell.Run """" & strHtmlPath & """", 1, False
End If
