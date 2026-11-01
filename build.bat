@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

title Classroom Visualizer Build Automation Pipeline

echo ============================================================
echo [BUILD] Classroom Visualizer Build Pipeline
echo ============================================================

cd /d "%~dp0"

REM ------------------------------------------------------------
REM Step 1: Read Semantic Version from version.json
REM ------------------------------------------------------------
set "APP_VERSION="
for /f "tokens=2 delims=:, " %%A in ('findstr /i "\"version\"" version.json') do (
    set "APP_VERSION=%%~A"
)

if "%APP_VERSION%"=="" (
    echo [ERROR] Could not parse version from version.json! Falling back to 1.3.1
    set "APP_VERSION=1.3.1"
)

echo [*] Target Semantic Version: v%APP_VERSION%

REM ------------------------------------------------------------
REM Step 2: Prepare Output Directories and Compile DLLs
REM ------------------------------------------------------------
if not exist "dist" mkdir "dist"
if not exist "dist\%APP_VERSION%" mkdir "dist\%APP_VERSION%"

if exist "tools\build_dll.bat" (
    call "tools\build_dll.bat"
    if errorlevel 1 goto BUILD_FAILED
)

REM ------------------------------------------------------------
REM Step 3: Locate Inno Setup Compiler (ISCC.exe)
REM ------------------------------------------------------------
set "ISCC_PATH="
if exist "%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe" set "ISCC_PATH=%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe"
if not defined ISCC_PATH if exist "%ProgramFiles%\Inno Setup 6\ISCC.exe" set "ISCC_PATH=%ProgramFiles%\Inno Setup 6\ISCC.exe"
if not defined ISCC_PATH for %%X in (ISCC.exe) do set "ISCC_PATH=%%~$PATH:X"

if not defined ISCC_PATH goto NO_ISCC

echo [*] Found Inno Setup Compiler: "%ISCC_PATH%"
echo [*] Compiling Windows Setup Installer...

"!ISCC_PATH!" /DMyAppVersion="%APP_VERSION%" "installer.iss"
if errorlevel 1 goto BUILD_FAILED

echo [*] Inno Setup compilation completed successfully.

REM Verify installer output
set "FOUND_INSTALLER="
for %%F in ("dist\*_Setup_v%APP_VERSION%.exe") do (
    set "FOUND_INSTALLER=1"
    echo [*] Verified primary installer: %%~nxF
    copy /y "%%~fF" "dist\%APP_VERSION%\" >nul
    echo [*] Copied installer to version folder: dist\%APP_VERSION%\
)
if not defined FOUND_INSTALLER (
    echo [WARNING] Expected installer matching dist\*_Setup_v%APP_VERSION%.exe not found!
)

goto CREATE_PORTABLE

:NO_ISCC
echo [WARNING] Inno Setup Compiler ISCC.exe not found on this machine.
echo [INFO] Skipping Inno Setup installer compilation.

:CREATE_PORTABLE
REM ------------------------------------------------------------
REM Step 4: Create Cross-Platform Portable ZIP Package
REM ------------------------------------------------------------
echo [*] Building Portable ZIP Package...
set "PORTABLE_ZIP=dist\AhBiCamViewer_Portable_v%APP_VERSION%.zip"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Compress-Archive -Path 'index.html', '아비캠뷰어_(AhBiCamViewer).html', '(AhBiYout)_공용_실물화상기_보기.html', '교실용_실물화상기.html', 'launcher.vbs', 'version.json', 'assets', 'docs', 'tools', 'bin' -DestinationPath '%PORTABLE_ZIP%' -Force"

if exist "%PORTABLE_ZIP%" (
    echo [*] Verified portable package: %PORTABLE_ZIP%
    copy /y "%PORTABLE_ZIP%" "dist\%APP_VERSION%\" >nul
    echo [*] Copied portable package to version folder: dist\%APP_VERSION%\
) else (
    echo [WARNING] Failed to generate portable zip archive.
)

REM ------------------------------------------------------------
REM Step 5: Build Summary & Completion
REM ------------------------------------------------------------
echo ============================================================
echo [BUILD SUCCESS] Artifacts generated for version v%APP_VERSION%:
echo - dist\
echo - dist\%APP_VERSION%\
echo ============================================================

if "%CI%"=="" (
    echo [*] Opening dist folder in Windows Explorer...
    explorer "dist\%APP_VERSION%"
)

exit /b 0

:BUILD_FAILED
echo ============================================================
echo [BUILD ERROR] Inno Setup compilation failed with exit code %ERRORLEVEL%!
echo ============================================================
pause
exit /b 1
