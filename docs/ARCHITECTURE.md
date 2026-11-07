# 🏛️ 시스템 아키텍처 (System Architecture)

본 문서는 **아비캠뷰어 (AhBiCamViewer / Classroom Visualizer v1.4.8)**의 소프트웨어 구조, 기술 스택, 데이터 파이프라인, 네이티브 계층 및 보안 모델을 상세히 기술합니다.

---

## 1. 개요 및 설계 철학 (Overview & Principles)

본 실물화상기 솔루션은 공용 및 교실 교육 현장에서 고가의 전용 하드웨어 실물화상기 없이도, PC에 연결된 **표준 USB 실물화상기, 외장 웹캠, 노트북 내장 카메라 또는 스마트폰(유선/UVC 연동)**을 활용하여 고화질 실시간 교재 투사, 대화면 판서, 수업 녹화 및 모니터 확장을 무설치 환경에서 수행할 수 있도록 설계된 차세대 에듀테크 솔루션입니다.

### 핵심 설계 원칙
1. **Zero-Install & Zero-Config (무설치 플러그 앤 플레이)**: 별도 제조사 드라이버 설치 없이 최신 웹 표준 브라우저 엔진(Edge/Chrome Chromium)만으로 즉시 구동.
2. **100% Offline Resilience (오프라인 완결성)**: 외부 서버 및 CDN 의존성 없는 100% 로컬 독립 실행 (인터넷 차단 폐쇄망 교실 완벽 동작).
3. **Hardware Direct Access & Clean Control**: W3C Media Capture / Image Capture API를 통해 UVC 하드웨어를 직접 제어하며, `track.applyConstraints`로 권한 팝업을 원천 배제.
4. **Anti-Feedback & Virtual Device Shield**: DirectShow 가상 캡처 필터를 감지하여 화면 무한 자가 복제(Droste Effect)를 원천 차단.
5. **Clean Viewport & Non-Intrusive UI**: 전체화면 및 캡처/녹화 시 메뉴 UI를 100% 배제(Clean Composite Canvas)하며, 전체화면 시 좌측 상단 카메라 정보 자동 은폐 지원.
6. **Pure Native Acceleration (순수 창작 Win32 DLL)**: C#/IL 하이브리드 VTable Fixup 기반 15대 네이티브 Win32 stdcall API 탑재 및 예외 쉴드로 호스트 크래시 0% 달성.
7. **Single Source of Truth**: 완전 단일화된 단일 배포 파일(`index.html`) 아키텍처 채택.

---

## 2. 기술 스택 (Technology Stack)

| 계층 | 기술 요소 | 사용 목적 및 특징 |
| :--- | :--- | :--- |
| **코어 런타임** | HTML5 / Modern JavaScript (ES2022) | 단일 배포 파일(`index.html`) 반응형 고성능 웹 애플리케이션 |
| **비디오 스트림** | W3C `navigator.mediaDevices.getUserMedia` | UVC 표준 카메라 스트림 획득 (4K UHD / 8MP / FHD / HD) |
| **장치 진단 및 제어** | W3C ImageCapture API (`applyConstraints`) | 플래시(Torch), 탭 오토포커스, 센서 노출 및 인플레이스 해상도 가변 제어, 정보 배지 토글 |
| **가상 카메라 차단** | `isVirtualCamera` 필터링 엔진 | OBS Virtual Cam, screen-recorder-device 등 가상 카메라 무한 복제 원천 차단 |
| **디스플레이 제어** | Multi-Screen Window Management API + 좌표 이동 | 브라우저 권한 팝업 없는 듀얼 모니터 원클릭 무팝업 점프 이동 (`#jumpMonitor`) |
| **판서 & 렌더링** | HTML5 2D Canvas Context API | 베지어 곡선 보간, 감압 필압, 4대 촉, 기하 도형 내부 독립 채우기 색상, 판서 도구 활성/비활성 토글 |
| **수업 보조 렌더러** | Composite Canvas Renderer (`requestAnimationFrame`) | 돋보기(확대경) 영상+판서 동시 확대, 스포트라이트, 잔상 레이저 |
| **영상 녹화 엔진** | Offscreen Canvas `captureStream(30)` + 🎙️ 마이크 음성 실시간 합성 | 메뉴 제외 영상+판서+선생님 설명 목소리 30 FPS MP4/WebM 실시간 합성 녹화 |
| **문서 컴파일러** | 내장 경량 jsPDF 엔진 | 캡처 이미지 A4 랜드스케이프 규격 다중 페이지 PDF 변환 |
| **오디오 엔진** | Web Audio API + Win32 `kernel32!Beep` (`CV_PlayCustomTone`) | 신시사이저 차임음 및 하드웨어 스피커 직결 무지연 타이머 톤 송출 |
| **순수 창작 네이티브 코어** | Pure C#/IL Hybrid Win32 DLL (`AhBiCamViewerCore.dll`) | VTable Fixup 기반 15대 unmanaged stdcall 함수 수출 및 예외 쉴드 (v1.4.8) |
| **단독 실행 런처** | VBScript + Windows Script Host (`launcher.vbs`) | `--app="file:///..."` 및 격리 프로필을 통한 무팝업 단독 창 모드 구동 |
| **패키징 & 배포** | Inno Setup 6 | 언팩형 다중 파일 인스톨러, 6단계 설치 시퀀스(실행 중 앱 종료, 삭제/덮어쓰기 분기, 라이선스 선언) |

---

## 3. 시스템 구성도 (System Architecture Diagram)

```mermaid
flowchart TD
    subgraph Hardware Layer
        CAM1["실물화상기 (IPEVO, Aver 등)"]
        CAM2["외장 USB 웹캠 (Logitech, Brio 등)"]
        CAM3["노트북 내장 카메라 / 스마트폰 UVC"]
        DISP["듀얼 모니터 (Display 1 / Display 2)"]
    end

    subgraph Desktop Launcher Layer
        LAUNCHER["tools/launcher.vbs (Chromeless App)"]
        PROFILE["%LocalAppData%/AhBiCamViewer_AppProfile"]
    end

    subgraph Browser Engine Runtime
        subgraph Device & Stream Management
            ENUM["classifyCamera (3대 분류 엔진)"]
            VIRT["isVirtualCamera (가상 캡처 필터 차단)"]
            DIAG["CameraDetailsModal ([🔍 상세정보])"]
            STREAM["MediaStream & Smooth Handoff"]
            CONSTR["track.applyConstraints (무팝업 해상도/노출)"]
        end

        subgraph Display & Window Control
            MSCREEN["Multi-Screen Window Placement API"]
            FULLSCR["Fullscreen & Accordion Drawer Engine"]
        end

        subgraph Visual Viewport Layer
            VID["<video id='video'> Viewfinder"]
            BOARD["<div id='boardBg'> 칠판 배경판"]
            DRAW["<canvas id='draw'> 판서 캔버스 (4대 촉/도형/형광펜)"]
            OVERLAY["Grid / Timer / Focus Ring / Rec Indicator"]
        end

        subgraph Composite Rendering Engine
            MAG["renderMagnifier (영상+판서 동시 확대 / 휠 제어)"]
            RECCANVAS["Offscreen Composite Canvas (30 FPS)"]
        end

        subgraph Export Engine
            SNAP["Clean Snapshot (메뉴 100% 제외 JPG)"]
            REC["MediaRecorder (수업 녹화 MP4/WebM - 0KB 방지)"]
            PDF["A4 Multi-page PDF Compiler"]
        end
    end

    subgraph Native Win32 Core
        DLL["AhBiCamViewerCore.dll (15대 Native APIs)"]
        IL["VTable Fixup Export Thunk (.try ... catch Shield)"]
        SYS["Win32 System (Beep / GetDiskFreeSpace / DPI / Topmost / QPC)"]
    end

    CAM1 & CAM2 & CAM3 --> ENUM
    ENUM --> VIRT
    VIRT --> STREAM
    STREAM --> VID
    VID & BOARD & DRAW --> MAG
    VID & BOARD & DRAW --> RECCANVAS
    RECCANVAS --> REC
    VID & BOARD & DRAW --> SNAP
    SNAP --> PDF
    MSCREEN --> DISP
    LAUNCHER --> PROFILE --> Browser Engine Runtime
    DLL --> IL --> SYS
```

---

## 4. 데이터 흐름 및 파이프라인 (Data Pipeline)

### 4.1 카메라 장치 분류 및 가상 카메라 루프 차단 파이프라인
1. **장치 열거 및 3대 분류**: `navigator.mediaDevices.enumerateDevices()` 결과를 분석하여 키워드 매칭 기반으로 **실물화상기(★)**, **외장 웹캠(🎥)**, **노트북 내장(💻)**으로 분류 및 정렬.
2. **가상 카메라 식별 (`isVirtualCamera`)**:
   - `screen-recorder-device`, `OBS Virtual Camera`, `ManyCam`, `XSplit`, `vMix` 등 가상 캡처 필터를 감지하여 `[🖥️ 가상 카메라]`(최하위 우선순위 99)로 분류.
   - 사용자 명시적 클릭 없이 **자동 연결 및 시작을 영구 배제**하여 화면 무한 자가 복제(Droste Effect)를 원천 차단.
3. **부드러운 스트림 인계 (Smooth Stream Handoff)**:
   - 기기 전환 시 기존 스트림을 미리 닫지 않고 새 스트림 획득에 성공한 직후 구 스트림을 종료하여 브라우저 활성 세션 유지.
4. **인플레이스 해상도 가변 조정**:
   - `resSelect.onchange` 시 `track.applyConstraints({ width, height })`를 직접 호출하여 스트림 재연결 없이 실시간 하드웨어 해상도 변경.

### 4.2 클린 캡처 및 고화질 복합 녹화 파이프라인 (0KB 방지)
1. **클린 캡처 (`capture`)**:
   - 실행 즉시 모든 풀다운 드롭다운을 닫고, 오프스크린 캔버스에 카메라 영상과 판서(`draw`)만 합성하여 JPG로 저장.
2. **복합 녹화 (`record`)**:
   - 오프스크린 캔버스 `recCanvas`를 생성하고 `requestAnimationFrame` 루프를 통해 카메라 영상과 판서를 30 FPS로 실시간 렌더링.
   - `MediaRecorder` 청크 수집 엔진을 최적화하여 녹화 종료 시 정상적인 컨테이너 완결을 보장함으로써 0KB 저장 사고를 원천 방지.

---

## 5. 순수 창작 Native DLL 15대 API 구조

`AhBiCamViewerCore.dll`은 C#/IL 하이브리드 아키텍처를 적용하여 100% C/C++ 네이티브 `stdcall` 바이너리 인터페이스를 제공합니다:

1. `CV_GetVersion`: 바이너리 버전 반환 (0x01040400).
2. `CV_ValidateKeyA`: Modulo-97 가중 체크섬 알고리즘 기반 라이선스 키 검증.
3. `CV_IsTrialKeyA`: 체험판 접두사(`TR30-`) 식별.
4. `CV_VerifyTrialStatus`: 머신별 체험판 30일 만료 여부 및 잔여일 계산.
5. `CV_GetMachineFingerprintA`: 하드웨어 고유 16진수 지문(Fingerprint) 생성.
6. `CV_GenerateTrialKeyA`: 머신 지문 결합 정합 키 자동 생성.
7. `CV_PreventSleep`: 수업 발표 중 시스템 절전 모드 차단.
8. `CV_GetMonitorCount`: 연결된 활성 디스플레이 모니터 수 탐지.
9. `CV_GetVirtualScreenBounds`: 다중 모니터 통합 가상 데스크톱 좌표계 반환.
10. `CV_PlayAttentionAlert`: 수업 주목 차임 사운드 송출.
11. `CV_PlayCustomTone`: Win32 `kernel32!Beep` 하드웨어 스피커 직결 무지연 비프음.
12. `CV_GetDiskFreeSpaceMB`: 대상 드라이브의 실시간 잔여 저장공간(MB) 진단.
13. `CV_GetDisplayDpi`: 주 모니터 DPI(96=100%, 120=125%, 144=150%, 192=200%) 실시간 감지.
14. `CV_SetWindowTopmost`: 실물화상기 창 항상 위(Always-on-Top) 고정 PIP 뷰 지원.
15. `CV_GetPerformanceTimeMs`: Win32 `QueryPerformanceCounter` 마이크로초 정밀도 고해상도 타이머.
