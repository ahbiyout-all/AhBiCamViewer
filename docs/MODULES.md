# 🧩 모듈 명세서 (Module Specifications)

본 문서는 **아비캠뷰어 (AhBiCamViewer / Classroom Visualizer v1.4.8)**를 구성하는 주요 서브시스템과 기능 모듈의 책임, 경계, 공개 인터페이스 및 의존성을 정의합니다.

---

## 1. 모듈 개요 (Module Overview)

```
[ 아비캠뷰어 (AhBiCamViewer) Core v1.4.8 ]
  │
  ├── 1. DeviceCaptureModule            (카메라 감지, 3대 분류, 스트림 획득 & Smooth Handoff, 정보 토글)
  ├── 2. HardwareControlModule          (applyConstraints 인플레이스 해상도, 플래시/초점/노출)
  ├── 3. CameraDiagnosticModule         (카메라 상세정보 진단 모달창, 스펙 및 HW 능력치)
  ├── 4. DualMonitorModule              (멀티스크린 모니터 1 ↔ 모니터 2 무팝업 좌표 점프 이동)
  ├── 5. PinAndAccordionLayoutModule    (가로 아코디언, 툴바 고정핀, 전체화면 시 카메라 배지 자동 은폐)
  ├── 6. DrawingEngineModule            (베지어 판서, 기하도형, 내부 독립 채우기 색상, 도구 토글)
  ├── 7. HistoryManagerModule           (Undo / Redo 40단계 스택 및 캔버스 백업 복원)
  ├── 8. CompositeRenderingModule       (돋보기 영상+판서 동시 확대, 스포트라이트, 휠 제어)
  ├── 9. CleanExportAndRecordingModule  (메뉴 제외 클린 캡처, 🎙️ 마이크 음성 실시간 합성 MP4/WebM 녹화)
  ├── 10. NativeLicenseModule           (C#/IL Win32 DLL, 15종 네이티브 API, 오프라인 라이선스 & 체험)
  └── 11. WindowsPackagingModule        (Inno Setup 6단계 설치 시퀀스, 런처 VBS, 빌드 자동화)
```

---

## 2. 모듈별 상세 사양

### 2.1 DeviceCaptureModule
- **책임**: 로컬 USB 실물화상기, 외장 웹캠, 노트북 내장 카메라를 지능적으로 감지하고 분류하며, 권한 팝업 없이 최적 해상도 스트림을 연결하고 좌측 상단 카메라 해상도 정보 표시를 제어.
- **의존성**: W3C `navigator.mediaDevices`
- **주요 인터페이스 / 메서드**:
  - `classifyCamera(label, facing, index)`: 장치 레이블을 분석하여 실물화상기(`★`), 외장 웹캠(`🎥`), 노트북 내장(`💻`)으로 3대 분류.
  - `cameras(opts)`: 연결된 비디오 장치를 열거하고 우선순위별로 정렬하여 드롭다운 구성.
  - `startCamera(id)`: 지정된 장치 ID로 비디오 스트림 획득. 기기 전환 시 이전 스트림을 유지한 채 새 스트림을 획득하는 **Smooth Stream Handoff** 메커니즘 적용.
  - `onCameraSuccess(stream, facing, id)`: 스트림을 `<video>`에 연결하고 해상도 뱃지 및 상태 동기화.
  - `updateCamInfoVisibility()`: 좌측 상단 카메라 정보 표시 On/Off 토글 및 `localStorage` 보존. 전체화면 시 CSS `:fullscreen .res-badge`로 자동 완전 은폐.

### 2.2 HardwareControlModule
- **책임**: 비디오 트랙의 고급 하드웨어 기능(Torch, Focus, Exposure) 및 인플레이스 해상도 조절.
- **의존성**: W3C ImageCapture API (`track.applyConstraints()`, `track.getCapabilities()`)
- **주요 인터페이스**:
  - `resSelect.onchange`: `track.applyConstraints({ width, height })`를 직접 호출하여 스트림 재연결이나 권한 팝업 없이 센서 해상도를 실시간 가변 변경.
  - `toggleTorch(enable)`: 후면 LED 보조 조명 On/Off.
  - `triggerFocusAt(clientX, clientY)`: 터치/클릭 좌표 기반 연속 오토포커스 재조정.
  - `setExposure(ev)`: -2.0 ~ +2.0 EV 센서 노출 조정.

### 2.3 CameraDiagnosticModule
- **책임**: 연결된 카메라의 세부 하드웨어 스펙, 실제 비디오 트랙 수치, UVC 제어 가능 여부를 진단하는 모달창 제공.
- **주요 인터페이스**:
  - `openCameraDetailsModal()`: 모달 창 활성화 및 3대 진단 섹션 렌더링:
    - 섹션 1: 활성 비디오 스트림 실제 해상도, 프레임레이트(FPS), 종횡비, 장치 ID, 3대 분류 뱃지.
    - 섹션 2: 줌, 초점 모드, 노출 모드, 플래시 등 11개 세부 UVC HW 능력치 배지.
    - 섹션 3: 전체 감지 카메라 목록 및 원클릭 `[전환]` 버튼.
  - `copyCamDetailBtn.onclick`: 기술 지원 및 점검을 위한 포맷팅 텍스트 클립보드 원클릭 복사.

### 2.4 DualMonitorModule
- **책임**: 듀얼 모니터 또는 전자칠판 환경에서 브라우저 권한 허용 팝업 없이 창을 디스플레이 1과 디스플레이 2 사이로 원클릭 즉시 이동.
- **의존성**: Multi-Screen Window Management API 및 `window.screen` 좌표 계산
- **주요 인터페이스**:
  - `jumpToNextMonitor()`: 권한 허용 상태를 사전 점검하여 허용창 없이 부드러운 `window.moveTo()` 좌표 점프 수행.
  - 미지원 환경: Windows 표준 단축키(`Win + Shift + 방향키`) 안내 토스트 제공.

### 2.5 PinAndAccordionLayoutModule
- **책임**: 좌측 판서 메뉴와 하단 가로 아코디언 툴바(촬영·제어, 카메라·화질, 조절·도구 구역)의 고정핀(📌) 및 아코디언 드로어(자동 숨김) 모드 관리.
- **주요 인터페이스**:
  - `setLeftPinned(pinned, save)`: 좌측 툴바 고정/해제 전환 및 `localStorage`(`cv_pin_left`) 저장.
  - `setBottomPinned(pinned, save)`: 하단 툴바 고정/해제 전환 및 `localStorage`(`cv_pin_bottom`) 저장.
  - `toggleFullscreen()`: 전체화면 진입 시 자동으로 메뉴 고정을 해제(아코디언 모드)하고 좌측 상단 카메라 해상도 배지를 완전 숨김.

### 2.6 DrawingEngineModule
- **책임**: 비디오 상단 투명 캔버스 레이어에 부드러운 필기, 형광펜, 지우개, 7대 기하 도형, 텍스트 주석 렌더링 및 도구 활성/비활성 제어.
- **주요 인터페이스**:
  - `selectTool(t)`: 활성 도구 변경 및 상호 배타성 제어. `t === 'none'` 호출 시 일반 마우스 커서 모드로 복귀.
  - `setupToolWithFlyout`: 활성 상태인 도구 재클릭 시 `selectTool('none')`으로 비활성화 토글.
  - `shapeMasterBtn`: 활성/비활성 토글 및 텍스트 주석 도구와의 완벽한 상호 배타적 선택 보장.
  - `shapeFillColor` & `setShapeFillColor(c)`: 테두리 선 색상과 분리된 독립 내부 채우기 색상(7색 및 커스텀 피커) 지정 및 실시간 프리뷰 연동.
  - `markerColorPalette`: 형광펜 전용 독립 6색 팔레트 및 커스텀 컬러 피커 지원.
  - `startLaserLoop()`: 1.5초 후 자동으로 페이드아웃되는 잔상 레이저 펜 루프.

### 2.7 CompositeRenderingModule
- **책임**: 카메라 영상과 판서 내용을 실시간 복합 합성하여 발표 도구(돋보기, 스포트라이트) 제공.
- **주요 인터페이스**:
  - `renderMagnifier(x, y)`: 오프스크린 캔버스 기반으로 카메라 영상과 판서(`draw`)를 1:1 좌표계로 동시 확대 렌더링.
  - 마우스 휠 리스너:
    - 돋보기: 마우스 휠로 렌즈 반경(60~240px), `Shift + 휠`로 줌 배율(1.5~5.0x) 가변 조절.
    - 스포트라이트: 마우스 휠로 조명 반경(50~350px) 실시간 조절.

### 2.8 CleanExportAndRecordingModule
- **책임**: 메뉴 UI가 일체 찍히지 않는 순수 수업 콘텐츠 전용 캡처 및 선생님 목소리가 포함된 고음질 복합 동영상 녹화.
- **주요 인터페이스**:
  - `capture()`: 열려 있는 모든 풀다운을 자동 닫고, 카메라 영상(회전/반전/필터)과 순수 판서만 합성하여 고화질 JPG 저장 (단축키 `S`).
  - `record()`: 오프스크린 캔버스 30 FPS 렌더링 루프에 **선생님 마이크 오디오 트랙을 실시간 합성**하여 MP4/WebM으로 녹화.
    - 마이크 미연결 시 영상 단독 녹화로 안전 자동 전환, 녹화 중 메뉴 툴바 자동 수축, `[🔴 REC 00:00]` 인디케이터 배지 표시, 종료 시 타임스탬프 파일 다운로드.
  - `pdfAll()`: 캡처된 스냅샷들을 A4 랜드스케이프 규격의 다중 페이지 PDF 문서로 일괄 컴파일.

### 2.9 NativeSystemAndLicenseModule (`AhBiCamViewerCore.dll` / `Managed.dll`)
- **책임**: C#/IL 하이브리드 Win32 stdcall 네이티브 DLL을 통해 수업 중 디스플레이 절전 방지, 다중 모니터 위상 분석, 무지연 하드웨어 오디오 차임, 저장소 여유 공간 안전 진단, 전자칠판 DPI 스케일링 판별, Always-on-Top 및 오프라인 라이선스 검증 제공.
- **주요 인터페이스 (15대 Win32 stdcall 네이티브 익스포트)**:
  - `CV_GetVersion()`: DLL 바이너리 버전 반환 (`0x01040800` = v1.4.8).
  - `CV_ValidateKeyA(pKey)`: 오프라인 영구 라이선스 키 포맷 및 Mod 97 체크섬 검증.
  - `CV_IsTrialKeyA(pKey)`: `TR30-` 접두사 30일 체험키 판정.
  - `CV_VerifyTrialStatus(startDay, currentDay, trialDays, *pDaysRemaining)`: 30일 무료 체험 유효성 및 잔여 일수 계산.
  - `CV_GetMachineFingerprintA(pBuf, size)`: SHA-256 기반 학교/단말기 고유 16자리 식별자 획득.
  - `CV_GenerateTrialKeyA(pBuf, size)`: 체크섬 부합 유효 30일 체험키 동적 생성.
  - `CV_PreventSleep(enable)`: Win32 `SetThreadExecutionState` 기반 수업 중 디스플레이 꺼짐/절전 방지 및 복원.
  - `CV_GetMonitorCount()`: 활성 디스플레이 모니터 및 빔프로젝터 개수 감지.
  - `CV_GetVirtualScreenBounds(*left, *top, *width, *height)`: 다중 모니터 포괄 가상 데스크톱 전체 좌표 획득.
  - `CV_PlayAttentionAlert(alertType)`: Win32 `MessageBeep` 기반 무지연 교실 주목 알림 차임벨 재생.
  - `CV_PlayCustomTone(frequency, durationMs)`: Win32 `Beep` 기반 브라우저 스로틀링 없는 하드웨어 주파수 비프음 재생.
  - `CV_GetDiskFreeSpaceMB(pDrivePath, *pFreeMB)`: Win32 `GetDiskFreeSpaceExA` 기반 동영상 녹화 전 드라이브 잔여 공간(MB) 안전 진단.
  - `CV_GetDisplayDpi(*pDpiX, *pDpiY)`: Win32 GDI 기반 주 모니터 DPI 스케일링(96=100%, 120=125%, 144=150%, 192=200%) 판별.
  - `CV_SetWindowTopmost(hWnd, topmost)`: Win32 `SetWindowPos` 기반 수업 교재(PDF/PPT) 위 화상기 영상 Always-on-Top 플로팅 제어.
  - `CV_GetPerformanceTimeMs()`: Win32 QPC(QueryPerformanceCounter) 기반 마이크로초 정밀도 고해상도 단조 증가 타이머.
