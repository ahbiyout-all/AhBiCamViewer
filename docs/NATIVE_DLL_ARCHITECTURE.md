# 🏛️ 아비캠뷰어 (AhBiCamViewer) 순수 창작 네이티브 DLL 기술 아키텍처 및 상세 명세서

> **문서 버전:** v1.5.0 (엔진 v1.4.4 대응)  
> **최종 갱신일:** 2026-11-01  
> **개발자:** AhBiYout (AhBiYout-all)  
> **공식 저장소:** https://github.com/AhBiYout-all/ClassroomVisualizer  
> **대상 바이너리:** `bin/ClassroomVisualizerCore.dll` & `bin/ClassroomVisualizerManaged.dll`

---

## 1. 개요 및 순수 창작 설계 철학 (Executive Summary)

본 프로젝트는 상용 써드파티 보호기, 난독화 래퍼, 또는 불안정한 외부 C++ 런타임(MSVCRT 재배포 패키지)에 일체 의존하지 않고, **순수 Windows 표준 컴파일러(C# `csc.exe`)와 IL 어셈블러(`ilasm.exe`)만을 사용하여 독자 설계한 100% 순수 창작 Win32 네이티브 익스포트 DLL 아키텍처**를 채택하고 있습니다.

### 핵심 설계 목표
1. **외부 런타임 무의존(Zero Dependencies)**: Visual C++ 재배포 패키지(vcredist) 설치 없이 모든 Windows 7/8/10/11 시스템에서 100% 즉시 로드 보장.
2. **비관리형(Unmanaged) Win32 StdCall 완벽 호환**: Inno Setup(Pascal Script), C/C++, Delphi, Visual Basic 등 표준 Win32 호출자가 `LoadLibrary` / `GetProcAddress`를 통해 함수를 즉각 호출할 수 있는 정통 PE 익스포트 테이블 제공.
3. **완전한 예외 차단 쉴드(Fault-Tolerant Exception Isolation)**: 잘못된 포인터(NULL, 쓰레기 주소)나 예기치 않은 시스템 예외가 발생하더라도 호출자 프로세스(예: 설치 프로그램)가 절대 비정상 종료(Crash)되지 않고 안전하게 에러 코드를 반환하도록 보호.
4. **교실 수업 환경 특화 최적화**: 화면 꺼짐 방지, 고화질 DPI 스케일링 판별, 디스크 저장 공간 안전 진단, 0ms 레이턴시 하드웨어 알림음 등 수업 현장에 직결된 OS 제어 기능 탑재.

---

## 2. 듀얼 어셈블리 분리 아키텍처 및 동작 원리

아비캠뷰어의 네이티브 엔진은 **관리형 구현 계층(Managed Layer)**과 **비관리형 PE 썽크 계층(Unmanaged Thunk Layer)**이 철저히 분리된 2계층 듀얼 어셈블리 구조로 동작합니다.

```
+---------------------------------------------------------------------------------+
|  호출자 계층 (Caller: Inno Setup Pascal Script, Win32 Native App, C/C++ Host)    |
+---------------------------------------------------------------------------------+
                                     │
                 Win32 StdCall 호출 (PE Export Directory)
                                     ▼
+---------------------------------------------------------------------------------+
| [계층 1] ClassroomVisualizerCore.dll (순수 IL 어셈블리 썽크)                      |
|                                                                                 |
|  - PE Header: .corflags 0x00000002 (32BITREQUIRED)                              |
|  - VTable Fixups (.vtfixup [15] int32 fromunmanaged)                            |
|  - .export [1~15] 디렉터리 테이블                                               |
|  - 파라미터 경계 변환 (ANSI 포인터 ↔ CLR String, 역참조 stind.i4)                  |
|  - 구조적 예외 처리 (.try ... catch [mscorlib]System.Exception)                  |
+---------------------------------------------------------------------------------+
                                     │
                           CLR 내부 고속 프록시 호출
                                     ▼
+---------------------------------------------------------------------------------+
| [계층 2] ClassroomVisualizerManaged.dll (순수 C# 비즈니스 로직 & Win32 API)       |
|                                                                                 |
|  - LicenseCore.cs: Modulo-97 체크섬 알고리즘, 트라이얼 만료 계산, 머신 해시 생성      |
|  - NativeSystemCore.cs: SetThreadExecutionState (절전 방지), DPI 감지,          |
|                         디스크 용량(GetDiskFreeSpaceEx), 하드웨어 Beep 제어     |
+---------------------------------------------------------------------------------+
                                     │
                             Win32 서브시스템
                                     ▼
         [kernel32.dll]  [user32.dll]  [gdi32.dll]  (Windows OS 커널)
```

### 2.1 VTable Fixup (.vtfixup) 동작 메커니즘
표준 .NET 어셈블리는 원래 관리형 메타데이터만 포함하므로 C/C++ 등의 네이티브 코드가 일반 DLL 함수처럼 직접 호출할 수 없습니다.  
본 엔진은 **IL 어셈블러 고유 기능인 `.vtfixup`과 `.export` 지시자**를 순수하게 활용하여 이 문제를 해결합니다.

1. **VTable Fixup 테이블 정의**:
   ```il
   .vtfixup [15] int32 fromunmanaged at D_VTFIXUPS
   .data D_VTFIXUPS = bytearray (
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00 00 00 00 00
   )
   ```
   15개 익스포트 슬롯(슬롯당 4바이트, 총 60바이트)을 비관리형 호출 테이블로 사전 예약합니다.

2. **PE 익스포트 테이블 바인딩**:
   ```il
   .method public static int32 CV_GetVersion() cil managed
   {
     .vtentry 1 : 1
     .export [1] as CV_GetVersion
     ...
   }
   ```
   Windows OS의 PE 로더가 DLL을 메모리에 로드할 때, CLR 런타임이 해당 VTable Fixup 슬롯에 관리형 메서드로 점프하는 네이티브 스텁(Stub) 주소를 동적으로 패치합니다. 호출자는 이것이 .NET으로 작성되었는지 여부를 알 필요 없이 순수 C 함수처럼 호출할 수 있습니다.

### 2.2 메모리 마샬링 및 경계 안전성 (Memory Boundary Safety)
- **문자열 전달**: `native int`(C 포인터)를 받아 `Marshal::PtrToStringAnsi`로 변환하여 안전하게 처리합니다.
- **포인터 역참조 방어 (`stind.i4`)**: 출력 포인터(`int*`, `var Integer`)에 결과값을 기록할 때, `ldsfld IntPtr::Zero`와 `beq.s` 분기문으로 NULL 포인터 전달 여부를 사전에 검사한 후 `stind.i4`를 수행하여 세그멘테이션 폴트(Access Violation)를 원천 차단합니다.
- **고정 버퍼 출력**: `CopyStringToAnsiBuffer` 유틸리티를 통해 목적지 버퍼 크기(`bufferSize`)를 초과하지 않도록 철저히 `Math.Min(len, bufferSize - 1)`로 복사한 뒤 마지막 바이트에 명시적 NULL 종단 문자(`\0`)를 기록합니다.

### 2.3 구조적 예외 차단 쉴드 (.try ... catch)
모든 15개 IL 썽크 메서드는 최외곽에 `.try ... catch [mscorlib]System.Exception` 핸들러를 탑재하고 있습니다.  
하위 C# 로직이나 P/Invoke 호출 중 예외가 발생하더라도 CLR이 예외를 흡수하고 안전한 기본값(대부분 `0` 또는 `1`)을 리턴하므로 호출자 프로세스가 비정상 종료되는 일이 결코 발생하지 않습니다.

---

## 3. 전체 네이티브 API 상세 명세서 (15 Native APIs)

| 번호 | 함수명 | 반환 타입 | 파라미터 | 핵심 기능 |
| :---: | :--- | :---: | :--- | :--- |
| **[1]** | `CV_GetVersion` | `int32` | 없음 | 엔진 시맨틱 버전 16진수 반환 (v1.4.4 = `0x01040400`) |
| **[2]** | `CV_ValidateKeyA` | `int32` | `const char* pKey` | 16자리 라이선스 키 구조 및 Modulo-97 체크섬 검증 |
| **[3]** | `CV_IsTrialKeyA` | `int32` | `const char* pKey` | 30일 무료 체험 키(`TR30-`) 여부 판별 |
| **[4]** | `CV_VerifyTrialStatus` | `int32` | `int startDay, int curDay, int trialDays, int* pRem` | 트라이얼 유효성 판별 및 남은 일수 포인터 역참조 기록 |
| **[5]** | `CV_GetMachineFingerprintA` | `int32` | `char* pBuf, int bufSize` | 단말기 고유 하드웨어 지문(16자리 Hex SHA-256 해시) 버퍼 복사 |
| **[6]** | `CV_GenerateTrialKeyA` | `int32` | `char* pBuf, int bufSize` | 체크섬을 만족하는 유효한 30일 체험 키 동적 자동 생성 |
| **[7]** | `CV_PreventSleep` | `int32` | `int enable` | Win32 절전 모드 방지 제어 (`SetThreadExecutionState`) |
| **[8]** | `CV_GetMonitorCount` | `int32` | 없음 | 시스템에 연결된 활성 디스플레이/빔프로젝터 대수 감지 |
| **[9]** | `CV_GetVirtualScreenBounds` | `int32` | `int* pL, int* pT, int* pW, int* pH` | 다중 모니터 통합 가상 데스크톱 영역 좌표 및 해상도 반환 |
| **[10]** | `CV_PlayAttentionAlert` | `int32` | `int alertType` | 수업 주목 차임벨 사운드 재생 (`MessageBeep`) |
| **[11]** | `CV_PlayCustomTone` | `int32` | `int freq, int durationMs` | 브라우저 백그라운드 스로틀링 없는 하드웨어 주파수 비프음 (`Beep`) |
| **[12]** | `CV_GetDiskFreeSpaceMB` | `int32` | `const char* pPath, int* pFreeMB` | 동영상 녹화 전 저장 드라이브 여유 공간(MB 단위) 안전 조회 |
| **[13]** | `CV_GetDisplayDpi` | `int32` | `int* pDpiX, int* pDpiY` | 전자칠판 및 4K 프로젝터 주 모니터 DPI 스케일링 비율 조회 |
| **[14]** | `CV_SetWindowTopmost` | `int32` | `HWND hWnd, int topmost` | 수업 교재(PDF/PPT) 위에 화상기 영상을 띄우는 항상 위(PIP) 제어 |
| **[15]** | `CV_GetPerformanceTimeMs` | `int32` | 없음 | 마이크로초 정밀도의 Win32 고해상도 경과 시간 타이머 (QPC) |

---

### 3.1 개별 API 상세 스펙

#### [1] `CV_GetVersion`
- **C 서명**: `int __stdcall CV_GetVersion(void);`
- **Pascal 서명**: `function CV_GetVersion(): Integer;`
- **동작 원리**: 엔진의 시맨틱 버전(MAJOR, MINOR, PATCH, BUILD)을 32비트 정수로 패킹하여 반환합니다.
- **반환값**: `0x01040400` (v1.4.4.0)

#### [2] `CV_ValidateKeyA`
- **C 서명**: `int __stdcall CV_ValidateKeyA(const char* pKeyAnsi);`
- **Pascal 서명**: `function CV_ValidateKeyA(pKeyAnsi: PAnsiChar): Integer;`
- **알고리즘**:
  1. 하이픈(`-`) 제거 후 16자리 영숫자 확인.
  2. $\sum_{i=0}^{15} (\text{ASCII}(c_i) \times (i + 1)) \pmod{97} \equiv 1$
- **반환값**: 유효 시 `1`, 유효하지 않거나 NULL 포인터 시 `0`.

#### [3] `CV_IsTrialKeyA`
- **C 서명**: `int __stdcall CV_IsTrialKeyA(const char* pKeyAnsi);`
- **Pascal 서명**: `function CV_IsTrialKeyA(pKeyAnsi: PAnsiChar): Integer;`
- **동작 원리**: 키 유효성 검증을 통과하고 앞 4자리가 `TR30`으로 시작하는지 확인.
- **반환값**: 30일 체험 키인 경우 `1`, 정식 키 또는 무효 키인 경우 `0`.

#### [4] `CV_VerifyTrialStatus`
- **C 서명**: `int __stdcall CV_VerifyTrialStatus(int startDay, int currentDay, int trialDays, int* pDaysRemaining);`
- **Pascal 서명**: `function CV_VerifyTrialStatus(startDay, currentDay, trialDays: Integer; var daysRemaining: Integer): Integer;`
- **동작 원리**: 발급 기준일과 현재 일자의 차이를 계산하여 잔여 일수를 계산하고 `pDaysRemaining` 포인터에 안전하게 역참조 기록.
- **반환값**: 트라이얼 활성 시 `1`, 만료 시 `0`.

#### [5] `CV_GetMachineFingerprintA`
- **C 서명**: `int __stdcall CV_GetMachineFingerprintA(char* pOutBuffer, int bufferSize);`
- **Pascal 서명**: `function CV_GetMachineFingerprintA(pOutBuffer: PAnsiChar; bufferSize: Integer): Integer;`
- **동작 원리**: 머신 이름, 프로세서 개수, OS 아키텍처, 윈도우 디렉터리 정보를 결합하여 SHA-256 해시를 산출한 후 앞 16자리 Hex 문자열을 버퍼에 복사.
- **반환값**: 복사된 문자열 길이 (정상 시 `16`).

#### [6] `CV_GenerateTrialKeyA`
- **C 서명**: `int __stdcall CV_GenerateTrialKeyA(char* pOutBuffer, int bufferSize);`
- **Pascal 서명**: `function CV_GenerateTrialKeyA(pOutBuffer: PAnsiChar; bufferSize: Integer): Integer;`
- **동작 원리**: 접두사 `TR30`으로 시작하고 가독 문자셋(`A-Z`, `2-9`, `0/1/O/I` 제외)을 기반으로 Modulo-97 체크섬을 만족하는 19자리(`TR30-XXXX-XXXX-XXXX`) 체험 키를 난수 합성하여 버퍼에 반환.
- **반환값**: 복사된 문자열 길이 (정상 시 `19`).

#### [7] `CV_PreventSleep`
- **C 서명**: `int __stdcall CV_PreventSleep(int enable);`
- **Pascal 서명**: `function CV_PreventSleep(enable: Integer): Integer;`
- **동작 원리**: Windows Win32 API `SetThreadExecutionState`를 호출.
  - `enable != 0`: `ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED` 플래그로 수업 중 화면 보호기 및 절전 모드 차단.
  - `enable == 0`: `ES_CONTINUOUS`로 기본 절전 정책 복원.
- **반환값**: 성공 시 `1`, 실패 시 `0`.

#### [8] `CV_GetMonitorCount`
- **C 서명**: `int __stdcall CV_GetMonitorCount(void);`
- **Pascal 서명**: `function CV_GetMonitorCount(): Integer;`
- **동작 원리**: `GetSystemMetrics(SM_CMONITORS)`를 호출하여 시스템에 연결된 활성 디스플레이 개수 반환 (최소 1 이상 보장).
- **반환값**: 활성 모니터 대수 (예: `1`, `2`, `3`).

#### [9] `CV_GetVirtualScreenBounds`
- **C 서명**: `int __stdcall CV_GetVirtualScreenBounds(int* pLeft, int* pTop, int* pWidth, int* pHeight);`
- **Pascal 서명**: `function CV_GetVirtualScreenBounds(var left, top, width, height: Integer): Integer;`
- **동작 원리**: `SM_XVIRTUALSCREEN`, `SM_YVIRTUALSCREEN`, `SM_CXVIRTUALSCREEN`, `SM_CYVIRTUALSCREEN`을 통해 모든 모니터를 포괄하는 가상 데스크톱 좌표계 반환.
- **반환값**: 성공 시 `1`, 실패 시 `0`.

#### [10] `CV_PlayAttentionAlert`
- **C 서명**: `int __stdcall CV_PlayAttentionAlert(int alertType);`
- **Pascal 서명**: `function CV_PlayAttentionAlert(alertType: Integer): Integer;`
- **동작 원리**: Win32 `MessageBeep`를 호출하여 교실 주목용 시스템 차임벨 사운드 출력.
- **반환값**: 성공 시 `1`, 실패 시 `0`.

#### [11] `CV_PlayCustomTone` *(New)*
- **C 서명**: `int __stdcall CV_PlayCustomTone(int frequency, int durationMs);`
- **Pascal 서명**: `function CV_PlayCustomTone(frequency, durationMs: Integer): Integer;`
- **동작 원리**: Win32 `kernel32!Beep(frequency, durationMs)`를 호출하여 하드웨어 스피커를 통해 지정된 주파수(Hz)와 지속 시간(ms)으로 비프음을 재생합니다. 브라우저 비활성 탭 오디오 중단(Throttling) 현상에 일체 영향을 받지 않습니다.
- **반환값**: 성공 시 `1`, 실패 시 `0`.

#### [12] `CV_GetDiskFreeSpaceMB` *(New)*
- **C 서명**: `int __stdcall CV_GetDiskFreeSpaceMB(const char* pDrivePathAnsi, int* pFreeMB);`
- **Pascal 서명**: `function CV_GetDiskFreeSpaceMB(pDrivePathAnsi: PAnsiChar; var freeMB: Integer): Integer;`
- **동작 원리**: Win32 `kernel32!GetDiskFreeSpaceExA`를 호출하여 지정된 경로(기본값 `C:\`)의 사용 가능한 디스크 용량을 메가바이트(MB) 단위로 계산하여 반환합니다. 대용량 동영상 녹화 및 4K 캡처 전 0KB 파일 생성 사고를 사전 차단합니다.
- **반환값**: 성공 시 `1`, 실패 시 `0`.

#### [13] `CV_GetDisplayDpi` *(New)*
- **C 서명**: `int __stdcall CV_GetDisplayDpi(int* pDpiX, int* pDpiY);`
- **Pascal 서명**: `function CV_GetDisplayDpi(var dpiX, dpiY: Integer): Integer;`
- **동작 원리**: Win32 `user32!GetDC`와 `gdi32!GetDeviceCaps(hdc, LOGPIXELSX/Y)`를 호출하여 주 디스플레이의 실제 DPI 스케일링 비율(96=100%, 120=125%, 144=150%, 192=200%)을 반환합니다. 전자칠판 및 4K 프로젝터 환경에서 캔버스 좌표계 왜곡을 방지합니다.
- **반환값**: 성공 시 `1`, 실패 시 `0`.

#### [14] `CV_SetWindowTopmost` *(New)*
- **C 서명**: `int __stdcall CV_SetWindowTopmost(HWND hWnd, int topmost);`
- **Pascal 서명**: `function CV_SetWindowTopmost(hWnd: HWND; topmost: Integer): Integer;`
- **동작 원리**: Win32 `user32!SetWindowPos`를 호출하여 지정된 윈도우 핸들의 Z-Order를 `HWND_TOPMOST`(항상 위) 또는 `HWND_NOTOPMOST`(일반)로 전환합니다. 교사가 PDF 교과서나 PPT 화면 위에 실물화상기 영상을 띄워두고 수업할 수 있도록 지원합니다.
- **반환값**: 성공 시 `1`, 실패 시 `0`.

#### [15] `CV_GetPerformanceTimeMs` *(New)*
- **C 서명**: `int __stdcall CV_GetPerformanceTimeMs(void);`
- **Pascal 서명**: `function CV_GetPerformanceTimeMs(): Integer;`
- **동작 원리**: Win32 `kernel32!QueryPerformanceCounter` 및 `QueryPerformanceFrequency`를 호출하여 프로세스 시작 시점 대비 경과 밀리초를 마이크로초 정밀도로 산출하여 반환합니다.
- **반환값**: 경과 밀리초 (단조 증가 정수).

---

## 4. 빌드 파이프라인 및 도구 체인 (Build Pipeline)

본 아키텍처는 `build.bat` 및 `tools/build_dll.bat`를 통해 단 한 번의 명령으로 완전 자동화 빌드됩니다.

```batch
REM 1단계: 순수 C# 관리형 어셈블리 컴파일
csc /target:library /platform:anycpu /out:bin\ClassroomVisualizerManaged.dll /optimize+ ^
    src\dll\LicenseCore.cs src\dll\NativeSystemCore.cs

REM 2단계: VTable Fixup 기반 순수 IL 어셈블리 컴파일 (PE Export Directory 생성)
ilasm /dll /quiet /out=bin\ClassroomVisualizerCore.dll src\dll\ClassroomVisualizerCore.il

REM 3단계: 단위 검증 러너 컴파일 및 15개 전수 테스트 실행
csc /target:exe /platform:x64 /out:bin\TestRunner.exe /reference:bin\ClassroomVisualizerManaged.dll src\dll\TestRunner.cs
bin\TestRunner.exe
```

---

## 5. 단위 테스트 및 품질 보증 (QA Matrix)

`bin/TestRunner.exe` 실행 시 15개 전체 네이티브 함수에 대한 실시간 단위 검증이 수행되며, 단 하나의 오류도 없이 15/15 전원 합격을 달성하였습니다.

```
============================================================
[TEST SUITE] ClassroomVisualizer Pure Native DLL Verification (15 Tests)
============================================================
[TEST 1] CV_GetVersion: 0x01040400
         PASS: Version matches v1.4.4.0 (0x01040400)
[TEST 2] CV_ValidateKeyA: valid=1, invalid=0, null=0
         PASS: Checksum validation and NULL safety correct
[TEST 3] CV_IsTrialKeyA: trial=1, nonTrial=0
         PASS: Trial prefix detection correct
[TEST 4] CV_VerifyTrialStatus: active=1 (rem=21d), expired=0 (rem=0d)
         PASS: Trial expiration & remaining days calculation accurate
[TEST 5] CV_GetMachineFingerprintA: '81DFD1DE2A99CF03' (len=16)
         PASS: Machine fingerprint hash generated (16 hex chars)
[TEST 6] CV_GenerateTrialKeyA: 'TR30-MRMG-4L6K-ANAQ' (valid=1, trial=1)
         PASS: Dynamically generated trial key conforms to checksum and prefix
[TEST 7] CV_PreventSleep: enable=1, restore=1
         PASS: Win32 SetThreadExecutionState presentation sleep control operational
[TEST 8] CV_GetMonitorCount: 1 active monitor(s) detected
         PASS: Display monitor topology detection operational
[TEST 9] CV_GetVirtualScreenBounds: ok=1, rect=(0,0, 1920x1080)
         PASS: Virtual desktop geometry successfully retrieved
[TEST 10] CV_PlayAttentionAlert: alertType 0 returned 1
         PASS: Classroom audio alert call succeeded without exception
[TEST 11] CV_PlayCustomTone: 1200Hz 30ms returned 1
         PASS: Native hardware tone generator succeeded
[TEST 12] CV_GetDiskFreeSpaceMB: ok=1, free=14145 MB (13.8 GB)
         PASS: Disk free space query operational
[TEST 13] CV_GetDisplayDpi: ok=1, dpi=(96, 96), scale=100%
         PASS: Display DPI scaling operational
[TEST 14] CV_SetWindowTopmost: null hWnd returned 0
         PASS: Window topmost call handled safely without exception
[TEST 15] CV_GetPerformanceTimeMs: t1=0ms, t2=27ms, delta=27ms
         PASS: High-resolution monotonic performance counter operational
============================================================
[RESULT] 15 of 15 tests passed. (100% PASS)
============================================================
```

---

## 6. 결론 및 실무 가치

아비캠뷰어의 순수 창작 네이티브 DLL 아키텍처는:
1. **완전한 독립성**: 상용 난독화툴이나 C++ 컴파일러 없이도 Windows 표준 개발 도구만으로 정통 Win32 C/Pascal 호출 규격을 구현할 수 있음을 완벽히 입증하였습니다.
2. **소프트웨어 신뢰성**: 모든 포인터 역참조와 API 호출에 예외 방어 쉴드가 적용되어 학교 현장의 다양한 윈도우 버전 및 셋업 환경에서 단 한 번의 비정상 종료도 허용하지 않습니다.
3. **교실 수업 생산성 향상**: 하드웨어 비프음, 디스크 잔여 용량 사전 진단, 화면 절전 방지, 고화질 DPI 스케일링, Always-on-Top 등 수업 현장에 직결된 필수 기능들을 단 하나의 통합 바이너리로 무결하게 제공합니다.
