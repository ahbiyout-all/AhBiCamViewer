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

---

## 📝 세부 작업 명세서 (Task Specifications)

### TASK-001: 표준 UVC 카메라 스트림 및 다중 입력 장치 열거
- **Identifier**: `TASK-001`
- **Description**: 표준 UVC 드라이버 기반 웹캠 및 스마트폰 유선 연동 카메라를 무설치 환경에서 자동 탐색하고 해상도별 스트림을 렌더링.
- **Priority**: `P1`
- **Dependencies**: 없음
- **Target Files**:
  - `교실용_실물화상기.html`
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
  - `교실용_실물화상기.html`
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
  - `교실용_실물화상기.html`
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
  - `교실용_실물화상기.html`
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
