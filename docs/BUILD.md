# 🛠️ 빌드 및 패키징 가이드 (Build Guide)

본 문서는 **아비캠뷰어 (AhBiCamViewer) v1.4.0**을 윈도우 데스크톱 및 웹 배포용 패키지로 빌드하는 절차를 설명합니다.

---

## 1. 사전 요구 사항 (Prerequisites)

- **운영체제**: Windows 10 / 11 (64-bit)
- **컴파일러**: [Inno Setup 6.x](https://jrsoftware.org/isdl.php) (ISCC.exe)
  - 기본 설치 경로: `C:\Program Files (x86)\Inno Setup 6\ISCC.exe` 또는 `C:\Program Files\Inno Setup 6\ISCC.exe`
- **.NET IL Assembler**: `ilasm.exe` (Windows SDK 또는 .NET Framework 포함)
  - 네이티브 DLL 빌드(`tools\build_dll.bat`)에 사용
- **스크립트 런타임**: Windows PowerShell 5.1 이상
- **줄바꿈 규격**: 모든 윈도우 배치 파일(`.bat`)은 Windows 표준 **CRLF**를 엄격히 유지해야 합니다.

---

## 2. 자동 빌드 파이프라인 (`build.bat`)

프로젝트 루트의 `build.bat`을 실행하면 다음 과정이 자동으로 진행됩니다.

```cmd
C:\Users\user\.gemini\antigravity\scratch\교실용_실물화상기> build.bat
```

> **CI 모드**: 환경 변수 `CI=true`를 설정하면 빌드 완료 후 탐색기 자동 열기를 억제합니다.
> ```cmd
> set CI=true&& build.bat
> ```

### 파이프라인 수행 단계:
1. **버전 파싱**: `version.json`에서 현재 타겟 시맨틱 버전(예: `1.4.0`)을 읽어옵니다.
2. **출력 폴더 준비**: `dist/` 및 버전별 격리 폴더 `dist/1.4.0/`을 생성합니다.
3. **네이티브 DLL 컴파일** *(신규)*:
   - `tools\build_dll.bat`이 존재하면 자동 호출합니다.
   - IL Assembler(`ilasm.exe`)로 `ClassroomVisualizerCore.dll` 및 `ClassroomVisualizerManaged.dll`을 `bin/` 폴더에 빌드합니다.
   - DLL 빌드 실패 시 전체 파이프라인을 중단합니다.
4. **Inno Setup 컴파일**:
   - `ISCC.exe`를 탐색하고 매개변수 `/DMyAppVersion="1.4.0"`를 전달하여 `installer.iss`를 컴파일합니다.
   - 단일 설치 실행 파일 `아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe`를 빌드합니다.
   - 컴파일 성공 시 해당 설치 파일을 `dist/1.4.0/` 폴더에도 복제합니다.
5. **포터블 ZIP 패키징**:
   - `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`, `launcher.vbs`, `version.json`, `assets/`, `docs/`, `tools/`, `bin/`을 묶어 `AhBiCamViewer_Portable_v1.4.0.zip`을 생성합니다.
6. **검증 및 탐색기 오픈**: 산출물의 존재를 확인하고 윈도우 탐색기로 결과 폴더를 엽니다 (CI 모드 제외).

---

## 3. 빌드 산출물 구조 (Output Artifacts)

빌드가 완료되면 다음과 같이 산출물이 정렬됩니다:

```
dist/
├── 아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe   # 루트 최신 설치 프로그램
├── AhBiCamViewer_Portable_v1.4.0.zip               # 루트 최신 포터블 압축본
└── 1.4.0/                                           # 버전별 아카이브 폴더
    ├── 아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe
    └── AhBiCamViewer_Portable_v1.4.0.zip
```

### DLL 산출물 (bin/ 폴더):
```
bin/
├── ClassroomVisualizerCore.dll      # 네이티브 C/C++ 스타일 DLL (설치 시 무결성 검증)
└── ClassroomVisualizerManaged.dll   # .NET 관리 어셈블리 DLL
```

---

## 4. 수동 컴파일 명령

### 4.1 Inno Setup 수동 컴파일
명령 프롬프트(CMD) 또는 PowerShell에서 직접 컴파일할 경우:

```powershell
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" /DMyAppVersion="1.4.0" "installer.iss"
```

### 4.2 DLL 수동 빌드
```cmd
tools\build_dll.bat
```

---

## 5. 배치 파일 줄바꿈 검증 (CRLF Verification)

배치 파일이 Linux 스타일(LF)로 변경되어 명령 프롬프트 구문 에러가 발생하는 것을 방지하려면 다음 도구를 실행합니다:

```powershell
powershell -ExecutionPolicy Bypass -File "tools\format_crlf.ps1"
```
모든 `.bat` 파일이 UTF-8 무손실 및 CRLF 줄바꿈으로 자동 정규화됩니다.

---

## 6. 설치 프로그램 기능 요약 (installer.iss)

`installer.iss`는 Inno Setup 6.x 스크립트로, 다음 기능을 포함합니다:

| 기능 | 설명 |
|:---|:---|
| 기존 버전 감지 | 레지스트리에서 이전 설치를 감지하고 덮어쓰기/취소 대화상자 표시 |
| DLL 무결성 검증 | `InitializeSetup()` 코드에서 `ClassroomVisualizerCore.dll`의 `CV_GetVersion()`을 호출하여 DLL 정합성 확인 |
| 무인 설치 | `/SILENT`, `/VERYSILENT` 명령줄 스위치 지원 |
| 런처 실행 | 설치 완료 후 `launcher.vbs`를 `shellexec`로 실행 (크로미움 독립 앱 창) |
| 레거시 방화벽 정리 | 제거 시 이전 버전에서 등록한 방화벽 규칙 자동 삭제 |
| 다국어 지원 | 한국어 / 영어 설치 마법사 |
