# 🏛️ 시스템 아키텍처 (System Architecture)

본 문서는 **아비캠뷰어 (AhBiCamViewer / Classroom Visualizer v1.4.0)**의 소프트웨어 구조, 기술 스택, 데이터 파이프라인, 네이티브 계층 및 보안 모델을 상세히 기술합니다.

---

## 1. 개요 및 설계 철학 (Overview & Principles)

본 실물화상기 솔루션은 공용 및 교실 교육 현장에서 고가의 전용 하드웨어 실물화상기 없이도, PC에 연결된 **표준 USB 실물화상기, 외장 웹캠, 노트북 내장 카메라 또는 스마트폰(유선/UVC 연동)**을 활용하여 고화질 실시간 교재 투사, 대화면 판서, 수업 녹화 및 모니터 확장을 무설치 환경에서 수행할 수 있도록 설계된 차세대 에듀테크 솔루션입니다.

### 핵심 설계 원칙
1. **Zero-Install & Zero-Config (무설치 플러그 앤 플레이)**: 런타임(Python, Java 등) 설치 없이 최신 웹 브라우저 엔진(Edge/Chrome Chromium)만으로 즉시 구동.
2. **100% Offline Resilience (오프라인 완결성)**: 인터넷이 차단된 폐쇄망 교실에서도 모든 핵심 기능(카메라 투사, 하드웨어 제어, 판서, PDF/WebM 생성, 오프라인 라이선스 인증) 완벽 동작.
3. **Hardware Direct Access & Clean Control**: W3C Media Capture / Image Capture API를 통해 UVC 하드웨어를 직접 제어하며, `track.applyConstraints`와 런처 플래그를 통해 브라우저 권한 팝업을 원천 배제.
4. **Clean Viewport & Non-Intrusive UI**: 전체화면 및 캡처/녹화 시 메뉴 UI를 100% 배제(Clean Composite Canvas)하여 수업 몰입감과 결과물 무결성 보장.
5. **Least Privilege & Native Security**: 순수 C#/IL 하이브리드 Win32 stdcall DLL을 통한 바이너리 무결성 검증 및 인바운드 포트 0개의 무방화벽 최소 권한 아키텍처.

---

## 2. 기술 스택 (Technology Stack)

| 계층 | 기술 요소 | 사용 목적 및 특징 |
| :--- | :--- | :--- |
| **코어 런타임** | HTML5 / Modern JavaScript (ES2022) | 단일 파일(SPA) 반응형 애플리케이션 |
| **비디오 스트림** | W3C `navigator.mediaDevices.getUserMedia` | UVC 표준 카메라 스트림 획득 (4K UHD / 8MP / FHD / HD) |
| **장치 진단 및 제어** | W3C ImageCapture API (`applyConstraints`) | 플래시(Torch), 탭 오토포커스, 센서 노출 및 인플레이스 해상도 가변 제어 |
| **디스플레이 제어** | Multi-Screen Window Placement API (`getScreenDetails`) | 듀얼 모니터 원클릭 점프 이동 (`#jumpMonitor`) |
| **판서 & 렌더링** | HTML5 2D Canvas Context API | 베지어 곡선 보간, 감압 필압, 도형 채우기, 형광펜 독립 팔레트 |
| **수업 보조 렌더러** | Composite Canvas Renderer (`requestAnimationFrame`) | 돋보기(확대경) 영상+판서 동시 확대, 스포트라이트, 잔상 레이저 |
| **영상 녹화 엔진** | Offscreen Canvas `captureStream(30)` + `MediaRecorder` | 메뉴 제외 순수 영상+판서 30 FPS WebM 동영상 실시간 녹화 |
| **문서 컴파일러** | 내장 경량 jsPDF 엔진 | 캡처 이미지 A4 랜드스케이프 규격 다중 페이지 PDF 변환 |
| **오디오 엔진** | Web Audio API (`AudioContext`, `OscillatorNode`) | 외부 파일 없는 신시사이저 기반 집중 벨 사운드 |
| **네이티브 코어** | Pure C#/IL Hybrid Win32 DLL (`ClassroomVisualizerCore.dll`) | 비관리(Unmanaged) stdcall 함수 수출(`.export`), 라이선스 검증 |
| **단독 실행 런처** | VBScript + Windows Script Host (`launcher.vbs`) | `--app="file:///..."` 및 `--use-fake-ui-for-media-stream` 앱 모드 구동 |
| **패키징** | Inno Setup 6.7.1 | DLL 무결성 검증, 언팩형 다중 파일 윈도우 인스톨러 생성 |

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
        FLAGS["--app=file:///... \n --use-fake-ui-for-media-stream"]
    end

    subgraph Browser Engine Runtime
        subgraph Device & Stream Management
            ENUM["classifyCamera (3대 분류 엔진)"]
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
            DRAW["<canvas id='draw'> 판서 캔버스 (베지어/도형/형광펜)"]
            OVERLAY["Grid / Timer / Focus Ring / Rec Indicator"]
        end

        subgraph Composite Rendering Engine
            MAG["renderMagnifier (영상+판서 동시 확대 / 휠 제어)"]
            RECCANVAS["Offscreen Composite Canvas (30 FPS)"]
        end

        subgraph Export Engine
            SNAP["Clean Snapshot (메뉴 100% 제외 JPG)"]
            REC["MediaRecorder (수업 녹화 WebM)"]
            PDF["A4 Multi-page PDF Compiler"]
        end
    end

    subgraph Native Security Layer
        DLL["ClassroomVisualizerCore.dll (Win32 stdcall)"]
        INNO["Inno Setup Installer (InitializeSetup 검증)"]
    end

    CAM1 & CAM2 & CAM3 --> ENUM
    ENUM --> STREAM
    STREAM --> VID
    VID & BOARD & DRAW --> MAG
    VID & BOARD & DRAW --> RECCANVAS
    RECCANVAS --> REC
    VID & BOARD & DRAW --> SNAP
    SNAP --> PDF
    MSCREEN --> DISP
    LAUNCHER --> FLAGS --> Browser Engine Runtime
    DLL --> INNO
```

---

## 4. 데이터 흐름 및 파이프라인 (Data Pipeline)

### 4.1 카메라 장치 분류 및 자동 연결 파이프라인
1. **장치 열거 및 3대 분류**: `navigator.mediaDevices.enumerateDevices()` 결과를 분석하여 키워드 매칭 기반으로 **실물화상기(★)**, **외장 웹캠(🎥)**, **노트북 내장(💻)**으로 분류 및 정렬.
2. **부드러운 스트림 인계 (Smooth Stream Handoff)**:
   - 기기 전환 시 기존 스트림을 미리 닫지 않고 새 스트림 획득에 성공한 직후에만 구 스트림을 종료하여 브라우저 활성 세션 유지(권한 팝업 방지).
3. **인플레이스 해상도 가변 조정**:
   - `resSelect.onchange` 시 `track.applyConstraints({ width, height })`를 직접 호출하여 스트림 재연결 없이 실시간 하드웨어 해상도 변경.

### 4.2 듀얼 모니터 점프 이동 메커니즘
1. Chromium `window.getScreenDetails()`를 호출하여 멀티 모니터 좌표계 파악.
2. 현재 활성 창이 위치한 스크린 인덱스를 계산하고 다음 모니터의 중심 좌표로 `window.moveTo()` 실행.
3. 구형 브라우저에서는 Windows 전용 단축키(`Win + Shift + 방향키`) 안내를 가이드로 제공.

### 4.3 툴바 고정핀(📌) 및 아코디언 드로어 엔진
1. **상태 관리**: 좌측 툴바(`cv_pin_left`), 하단 툴바(`cv_pin_bottom`)의 고정 여부를 `localStorage`에 영구 저장.
2. **아코디언 모드**: 고정 해제 시 화면 가장자리로 슬림 수축(`transform: translateY/X`)되며, 마우스 호버(`:hover`) 시 부드럽게 펼쳐지는 플로팅 서랍 전개.
3. **전체화면 연동**: 전체화면 진입 시 자동으로 메뉴 고정을 풀어 100% 뷰포트를 확보하고, 전체화면 종료 시 이전 고정 상태로 자동 원복.

### 4.4 클린 캡처 및 고화질 복합 녹화 파이프라인
1. **클린 캡처 (`capture`)**:
   - 실행 즉시 모든 풀다운 드롭다운을 자동 닫고, 일시적으로 `body.capturing` 클래스를 적용하여 화면 메뉴를 투명화.
   - 오프스크린 캔버스에 카메라 영상(필터/변형 적용)과 판서(`draw`)만 합성하여 JPG로 저장.
2. **복합 녹화 (`record`)**:
   - 오프스크린 캔버스 `recCanvas`를 생성하고 `requestAnimationFrame` 루프를 통해 카메라 영상과 판서를 30 FPS로 실시간 렌더링.
   - `recCanvas.captureStream(30)`을 `MediaRecorder`에 연결하여 **메뉴 UI가 일체 찍히지 않는 순수 수업 영상**을 WebM으로 녹화.
   - 녹화 중에는 화면 우측 상단에 펄스 애니메이션이 적용된 `[🔴 REC 00:00]` 인디케이터 표출.

---

## 5. 네이티브 DLL 및 보안 아키텍처

1. **C#/IL 하이브리드 네이티브 수출**:
   - C# 소스를 컴파일한 후 IL 어셈블리 수준에서 `.vtfixup` 및 `.export` 지시어를 주입하여 32비트 stdcall 네이티브 C API 함수(`CV_GetVersion`, `CV_ValidateKeyA`, `CV_IsTrialKeyA`, `CV_VerifyTrialStatus`)를 수출.
2. **인스톨러 무결성 검증**:
   - Inno Setup 설치 마법사 시작 시 `InitializeSetup()` 단계에서 DLL의 `CV_GetVersion`을 직접 호출하여 설치 바이너리의 변조 여부를 사전 차단.
3. **최소 권한 원칙**:
   - 백그라운드 리스닝 소켓 0개, 인바운드 방화벽 오픈 배제, 외부 통신 없는 100% 오프라인 동작 보장.
