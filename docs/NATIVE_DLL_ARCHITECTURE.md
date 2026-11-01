# 🏛️ 순수 창작 네이티브 DLL 아키텍처 및 동작 원리 명세서

본 문서는 **교실용 실물화상기(아비캠뷰어 / AhBiCamViewer)** 프로젝트에 탑재된 순수 창작 Win32 네이티브 익스포트 DLL(`ClassroomVisualizerCore.dll`) 및 관리형 코어 어셈블리(`ClassroomVisualizerManaged.dll`)의 설계 배경, 아키텍처, PE 수준 동작 원리, 기존 결함 점검 및 해결 내역, 10대 네이티브 API 상세 규격, 빌드 파이프라인 및 테스트 검증 결과를 상세히 기록한 공식 기술 명세서입니다.

---

## 1. 개요 및 배경

### 1.1 순수 창작 DLL의 도입 목적
교실 수업 환경에서 구동되는 실물화상기 소프트웨어는 브라우저 샌드박스 내부의 Web API만으로는 해결하기 어려운 여러 윈도우 네이티브 하드웨어 제어 한계에 직면합니다:
1. **수업 중 화면 꺼짐 및 절전 모드 진입 방지**:
   - 교사가 실물화상기 화면을 띄워두고 학생들에게 판서나 교재를 설명하는 동안 수 분간 마우스나 키보드 입력이 없으면 윈도우 기본 절전 정책에 의해 프로젝터나 TV 화면이 꺼지는 현상이 빈번하게 발생합니다.
2. **다중 디스플레이 및 빔프로젝터 위상 감지**:
   - 교사용 메인 노트북 화면과 프로젝터/전자칠판 확장 화면의 해상도 및 가상 데스크톱 경계를 브라우저 권한 허용 팝업 없이 즉각 네이티브 수준에서 파악해야 합니다.
3. **인스톨러(Inno Setup) 레벨의 오프라인 사전 검증**:
   - Inno Setup 설치 마법사(32비트 `SetupLdr.e32`)에서 프로그램 설치 전 시스템 무결성, 하드웨어 식별자, 오프라인 라이선스 체크섬을 인터넷 연결 없이 즉각 판정해야 합니다.
4. **외부 런타임 종속성 제로(Zero-Dependency) 원칙**:
   - 수 기가바이트에 달하는 Visual Studio C++ 빌드 도구나 별도의 MSVCRT 재배포 패키지 없이, **Windows 표준 .NET Framework 4.0 내장 도구(`csc.exe`, `ilasm.exe`)만으로 100% 컴파일 및 링크** 가능한 순수 창작 모듈을 구축해야 합니다.

---

## 2. 기존 DLL 결함 점검 및 개선 내역

기존 `ClassroomVisualizerCore.dll` 및 `ClassroomVisualizerManaged.dll`의 소스 코드와 바이너리를 정밀 분석한 결과, 다음 4가지 핵심 결함과 개선점이 확인되어 모두 수정 및 최적화되었습니다.

| 번호 | 결함 항목 | 기존 상태 (문제점) | 개선 및 해결 내역 (v1.4.4) |
|---|---|---|---|
| **1** | **엔진 버전 상수 불일치** | IL 코드 내 `CV_GetVersion`이 `0x01040000`(v1.4.0)을 반환하여 현재 앱 버전(v1.4.4)과 불일치 | IL 및 어셈블리 버전을 `1.4.4.0`으로 갱신하고 `0x01040400`을 반환하도록 완전 동기화 |
| **2** | **체험키 검증 시그니처 파괴** | 문서(4개 인자: `startDay, currentDay, trialDays, *pDaysRemaining`)와 IL/C# 구현(2개 int64 타임스탬프)이 불일치하여 Inno Setup이나 C 호출 시 **스택 프레임 파괴(Stack Corruption Crash)** 발생 위험 존재 | `LicenseCore.VerifyTrialStatusDays`를 신설하고 IL thunk에서 4개 인자 stdcall 규약 및 포인터 역참조(`stind.i4`)를 정확히 구현하여 스택 무결성 100% 확보 |
| **3** | **머신 식별자 익스포트 누락** | `LicenseCore.cs`에 하드웨어 핑거프린트 함수가 존재했으나 IL thunk 익스포트 목록에서 누락되어 외부에서 호출 불가 | `CV_GetMachineFingerprintA` 네이티브 stdcall 익스포트 신설 (16자리 고유 HEX 반환) |
| **4** | **예외 안전성 부재** | C/Pascal 호출자가 잘못된 포인터(NULL, 쓰레기 주소) 전달 시 CLR 비정상 종료(Crash) 발생 위험 | 모든 IL 메서드에 `.try ... catch [mscorlib]System.Exception` 블록을 탑재하여 안전하게 0 반환 보장 |
| **5** | **빌드 플랫폼 타깃 모호성** | `csc.exe` 기본 옵션 빌드 시 64비트 환경에서 AnyCPU로 생성되어 32비트 인스톨러에서 `BadImageFormatException` 잠재 위험 | `tools/build_dll.bat`에 `/platform:x86` 플래그를 명시하여 결정론적 32비트 PE 바이너리 보장 |

---

## 3. C#/IL 하이브리드 VTable Thunk 동작 원리

### 3.1 아키텍처 개요
일반적인 C# 컴파일러(`csc.exe`)는 관리형 어셈블리(CLI Metadata)만 생성할 수 있으며, C/C++이나 Inno Setup이 직접 `GetProcAddress`나 정적 임포트로 호출할 수 있는 **Win32 네이티브 익스포트 디렉터리(.edata)**를 생성하지 못합니다.

본 프로젝트는 C#으로 비즈니스 로직을 구현한 뒤, 순수 IL(Intermediate Language) 어셈블러(`ilasm.exe`)의 **VTable Fixup (`.vtfixup`) 및 네이티브 익스포트(`.export`)** 메커니즘을 결합하여 순수 32비트 Win32 stdcall 네이티브 DLL을 완벽하게 생성합니다.

```
┌────────────────────────────────────────────────────────────────────────┐
│ [Inno Setup 32-bit Installer] / [Win32 Native C/C++ App] / [VBScript]   │
└────────────────────────────────────┬───────────────────────────────────┘
                                     │ 1. Win32 __stdcall 네이티브 호출
                                     ▼
┌────────────────────────────────────────────────────────────────────────┐
│ ClassroomVisualizerCore.dll (32-bit PE Native Win32 DLL)               │
│                                                                        │
│  [PE Export Directory (.edata)]                                       │
│    ├── Ordinal 1:  CV_GetVersion                                       │
│    ├── Ordinal 2:  CV_ValidateKeyA                                     │
│    ├── Ordinal 3:  CV_IsTrialKeyA                                      │
│    ├── Ordinal 4:  CV_VerifyTrialStatus                                │
│    ├── Ordinal 5:  CV_GetMachineFingerprintA                           │
│    ├── Ordinal 6:  CV_GenerateTrialKeyA                                │
│    ├── Ordinal 7:  CV_PreventSleep                                     │
│    ├── Ordinal 8:  CV_GetMonitorCount                                  │
│    ├── Ordinal 9:  CV_GetVirtualScreenBounds                           │
│    └── Ordinal 10: CV_PlayAttentionAlert                               │
│                                                                        │
│  [VTable Fixup Table (.vtfixup)]                                       │
│    └── 10개 슬롯 (40 Bytes D_VTFIXUPS 바이트 배열)                      │
│        각 슬롯이 Unmanaged Win32 진입점을 관리형 Thunk 메서드로 라우팅 │
└────────────────────────────────────┬───────────────────────────────────┘
                                     │ 2. CLR Context Transition & 위임
                                     ▼
┌────────────────────────────────────────────────────────────────────────┐
│ ClassroomVisualizerManaged.dll (.NET Class Library, x86)               │
│                                                                        │
│  ├── LicenseCore                                                       │
│  │     ├─ ValidateKey(string) (Mod 97 오프라인 체크섬 검증)            │
│  │     ├─ IsTrialKey(string) (TR30- 체험키 접두사 판정)                │
│  │     ├─ GenerateTrialKey() (체크섬 부합 체험키 동적 생성)            │
│  │     ├─ VerifyTrialStatusDays(...) (남은 체험 일수 계산)             │
│  │     └─ GetMachineFingerprintHex() (SHA-256 하드웨어 고유 해시)      │
│  │                                                                     │
│  └── NativeSystemCore                                                  │
│        ├─ PreventSleep(int) (kernel32 SetThreadExecutionState)         │
│        ├─ GetMonitorCount() (user32 GetSystemMetrics SM_CMONITORS)     │
│        ├─ GetVirtualScreenBounds(...) (user32 가상화면 좌표 추출)      │
│        └─ PlayAttentionAlert(int) (user32 MessageBeep 무지연 차임)     │
└────────────────────────────────────────────────────────────────────────┘
```

### 3.2 핵심 IL 지시어와 메모리 레이아웃

1. **`.corflags 0x00000002`**:
   - 바이너리가 32비트 필수(COMIMAGE_FLAGS_32BITREQUIRED) PE 헤더를 갖도록 선언하여 32비트 Inno Setup 프로세스에서 메모리 주소 및 포인터 정렬이 완벽하게 호환되도록 합니다.
2. **`.vtfixup [10] int32 fromunmanaged at D_VTFIXUPS`**:
   - Windows PE 로더 및 .NET 런타임에게 `D_VTFIXUPS` 데이터 영역에 10개의 VTable Thunk 슬롯을 할당하고, 네이티브 호출(`fromunmanaged`)이 발생할 때 CLR 스택 프레임으로 변환하도록 명령합니다.
3. **`.data D_VTFIXUPS = bytearray ( ... 40바이트 ... )`**:
   - 10개 함수에 대해 각 4바이트(32비트 포인터)씩 총 40바이트의 제로 버퍼를 `.data` 섹션에 정렬 배치합니다.
4. **`.vtentry 1 : N` 및 `.export [N] as FunctionName`**:
   - 각 CIL 메서드 선언부에 VTable 슬롯 인덱스와 PE Export Ordinal 번호를 부여하여 익스포트 심볼 이름을 등록합니다.
5. **예외 격리(`.try ... catch [mscorlib]System.Exception`)**:
   - 네이티브 포인터 역참조 또는 ANSI 문자열 변환 시 발생할 수 있는 CLR 예외를 Thunk 계층 내부에서 포획(`pop`)하여 호출한 네이티브 프로세스에 치명적 크래시를 전파하지 않고 안전 코드(0)를 반환합니다.

---

## 4. 10대 네이티브 익스포트 API 상세 레퍼런스

모든 함수는 **Win32 `__stdcall` (x86 WINAPI, 호출된 쪽에서 스택 정리)** 규약을 사용합니다.

### 4.1 `CV_GetVersion` (Ordinal 1)
DLL 엔진의 시맨틱 버전을 16진수 단일 32비트 정수로 반환합니다.
- **C/C++ 시그니처**:
  ```c
  unsigned int __stdcall CV_GetVersion(void);
  ```
- **Inno Setup Pascal 시그니처**:
  ```pascal
  function CV_GetVersion(): Cardinal;
  external 'CV_GetVersion@{tmp}\ClassroomVisualizerCore.dll stdcall delayload';
  ```
- **반환값**: `0x01040400` (Major: 1, Minor: 4, Patch: 4, Build: 0 = v1.4.4)

---

### 4.2 `CV_ValidateKeyA` (Ordinal 2)
16자리 라이선스 키(`XXXX-XXXX-XXXX-XXXX`)의 오프라인 Mod 97 체크섬 유효성을 검증합니다.
- **C/C++ 시그니처**:
  ```c
  int __stdcall CV_ValidateKeyA(const char* pKeyAnsi);
  ```
- **반환값**: `1` (유효), `0` (무효 또는 NULL 포인터)
- **체크섬 알고리즘**:
  $$\left( \sum_{i=0}^{15} \text{AsciiCode}(Key_i) \times (i + 1) \right) \pmod{97} \equiv 1$$

---

### 4.3 `CV_IsTrialKeyA` (Ordinal 3)
전달된 키가 30일 체험용 키(접두사 `TR30-`)인지 판별합니다.
- **C/C++ 시그니처**:
  ```c
  int __stdcall CV_IsTrialKeyA(const char* pKeyAnsi);
  ```
- **반환값**: `1` (30일 체험키), `0` (정품 영구키 또는 유효하지 않은 키)

---

### 4.4 `CV_VerifyTrialStatus` (Ordinal 4)
체험 시작일, 현재 일자 및 유효 일수를 계산하여 만료 여부 판정 및 잔여 일수를 포인터로 반환합니다.
- **C/C++ 시그니처**:
  ```c
  int __stdcall CV_VerifyTrialStatus(int startDay, int currentDay, int trialDays, int* pDaysRemaining);
  ```
- **Inno Setup Pascal 시그니처**:
  ```pascal
  function CV_VerifyTrialStatus(startDay, currentDay, trialDays: Integer; var pDaysRemaining: Integer): Integer;
  external 'CV_VerifyTrialStatus@{tmp}\ClassroomVisualizerCore.dll stdcall delayload';
  ```
- **반환값**: `1` (체험 기간 유효), `0` (기간 만료 / 비정상 파라미터)
- **출력 매개변수**: `pDaysRemaining`에 남은 일수 기록 (만료 시 0)

---

### 4.5 `CV_GetMachineFingerprintA` (Ordinal 5)
학교 및 교실 PC의 컴퓨터 이름, 사용자명, CPU 코어 수, OS 버전을 종합한 SHA-256 고유 16진수 해시(16자리)를 출력 버퍼에 기록합니다.
- **C/C++ 시그니처**:
  ```c
  int __stdcall CV_GetMachineFingerprintA(char* pOutBuffer, int bufferSize);
  ```
- **Inno Setup Pascal 시그니처**:
  ```pascal
  function CV_GetMachineFingerprintA(pOutBuffer: PAnsiChar; bufferSize: Integer): Integer;
  external 'CV_GetMachineFingerprintA@{tmp}\ClassroomVisualizerCore.dll stdcall delayload';
  ```
- **반환값**: 버퍼에 기록된 바이트 수 (성공 시 16)
- **출력 예시**: `"81DFD1DE2A99CF03\0"`

---

### 4.6 `CV_GenerateTrialKeyA` (Ordinal 6)
오프라인 환경의 교실 단말기에서 즉시 사용 가능한 유효한 30일 체험키(`TR30-XXXX-XXXX-XXXX`)를 동적으로 생성하여 버퍼에 반환합니다.
- **C/C++ 시그니처**:
  ```c
  int __stdcall CV_GenerateTrialKeyA(char* pOutBuffer, int bufferSize);
  ```
- **반환값**: 버퍼에 기록된 바이트 수 (성공 시 19)
- **출력 예시**: `"TR30-79F2-TQRU-VXFW\0"`

---

### 4.7 `CV_PreventSleep` (Ordinal 7)
교실 수업 발표 중 프로젝터 및 디스플레이가 절전 모드로 꺼지는 현상을 방지하거나 정상 복원합니다.
- **C/C++ 시그니처**:
  ```c
  int __stdcall CV_PreventSleep(int enable);
  ```
- **Inno Setup Pascal 시그니처**:
  ```pascal
  function CV_PreventSleep(enable: Integer): Integer;
  external 'CV_PreventSleep@{tmp}\ClassroomVisualizerCore.dll stdcall delayload';
  ```
- **파라미터**:
  - `enable = 1`: 디스플레이 및 시스템 절전 방지 활성화 (`ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED`)
  - `enable = 0`: 윈도우 기본 전원 정책으로 정상 복원 (`ES_CONTINUOUS`)
- **반환값**: `1` (성공), `0` (실패)

---

### 4.8 `CV_GetMonitorCount` (Ordinal 8)
현재 시스템에 연결된 활성 디스플레이 모니터 및 빔프로젝터의 개수를 반환합니다.
- **C/C++ 시그니처**:
  ```c
  int __stdcall CV_GetMonitorCount(void);
  ```
- **Inno Setup Pascal 시그니처**:
  ```pascal
  function CV_GetMonitorCount(): Integer;
  external 'CV_GetMonitorCount@{tmp}\ClassroomVisualizerCore.dll stdcall delayload';
  ```
- **반환값**: 연결된 모니터 개수 (최소 1)

---

### 4.9 `CV_GetVirtualScreenBounds` (Ordinal 9)
모든 다중 모니터를 포괄하는 가상 데스크톱(Virtual Screen) 전체 사각 좌표를 획득합니다.
- **C/C++ 시그니처**:
  ```c
  int __stdcall CV_GetVirtualScreenBounds(int* pLeft, int* pTop, int* pWidth, int* pHeight);
  ```
- **파라미터**: 각 포인터로 `Left, Top, Width, Height` 픽셀 좌표 반환
- **반환값**: `1` (성공), `0` (실패)

---

### 4.10 `CV_PlayAttentionAlert` (Ordinal 10)
웹 오디오 컨텍스트 지연 없이 윈도우 사운드 서브시스템을 통해 교실 주목 알림 차임벨(Beep)을 즉각 재생합니다.
- **C/C++ 시그니처**:
  ```c
  int __stdcall CV_PlayAttentionAlert(int alertType);
  ```
- **파라미터**: `0` = 일반 비프, `1` = 안내/아스테리스크, `2` = 주의/경고, `3` = 질의, `4` = 정지
- **반환값**: `1` (성공), `0` (실패)

---

## 5. 빌드 및 테스트 자동화 파이프라인

### 5.1 빌드 스크립트 (`tools\build_dll.bat`)
외부 Visual Studio 도구 없이 Windows 기본 .NET 4.0 프레임워크 경로를 활용합니다:
```cmd
REM 1. Managed 코어 컴파일 (명시적 x86 32비트 타깃)
csc.exe /target:library /platform:x86 /out:src\dll\ClassroomVisualizerManaged.dll src\dll\LicenseCore.cs src\dll\NativeSystemCore.cs

REM 2. IL Thunk를 통한 Native Export PE 바이너리 어셈블
ilasm.exe /dll /out:src\dll\ClassroomVisualizerCore.dll src\dll\ClassroomVisualizerCore.il

REM 3. 배포 디렉터리(bin\) 복사
copy /y src\dll\*.dll bin\

REM 4. 네이티브 검증 테스트러너 빌드 및 전수 테스트 실행
csc.exe /target:exe /platform:x86 /out:bin\TestRunner.exe src\dll\TestRunner.cs
bin\TestRunner.exe
```

### 5.2 단위 테스트 검증 결과 (`src\dll\TestRunner.cs`)
10대 네이티브 stdcall 익스포트 함수에 대해 전수 자동 검증을 수행하였으며, 10개 전 테스트 통과를 달성했습니다:

```
============================================================
[TEST SUITE] ClassroomVisualizer Pure Native DLL Verification
============================================================
[TEST 1] CV_GetVersion: 0x01040400
         PASS: Version matches v1.4.4.0 (0x01040400)
[TEST 2] CV_ValidateKeyA: valid=1, invalid=0
         PASS: Checksum validation correct
[TEST 3] CV_IsTrialKeyA: trial=1, nonTrial=0
         PASS: Trial prefix detection correct
[TEST 4] CV_VerifyTrialStatus: active=1 (rem=21d), expired=0 (rem=0d)
         PASS: Trial expiration & remaining days calculation accurate
[TEST 5] CV_GetMachineFingerprintA: '81DFD1DE2A99CF03' (len=16)
         PASS: Machine fingerprint hash generated (16 hex chars)
[TEST 6] CV_GenerateTrialKeyA: 'TR30-79F2-TQRU-VXFW' (valid=1, trial=1)
         PASS: Dynamically generated trial key conforms to checksum and prefix
[TEST 7] CV_PreventSleep: enable=1, restore=1
         PASS: Win32 SetThreadExecutionState presentation sleep control operational
[TEST 8] CV_GetMonitorCount: 1 active monitor(s) detected
         PASS: Display monitor topology detection operational
[TEST 9] CV_GetVirtualScreenBounds: ok=1, rect=(0,0, 1920x1080)
         PASS: Virtual desktop geometry successfully retrieved
[TEST 10] CV_PlayAttentionAlert: alertType 0 returned 1
         PASS: Classroom audio alert call succeeded without exception
============================================================
[RESULT] 10 of 10 tests passed.
============================================================
```

---

## 6. 결론

본 순수 창작 DLL 시스템은 어떠한 외부 서드파티 라이브러리나 런타임 설치 없이도 교실용 실물화상기 환경에 필수적인 **절전 방지, 다중 모니터 분석, 무지연 오디오 차임벨, 오프라인 체크섬 검증 및 하드웨어 핑거프린팅**을 완벽하게 네이티브 수준으로 제공합니다.
Inno Setup 인스톨러 및 다양한 윈도우 호스트 프로세스에서 높은 안정성과 무결성을 발휘합니다.
