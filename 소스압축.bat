@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM ============================================================
REM 아비캠뷰어 (AhBiCamViewer) 원본 소스코드 백업 압축 자동화 도구
REM 제작자: AhBiYout (AhBiYout-all)
REM 공식 저장소: https://github.com/AhBiYout-all/AhBiCamViewer
REM ============================================================

title 아비캠뷰어 원본 소스코드 압축 백업 파이프라인
cd /d "%~dp0"

echo ============================================================
echo   [SOURCE BACKUP] 아비캠뷰어 원본 소스 백업 압축
echo ============================================================
echo.

REM ------------------------------------------------------------
REM 1단계: 시맨틱 버전 및 백업 타임스탬프 산출
REM ------------------------------------------------------------
set "APP_VERSION="
for /f "tokens=2 delims=:, " %%A in ('findstr /i "\"version\"" version.json 2^>nul') do (
    set "APP_VERSION=%%~A"
)
if "%APP_VERSION%"=="" set "APP_VERSION=1.4.8"

for /f %%A in ('powershell -NoProfile -Command "Get-Date -Format 'yyyyMMdd_HHmmss'"') do (
    set "STAMP=%%A"
)

set "BACKUP_DIR=backup"
set "STAGE_DIR=dist\_stage_source"
set "ZIP_NAME=AhBiCamViewer_Source_v%APP_VERSION%_%STAMP%.zip"
set "ZIP_PATH=%BACKUP_DIR%\%ZIP_NAME%"

if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
if not exist "dist" mkdir "dist"

echo [*] 프로젝트 버전 : v%APP_VERSION%
echo [*] 백업 일시     : %STAMP%
echo [*] 대상 파일명   : %ZIP_NAME%
echo.

REM ------------------------------------------------------------
REM 2단계: 순수 원본 소스코드 클린 스테이징 (불필요 파일 제외)
REM ------------------------------------------------------------
echo [*] 불필요한 파일 및 바이너리를 배제하고 순수 원본 소스를 수집 중...

if exist "%STAGE_DIR%" rd /s /q "%STAGE_DIR%"
mkdir "%STAGE_DIR%"
mkdir "%STAGE_DIR%\.github"
mkdir "%STAGE_DIR%\assets"
mkdir "%STAGE_DIR%\docs"
mkdir "%STAGE_DIR%\src"
mkdir "%STAGE_DIR%\src\dll"
mkdir "%STAGE_DIR%\tools"

REM 1) 루트 핵심 소스 및 설정 파일 복사
for %%F in (index.html version.json launcher.vbs installer.iss build.bat README.md .gitignore) do (
    if exist "%%F" copy /y "%%F" "%STAGE_DIR%\" >nul
)
if exist "%~nx0" copy /y "%~nx0" "%STAGE_DIR%\" >nul

REM 2) .github CI/CD 워크플로 복사
if exist ".github" (
    xcopy /e /i /y /q ".github" "%STAGE_DIR%\.github" >nul
)

REM 3) 에셋 파일 복사
if exist "assets" (
    xcopy /e /i /y /q "assets" "%STAGE_DIR%\assets" >nul
)

REM 4) 공식 기술 문서 복사 (docs 전체 15종)
if exist "docs" (
    xcopy /e /i /y /q "docs" "%STAGE_DIR%\docs" >nul
)

REM 5) C#/IL 순수 네이티브 DLL 소스 복사 (*.dll, *.exe, *.pdb 바이너리 제외)
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem 'src\dll' -File | Where-Object { $_.Extension -notin @('.dll', '.exe', '.pdb', '.obj', '.lib') } | ForEach-Object { Copy-Item $_.FullName '%STAGE_DIR%\src\dll\' }"

REM 6) 개발 도구 및 런타임 스크립트 복사 (깃허브 푸시/임시 스크립트 제외)
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem 'tools' -File | Where-Object { $_.Name -notmatch 'push' -and $_.Name -notmatch 'release' -and $_.Name -notmatch 'temp_' -and $_.Name -notmatch 'inspect_' -and $_.Name -notmatch 'update_' } | ForEach-Object { Copy-Item $_.FullName '%STAGE_DIR%\tools\' }"

REM ------------------------------------------------------------
REM 3단계: ZIP 압축 아카이브 생성
REM ------------------------------------------------------------
echo [*] 무손실 ZIP 압축 아카이브 생성 중...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Compress-Archive -Path '%STAGE_DIR%\*' -DestinationPath '%ZIP_PATH%' -Force"

REM 스테이징 디렉터리 정리
if exist "%STAGE_DIR%" rd /s /q "%STAGE_DIR%"

if not exist "%ZIP_PATH%" goto ZIP_FAILED

REM dist 디렉터리에도 최신 버전 단일 이름 복사본 보관
copy /y "%ZIP_PATH%" "dist\AhBiCamViewer_Source_v%APP_VERSION%.zip" >nul 2>&1

REM ------------------------------------------------------------
REM 4단계: 백업 결과 검증 및 요약 안내
REM ------------------------------------------------------------
for %%I in ("%ZIP_PATH%") do set "ZIP_BYTES=%%~zI"
set /a "ZIP_KB=!ZIP_BYTES! / 1024"

echo.
echo ============================================================
echo   [압축 성공] 원본 소스코드 백업 아카이브가 생성되었습니다!
echo ============================================================
echo   - 백업 파일 : %ZIP_PATH%
echo   - 배포 사본 : dist\AhBiCamViewer_Source_v%APP_VERSION%.zip
echo   - 파일 크기 : !ZIP_KB! KB (!ZIP_BYTES! bytes)
echo.
echo   [제외된 불필요 파일 및 폴더]:
echo   - .git/ (Git 버전 관리 전체 데이터베이스)
echo   - dist/ (빌드된 인스톨러 Setup.exe 및 배포용 ZIP 패키지)
echo   - bin/ (컴파일된 DLL 바이너리 및 TestRunner.exe)
echo   - 모든 *.dll, *.exe, *.pdb, *.obj 바이너리 산출물
echo   - 로컬 GitHub 푸시/릴리즈 스크립트 (*push*, *release*)
echo   - 임시 캐시 및 로그 (*.tmp, *.log, *.bak, scratch/)
echo ============================================================
echo.

if "%CI%"=="" (
    echo [*] 백업 압축 파일이 위치한 탐색기 폴더를 엽니다...
    explorer.exe /select,"%ZIP_PATH%"
)

pause
exit /b 0

:ZIP_FAILED
echo.
echo [ERROR] 소스코드 ZIP 압축 파일 생성에 실패하였습니다.
pause
exit /b 1
