# 🛠️ 빌드 및 패키징 가이드 (Build Guide)

본 문서는 **아비캠뷰어 (AhBiCamViewer) v1.4.4**를 윈도우 데스크톱 및 웹 배포용 패키지로 빌드하는 절차를 설명합니다.

---

## 1. 사전 요구 사항 (Prerequisites)

- **운영체제**: Windows 10 / 11 (64-bit)
- **컴파일러**: [Inno Setup 6.x](https://jrsoftware.org/isdl.php) (ISCC.exe)
  - 기본 설치 경로: `C:\Program Files (x86)\Inno Setup 6\ISCC.exe` 또는 `C:\Program Files\Inno Setup 6\ISCC.exe`
- **.NET 컴파일러 & IL Assembler**:
  - `csc.exe` (Microsoft .NET Framework v4.0.30319) - 매니지드 코어 컴파일
  - `ilasm.exe` (Microsoft .NET Framework v4.0.30319) - 15 Native API Export Thunk 어셈블
- **스크립트 런타임**: Windows PowerShell 5.1 이상 / Node.js 22 LTS 이상
- **줄바꿈 규격**: 모든 윈도우 배치 파일(`.bat`)은 Windows 표준 **CRLF**를 엄격히 유지해야 합니다.

---

## 2. 자동 빌드 파이프라인 (`build.bat`)

프로젝트 루트의 `build.bat`을 실행하면 전체 빌드와 검증이 원클릭으로 완료됩니다.

```cmd
C:\Users\user\.gemini\antigravity\scratch\교실용_실물화상기> build.bat
```

> **CI 모드**: 환경 변수 `CI=true`를 설정하면 빌드 완료 후 탐색기 자동 열기를 억제합니다.
> ```cmd
> set CI=true&& build.bat
> ```

### 파이프라인 수행 단계:
1. **버전 파싱**: `version.json`에서 현재 타겟 시맨틱 버전(`v1.4.4`)을 읽어옵니다.
2. **출력 폴더 준비**: `dist/` 및 버전별 격리 폴더 `dist/1.4.4/`를 생성합니다.
3. **순수 창작 네이티브 DLL 15대 API 컴파일 (`tools\build_dll.bat`)**:
   - `csc.exe`로 `src/dll/LicenseCore.cs`와 `src/dll/NativeSystemCore.cs`를 `src/dll/AhBiCamViewerManaged.dll`로 빌드합니다.
   - `ilasm.exe`로 `src/dll/AhBiCamViewerCore.il`을 어셈블하여 VTable Fixup 기반 순수 stdcall PE Export DLL(`AhBiCamViewerCore.dll`)을 생성합니다.
   - `TestRunner.cs`를 컴파일하고 15개 네이티브 함수에 대한 단위 테스트를 실행하여 15/15 PASS(100%)를 검증합니다.
4. **Inno Setup 6 멀티파일 인스톨러 컴파일**:
   - `ISCC.exe`를 탐색하고 매개변수 `/DMyAppVersion="1.4.4"`를 전달하여 `installer.iss`를 컴파일합니다.
   - 폴더 풀림(Unpacked Multi-File) 구조로 `아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.4.exe`를 빌드합니다.
   - 컴파일 성공 시 해당 설치 파일을 `dist/1.4.4/` 폴더에도 복제합니다.
5. **포터블 ZIP 패키징**:
   - `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`, `launcher.vbs`, `version.json`, `assets/`, `docs/`, `tools/`, `bin/`을 묶어 `AhBiCamViewer_Portable_v1.4.4.zip`을 생성합니다.
6. **검증 및 산출물 확인**: 빌드 결과물의 해시 및 존재 여부를 검증합니다.

---

## 3. 빌드 산출물 구조 (Output Artifacts)

```
dist/
├── 아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.4.exe   # 루트 최신 멀티파일 인스톨러
├── AhBiCamViewer_Portable_v1.4.4.zip               # 루트 최신 포터블 압축 패키지
└── 1.4.4/                                           # 버전별 아카이브 폴더
    ├── 아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.4.exe
    └── AhBiCamViewer_Portable_v1.4.4.zip
```

### DLL 산출물 (`bin/` 폴더):
```
bin/
├── AhBiCamViewerCore.dll      # 15대 네이티브 Win32 C/C++ 스타일 stdcall DLL
└── AhBiCamViewerManaged.dll   # .NET 매니지드 어셈블리 DLL
```

---

## 4. 수동 컴파일 명령

### 4.1 Inno Setup 수동 컴파일
명령 프롬프트(CMD) 또는 PowerShell에서 직접 컴파일할 경우:

```powershell
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" /DMyAppVersion="1.4.4" "installer.iss"
```

### 4.2 DLL 수동 빌드 및 단위 테스트
```cmd
tools\build_dll.bat
```

---

## 5. GitHub Actions CI/CD (`.github/workflows/build-and-release.yml`)

GitHub에 `v1.4.4` 태그를 푸시하면 다음 자동화 워크플로가 클라우드에서 실행됩니다:
- **실행 환경**: `windows-latest`
- **Node.js 런타임**: **Node.js 22 LTS** (GitHub 공식 Node 20 EOL 권고 완벽 준수)
- **자동 빌드**: .NET 컴파일러 및 Inno Setup 6을 통해 DLL과 설치 파일 빌드
- **자동 릴리스**: 릴리스 자산에는 **설치 실행 파일(`dist/*_Setup_v*.exe`)만 첨부**

---

## 6. 설치 프로그램 기능 요약 (`installer.iss`)

| 기능 | 설명 |
|:---|:---|
| 멀티파일 설치 | Unpacked Multi-File 구조로 개별 파일 정상 배포 |
| 기존 버전 감지 | 레지스트리에서 이전 설치를 감지하고 덮어쓰기/삭제 대화상자 표시 |
| 무인 설치 | `/SILENT`, `/VERYSILENT` 명령줄 스위치 지원 |
| 방화벽 사전 등록 | 설치 시 Windows 방화벽 규칙을 기본 앱 이름 및 버전 표기 이름으로 사전 조용히 등록 |
| 방화벽 정리 | 제거 시 등록된 방화벽 규칙 자동 삭제 |
| 런처 실행 | 설치 완료 후 `launcher.vbs`를 무음 백그라운드로 실행 |
| DLL 무결성 검증 | `InitializeSetup()` 코드에서 `AhBiCamViewerCore.dll`의 `CV_GetVersion()`을 호출하여 무결성 확인 |
