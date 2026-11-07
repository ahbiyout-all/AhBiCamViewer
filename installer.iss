; ============================================================
; Inno Setup Script: 아비캠뷰어 (AhBiCamViewer)
; Version: 1.4.7
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
#define MyAppVersion "1.4.7"
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

[Languages]
Name: "korean"; MessagesFile: "compiler:Languages\Korean.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
; Unpacked multi-file installation (individual files only, no portable zip)
Source: "(AhBiYout)_공용_실물화상기_보기.html"; DestDir: "{app}"; Flags: ignoreversion
Source: "아비캠뷰어_(AhBiCamViewer).html"; DestDir: "{app}"; Flags: ignoreversion
Source: "index.html"; DestDir: "{app}"; Flags: ignoreversion
Source: "교실용_실물화상기.html"; DestDir: "{app}"; Flags: ignoreversion
Source: "version.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "assets\*"; DestDir: "{app}\assets"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "docs\*"; DestDir: "{app}\docs"; Excludes: "*SYSTEM.txt"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "tools\launcher.vbs"; DestDir: "{app}"; Flags: ignoreversion
Source: "tools\launcher.vbs"; DestDir: "{app}\tools"; Flags: ignoreversion
Source: "tools\AhBiCamViewer.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "tools\AhBiCamViewer.bat"; DestDir: "{app}\tools"; Flags: ignoreversion
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
// Pure native DLL import from AhBiCamViewerCore.dll (v1.4.7 - 15 Native APIs)
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

// Terminate running application instances (Edge/Chrome app mode, launchers, batch)
procedure TerminateExistingApp();
var
  ResultCode: Integer;
begin
  Log('Terminating running AhBiCamViewer/ClassroomVisualizer instances...');
  // Terminate browser windows hosting the app (Edge/Chrome app mode)
  Exec('cmd.exe', '/c taskkill /F /IM msedge.exe /FI "WINDOWTITLE eq *아비캠뷰어*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM msedge.exe /FI "WINDOWTITLE eq *AhBiCamViewer*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM msedge.exe /FI "WINDOWTITLE eq *ClassroomVisualizer*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM msedge.exe /FI "WINDOWTITLE eq *실물화상기*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM chrome.exe /FI "WINDOWTITLE eq *아비캠뷰어*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM chrome.exe /FI "WINDOWTITLE eq *AhBiCamViewer*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM chrome.exe /FI "WINDOWTITLE eq *ClassroomVisualizer*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM chrome.exe /FI "WINDOWTITLE eq *실물화상기*" /T >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  // Terminate batch launcher if active
  Exec('cmd.exe', '/c taskkill /F /IM cmd.exe /FI "WINDOWTITLE eq *AhBiCamViewer*" >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('cmd.exe', '/c taskkill /F /IM cmd.exe /FI "WINDOWTITLE eq *ClassroomVisualizer*" >nul 2>&1', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Sleep(500);
end;

// Retrieve previous uninstaller executable path and installation location from registry
function GetPreviousUninstaller(var UninstallerPath, OldInstallDir: String): Boolean;
var
  AppKey: String;
  RawString: String;
begin
  Result := False;
  UninstallerPath := '';
  OldInstallDir := '';
  AppKey := 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#SetupSetting("AppId")}_is1';

  // 1. Check HKEY_LOCAL_MACHINE (default view)
  if RegQueryStringValue(HKEY_LOCAL_MACHINE, AppKey, 'UninstallString', RawString) then
  begin
    UninstallerPath := RemoveQuotes(RawString);
    RegQueryStringValue(HKEY_LOCAL_MACHINE, AppKey, 'InstallLocation', OldInstallDir);
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
      if FileExists(UninstallerPath) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

// Silently execute previous uninstaller and remove legacy install directory if needed
function UninstallPreviousVersion(): Boolean;
var
  UninstallerPath: String;
  OldInstallDir: String;
  ResultCode: Integer;
  WaitCount: Integer;
begin
  Result := True;
  if GetPreviousUninstaller(UninstallerPath, OldInstallDir) then
  begin
    Log(Format('Previous installation found: %s. Executing silent uninstaller: %s', [OldInstallDir, UninstallerPath]));
    // Execute silent uninstaller and wait for completion
    if Exec(UninstallerPath, '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
    begin
      Log(Format('Previous uninstaller executed. Exit code: %d', [ResultCode]));
      WaitCount := 0;
      while FileExists(UninstallerPath) and (WaitCount < 20) do
      begin
        Sleep(500);
        WaitCount := WaitCount + 1;
      end;
      Sleep(500);

      // Clean up legacy directory if different from current target and it still exists
      if (OldInstallDir <> '') and (CompareText(OldInstallDir, ExpandConstant('{app}')) <> 0) and DirExists(OldInstallDir) then
      begin
        Log(Format('Removing lingering previous installation directory: %s', [OldInstallDir]));
        DelTree(OldInstallDir, True, True, True);
      end;
    end
    else
    begin
      Log(Format('Failed to launch previous uninstaller: %s (ResultCode: %d)', [UninstallerPath, ResultCode]));
      Result := False;
    end;
  end
  else
  begin
    Log('No previous version uninstaller detected or unins000.exe not found on disk.');
  end;
end;

// Detect existing installation, verify DLL integrity and terminate running app
function InitializeSetup(): Boolean;
var
  InstalledVersion: String;
  PromptMsg: String;
  DllVer: Integer;
  MonCount: Integer;
  FreeMB: Integer;
  DpiX, DpiY: Integer;
begin
  Result := True;

  // Extract and verify native core DLL integrity before setup execution
  try
    ExtractTemporaryFile('AhBiCamViewerManaged.dll');
    ExtractTemporaryFile('AhBiCamViewerCore.dll');
    DllVer := CV_GetVersion();
    MonCount := CV_GetMonitorCount();
    FreeMB := 0;
    CV_GetDiskFreeSpaceMB('C:\', FreeMB);
    DpiX := 96; DpiY := 96;
    CV_GetDisplayDpi(DpiX, DpiY);
    Log(Format('Native Core DLL verified successfully. Engine: 0x%8.8x, Displays: %d, Free Disk: %d MB, Primary DPI: %dx%d', [DllVer, MonCount, FreeMB, DpiX, DpiY]));
  except
    Log('Warning: Native Core DLL pre-check bypassed or runtime initialization skipped.');
  end;

  // Terminate any running app instance immediately when installer starts
  TerminateExistingApp();

  // Check registry for previous installation
  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#SetupSetting("AppId")}_is1', 'DisplayVersion', InstalledVersion) then
  begin
    // If running in unattended / silent mode, proceed automatically with upgrade
    if WizardSilent then
    begin
      Result := True;
      Exit;
    end;

    PromptMsg := '컴퓨터에 이미 이전 버전의 [' + '{#MyAppName}' + ' (v' + InstalledVersion + ')]이(가) 설치되어 있습니다.' + #13#10#13#10 +
                 '설치를 계속하면 실행 중인 기존 앱을 종료하고 이전 버전을 완전히 삭제한 후 최신 버전(v{#MyAppVersion})으로 새로 설치합니다.' + #13#10#13#10 +
                 '계속 진행하시겠습니까?';
                 
    if MsgBox(PromptMsg, mbConfirmation, MB_YESNO or MB_DEFBUTTON1) = IDYES then
    begin
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  end;
end;

// PrepareToInstall: Executes right before actual file extraction begins
function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  Result := '';

  // 1. Ensure any running application instance is terminated
  TerminateExistingApp();

  // 2. Silently uninstall previous version and remove obsolete files
  if not UninstallPreviousVersion() then
  begin
    Log('Notice: Silent uninstallation of previous version reported non-zero or was skipped.');
  end;
end;
