# 🗺️ Implementation Roadmap (작업 로드맵)

본 문서는 **Autonomous Coding Agent System v2.0** 표준(§3)에 따라 작성된 의존성 기반의 작업 로드맵입니다.
모든 작업 항목은 고유 식별자, 우선순위(P0~P3), 대상 파일, 승인 기준 및 검증 절차를 명시하며, 실제 관측 가능한 증거에 의해서만 `VERIFIED` 상태로 전이됩니다.

---

## 📊 작업 상태 요약 (Status Overview)

| ID | 작업 명칭 | 우선순위 | 의존성 | 상태 |
| :--- | :--- | :---: | :--- | :---: |
| **TASK-001** | 표준 UVC 카메라 스트림 및 다중 입력 장치 열거 | **P1** | None | `VERIFIED` |
| **TASK-002** | HTML5 Canvas 기반 실시간 판서, 도형 렌더링 및 캡처 | **P1** | TASK-001 | `VERIFIED` |
| **TASK-003** | 하드웨어 카메라 직접 제어 (플래시, 터치 포커스, 노출) | **P1** | TASK-001 | `VERIFIED` |
| **TASK-004** | 보안 및 네트워크 표면 축소 (불안정 무선 제거 & 최소 권한 방화벽) | **P0** | None | `VERIFIED` |
| **TASK-005** | Windows Inno Setup 패키징 및 단독 실행(`shellexec`) 보장 | **P1** | TASK-001, TASK-004 | `VERIFIED` |
| **TASK-006** | 시맨틱 버저닝(v1.3.1) 동기화 및 윈도우 CRLF 빌드 파이프라인 | **P2** | TASK-005 | `VERIFIED` |
| **TASK-007** | 표준 기술 문서 체계 구축 (Architecture, Security, Work Log 등) | **P2** | None | `VERIFIED` |
| **TASK-008** | GitHub Actions CI/CD 워크플로우 최신 Node 22 LTS 런타임 갱신 | **P3** | TASK-005, TASK-006 | `VERIFIED` |
| **TASK-009** | 듀얼 모니터 원클릭 점프 이동 (`#jumpMonitor`) | **P1** | TASK-001 | `VERIFIED` |
| **TASK-010** | 좌측/하단 분리형 메뉴 레이아웃 및 툴바 고정핀(📌) / 아코디언 드로어 엔진 | **P1** | TASK-002 | `VERIFIED` |
| **TASK-011** | 돋보기 복합 캔버스 렌더러 및 마우스 휠 크기/배율 제어, 형광펜 독립 컬러 팔레트 | **P1** | TASK-002 | `VERIFIED` |
| **TASK-012** | 인식된 카메라 지능형 3대 분류 및 상세정보 진단 모달창 (`#camInfoModal`) | **P1** | TASK-001 | `VERIFIED` |
| **TASK-013** | 카메라 계속된 권한 허용 팝업 완전 제거 (런처 플래그, applyConstraints, Smooth Handoff) | **P0** | TASK-001 | `VERIFIED` |
| **TASK-014** | 전체화면 선택 시 메뉴 고정 풀림(아코디언 모드) 및 클린 캡처/고화질 복합 녹화 엔진 | **P1** | TASK-010, TASK-002 | `VERIFIED` |
| **TASK-022** | 듀얼 모니터 점프 시 권한 팝업 차단 및 전체화면 안전 해제 파이프라인 | **P1** | TASK-009 | `VERIFIED` |
| **TASK-023** | 전체화면 카메라 해상도 정보 ON/OFF 토글 | **P1** | TASK-014 | `VERIFIED` |
| **TASK-024** | 수업 녹화 마이크 음성 합성 녹음 (Web Audio API 믹싱) | **P1** | TASK-015 | `VERIFIED` |
| **TASK-025** | 도형 내부 채우기(Fill) 색상 독립 팔레트 및 불투명도 엔진 | **P1** | TASK-002 | `VERIFIED` |
| **TASK-026** | 좌측 판서 도구 활성/비활성 토글 스위치 | **P2** | TASK-010 | `VERIFIED` |
| **TASK-027** | 텍스트 주석과 이동식 도형 상호 배타성 분리 | **P1** | TASK-002 | `VERIFIED` |
| **TASK-028** | 도형 생성 후 사후 수정 & 8방향 리사이즈 핸들 및 플로팅 미니 툴바 | **P1** | TASK-027 | `VERIFIED` |
| **TASK-029** | 돋보기(확대경) GPU 캔버스 캐싱 기반 60fps 무지연 렌더링 & 테두리 경계선 픽스 | **P1** | TASK-011 | `VERIFIED` |
| **TASK-030** | 형광펜 100% 균일 색상 오프스크린 단일패스 합성 아키텍처 | **P1** | TASK-011 | `VERIFIED` |
| **TASK-031** | 수업 녹화 데이터 유실 방어 쉴드 & 4K 동적 Undo 메모리 가드 | **P0** | TASK-024 | `VERIFIED` |

---

## 📝 세부 작업 명세서 (Task Specifications)

### TASK-001: 표준 UVC 카메라 스트림 및 다중 입력 장치 열거
- **Identifier**: `TASK-001`
- **Description**: 표준 UVC 드라이버 기반 웹캠 및 스마트폰 유선 연동 카메라를 무설치 환경에서 자동 탐색하고 해상도별 스트림을 렌더링.
- **Priority**: `P1`
- **Dependencies**: 없음
- **Target Files**:
  - `index.html`
  - `index.html`
- **Implementation Plan**:
  1. `navigator.mediaDevices.enumerateDevices()`를 통해 사용 가능한 영상 입력 장치(`videoinput`) 목록 파싱.
  2. 해상도 프로파일(4K, FHD, HD, VGA) 및 `facingMode`(`environment`, `user`) 제약조건 처리.
  3. `<video>` 요소 및 뷰파인더 캔버스에 0ms 지연 스트림 바인딩.
- **Acceptance Criteria**:
  - 드라이버 추가 설치 없이 표준 웹캠 및 Iriun/DroidCam UVC 스트림 수신.
  - 카메라 전환 드롭다운 및 모바일 플로팅 전환 버튼 정상 동작.
- **Validation Procedure**: 브라우저 디버깅 환경에서 MediaStream 인스턴스 활성화 및 비디오 트랙 수신 확인.
- **Status**: `VERIFIED`
- **Remaining Blockers**: 없음

---

### TASK-002: HTML5 Canvas 기반 실시간 판서, 도형 렌더링 및 캡처
- **Identifier**: `TASK-002`
- **Description**: 카메라 영상 상단에 투명 캔버스를 오버레이하여 판서, 도형, 텍스트를 그리고 스냅샷을 생성.
- **Priority**: `P1`
- **Dependencies**: `TASK-001`
- **Target Files**:
  - `index.html`
  - `index.html`
- **Implementation Plan**:
  1. 2D Canvas 컨텍스트를 활용한 펜, 형광펜, 지우개, 기하 도형(직선, 사각형, 원, 화살표) 렌더러 구현.
  2. 최대 40단계의 Undo/Redo 이력 스택 및 단축키(`Ctrl+Z`, `Ctrl+Y`) 핸들러 추가.
  3. 무손실 스냅샷(PNG), jsPDF 기반 다중 페이지 A4 PDF 묶기, WebM 미디어 레코더 연동.
- **Acceptance Criteria**:
  - 판서 지연 없는 부드러운 드로잉 및 프리뷰.
  - 스냅샷 썸네일 스트립 추가 및 2분할 좌우 비교 모드 동작.
- **Validation Procedure**: 캔버스 드로우 이벤트 및 이미지 Blob 생성 함수 실행 검증.
- **Status**: `VERIFIED`
- **Remaining Blockers**: 없음

---

### TASK-003: 하드웨어 카메라 직접 제어 (플래시, 터치 포커스, 노출)
- **Identifier**: `TASK-003`
- **Description**: 스마트폰 및 지원 웹캠의 하드웨어 기능(LED Torch, Focus Mode, Exposure Compensation)을 W3C ImageCapture API로 제어.
- **Priority**: `P1`
- **Dependencies**: `TASK-001`
- **Target Files**:
  - `index.html`
  - `index.html`
- **Implementation Plan**:
  1. `videoTrack.getCapabilities()`로 `torch`, `focusMode`, `exposureCompensation` 지원 여부 실시간 조회.
  2. 지원 시 툴바 토글 버튼, 터치 클릭 링 애니메이션, 노출 슬라이더 노출.
  3. `videoTrack.applyConstraints({ advanced: [...] })` 호출을 통한 하드웨어 제어.
- **Acceptance Criteria**:
  - 플래시 버튼 클릭 시 지원 기기의 LED 조명 즉시 점등/소등.
  - 화면 클릭 위치에 초점 링 표출 및 자동 초점 명령 전송.
  - 노출 슬라이더 조작 시 센서 밝기 보정 반영.
- **Validation Procedure**: ImageCapture capabilities 조회 및 constraints 객체 전달 확인.
- **Status**: `VERIFIED`
- **Remaining Blockers**: 없음

---

### TASK-004: 보안 및 네트워크 표면 축소 (불안정 무선 제거 & 최소 권한 방화벽)
- **Identifier**: `TASK-004`
- **Description**: 불필요하거나 보안 위험을 초래할 수 있는 외부 CDN 의존성(PeerJS)과 불안정한 P2P 무선 연결 모듈을 완전 제거하고, 인스톨러의 불필요한 인바운드 방화벽 개방을 차단하여 오프라인 보안을 확보.
- **Priority**: `P0`
- **Dependencies**: 없음
- **Target Files**:
  - `index.html`
  - `index.html`
  - `installer.iss`
- **Implementation Plan**:
  1. HTML 소스에서 외부 `peerjs.min.js`, QR 생성 라이브러리 및 소켓 연결 코드 영구 삭제.
  2. 무선 연결 팝업, 모달 및 툴바 버튼 UI 완전 정리.
  3. `installer.iss`에서 TCP 인바운드 포트 자동 개방(`netsh advfirewall add rule`) 제거.
  4. 언인스톨 단계에서 과거 설치된 레거시 방화벽 규칙을 청소하는 루틴 유지.
- **Acceptance Criteria**:
  - 외부 네트워크 단절 상태(완전 오프라인)에서도 로컬 실행 100% 정상 작동.
  - 로컬 포트 리스닝(Listening Port) 전무.
- **Validation Procedure**: 소스 코드 정적 분석 및 네트워크 호출 제거 확인, Inno Setup 스크립트 방화벽 규칙 검증.
- **Status**: `VERIFIED`
- **Remaining Blockers**: 없음

---

### TASK-005: Windows Inno Setup 패키징 및 단독 실행(`shellexec`) 보장
- **Identifier**: `TASK-005`
- **Description**: Inno Setup 6을 통한 언팩형 멀티파일 설치 프로그램 컴파일 및 설치 직후 안전한 브라우저 실행 지원.
- **Priority**: `P1`
- **Dependencies**: `TASK-001`, `TASK-004`
- **Target Files**:
  - `installer.iss`
- **Implementation Plan**:
  1. Multi-File 설치 구조 (`{app}` 내 html, assets, docs, tools 분리 배치).
  2. 기존 버전 설치 감지 및 대화상자(`InitializeSetup`) 구현.
  3. 설치 완료 후 실행 시 `CreateProcess error 2` 방지를 위해 `shellexec` 플래그 적용.
  4. 관리자 권한 및 무인 설치 스위치(`/SILENT`, `/VERYSILENT`) 지원.
- **Acceptance Criteria**:
  - `ISCC.exe`로 `dist/(AhBiYout) 공용 실물화상기 보기_Setup_v1.3.1.exe` 정상 빌드.
  - 설치 후 바로 열기 체크 시 기본 웹 브라우저로 에러 없이 즉시 실행.
- **Validation Procedure**: `ISCC.exe` 컴파일러 직접 실행 및 반환 코드 0 확인.
- **Status**: `VERIFIED`
- **Remaining Blockers**: 없음

---

### TASK-006: 시맨틱 버저닝(v1.3.1) 동기화 및 윈도우 CRLF 빌드 파이프라인
- **Identifier**: `TASK-006`
- **Description**: 모든 설정, UI, 스크립트의 버전을 `1.3.1`로 일치시키고 배치 파일 줄바꿈을 윈도우 표준 CRLF로 검증.
- **Priority**: `P2`
- **Dependencies**: `TASK-005`
- **Target Files**:
  - `version.json`
  - `build.bat`
  - `git-release.bat`
  - `tools/format_crlf.ps1`
- **Implementation Plan**:
  1. `version.json` 버전을 단일 진실 공급원(Single Source of Truth)으로 삼아 빌드 스크립트와 동기화.
  2. `build.bat`을 영문 라벨 기반의 견고한 스크립트로 개편하고 버전별 폴더(`dist/1.3.1/`) 자동 생성 지원.
  3. `tools/format_crlf.ps1`을 UTF-8 무손실 변환으로 수정하여 배치 파일 내 문자 깨짐 현상 차단.
- **Acceptance Criteria**:
  - `build.bat` 실행 시 에러 없이 산출물 생성 및 버전 폴더 격리.
  - 배치 파일 CRLF 줄바꿈 규격 준수.
- **Validation Procedure**: PowerShell 바이트 검사 및 빌드 실행 테스트.
- **Status**: `VERIFIED`
- **Remaining Blockers**: 없음

---

### TASK-007: 표준 기술 문서 체계 구축 (Architecture, Security, Work Log 등)
- **Identifier**: `TASK-007`
- **Description**: 시스템 v2.0 지침에 따라 아키텍처, 보안 감사, 작업 로그, 빌드/설치 매뉴얼, 라이선스를 완성.
- **Priority**: `P2`
- **Dependencies**: 없음
- **Target Files**:
  - `README.md`
  - `docs/ARCHITECTURE.md`
  - `docs/SECURITY.md`
  - `docs/MODULES.md`
  - `docs/BUILD.md`
  - `docs/INSTALL.md`
  - `docs/WORK_LOG.md`
  - `docs/CHANGELOG.md`
  - `docs/LICENSE.ko.md`
  - `docs/LICENSE.en.md`
- **Implementation Plan**:
  1. 각 영역별 실측 기반의 구체적 기술 정보 작성.
  2. 제작자(AhBiYout, AhBiYout-all) 및 공식 채널 링크 일원화.
- **Acceptance Criteria**:
  - 모든 필수 문서가 `docs/`에 유효하게 생성되고 교차 링크 검증 완료.
- **Validation Procedure**: 파일 존재 여부 및 마크다운 링크 정합성 확인.
- **Status**: `VERIFIED`
- **Remaining Blockers**: 없음

---

### TASK-008: GitHub Actions CI/CD 워크플로우 최신 Node 22 LTS 런타임 갱신
- **Identifier**: `TASK-008`
- **Description**: GitHub Actions 환경에서 지원 종료된 Node.js 20 대신 Node 22 LTS를 지정하고 자동 릴리즈 파이프라인 검증.
- **Priority**: `P3`
- **Dependencies**: `TASK-005`, `TASK-006`
- **Target Files**:
  - `.github/workflows/build-and-release.yml`
- **Implementation Plan**:
  1. `actions/setup-node@v4`의 `node-version`을 `'22'`로 명시.
  2. Git 태그 트리거(`v*`) 시 Inno Setup 컴파일 및 GitHub Release 업로드 단계 검증.
- **Acceptance Criteria**:
  - 워크플로우 구문 오류 없음 및 Node 22 지정.
- **Validation Procedure**: YAML 린트 및 릴리즈 단계 파싱 검증.
- **Status**: `VERIFIED`
- **Remaining Blockers**: 없음

---

### TASK-015: 캡처/녹화 포맷 엔진 리팩토링 및 동영상 0KB 비정상 저장 결함 해결
- **Identifier**: TASK-015
- **Description**: 수업 녹화 완료 시 미디어 스트림 청크 수집 및 파일 저장 파이프라인에서 컨테이너 헤더 완결을 보장하여 0KB 비정상 파일 생성을 차단.
- **Priority**: P0
- **Dependencies**: TASK-014
- **Status**: VERIFIED

---

### TASK-016: 가상 카메라 자동 연결 배제 및 화면 무한 복제(Droste Effect) 방어
- **Identifier**: TASK-016
- **Description**: DirectShow 가상 캡처 필터(screen-recorder-device, OBS Virtual Camera 등)를 자동 식별하여 자동 시작에서 영구 배제함으로써 카메라 미연결 시 화면 무한 자가 복제 루프 원천 차단.
- **Priority**: P0
- **Dependencies**: TASK-001
- **Status**: VERIFIED

---

### TASK-017: 순수 창작 Win32 Native DLL 15대 API 확장, VTable Fixup 및 예외 쉴드
- **Identifier**: TASK-017
- **Description**: 하드웨어 비프 톤, 디스크 용량 진단, 디스플레이 DPI 감지, 항상 위 창 고정, QPC 마이크로초 타이머 등 5대 신규 API를 증설하고 15개 전체 unmanaged export thunk에 IL 예외 쉴드 탑재 (테스트 15/15 PASS).
- **Priority**: P1
- **Dependencies**: None
- **Status**: VERIFIED

---

### TASK-018: Inno Setup 6 멀티파일 인스톨러 방화벽 규칙 사전 자동 등록 및 무인 설치
- **Identifier**: TASK-018
- **Description**: 언팩형 다중 파일 배포, 구버전 감지 시 덮어쓰기 안내, 무인 설치 스위치 지원, 설치 시 윈도우 방화벽 규칙 사전 조용 등록 및 삭제 시 완전 제거.
- **Priority**: P1
- **Dependencies**: TASK-005
- **Status**: VERIFIED

---

### TASK-019: GitHub Releases 기반 실시간 자동 업데이트 알림 팝업 시스템
- **Identifier**: TASK-019
- **Description**: 앱 시작 시 GitHub Releases 최신 태그를 비동기 조회하여 신규 릴리스 발견 시 버전 정보와 원클릭 다운로드 경로를 제공하는 사용자 대화상자 자동 실행.
- **Priority**: P2
- **Dependencies**: None
- **Status**: VERIFIED

---

### TASK-020: 구글 블로거 공식 포스팅 원고(서식 텍스트 / HTML 편집 모드) 체계화
- **Identifier**: TASK-020
- **Description**: 구글 블로그(ahbiyoutvibe.blogspot.com) 규격에 맞추어 [작성 모드(서식 있는 텍스트)] 및 [HTML 편집 모드] 원고를 작성하고, 제목-본문-업데이트-앱그림-다운로드-버전-요구사항-채널안내-전체업데이트-추천태그(20개 이하, 200자 이내) 순서 준수.
- **Priority**: P2
- **Dependencies**: None
- **Status**: VERIFIED

---

### TASK-021: 형광펜/펜 붓펜 촉 속도·필압 반응형 가변 너비 및 프리뷰 고도화
- **Identifier**: TASK-021
- **Description**: 형광펜 모드에서 붓펜 촉 선택 시 선 두께가 둥근 촉과 같게 고정되던 결함을 해결하고, 이동 속도와 필압에 실시간 반응하는 4단계 베지어 연속 보간 렌더링, 전용 붓펜 프리뷰 캔버스 및 타원 회전 커서 탑재.
- **Priority**: P1
- **Dependencies**: TASK-002
- **Status**: VERIFIED

---

### TASK-022: 듀얼 모니터 점프 시 권한 팝업 차단 및 전체화면 안전 해제 파이프라인
- **Identifier**: TASK-022
- **Description**: 수업 중 모니터 1/2 전환 시 브라우저 `window-management` 권한 상태를 사전 검증하여 팝업 없이 즉시 이동. 전체화면 상태에서 `window.moveTo()`가 무시되는 현상을 해결하기 위해 전체화면 일시 해제 후 안전 점프 파이프라인 탑재.
- **Priority**: P1
- **Dependencies**: TASK-009
- **Status**: VERIFIED

---

### TASK-023: 전체화면 카메라 해상도 정보 ON/OFF 토글
- **Identifier**: TASK-023
- **Description**: 전체화면 시 좌측 상단 카메라 해상도 정보 배지를 자동 은폐하되, 헤더 및 하단 툴바에서 원클릭으로 표시/숨김 전환 가능. CSS `:not(.cam-info-show-fs)` 조건부 선택자로 전체화면 상태에서도 사용자 의도대로 제어.
- **Priority**: P1
- **Dependencies**: TASK-014
- **Status**: VERIFIED

---

### TASK-024: 수업 녹화 마이크 음성 합성 녹음 (Web Audio API 믹싱)
- **Identifier**: TASK-024
- **Description**: 교사 마이크 음성을 Web Audio API의 `createMediaStreamSource`와 `MediaStreamAudioDestinationNode`로 실시간 믹싱하여 MediaRecorder 녹화 스트림에 합성. 마이크 미연결 시 자동 폴백하여 카메라 영상만 녹화.
- **Priority**: P1
- **Dependencies**: TASK-015
- **Status**: VERIFIED

---

### TASK-025: 도형 내부 채우기(Fill) 색상 독립 팔레트 및 불투명도 엔진
- **Identifier**: TASK-025
- **Description**: 도형의 선(스트로크)과 내부(필) 색상을 독립적으로 변경할 수 있는 전용 색상 피커, 불투명도(투명/25%/50%/솔리드) 조절 드롭다운, 그리고 하단 툴바 채우기 토글 버튼 양방향 동기화 구현.
- **Priority**: P1
- **Dependencies**: TASK-002
- **Status**: VERIFIED

---

### TASK-026: 좌측 판서 도구 활성/비활성 토글 스위치
- **Identifier**: TASK-026
- **Description**: 이미 선택된 판서 도구 버튼을 다시 클릭하면 일반 마우스 커서 모드(`selectTool('none')`)로 즉시 복귀하는 토글 동작 구현. Escape 키에도 동일한 도구 해제 연동.
- **Priority**: P2
- **Dependencies**: TASK-010
- **Status**: VERIFIED

---

### TASK-027: 텍스트 주석과 이동식 도형 상호 배타성 분리
- **Identifier**: TASK-027
- **Description**: 텍스트 주석 카드와 이동식 도형(Movable Shapes)이 동시에 선택/조작되던 문제를 해결하여 상호 배타적으로 작동하도록 이벤트 파이프라인 분리.
- **Priority**: P1
- **Dependencies**: TASK-002
- **Status**: VERIFIED

---

### TASK-028: 도형 생성 후 사후 수정 & 8방향 리사이즈 핸들 및 플로팅 미니 툴바
- **Identifier**: `TASK-028`
- **Description**: 기하 도형을 그린 직후뿐만 아니라 사후에도 자유롭게 클릭하여 선택하고, 8방향 핸들로 크기를 조절하며 미니 툴바를 통해 색상/채우기/굵기/선스타일을 변경하거나 캔버스에 영구 고정/삭제하는 엔진.
- **Priority**: `P1`
- **Dependencies**: TASK-027
- **Target Files**: `index.html`
- **Acceptance Criteria**:
  - 도형 선택 시 8개 리사이즈 핸들(`nw, n, ne, e, se, s, sw, w`) 노출 및 포인터 캡처 기반 리사이즈 정상 동작.
  - 플로팅 미니 툴바 버튼(색상 🎨, 채우기 ⬛, 굵기 📏, 스타일 〰️, 고정 📌, 삭제 ✕) 및 메인 툴바 양방향 동기화.
  - `Delete`, `Backspace`, `Escape` 키보드 인터랙션 완벽 대응.
- **Validation Procedure**: 7대 도형 생성 후 리사이즈 핸들 드래그, 미니 툴바 속성 변경, 핀 고정 및 캡처 합성 검증.
- **Status**: `VERIFIED`

---

### TASK-029: 돋보기(확대경) GPU 캔버스 캐싱 기반 60fps 무지연 렌더링 & 테두리 경계선 픽스
- **Identifier**: `TASK-029`
- **Description**: 돋보기 구동 시 매 프레임 GPU 캔버스 버퍼를 재할당하던 구조를 반경 변경 시에만 동적 할당하도록 캐싱하여 60fps 무지연 렌더링을 달성하고, 좌측 끝(x=0) 렌더링 멈춤 버그 수정.
- **Priority**: `P1`
- **Dependencies**: TASK-011
- **Target Files**: `index.html`
- **Acceptance Criteria**:
  - 마우스 이동 중 프레임 드랍 없이 60fps 매끄러운 돋보기 뷰 렌더링.
  - 화면 좌측 끝(x=0) 테두리 멈춤 현상 제거 및 기본 CSS 필터 우회 패스트패스 작동.
- **Validation Procedure**: 고속 마우스 이동 및 화면 최좌측 가장자리 확대 렌더링 관측.
- **Status**: `VERIFIED`

---

### TASK-030: 형광펜 100% 균일 색상 오프스크린 단일패스 합성 아키텍처
- **Identifier**: `TASK-030`
- **Description**: 획 꺾임이나 세그먼트 중복 렌더링 시 발생하는 알파 누적 얼룩을 오프스크린 캔버스 단일패스 비트맵 합성 기법으로 원천 차단하여 100% 균일한 색상 품질 유지.
- **Priority**: `P1`
- **Dependencies**: TASK-011
- **Target Files**: `index.html`
- **Acceptance Criteria**:
  - 형광펜으로 여러 번 꺾거나 천천히 그려도 획 겹침 구간에 알파 누적 얼룩이 발생하지 않음.
  - 4종 펜 촉(둥근 촉, 사각 촉, 캘리 촉, 붓펜 촉) 전체에 오프스크린 단일패스 합성 적용.
- **Validation Procedure**: 복잡한 지그재그 형광펜 판서 후 균일한 알파 채널(0.38) 유지 확인.
- **Status**: `VERIFIED`

---

### TASK-031: 수업 녹화 데이터 유실 방어 쉴드 & 4K 동적 Undo 메모리 가드
- **Identifier**: `TASK-031`
- **Description**: 수업 녹화 중 실수로 창 닫기/새로고침 시 데이터 손실을 방지하고, 녹화 중 비디오 스트림 변경을 차단하며, 4K 환경에서 RAM 누수 및 크래시를 방지하는 스마트 메모리 가드.
- **Priority**: `P0`
- **Dependencies**: TASK-024
- **Target Files**: `index.html`
- **Acceptance Criteria**:
  - 녹화 중 `beforeunload` 경고 팝업 작동.
  - 녹화 진행 중 카메라/해상도/미러링 전환 잠금 및 안내 모달 표출.
  - 4K 환경 동적 Undo 한도 산정(`getDynamicUndoLimit`, 최대 160MB 상한) 및 캡처 갤러리 30장 상한 관리.
- **Validation Procedure**: 녹화 중 창 닫기 시도, 녹화 중 해상도 변경 차단 확인, 4K 캔버스 Undo 스택 크기 측정.
- **Status**: `VERIFIED`
