; ============================================================
; Inno Setup Script: 아비캠뷰어 (AhBiCamViewer)
; Version: 1.4.8
; Architecture: Unpacked Multi-File Installation
; Developer: AhBiYout (AhBiYout-all)
; Repository: https://github.com/AhBiYout-all/AhBiCamViewer
; Official Blog: https://ahbiyoutvibe.blogspot.com/
; Features:
;  - Unpacked multi-file individual files (no zip bundling)
;  - Existing version detection with overwrite/upgrade prompt
;  - Silent / VerySilent unattended command-line installation support
;  - Windows Firewall rules pre-registered quietly (Base Name & Versioned Name)
;  - Desktop & Start Menu high-resolution icons
; ============================================================

#define MyAppName "아비캠뷰어 (AhBiCamViewer)"
#define MyAppEnglishName "AhBiCamViewer"
#define MyAppVersion "1.4.8"
#define MyAppPublisher "AhBiYout"
#define MyAppURL "https://github.com/AhBiYout-all/AhBiCamViewer"
#define MyAppExeName "AhBiCamViewer.bat"

[Setup]
AppId={{E68A9F21-7A39-4E61-9A3F-470295BCA120}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} v{#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppEnglishName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
DisableWelcomePage=no
LicenseFile=assets\LICENSE.txt
OutputDir=dist
OutputBaseFilename={#MyAppName}_Setup_v{#MyAppVersion}
SetupIconFile=assets\app.ico
Compression=lzma2/ultra64
SolidCompression=no
PrivilegesRequired=admin
ArchitecturesInstallIn64BitMode=x64compatible
WizardStyle=modern
UninstallDisplayIcon={app}\assets\app.ico
CloseApplications=yes
RestartApplications=no
UsePreviousAppDir=no
UsePreviousTasks=no

[Languages]
Name: "korean"; MessagesFile: "compiler:Languages\Korean.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce

[Files]
; Unpacked multi-file installation (clean production files only)
Source: "index.html"; DestDir: "{app}"; Flags: ignoreversion
Source: "version.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "assets\*"; DestDir: "{app}\assets"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "docs\*"; DestDir: "{app}\docs"; Excludes: "*SYSTEM.txt,WORK_LOG.md,AI_HANDOVER.md,BLOG_POST.md,BUILD.md,GITHUB.md,ARCHITECTURE.md,NATIVE_DLL_ARCHITECTURE.md,MODULES.md,ROADMAP.md,SECURITY.md"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "launcher.vbs"; DestDir: "{app}"; Flags: ignoreversion
Source: "tools\AhBiCamViewer.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "bin\*.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
; Files required during setup execution
Source: "bin\AhBiCamViewerCore.dll"; Flags: dontcopy
Source: "bin\AhBiCamViewerManaged.dll"; Flags: dontcopy

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\launcher.vbs"; WorkingDir: "{app}"; IconFilename: "{app}\assets\app.ico"
Name: "{group}\수업자료 매뉴얼 (Docs)"; Filename: "{app}\docs\README.md"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\launcher.vbs"; WorkingDir: "{app}"; IconFilename: "{app}\assets\app.ico"; Tasks: desktopicon

[Run]
; [배포/설치 단계] Windows Firewall 규칙 사전 조용히 등록 (기본 이름 및 버전 포함 이름 동시 등록)
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName}"" dir=in action=allow program=""{sys}\wscript.exe"" enable=yes"; Flags: runhidden
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} v{#MyAppVersion}"" dir=in action=allow program=""{sys}\wscript.exe"" enable=yes"; Flags: runhidden
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName}"" dir=out action=allow program=""{sys}\wscript.exe"" enable=yes"; Flags: runhidden
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} v{#MyAppVersion}"" dir=out action=allow program=""{sys}\wscript.exe"" enable=yes"; Flags: runhidden

; Post-install launch option (launches standalone chromeless webview app window via launcher.vbs)
Filename: "{app}\launcher.vbs"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: shellexec nowait postinstall skipifsilent

[UninstallRun]
; Silently clean up Windows Firewall rules on uninstallation (Base Name & Versioned Name)
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""{#MyAppName}"""; Flags: runhidden; RunOnceId: "DelFwBase"
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=""{#MyAppName} v{#MyAppVersion}"""; Flags: runhidden; RunOnceId: "DelFwVer"

[Code]
// Pure native DLL import from AhBiCamViewerCore.dll (v1.4.8 - 15 Native APIs)
function CV_GetVersion(): Integer;
  external 'CV_GetVersion@{tmp}\AhBiCamViewerCore.dll stdcall delayload';

function CV_GetMonitorCount(): Integer;
  external 'CV_GetMonitorCount@{tmp}\AhBiCamViewerCore.dll stdcall delayload';

function CV_PreventSleep(enable: Integer): Integer;
  external 'CV_PreventSleep@{tmp}\AhBiCamViewerCore.dll stdcall delayload';

function CV_GetDiskFreeSpaceMB(drivePath: PAnsiChar; var freeMB: Integer): Integer;
  external 'CV_GetDiskFreeSpaceMB@{tmp}\AhBiCamViewerCore.dll stdcall delayload';

function CV_GetDisplayDpi(var dpiX, dpiY: Integer): Integer;
  external 'CV_GetDisplayDpi@{tmp}\AhBiCamViewerCore.dll stdcall delayload';

// Check if the application or launcher is currently running
function IsExistingAppRunning(): Boolean;
var
  ResultCode: Integer;
begin
  Result := False;

  // 1. Check window titles via tasklist
  Exec('cmd.exe', '/c tasklist /FI "WINDOWTITLE eq 아비캠뷰어*" 2>nul | find /i ".exe" >nul', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  if ResultCode = 0 then begin Result := True; Exit; end;

  Exec('cmd.exe', '/c tasklist /FI "WINDOWTITLE eq AhBiCamViewer*" 2>nul | find /i ".exe" >nul', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  if ResultCode = 0 then begin Result := True; Exit; end;

  Exec('cmd.exe', '/c tasklist /FI "WINDOWTITLE eq ClassroomVisualizer*" 2>nul | find /i ".exe" >nul', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  if ResultCode = 0 then begin Result := True; Exit; end;

  Exec('cmd.exe', '/c tasklist /FI "WINDOWTITLE eq 실물화상기*" 2>nul | find /i ".exe" >nul', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  if ResultCode = 0 then begin Result := True; Exit; end;

  // 2. Check PowerShell WMI for app isolated profile
  Exec('powershell.exe', '-NoProfile -ExecutionPolicy Bypass -Command "& { if (Get-CimInstance Win32_Process | Where-Object { ($_.Name -eq ''msedge.exe'' -or $_.Name -eq ''chrome.exe'') -and ($_.CommandLine -like ''*AhBiCamViewer_AppProfile*'' -or $_.CommandLine -like ''*AhBiCamViewer*'') }) { exit 0 } else { exit 1 } }"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  if ResultCode = 0 then begin Result := True; Exit; end;
end;

// Terminate running application instances (Edge/Chrome app mode, launchers, batch)
procedure TerminateExistingApp();
var
  ResultCode: Integer;
begin
  Log('Terminating running AhBiCamViewer/ClassroomVisualizer instances...');
  // Terminate browser windows hosting the app (Edge/Chrome app mode)
  // Note: Windows taskkill /FI only accepts trailing wildcard (e.g. title*), not leading (*title)
  Exec('cmd.exe', '/c taskkill /F /IM msedge.exe /FI "WINDOWTITLE eq 아비캠뷰어*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM msedge.exe /FI "WINDOWTITLE eq AhBiCamViewer*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM msedge.exe /FI "WINDOWTITLE eq ClassroomVisualizer*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM msedge.exe /FI "WINDOWTITLE eq 교실용*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM msedge.exe /FI "WINDOWTITLE eq 실물화상기*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

  Exec('cmd.exe', '/c taskkill /F /IM chrome.exe /FI "WINDOWTITLE eq 아비캠뷰어*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM chrome.exe /FI "WINDOWTITLE eq AhBiCamViewer*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM chrome.exe /FI "WINDOWTITLE eq ClassroomVisualizer*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM chrome.exe /FI "WINDOWTITLE eq 교실용*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM chrome.exe /FI "WINDOWTITLE eq 실물화상기*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

  // Terminate batch launcher if active
  Exec('cmd.exe', '/c taskkill /F /IM cmd.exe /FI "WINDOWTITLE eq AhBiCamViewer*" >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM cmd.exe /FI "WINDOWTITLE eq ClassroomVisualizer*" >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM cmd.exe /FI "WINDOWTITLE eq 아비캠뷰어*" >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

  // Terminate any browser instance using the app profile
  Exec('powershell.exe', '-NoProfile -ExecutionPolicy Bypass -Command "& { Get-CimInstance Win32_Process | Where-Object { ($_.Name -eq ''msedge.exe'' -or $_.Name -eq ''chrome.exe'') -and ($_.CommandLine -like ''*AhBiCamViewer_AppProfile*'' -or $_.CommandLine -like ''*AhBiCamViewer*'') } | Stop-Process -Force -ErrorAction SilentlyContinue }"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

  Sleep(500);
end;

// Retrieve previous uninstaller executable path, install dir, and version from registry
function GetPreviousUninstaller(var UninstallerPath, OldInstallDir, OldVersion: String): Boolean;
var
  AppKey: String;
  RawString: String;
begin
  Result := False;
  UninstallerPath := '';
  OldInstallDir := '';
  OldVersion := '';
  AppKey := 'Software\Microsoft\Windows\CurrentVersion\Uninstall\' + '{E68A9F21-7A39-4E61-9A3F-470295BCA120}_is1';

  // 1. Check HKEY_LOCAL_MACHINE (default view)
  if RegQueryStringValue(HKEY_LOCAL_MACHINE, AppKey, 'UninstallString', RawString) then
  begin
    UninstallerPath := RemoveQuotes(RawString);
    RegQueryStringValue(HKEY_LOCAL_MACHINE, AppKey, 'InstallLocation', OldInstallDir);
    RegQueryStringValue(HKEY_LOCAL_MACHINE, AppKey, 'DisplayVersion', OldVersion);
    if FileExists(UninstallerPath) then
    begin
      Result := True;
      Exit;
    end;
  end;

  // 2. Check HKLM64 if running on 64-bit Windows
  if (not Result) and IsWin64 then
  begin
    if RegQueryStringValue(HKLM64, AppKey, 'UninstallString', RawString) then
    begin
      UninstallerPath := RemoveQuotes(RawString);
      RegQueryStringValue(HKLM64, AppKey, 'InstallLocation', OldInstallDir);
      RegQueryStringValue(HKLM64, AppKey, 'DisplayVersion', OldVersion);
      if FileExists(UninstallerPath) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

  // 3. Check HKLM32
  if not Result then
  begin
    if RegQueryStringValue(HKLM32, AppKey, 'UninstallString', RawString) then
    begin
      UninstallerPath := RemoveQuotes(RawString);
      RegQueryStringValue(HKLM32, AppKey, 'InstallLocation', OldInstallDir);
      RegQueryStringValue(HKLM32, AppKey, 'DisplayVersion', OldVersion);
      if FileExists(UninstallerPath) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

  // 4. Check HKEY_CURRENT_USER
  if not Result then
  begin
    if RegQueryStringValue(HKEY_CURRENT_USER, AppKey, 'UninstallString', RawString) then
    begin
      UninstallerPath := RemoveQuotes(RawString);
      RegQueryStringValue(HKEY_CURRENT_USER, AppKey, 'InstallLocation', OldInstallDir);
      RegQueryStringValue(HKEY_CURRENT_USER, AppKey, 'DisplayVersion', OldVersion);
      if FileExists(UninstallerPath) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

// Silently execute previous uninstaller and completely remove previous installation directory
function UninstallPreviousVersion(): Boolean;
var
  UninstallerPath: String;
  OldInstallDir: String;
  OldVersion: String;
  ResultCode: Integer;
  WaitCount: Integer;
begin
  Result := True;
  if GetPreviousUninstaller(UninstallerPath, OldInstallDir, OldVersion) then
  begin
    Log(Format('Previous installation found: %s. Executing silent uninstaller: %s', [OldInstallDir, UninstallerPath]));
    
    // 1. Execute unins000.exe silently
    Exec(UninstallerPath, '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    
    // 2. Wait up to 5 seconds for uninstaller process to complete
    WaitCount := 0;
    while FileExists(UninstallerPath) and (WaitCount < 10) do
    begin
      Sleep(500);
      WaitCount := WaitCount + 1;
    end;
    Sleep(500);

    // 3. Completely delete previous files and directory in OldInstallDir
    if (OldInstallDir <> '') and DirExists(OldInstallDir) then
    begin
      Log(Format('Completely deleting previous files from: %s', [OldInstallDir]));
      DelTree(OldInstallDir, True, True, True);
    end;

    // 4. Clean up registry uninstaller keys
    RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\' + '{E68A9F21-7A39-4E61-9A3F-470295BCA120}_is1');
    if IsWin64 then
      RegDeleteKeyIncludingSubkeys(HKLM64, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\' + '{E68A9F21-7A39-4E61-9A3F-470295BCA120}_is1');
    RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\' + '{E68A9F21-7A39-4E61-9A3F-470295BCA120}_is1');
  end
  else
  begin
    Log('No previous version uninstaller detected or unins000.exe not found on disk.');
  end;
end;

// Detect existing installation, handle app termination, and handle user choice
function InitializeSetup(): Boolean;
var
  PrevUninstaller: String;
  PrevDir: String;
  PrevVersion: String;
  PromptMsg: String;
  Choice: Integer;
begin
  Result := True;

  // 1. [기존 앱 실행 시 감지 및 강제 종료 안내 알림]
  if IsExistingAppRunning() then
  begin
    if not WizardSilent then
    begin
      MsgBox('현재 실행 중인 [' + '{#MyAppName}' + '] 프로그램이 감지되었습니다.' + #13#10#13#10 +
             '안전한 설치 및 파일 업데이트를 위해 실행 중인 프로그램을 자동으로 종료합니다.', mbInformation, MB_OK);
    end;
    TerminateExistingApp();
  end
  else
  begin
    TerminateExistingApp();
  end;

  // 2. [기존 앱 인스톨 여부 확인 및 삭제/덮어쓰기 분기 실제 실행]
  if GetPreviousUninstaller(PrevUninstaller, PrevDir, PrevVersion) then
  begin
    if PrevVersion = '' then PrevVersion := '이전 버전';
    Log(Format('Existing installation detected. Version: %s, Location: %s, Uninstaller: %s', [PrevVersion, PrevDir, PrevUninstaller]));

    // 무인/자동 설치 모드인 경우 기본적으로 클린 삭제 후 설치 진행
    if WizardSilent then
    begin
      UninstallPreviousVersion();
    end
    else
    begin
      PromptMsg := '컴퓨터에 이미 이전 버전의 [' + '{#MyAppName}' + ' (v' + PrevVersion + ')]이(가) 설치되어 있습니다.' + #13#10#13#10 +
                   '기존 버전을 어떻게 처리하고 설치를 진행하시겠습니까?' + #13#10#13#10 +
                   '• [예 (Y)] : 기존 버전을 완전히 삭제(제거) 후 최신 버전으로 새로 설치 (권장)' + #13#10 +
                   '• [아니오 (N)] : 기존 앱을 삭제하지 않고 현재 위치에 덮어쓰기(업그레이드) 설치' + #13#10 +
                   '• [취소 (Cancel)] : 설치를 취소하고 설치 프로그램을 종료합니다.';

      Choice := MsgBox(PromptMsg, mbConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON1);
      if Choice = IDYES then
      begin
        Log('User chose to uninstall previous version first.');
        if UninstallPreviousVersion() then
        begin
          MsgBox('기존 버전(v' + PrevVersion + ')이 안전하게 완전 삭제되었습니다.' + #13#10#13#10 +
                 '최신 버전(v{#MyAppVersion}) 설치를 계속 진행합니다.', mbInformation, MB_OK);
        end
        else
        begin
          MsgBox('기존 버전 삭제를 완료하고 최신 버전(v{#MyAppVersion}) 설치를 계속 진행합니다.', mbInformation, MB_OK);
        end;
      end
      else if Choice = IDNO then
      begin
        Log('User chose to overwrite/upgrade without full previous uninstallation.');
      end
      else
      begin
        // 취소(Cancel) 선택 시 설치 즉시 종료
        Result := False;
        Exit;
      end;
    end;
  end;
end;

// PrepareToInstall: Executes right before actual file extraction begins
function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  Result := '';
  // Ensure any lingering processes are terminated before copying files
  TerminateExistingApp();
end;
