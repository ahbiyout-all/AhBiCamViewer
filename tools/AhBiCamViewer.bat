@echo off
setlocal
cd /d "%~dp0\.."

set "HTML_FILE=%~dp0..\index.html"

rem Normalize to forward slashes for file URI
set "FILE_URI=file:///%HTML_FILE:\=/%"

rem Prepare isolated user-data-dir with camera auto-allow preferences
set "USER_DATA_DIR=%LocalAppData%\AhBiCamViewer_AppProfile"
set "DEFAULT_DIR=%USER_DATA_DIR%\Default"
set "PREFS_FILE=%DEFAULT_DIR%\Preferences"

if not exist "%USER_DATA_DIR%" mkdir "%USER_DATA_DIR%"
if not exist "%DEFAULT_DIR%" mkdir "%DEFAULT_DIR%"

rem Write Preferences file to auto-allow camera, mic, and multi-monitor window management for file:// URLs
if not exist "%PREFS_FILE%" (
    > "%PREFS_FILE%" echo {"profile":{"content_settings":{"exceptions":{"media_stream_camera":{"file://,*":{"expiration":"0","setting":1}},"media_stream_mic":{"file://,*":{"expiration":"0","setting":1}},"window_management":{"file://,*":{"expiration":"0","setting":1}},"window_placement":{"file://,*":{"expiration":"0","setting":1}}}}}}
)

set "APP_FLAGS=--app="%FILE_URI%" --window-size=1280,800 --user-data-dir="%USER_DATA_DIR%" --use-fake-ui-for-media-stream --test-type --enable-features=WindowPlacement,WindowManagement"

rem Check for Microsoft Edge standalone app mode
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" %APP_FLAGS%
    exit /b 0
)
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" %APP_FLAGS%
    exit /b 0
)

rem Check for Google Chrome standalone app mode
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" %APP_FLAGS%
    exit /b 0
)
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" %APP_FLAGS%
    exit /b 0
)

rem Fallback via launcher.vbs
start "" "%~dp0launcher.vbs"
exit /b 0
