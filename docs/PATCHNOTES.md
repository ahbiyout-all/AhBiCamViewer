# 📋 패치노트 및 버전 관리 (Release Notes & Changelog)

본 프로젝트는 **Semantic Versioning 2.0.0 (MAJOR.MINOR.PATCH)** 규칙을 엄격히 준수하여 버전을 관리합니다.

> [!IMPORTANT]
> **코드 수정 특이점 발생 시 자동 기록 및 버전 관리 원칙 (Automated Versioning & Patchnotes Policy)**
> 본 프로젝트는 코드 수정 과정에서 다음과 같은 '특이점'이 발생할 때마다 즉시 본 패치노트와 기술 문서에 변경 사항을 상세히 기록하고 버전을 상향 관리합니다:
> 1. **신규 핵심 기능 추가 및 API 증설**: 순수 창작 DLL 신규 Win32 API 증설, 맞춤 펜 촉 디자인, 신규 수업 지원 도구 탑재 등.
> 2. **치명적 결함 및 버그 해결**: 동영상 0KB 비정상 저장 결함, 가상 카메라 무한 복제(Droste Effect) 루프 방어 등.
> 3. **아키텍처 및 보안/배포 정책 변경**: Inno Setup 멀티파일 인스톨러 방화벽 사전 등록, GitHub Actions Node.js 22 LTS 전환, 권한 팝업 차단 격리 프로필 적용 등.
> 4. **버전 동기화 (Single Source of Truth)**: `version.json`을 기준으로 단일 index.html 배포 파일, `installer.iss`, 네이티브 DLL, 전체 기술 문서를 즉시 100% 동기화합니다.

---

### 🧹 배포 산출물 및 인스톨러 불필요 파일/폴더 전면 정격화 (2026-11-09)
- **점검 배경 및 최적화 목표**:
  - 인스톨러 및 포터블 패키지에 포함된 파일 전수 점검 요구 반영.
  - 교실 및 공용 PC 환경에서 사용자에게 불필요한 개발자 전용 문서/스크립트/중복 파일이 배포 패키지에 포함되는 것을 원천 차단하고 순수 런타임 파일만 정갈하게 제공.
- **점검 결과 및 조치 내역**:
  1. **인스톨러 중복 파일 제거 ({app}\tools)**:
     - `tools\launcher.vbs` 및 `tools\AhBiCamViewer.bat`가 `{app}` 루트와 `{app}\tools`에 이중 복사되던 중복을 제거하여 `{app}` 단일 배치로 일원화.
  2. **사용자 비필요 개발자 전용 문서 인스톨러 제외**:
     - `{app}\docs`에 복사되던 개발 작업 일지(`WORK_LOG.md`, 1280줄), 블로그 원고(`BLOG_POST.md`), 소스 빌드 가이드(`BUILD.md`), CI/CD 명세(`GITHUB.md`), 내부 아키텍처/모듈 사양서(`ARCHITECTURE.md`, `NATIVE_DLL_ARCHITECTURE.md`, `MODULES.md`, `ROADMAP.md`, `SECURITY.md`)를 인스톨러 `Excludes`에 등록.
     - 사용자에게 필요한 `README.md`(수업자료 매뉴얼), `INSTALL.md`(설치 가이드), `LICENSE.ko.md` / `LICENSE.en.md`(라이선스), `PATCHNOTES.md` / `CHANGELOG.md`만 정확히 배포.
  3. **포터블 패키지 (Portable ZIP) 클린 스테이징 파이프라인 구축**:
     - 기존 전체 폴더 일괄 압축 방식으로 인해 포함되던 단위 테스트 바이너리(`bin\TestRunner.exe`), 개발용 스크립트(`build_dll.bat`, `check_syntax.cjs`, `format_crlf.ps1`, `make_icon.ps1`, `push_to_github.cjs`)를 완전 배제.
     - 임시 스테이징 디렉토리를 통해 순수 실행에 필요한 런타임 파일만 엄선 압축하도록 `build.bat` 자동화 파이프라인 고도화.
  4. **루트 `launcher.vbs` 최신화 동기화**:
     - 다중 모니터 권한 및 Chromium 플래그가 누락되어 있던 루트 `launcher.vbs`를 최신 `tools/launcher.vbs`와 100% 동기화.
- **영향 파일**: `installer.iss`, `build.bat`, `launcher.vbs`, `README.md`, `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`

---

### 🚀 v1.4.8 — 교실 수업 편의성 6대 핵심 기능 및 결함 개선 (2026-11-07)
- **도입 배경 및 사용자 피드백 해결 (Background & User Feedback)**:
  1. `모니터 1,2 전환시에 허용창뜸`: 모니터 점프 버튼 클릭 시 크로미움 브라우저의 전체 화면 배치 권한 팝업이 노출되던 불편함 해소.
  2. `전체화면 시에 왼쪽상단에 카메라정보 나오지 않도록합니다. 왼쪽상단에 카메라정보를 on/off 할 수 있도록 합니다`: 전체화면 수업 시 상단 배지가 시야를 가리는 현상을 차단하고, 언제든 자유롭게 켜고 끌 수 있는 토글 지원.
  3. `수업녹화시에 소리가 녹음되지 않음`: 동영상 수업 녹화 시 캔버스 비디오만 캡처되어 선생님의 설명 목소리가 누락되던 결함 전면 해결.
  4. `텍스트, 도형 같이 선택이 됨`: 텍스트 도구와 도형 도구가 동시에 활성 상태로 표시되던 상호 배타성 미비 결함 완벽 해결.
  5. `도형 내부에 색상변경이 되도록 합니다`: 도형 테두리 선 색상에 묶여 있던 내부 채우기 색상을 자유롭게 변경할 수 있도록 독립 팔레트 탑재.
  6. `왼쪽 판서 메뉴 클릭마다 활성/비활성이 되도록 합니다`: 활성화된 판서 도구를 다시 누르면 즉시 해제되어 일반 마우스 커서로 손쉽게 복귀 가능하도록 토글 메커니즘 전면 적용.
- **아키텍처 및 상세 구현 내역**:
  1. **모니터 점프 권한 팝업 원천 차단 (`jumpToNextMonitor`)**:
     - `window.getScreenDetails()` 무조건 호출을 배제하고, `navigator.permissions.query`를 통해 권한이 이미 'granted'된 경우에만 호출.
     - 미허용 상태에서는 권한 팝업을 띄우지 않고 `window.screenX/screenLeft`와 `availWidth` 좌표 계산 기반의 순수 윈도우 이동(`window.moveTo`)으로 무팝업 점프 처리.
     - `tools/launcher.vbs` 격리 프로필 환경 설정(`Preferences`)에 `window_management` 및 `window_placement` 사전 등록 및 실행 플래그(`--enable-features=WindowPlacement,WindowManagement`) 추가.
  2. **전체화면 카메라 정보 숨김 및 ON/OFF 토글 시스템**:
     - CSS `:fullscreen .res-badge, body.is-fullscreen .res-badge { display: none !important; }`로 전체화면 시 좌측 상단 카메라 해상도 배지 완전 은폐.
     - 하단 가로 툴바 카메라 구역 및 상단 헤더에 `ℹ️ 정보 ON / OFF` 토글 버튼 탑재 및 `localStorage(cv_cam_info_visible)` 상태 연동.
  3. **수업 녹화 마이크 음성 실시간 합성 (`record.onclick`)**:
     - 녹화 시작 시 `navigator.mediaDevices.getUserMedia({ audio: { echoCancellation: true, noiseSuppression: true, autoGainControl: true } })`로 마이크 음성 스트림 획득.
     - 캔버스 스트림에 마이크 오디오 트랙을 합성(`recStream.addTrack`)하여 MP4/WebM 녹화 파일에 고음질 음성 동시 기록.
     - 마이크 미연결 시 무음 영상으로 안전 자동 폴백되며, 녹화 중지 시 마이크 하드웨어 리소스 즉시 해제.
  4. **텍스트 및 도형 상호 배타적 선택 보장**:
     - `selectTool('textTool')` 호출 시 도형 마스터 버튼 및 모든 하위 도형의 활성 클래스(`.active`) 즉각 제거.
     - 도형 도구 선택 시 텍스트 도구의 활성 클래스 즉각 제거.
     - HTML 마크업 내 `shapeRect`의 `active` 하드코딩 제거.
  5. **도형 내부 채우기 색상(Fill Color) 독립 선택 시스템**:
     - 도형 플라이아웃 패널 내 전용 내부 채우기 색상 팔레트(자동/테두리와동일, 화이트, 옐로우, 스카이, 민트, 핑크, 블랙) 및 커스텀 컬러 피커(`#shapeCustomFillPicker`) 신설.
     - `drawShapeOn`, 실시간 도형 프리뷰, 드로잉 캔버스, 이동식 도형 카드, 캔버스 고정(Bake), 캡처/녹화 캔버스 전역에 `effFillCol` 동기화.
  6. **좌측 판서 메뉴 클릭 시 활성/비활성(일반 커서) 토글**:
     - `setupToolWithFlyout` 및 `shapeMasterBtn`에서 활성 상태인 도구를 다시 클릭 시 `selectTool('none')` 호출로 비활성화.
     - 판서 도구가 해제되면 커서가 `default`로 복귀하고 펜/지우개 커서가 숨겨지며, 카메라 영상 조작 및 일반 마우스 작업이 가능.
- **영향 파일**: `index.html`, `tools/launcher.vbs`, `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`

---

### ⚙️ Inno Setup 기존 앱 종료 알림 및 이전 버전 실제 삭제 분기 완비 (2026-11-07)
- **도입 배경 및 사용자 피드백 해결 (Background & User Feedback)**:
  - "기존 앱 강제 종료-알림 없음": 실행 중인 앱을 사전 예고 없이 무통보 강제 종료하던 문제를 해결하여, 앱 실행 감지 시 사용자 안내 팝업을 먼저 띄우고 종료하도록 개선.
  - "이전 버전 감지 및 분기-실제 실행안됨": [예: 삭제 후 설치]를 선택했음에도 실제 언인스톨 및 디렉토리 삭제가 즉시 실행되지 않고 지연되던 문제를 해결하여, 선택 즉시 `unins000.exe` 무인 실행 + `DelTree` 완전 폴더 청소 + 성공 알림창 표출까지 완벽하게 직렬 분기 실행.
- **아키텍처 및 구현 내역**:
  1. **실행 중 앱 지능형 감지 및 사전 알림 (`IsExistingAppRunning`)**:
     - `tasklist` 및 PowerShell WMI를 통해 앱 창(`아비캠뷰어*`, `AhBiCamViewer*`, `ClassroomVisualizer*`) 및 격리 프로필(`AhBiCamViewer_AppProfile`) 실행 상태 실시간 감지.
     - 앱 구동 확인 시: `현재 실행 중인 [아비캠뷰어] 프로그램이 감지되었습니다. 안전한 설치 및 파일 업데이트를 위해 실행 중인 프로그램을 자동으로 종료합니다.` 안내창 표출 후 안전하게 프로세스 종료.
  2. **이전 버전 삭제 분기 즉시 실행 및 피드백 알림 (`UninstallPreviousVersion`)**:
     - [예 (Y)] 선택 시 `InitializeSetup` 단계에서 즉각 `unins000.exe /VERYSILENT` 호출.
     - 언인스톨러 종료 후 `DelTree(OldInstallDir, True, True, True)`로 잔여 파일/폴더 완전 제거.
     - 레지스트리 잔여 키 완전 말소.
     - `기존 버전이 안전하게 완전 삭제되었습니다. 최신 버전 설치를 계속 진행합니다.` 안내창 표출.
  3. **덮어쓰기 [아니오] 및 취소 분기 보장**:
     - [아니오 (N)] 선택 시 기존 파일 삭제를 건너뛰고 제자리 덮어쓰기(업그레이드) 모드로 라이선스 화면 진입.
     - [취소 (Cancel)] 선택 시 설치를 즉시 중단하고 종료.
- **영향 파일**: `installer.iss`, `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`

---

### ⚙️ Inno Setup 6단계 설치 시퀀스 결함 완전 해결 및 검증 (2026-11-07)
- **원인 분석 및 미적용 결함 해결 (Root Cause Resolution)**:
  1. **레지스트리 이중 중괄호(Double-Brace) 버그 수정**: Inno Setup 전처리기에서 `{#SetupSetting("AppId")}` 참조 시 스크립트에 이스케이프된 `{{...`가 그대로 전달되어 `{{E68A9F21..._is1`이라는 잘못된 경로를 조회함에 따라 기존 설치본을 감지하지 못하고 삭제/덮어쓰기 안내창이 생략되던 결함 원천 해결. 정규 GUID 키(`{E68A9F21-7A39-4E61-9A3F-470295BCA120}_is1`)로 직접 매핑.
  2. **프로세스 강제 종료 필터 문법 오류 수정**: `taskkill /FI "WINDOWTITLE eq *아비캠뷰어*"`에서 선행 와일드카드(`*`) 사용 시 윈도우가 "검색 필터를 인식할 수 없습니다" 에러를 반환하던 문제를 접미사 와일드카드(`아비캠뷰어*`)로 수정하고, 격리 프로필(`AhBiCamViewer_AppProfile`) 백그라운드 WMI 강제 종료 연동.
  3. **라이선스 화면 인코딩 최적화**: 마크다운 파일 대신 UTF-8 BOM(`\uFEFF`)이 포함된 전용 텍스트(`assets/LICENSE.txt`)를 `LicenseFile`로 지정하여 한글 깨짐 없이 선명하게 표출.
  4. **바탕화면 바로가기 기본 체크 유지**: `UsePreviousTasks=no` 및 `Flags: checkedonce`를 동시 적용하여 과거 실행 이력과 무관하게 항상 기본 체크되도록 보장.
- **검증 완료**: `reg query`를 통한 실제 시스템 레지스트리 키 정합성 대조 확인 및 Inno Setup `build.bat` 컴파일 완료.
- **영향 파일**: `installer.iss`, `assets/LICENSE.txt`, `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`

---

### ⚙️ Inno Setup 설치 마법사 전체 시퀀스 및 사용자 대화형 업그레이드 체계화 (2026-11-07)
- **도입 배경 및 사용자 니즈 (Background & User Need)**:
  - 인스톨러 구동 시 기존에 열려 있는 앱과의 파일 잠금 충돌을 방지하고, 사용자에게 기존 버전 '완전 삭제 후 설치' 또는 '덮어쓰기' 선택권을 부여.
  - 라이선스 선언 화면, 바탕화면 바로가기 기본 체크, 설치 후 즉시 실행까지 6단계 완벽 시퀀스 구성 요구 반영.
- **설치 마법사 6대 단계별 구현 내역**:
  1. **기존 앱 실행 시 강제 종료**: 인스톨러 시작(`InitializeSetup`) 즉시 실행 중인 뷰어 브라우저 창(`msedge.exe`, `chrome.exe`) 및 런처 프로세스 백그라운드 강제 종료.
  2. **기존 앱 인스톨 감지 및 삭제/덮어쓰기 분기**:
     - 레지스트리(HKLM, HKLM64, HKLM32, HKCU) 전수 조회.
     - 기존 버전 발견 시 3-way 안내 대화상자 표출:
       - `[예 (Y)]`: 기존 버전을 조용히 완전 삭제(`unins000.exe /VERYSILENT`) 후 새 버전 설치 (권장).
       - `[아니오 (N)]`: 기존 앱을 삭제하지 않고 현재 위치에 덮어쓰기(업그레이드) 설치.
       - `[취소 (Cancel)]`: 설치 즉시 중단 및 종료.
  3. **라이선스 선언 화면**: `LicenseFile=docs\LICENSE.ko.md` 선언으로 한국어 MIT 라이선스 전문 표시 및 동의 절차 진행.
  4. **설치**: `{autopf}\AhBiCamViewer` 위치로 핵심 파일 및 순수 Win32 Native DLL 단독 언팩 설치.
  5. **바탕화면 바로가기 기본 체크**: `Flags: checkedonce` 속성 부여로 바탕화면 아이콘 생성이 기본 활성화됨.
  6. **앱 즉시 실행**: 설치 완료 창에 `{app}\launcher.vbs` 실행 체크박스 기본 활성화 제공.
- **영향 파일**: `installer.iss`, `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`

---

### 🗂️ 하단 가로 툴바 구역별 가로 아코디언(Horizontal Accordion) 시스템 완성 (2026-11-07)
- **도입 배경 및 사용자 니즈 (Background & User Need)**:
  - 교실 수업 중 전자칠판이나 빔프로젝터 투사 시 불필요한 카메라 옵션, 화질 선택창, 슬라이더 등이 화면 하단을 가려 수업 집중도를 저하시키는 문제 해결.
  - 기능 구역별로 필요할 때만 자유롭게 접고 펼칠 수 있는 인터랙티브 가로 아코디언(Horizontal Accordion) 체계 구축.
  - 마스터 원클릭 전체 접기/펼치기 버튼 및 교사용 퀵 단축키 요구 충족.
- **아키텍처 및 구현 내역**:
  1. **하단 툴바 3대 기능 구역 가로 아코디언 체계화**:
     - **구역 1: 🎬 촬영·제어 (11개 도구)** - 카메라 시작, 정지, 캡처, JPG 포맷, 동영상 녹화, MP4 포맷, 효과음/FX, 전체화면, 모니터 점프, 좌우 반전, 90도 회전.
     - **구역 2: 🎥 카메라·화질 (6개 도구)** - 웹캠 장치 선택, 해상도 선택, 지원 여부 점(LED), 전/후면 방향, 장치 재탐색, 센서 상세정보 모달.
     - **구역 3: 🧰 조절·도구 (2대 드롭다운 그룹)** - 영상/렌즈 조절(줌, 밝기, 대비, 노출) 및 교실 수업 도구(타이머, 격자, 배경판, 주목 벨, 2분할 비교, PIP, PDF 묶기).
  2. **직관적인 도구 개수 뱃지 (Tool Count Badges)**:
     - 각 구역 토글 헤더에 수납된 도구 개수(`[11]`, `[6]`, `[2]`)를 표출하여 접힌 상태에서도 내부 기능 구성을 한눈에 인지 가능.
  3. **마스터 전체 접기/펼치기 컨트롤 (`#bAccToggleMaster`) 탑재**:
     - 하단 고정 제어 영역(`.b-fixed-controls`)에 마스터 토글 버튼을 추가하여 원클릭으로 3개 구역 전체를 접어 쾌적한 전면 칠판 모드로 전환하거나 즉시 복원.
     - 전체 접힘/펼침 상태에 따라 `[🗂️ 전체 접기]` ↔ `[📂 전체 펼치기]` 레이블과 아이콘 자동 전환.
  4. **수업용 고속 핫키 (Classroom Presentation Hotkeys)**:
     - `Alt+1`: 촬영·제어 구역 토글
     - `Alt+2`: 카메라·화질 구역 토글
     - `Alt+3`: 영상조절·수업도구 구역 토글
     - `Alt+0`: 전체 일괄 접기 / 펼치기 (마스터 토글)
     - 마우스 `Alt + 헤더 클릭`: 해당 구역 클릭 시 전체 일괄 토글 지원.
  5. **시각적 완성도 및 렌더링 결함 해결**:
     - 쉐브론 이중 반전 버그 해결: JS에서 텍스트를 강제 치환하지 않고, 순수 CSS `transform: rotate(180deg)`로 `◀` (펼침) ↔ `▶` (접힘)을 부드럽게 회전하도록 정비.
     - 구역별 은은한 반투명 캡슐형 배경(`rgba(255,255,255,0.02)`) 및 호버 시 테두리 하이라이트 적용.
     - 구역 접힘 시 인접 구분선(`.b-divider`) 투명도 자동 감쇄(`opacity: 0.35`)로 시각적 군집 현상 제거.
     - `localStorage`(`cv_bottom_accordion_zones`) 영구 기억 및 활성 상태(녹화 중 붉은 점멸, 카메라 구동 중 녹색 점) 실시간 인디케이터 연동.
- **영향 파일**: `index.html`, `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`

---

### 📦 배포 파일 구조 최적화: 중복 HTML 3종 정리 및 단일 index.html 완전 일원화 (2026-11-07)
- **도입 배경 및 사용자 니즈 (Background & User Need)**:
  - 과거 버전에서 하위 호환성 유지를 위해 중복 유지하던 3종의 HTML 파일(`아비캠뷰어_(AhBiCamViewer).html`, `교실용_실물화상기.html`, `(AhBiYout)_공용_실물화상기_보기.html`)의 필요성 검토.
  - 정식 런처(`launcher.vbs`) 및 인스톨러(`Setup.exe`)가 표준화된 현시점에서 중복 파일 유지에 따른 저장 공간 낭비(~1MB)와 동기화 복잡도를 해소하기 위해 사용자 승인에 따라 **[방안 1: index.html 1개로 완전 단일화]**를 전격 적용.
- **아키텍처 및 구현 내역**:
  1. **중복 배포 HTML 파일 3종 및 동기화 스크립트 제거**:
     - `아비캠뷰어_(AhBiCamViewer).html`, `교실용_실물화상기.html`, `(AhBiYout)_공용_실물화상기_보기.html` 삭제.
     - 4대 파일 복제 도구였던 `tools/sync_html.cjs`를 완전 제거하고 단일 `index.html` 체계로 전환.
  2. **런처 및 빌드 파이프라인 단일화**:
     - `launcher.vbs`, `tools/launcher.vbs`, `tools/AhBiCamViewer.bat`: 경로 탐색 루프를 단일화하여 `index.html`을 직접 고속 로드하도록 간소화.
     - `installer.iss`: [Files] 섹션에서 중복 3종 소스 선언을 제거하고 오직 `index.html`만 패키징하도록 정비.
     - `build.bat`: 포터블 ZIP 압축 대상에서 삭제된 3종 파일을 제거하여 아카이브 경량화 달성.
     - `.github/workflows/build-and-release.yml` & `tools/push_to_github.cjs`: `sync_html.cjs` 스텝을 제거하고 `tools/check_syntax.cjs` 단일 검증으로 빌드 속도 향상.
- **영향 파일**: `index.html`, `installer.iss`, `build.bat`, `launcher.vbs`, `tools/launcher.vbs`, `tools/AhBiCamViewer.bat`, `tools/push_to_github.cjs`, `.github/workflows/build-and-release.yml`

---

### 🐙 GitHub Releases 기반 실시간 자동 업데이트 시스템 고도화 및 깃허브 배포·보안 규칙 전면 개편 (2026-11-07)
- **도입 배경 및 사용자 니즈 (Background & User Need)**:
  - 깃허브 규칙 확립: 개발자명 `AhBiYout`, GitHub 계정명 `AhBiYout-all`, 저장소 `AhBiCamViewer`, 공식 블로그 `https://ahbiyoutvibe.blogspot.com/` 체계 일원화.
  - "GitHub Releases 기반 실시간 자동 업데이트 시스템"을 구성하여 신규 패치/릴리즈 발생 시 앱 실행 2.5초 후 자동 알림 팝업창을 즉각 표출.
  - 업데이트 알림 팝업창에 최신 버전 정보, 릴리즈 노트, 깃허브 저장소 경로, 원클릭 인스톨러 다운로드 버튼 배치.
  - 불필요한 빌드 산출물, 바이너리, 개인정보 및 개인 이메일 업로드를 방지하도록 `.gitignore` 전면 개편.
  - GitHub Actions 워크플로에서 PC 전용 인스톨러(`dist/*_Setup_v*.exe`)만 릴리즈 자산으로 첨부하고, 미지원 플랫폼(APK/iOS) 완전 제거.
  - 로컬 전용 깃허브 자동 푸시 스크립트(`push_to_github.bat`)를 제공하되, 원격 저장소 업로드에서 제외.
- **아키텍처 및 구현 내역**:
  1. **실시간 자동 업데이트 감지 및 팝업 시스템 고도화**:
     - 주 경로: GitHub REST API (`https://api.github.com/repos/AhBiYout-all/AhBiCamViewer/releases/latest`) 실시간 조회.
     - 폴백(Fallback) 안전망: API 레이트 리밋(Rate-limit) 발생 시 `raw.githubusercontent.com`의 `version.json`으로 2차 무결성 검증.
     - 팝업창 UI: `현재 버전: v1.4.7 ➡️ 최신 버전: vX.X.X` 대조 뱃지, 릴리즈 변경점 스크롤 뷰, `⬇️ 최신 인스톨러 다운로드`, `🌐 릴리즈 보기`, `나중에 하기` 버튼 완비.
  2. **핵심 파일 선별 및 .gitignore 규칙 전면 정비**:
     - 바이너리/산출물 제외: `dist/`, `build/`, `bin/`, `out/`, `output/`, `release_body.md`, `*.dll`, `*.exe`, `*.zip`.
     - 보안 및 비밀키 격리: `.env*`, `*.key`, `*.pem`, `credentials/`, `secrets/`.
     - 로컬 전용 배치 제외: `push_to_github.bat`, `push_github.bat`, `push*.bat`.
  3. **GitHub Actions 릴리즈 파이프라인 정비 (`.github/workflows/build-and-release.yml`)**:
     - Node.js 22 LTS 구동, 코드 구문 검사 및 4대 HTML 동기화 검증 선행.
     - .NET Framework 도구로 `AhBiCamViewerCore.dll` 및 `AhBiCamViewerManaged.dll` 컴파일 및 15/15 단위 테스트 전수 검증.
     - Inno Setup 6을 통한 인스톨러(`아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.7.exe`) 빌드.
     - 릴리즈 자산(Assets)에는 순수 윈도우 인스톨러 파일만 첨부(미지원 APK/iOS 제거 원칙 준수).
  4. **로컬 자동 푸시 스크립트 (`push_to_github.bat`) 구현**:
     - Git 작성자 이메일을 `AhBiYout-all@users.noreply.github.com`으로 자동 설정하여 개인 이메일 노출 원천 차단.
     - 코드 구문 검사 및 HTML 동기화 자동 검증 후 커밋/푸시 및 선택적 릴리즈 태그 푸시 지원.
     - `.gitignore`에 의해 원격 저장소 업로드에서 자동 배제.
- **영향 파일**: `index.html`, 4대 배포 HTML 파일, `.gitignore`, `.github/workflows/build-and-release.yml`, `push_to_github.bat`, `README.md`, `docs/GITHUB.md`, `version.json`

---

### 🚀 인스톨러 사전 작업 강화: 실행 중인 기존 앱 자동 종료 및 이전 버전 완전 무인 삭제 파이프라인 탑재 (2026-11-07)
- **도입 배경 및 사용자 니즈 (Background & User Need)**:
  - 사용자의 요청: "인스톨 파일을 시작하면 기존 앱 종료 후 이전 버전 앱 삭제 진행뒤에 새파일을 설치 합니다."
  - 기존 인스톨러는 이전 버전이 설치되어 있을 때 단순 확인 팝업만 띄우고 기존 앱을 덮어쓰기 방식으로 설치하였음. 이로 인해 다음 문제들이 발생할 수 있었음:
    1. 브라우저 창(Edge/Chrome 앱 모드)이나 런처 프로세스가 실행 중인 경우 파일 잠금(Lock)으로 인해 파일 복사 실패 및 충돌 위험 발생.
    2. 이전 버전이 구 설치 경로(`C:\Program Files\ClassroomVisualizer\`)에 존재할 경우, 새 버전(`AhBiCamViewer`) 설치 후에도 구 버전 파일 및 구 바탕화면/시작메뉴 바로가기가 잔존하여 혼란 초래.
- **아키텍처 및 구현 내역**:
  1. **실행 중인 기존 앱 프로세스 자동 감지 및 강제 종료 (`TerminateExistingApp`)**:
     - `msedge.exe`, `chrome.exe` 프로세스 중 창 제목에 `아비캠뷰어`, `AhBiCamViewer`, `ClassroomVisualizer`, `실물화상기`가 포함된 앱 전용 윈도우를 정밀 식별하여 종료 (`taskkill /F /IM ... /FI "WINDOWTITLE eq ..."`).
     - 인스톨러 자체(`Setup.exe`, `is-*.tmp`)는 프로세스 이미지 이름 필터를 통해 절대 종료되지 않도록 안전 가드 완비.
     - 활성화된 배치 창 및 VBS 스크립트 런처 잔여 프로세스도 안전하게 동시 정리 후 500ms 유예 시간을 두어 파일 핸들 완전 해제 보장.
     - 인스톨러 실행 초기(`InitializeSetup`) 및 파일 추출 직전(`PrepareToInstall`) 2중 호출로 완벽한 무결성 확보.
  2. **레지스트리 기반 이전 버전 탐색 및 무인 삭제 (`GetPreviousUninstaller`, `UninstallPreviousVersion`)**:
     - `AppId={{E68A9F21-7A39-4E61-9A3F-470295BCA120}}`를 기반으로 `HKLM`, `HKLM64`, `HKLM32`, `HKCU` 레지스트리를 순차 조회하여 `UninstallString` 및 `InstallLocation` 경로 획득.
     - 이전 버전의 `unins000.exe`를 완전 무인 모드(`/VERYSILENT /NORESTART /SUPPRESSMSGBOXES`)로 실행하고 종료 시까지 대기(`ewWaitUntilTerminated`).
     - 이전 버전 언인스톨러가 완료되어 `unins000.exe` 파일이 디스크에서 완전히 삭제될 때까지 상태를 폴링 감시.
  3. **구버전 잔여 디렉터리 클린업 및 경로 표준화**:
     - 이전 설치 디렉터리(`OldInstallDir`)가 신규 설치 경로(`{autopf}\AhBiCamViewer`)와 다른 경우(예: 구 `C:\Program Files\ClassroomVisualizer\`), 언인스톨 후 남은 잔여 폴더를 `DelTree`로 완전 파쇄 제거.
     - `UsePreviousAppDir=no` 지시문을 명시하여 구버전 경로로의 강제 덮어쓰기를 원천 방지하고 표준화된 `{autopf}\AhBiCamViewer`로 설치 보장.
     - `CloseApplications=yes`, `RestartApplications=no` 지시문을 통해 Windows Restart Manager 연계 지원.
  4. **무인(Silent) 및 대화형(GUI) 설치 환경 동시 지원**:
     - 대화형 GUI 설치 시: 사용자에게 기존 앱 종료 및 이전 버전 삭제 후 최신 버전 새로 설치 안내 메시지 제공.
     - 무인 Silent 설치 시: 사용자 질의 없이 자동 종료 → 무인 삭제 → 클린 신규 설치 전 과정이 100% 자동 완결.
- **영향 파일**: `installer.iss`

### 📂 하단 메뉴 구역별 접이식 가로 아코디언(Horizontal Accordion) 시스템 도입 (2026-11-06)
- **도입 배경 및 사용자 니즈 (Background & User Need)**:
  - 하단 가로 툴바에 카메라 시작/정지, 캡처, 포맷 변환, 수업 녹화, 모니터 점프, 해상도 선택, 상세정보, 영상 조절, 수업 도구 등 많은 기능이 밀집되어 있어 작은 해상도(노트북, 저해상도 모니터, 태블릿)에서 가로 스크롤이 발생하거나 시각적 복잡도가 높아지는 문제가 있었음.
  - "하단 메뉴에 구역 별로 접이식 가로 아코디언 구조 도입" 요청에 따라 기능적 응집도가 높은 3대 구역을 접고 펼칠 수 있는 독립형 가로 아코디언 엔진 탑재.
- **3대 구역 분할 및 아코디언 구성**:
  1. **🎬 [구역 1] 촬영·제어 (`capture`)**:
     - 카메라 시작/정지, 화면 캡처, JPG/PNG/WebP 포맷 변경, 수업 녹화, MP4/WebM 포맷 변경, 캡처/녹화 효과, 전체화면, 듀얼 모니터 점프, 좌우 반전, 90도 회전 (총 11개 제어 도구).
  2. **🎥 [구역 2] 카메라·화질 (`device`)**:
     - 카메라 장치 드롭다운, 해상도 선택 드롭다운, 해상도 지원 여부 인디케이터 닷, 전면/후면 카메라 방향, 카메라 장치 재탐색(🔄), 하드웨어 상세 스펙 진단창(🔍).
  3. **🧰 [구역 3] 영상조절·수업도구 (`tools`)**:
     - 영상/렌즈 조절 ▾ (줌, 문서 고대비, 터치/자동 초점, 조명, 밝기/대비/노출), 수업 도구 ▾ (타이머, 격자, 배경판, 주목 벨, 2분할 비교, PIP, PDF 일괄 컴파일, 녹화 바로가기).
  4. **📌 [고정 컨트롤]**: 캡처 갤러리 토글 버튼(`toggleThumbsBtn`), 하단 메뉴 고정 핀(`pinBottomBtn`)은 항시 우측 끝에 고정 배치.
- **주요 기능 및 UX 엔지니어링**:
  - **부드러운 가로 슬라이딩 애니메이션 (`max-width: 900px` ↔ `0px`)**: CSS `cubic-bezier(0.4, 0, 0.2, 1)` 트랜지션으로 튀지 않고 부드럽게 펼쳐짐/접힘.
  - **상태 영속화 (`localStorage`)**: `cv_bottom_accordion_zones` 키에 각 구역의 접힘 상태를 실시간 저장하여 앱 재부팅 시에도 사용자 설정 레이아웃 100% 복원.
  - **스마트 활성 감지 닷 (`updateBottomAccordionIndicators`)**: 구역이 접혀 있더라도 내부 기능이 동작 중이면 토글 버튼에 인디케이터 점등 (수업 녹화 중: 🔴 펄스 레드 닷, 카메라 활성/정지: 🟢 그린 닷, 카메라 연결: 🟢 닷, 특수 도구/조절 활성: 🔵 닷).
  - **Alt+클릭 일괄 토글**: 토글 버튼을 Alt 키와 함께 클릭 시 전체 구역을 한 번에 일괄 접기/펼치기 지원.
  - **모바일/태블릿 반응형 (`@media(max-width:960px)`)**: 폭이 좁은 화면에서는 텍스트 라벨을 숨기고 아이콘(`[🎬 ◂]`, `[🎥 ◂]`, `[🧰 ◂]`)만 표시하여 최소 32px의 초슬림 토글러 유지.
- **영향 파일**: `index.html` (4개 배포 HTML 파일 동기화 완료)

---

### 🎨 좌측 수업 발표 보조 도구 메뉴 하단 툴바 가림 현상 수정 (2026-11-06)
- **결함 원인 분석**:
  - 좌측 세로 툴바 최하단에 위치한 `presentFlyoutWrap` (💡 발표 도구: 레이저, 돋보기, 스포트라이트, 가림막) 패널이 기본값 `top: 0`으로 아래쪽으로 펼쳐지면서, 부모 컨테이너 `.main-container`의 `overflow: hidden` 및 하단 가로 툴바(`.bottom-toolbar`, `z-index: 50`)에 의해 메뉴 하단 70% 이상이 잘려 가려지는 현상 발생.
  - `.left-toolbar`의 기본 `z-index`가 `25`로 설정되어 있어 하단 툴바(`z-index: 50`) 뒤로 렌더링 스택이 밀리는 CSS Stacking Context 결함 동반.
- **수정 및 개선 내역**:
  1. **발표 도구 패널 상향 전개 (`#presentFlyoutPanel { top: auto; bottom: 0; }`)**:
     - 발표 도구 버튼 하단 기준선에 맞춰 메뉴가 위쪽으로 펼쳐지도록 CSS 앵커 변경.
  2. **동적 뷰포트 바운더리 가드 (`adjustFlyoutPanelPosition`) 탑재**:
     - 메뉴 열림 시 하단 툴바와의 충돌 여부를 실시간 측정하여, 창 크기가 작거나 리사이즈될 때도 하단 툴바 위(`bottomLimit - 8px`)에 정확히 머물도록 자동 오프셋 계산.
     - 상단 헤더와의 충돌 시 자동 스크롤(`maxHeight`, `overflowY: auto`)을 활성화하여 100% 가독성 및 클릭성 보장.
  3. **좌측 툴바 z-index 격상**:
     - `.left-toolbar` 기본 `z-index: 60`, 플라이아웃 활성 시 `z-index: 65`로 승격하여 하단 메뉴(`z-index: 50`)보다 항시 상위에 렌더링되도록 보정.
- **영향 파일**: `index.html` (4개 배포 HTML 파일 동기화 완료)

---

### 🔄 네이티브 DLL 및 저장소 명칭 전면 개편: ClassroomVisualizer → AhBiCamViewer (2026-11-06)
- **개편 배경 (Motivation)**:
  - 기존 `ClassroomVisualizerCore.dll` 및 `ClassroomVisualizer` 명칭이 인터넷 상의 기존 타 애플리케이션과 중복/충돌되는 문제가 확인됨.
  - 고유 브랜드 및 순수 창작 DLL 식별성 확보를 위해 DLL 파일명, 어셈블리/네임스페이스, 인스톨러 연동 구조를 `AhBiCamViewer`로 전면 개편.
- **순수 창작 Win32 Native DLL 및 C# 코어 명칭 변경**:
  - `src/dll/ClassroomVisualizerCore.il` → `src/dll/AhBiCamViewerCore.il` (ILASM 어셈블리 및 VTable Fixup Export Thunk)
  - `src/dll/ClassroomVisualizerCore.dll` → `bin/AhBiCamViewerCore.dll` (15대 Win32 stdcall 네이티브 PE 익스포트)
  - `src/dll/ClassroomVisualizerManaged.dll` → `bin/AhBiCamViewerManaged.dll` (.NET Framework 4.0 IL 매니지드 코어)
  - C# 및 IL 네임스페이스 갱신: `AhBiYout.ClassroomVisualizer.Core` → `AhBiYout.AhBiCamViewer.Core`
  - 단위 테스트 러너 갱신: `AhBiYout.AhBiCamViewer.Testing`, `AhBiCamViewerCore.dll` 15/15 검증 테스트 100% 통과
  - 인스톨러(`installer.iss`) 연동: 설치 전 사전 무결성 검사 호출 대상 DLL을 `AhBiCamViewerCore.dll`로 갱신
  - CI/CD 워크플로우(`.github/workflows/build-and-release.yml`) 및 빌드 스크립트(`tools/build_dll.bat`) 전면 동기화
- **GitHub 저장소 URL 및 문서 일괄 변경**: `AhBiYout-all/ClassroomVisualizer` → `AhBiYout-all/AhBiCamViewer`
- **대상 파일 (총 22개)**:
  - `index.html` (GITHUB_REPO 상수), `version.json` (repo 필드)
  - `installer.iss` (MyAppURL, MyAppExeName, 배포 소스 경로, DLL import)
  - `.github/workflows/build-and-release.yml` (빌드 파이프라인, 릴리스 노트 푸터)
  - `.gitignore`, `git-release.bat`, `push_github.bat`, `tools/build_dll.bat`
  - `src/dll/AhBiCamViewerCore.il`, `src/dll/LicenseCore.cs`, `src/dll/NativeSystemCore.cs`, `src/dll/TestRunner.cs`
  - `README.md`, `docs/README.md`, `docs/BLOG_POST.md`, `docs/GITHUB.md`
  - `docs/INSTALL.md`, `docs/LICENSE.en.md`, `docs/LICENSE.ko.md`
  - `docs/ARCHITECTURE.md`, `docs/BUILD.md`, `docs/MODULES.md`
  - `docs/NATIVE_DLL_ARCHITECTURE.md`, `docs/SECURITY.md`
  - 3개 HTML 배포 파일 (sync_html.cjs 자동 동기화)
- **런처 파일 통합**: `tools/ClassroomVisualizer.bat` 삭제 (`tools/AhBiCamViewer.bat` 단일 통합)
- **블로그 태그 정리**: 기존 외부 앱 중복 방지를 위해 블로그 검색 키워드에서 `ClassroomVisualizer` 제거

---

## v1.4.7 자유 이동식 기하 도형(Movable Geometric Shapes) 엔진 및 멀티레이어 무손실 벡터 합성 시스템 탑재 (2026-11-05)

### 📐 7대 기하 도형 자유 이동(Movable Shapes) 및 캔버스 융합(Bake) 엔진 탑재
- **개발 배경 및 사용자 니즈 (Background & User Need)**:
  - 기존 실물화상기 환경에서는 사각형, 원, 화살표 등 도형을 한 번 그리면 캔버스 픽셀에 즉시 고정(Bake)되어 교재나 실물 관찰 대상의 위치가 바뀌었을 때 도형을 옮길 수 없었습니다.
  - v1.4.6 텍스트 이동 기능에 이어 "도형도 이동 가능하게 해주세요"라는 교실 현장 요구사항을 완벽히 수용하여, 7대 기하 도형 전체에 대한 자유 드래그 앤 드롭 및 캔버스 고정/삭제 시스템을 구축.
- **핵심 구현 사항 (Key Implementations)**:
  1. **7대 기하 도형 인터랙티브 이동 엔진 (`createMovableShapeCard`)**:
     - 직선(`shapeLine`), 사각형(`shapeRect`), 원(`shapeCircle`), 삼각형(`shapeTriangle`), 화살표(`shapeArrow`), 양방향 화살표(`shapeDoubleArrow`), 별표(`shapeStar`) 등 7대 기하 도형 모두 그리기 완료 즉시 인터랙티브 이동 카드로 생성.
     - Pointer Capture 기반 드래그 앤 드롭으로 마우스가 영역을 벗어나도 끊김 없이 부드럽게 화면 어디든 이동.
     - 가로/세로가 좁은 선이나 얇은 도형도 쉽게 잡을 수 있도록 여유 있는 히트 패딩(`pad`) 바운딩 박스 제공.
  2. **호버 피드백 및 핀 고정(📌) & 개별 원클릭 삭제(✕)**:
     - 도형 호버 시 은은한 하늘색 가이드 점선과 함께 우측 상단에 삭제(`✕`) 버튼과 판서 캔버스 영구 고정(`📌`) 버튼 노출.
     - 핀(`📌`) 버튼 클릭 시 현재 이동된 위치 그대로 캔버스 비트맵 판서 레이어로 영구 융합(Bake)되어 되돌리기(Undo/Redo) 스택에 자동 등록.
  3. **도형 개별 스타일(선 스타일, 채우기, 선폭, 색상) 독립 보존**:
     - 도형마다 지정된 선 스타일(실선, 파선, 점선), 채우기 모드(없음, 25%, 50%, 솔리드), 선 굵기, 색상을 독립적으로 완벽 유지.
  4. **캡처, 녹화, PDF, 돋보기 4중 무손실 벡터 합성 (`renderShapeAnnotationsToCanvas`)**:
     - **스틸 이미지 캡처**: 고해상도(FHD~4K) 캡처 시 출력 해상도 비율에 맞춰 모든 도형을 벡터 선명도로 무손실 합성.
     - **MP4/WebM 녹화**: 동영상 녹화 프레임마다 실시간으로 도형을 정확한 위치에 부드럽게 융합 기록.
     - **PDF 묶기**: `frameData()`를 통한 다중 페이지 PDF 저장 시에도 도형 누락 없이 선명하게 포함.
     - **실시간 돋보기**: 돋보기 확대 렌더링 시 확대 배율과 렌즈 중심점에 맞춰 도형을 정밀하게 벡터 확대 표출.
  5. **판서 전체 지우기(`clearDraw`) 통합**:
     - 판서 전체 삭제 시 이동식 텍스트 카드와 함께 모든 이동식 도형도 일괄 안전하게 정리.
  6. **순수 창작 DLL 버전 상수 동기화 및 전수 검증**:
     - `ClassroomVisualizerCore.dll` 버전 상수 `0x01040700 (v1.4.7)` 반영 및 15/15 전수 단위 테스트 통과.

---

## v1.4.6 자유 이동식 텍스트 주석 카드(Movable Text Annotation Cards) 엔진 및 멀티레이어 합성 시스템 탑재 (2026-11-05)

### 📝 작성된 텍스트 주석 자유 이동 및 재편집(Movable & Editable Text Annotations) 엔진 탑재
- **개발 배경 및 사용자 니즈 (Background & User Need)**:
  - 기존 텍스트 도구는 텍스트 입력 완료 후 캔버스 비트맵 픽셀에 직접 렌더링(Bake)되어, 한 번 작성하고 나면 위치를 변경하거나 오타를 수정할 수 없었습니다.
  - 교실 수업 및 강의 중 교재나 실물 관찰 대상의 위치가 바뀌었을 때 텍스트 설명을 대상물 위치로 손쉽게 끌어다 옮기고자 하는 사용자 요구 반영.
- **핵심 구현 사항 (Key Implementations)**:
  1. **자유 드래그 앤 드롭 이동 (Pointer Capture Drag Engine)**:
     - 텍스트 입력 완료 시 무설치 인터랙티브 DOM 카드로 생성되어, 마우스 클릭 또는 터치 드래그로 화면 어느 위치로든 자유롭게 부드럽게 이동 가능.
     - 드래그 중 시각적 하이라이트 그림자(`box-shadow`)와 포인터 캡처(`setPointerCapture`) 적용으로 마우스가 영역을 벗어나도 끊김 없는 이동 보장.
  2. **더블 클릭 즉시 인라인 재편집 (Double-Click In-Place Re-edit)**:
     - 배치된 텍스트 카드를 더블 클릭하면 즉시 입력 폼이 활성화되어 오타 수정, 내용 추가 및 줄바꿈 편집이 가능하며 ESC 키로 취소 가능.
  3. **캔버스 영구 고정(📌 핀 버튼) & 개별 원클릭 삭제(✕ 버튼)**:
     - 카드 호버 시 상단에 원클릭 삭제(`✕`) 버튼과 판서 캔버스 영구 고정(`📌`) 버튼이 표출.
     - 핀(`📌`) 버튼 클릭 시 현재 위치의 텍스트가 캔버스 비트맵 판서 레이어로 영구 융합(Bake)되어 되돌리기(Undo) 스택에 자동 등록.
  4. **4대 카드 스타일 및 폰트 크기/색상 완벽 보존**:
     - 다크(Dark), 라이트(Light), 형광 메모(Yellow), 투명(None) 4대 카드 테마와 슬라이더로 조절한 폰트 크기, 팔레트 색상을 실시간 유지.
  5. **캡처(Capture), MP4 녹화, PDF 묶기, 돋보기(Magnifier) 4중 무손실 합성 엔진**:
     - `renderTextAnnotationsToCanvas(targetCtx, canvasW, canvasH)` 함수를 통해 무대(Stage) 좌표계를 출력 캔버스 해상도에 맞춰 자동 스케일링 합성.
     - **스틸 이미지 캡처**: JPG/PNG 캡처 다운로드 시 텍스트 카드가 캔버스에 정확한 위치와 스타일로 고화질 합성.
     - **MP4/WebM 비디오 녹화**: 녹화 프레임마다 실시간으로 텍스트 카드가 부드럽게 융합되어 기록.
     - **PDF 내보내기**: `frameData()`를 거치는 PDF 페이지 저장 시에도 텍스트 카드 완벽 보존.
     - **실시간 돋보기**: 돋보기 렌더링 시 확대 배율과 중심 좌표에 맞게 텍스트 카드가 정밀하게 확대 표출.
  6. **판서 전체 지우기(`clearDraw`) 통합**:
     - 화면의 모든 판서를 지울 때 이동식 텍스트 카드도 일괄 안전하게 정리되도록 연동.
  7. **순수 창작 DLL 버전 상수 동기화 및 전수 검증**:
     - `ClassroomVisualizerCore.dll` 버전 상수 `0x01040600 (v1.4.6)` 반영 및 15/15 전수 단위 테스트 통과.

---

## v1.4.5 형광펜 및 펜 붓펜 촉(Brush Tip) 속도/필압 반응형 테이퍼링 및 프리뷰 렌더링 고도화 (2026-11-04)

### 🖌️ 형광펜 붓펜 촉(Brush Tip) 둥근 촉 동일 렌더링 결함 완전 해결
- **문제 원인 (Root Cause)**:
  - 형광펜(`tool === 'marker'`) 모드에서 붓펜 촉(`brush`) 선택 시, `pointermove` 이벤트 내에서 계산된 동적 두께(`effW`)가 `ctx.lineWidth = tool === 'marker' ? +size.value * 4 : effW;` 구문에 의해 고정 폭(`+size.value * 4`)으로 강제 덮어쓰기되어 둥근 촉과 완전히 동일한 원기둥 형태로 그려지던 결함.
  - 펜 및 형광펜 하위메뉴(Flyout)의 프리뷰 캔버스(`renderPenTipPreview`, `renderMarkerTipPreview`)에서 `brush` 촉 전용 분기가 누락되어 `else` 분기로 진입, 둥근 촉과 100% 동일한 선으로 그려지던 문제.
  - 마우스/스타일러스 호버 시 커서 링이 붓펜의 특성을 반영하지 못하고 원형으로만 표출되던 문제.
- **원천 해결 조치 (Solution)**:
  - **속도 & 필압 반응형 붓 터치 알고리즘 (`drawBrushPreview` & 동적 파이프라인)**:
    - 마우스/펜 이동 속도(`speed = dist / dt`)를 실시간 계산하여, 빠르게 선을 그을 때(밑줄, 삐침)는 기본 폭의 **0.35배**로 날렵하게 가늘어지고, 천천히 눌러쓸 때는 **1.65배**로 풍성하게 배가되는 유기적 붓펜 효과 구현.
    - 스타일러스/디지타이저 펜의 하드웨어 필압(`pressure`) 가중치를 결합하여 아날로그 붓글씨와 동일한 필감 제공.
  - **4단계 2차 베지어 분할 연속 보간 (Continuous Tapering)**:
    - 선의 폭이 각진 계단식으로 변하지 않고, quadratic curve를 4단계 미세 세그먼트로 나누어 이전 폭(`prevW`)에서 목표 폭(`targetW`)으로 부드럽게 선형 보간되도록 구현.
  - **전용 붓펜 촉 프리뷰 캔버스 엔진 (`drawBrushPreview`) 탑재**:
    - 펜 및 형광펜 팝업 내 프리뷰 캔버스에 가늘게 시작하여 중간 굽은 구간에서 굵어지고 끝단이 날렵하게 빠지는 붓펜 시그니처 웨이브 곡선 렌더링 탑재.
  - **붓펜 전용 타원 회전 커서 탑재**:
    - 붓펜 촉 선택 시 마우스 커서가 붓의 경사각을 반영한 비스듬한 타원형(-25도 회전)으로 표시되어 시각적 피드백 강화.
  - **첫 터치 및 2포인트 탭 완화**:
    - `pointerdown` 시 붓의 첫 닿는 면적을 0.55배로 섬세하게 시작하도록 개선.

---

## v1.4.4 캡처/녹화 포맷 엔진, 동영상 0KB 저장 버그 완벽 해결 및 순수 창작 DLL 15대 API 확장 (2026-11-01)

### 💎 순수 창작 DLL(ClassroomVisualizerCore.dll) 15대 네이티브 API 완성 및 결함 전수 진단
- **기존 DLL 결함 전수 진단 및 개선 완료**:
  - VTable Fixup 슬롯 10개에서 15개로 확장(`D_VTFIXUPS` 60바이트 바이너리 패딩).
  - 전체 15개 네이티브 함수에 대한 최외곽 `.try ... catch [mscorlib]System.Exception` 예외 차단 쉴드 탑재로 포인터 오류에 따른 호스트 크래시 원천 차단.
  - 인스톨러(`installer.iss`)에 신규 네이티브 API(`CV_GetDiskFreeSpaceMB`, `CV_GetDisplayDpi`)를 지연 로드(`delayload`)로 바인딩하여 설치 사전 검증 수행.
- **5대 순수 창작 신규 네이티브 API 증설**:
  1. `CV_PlayCustomTone(frequency, durationMs)`: Win32 `kernel32!Beep` 직결로 브라우저 백그라운드 탭 스로틀링 없이 물리 스피커를 통한 0ms 무지연 수업 타이머/주목음 송출.
  2. `CV_GetDiskFreeSpaceMB(drivePath, *pFreeMB)`: Win32 `GetDiskFreeSpaceExA` 기반 녹화 폴더의 잔여 디스크 용량(MB)을 사전 진단하여 0KB 동영상 저장 사고 방지.
  3. `CV_GetDisplayDpi(*pDpiX, *pDpiY)`: Win32 GDI 기반 주 모니터 DPI 스케일링(96=100%, 120=125%, 144=150%, 192=200%)을 실시간 감지하여 전자칠판 및 4K 프로젝터 화각 왜곡 방어.
  4. `CV_SetWindowTopmost(hWnd, topmost)`: Win32 `SetWindowPos` 기반 수업 교재(PDF/PPT) 위에 화상기 창을 항상 위(Always-on-Top)로 띄우는 플로팅 뷰 모드 지원.
  5. `CV_GetPerformanceTimeMs()`: Win32 QPC(QueryPerformanceCounter) 기반 마이크로초 정밀도의 고해상도 단조 증가 타이머 제공.
- **15/15 전수 단위 테스트 통과 (`bin/TestRunner.exe`)**:
  - 버전, 체크섬, 트라이얼 일수, 하드웨어 지문, 절전 방지, 다중 모니터, 가상 화면, 차임벨, 하드웨어 톤, 디스크 용량, DPI, 윈도우 제어, QPC 타이머 전 항목 정상 통과(100% PASS).
- **마스터 기술 명세서 (`docs/NATIVE_DLL_ARCHITECTURE.md`) 등록**:
  - 듀얼 어셈블리 아키텍처, VTable Fixup 동작 원리, 메모리 마샬링, 전수 API 스펙, 빌드 파이프라인 총망라.


### 🚫 카메라 부재 시 화면 무한 자가 복제(Infinity Mirror / Droste Effect) 오류 원천 해결
- **문제 원인 (Root Cause)**:
  - USB 실물화상기나 물리 웹캠이 연결되지 않은 PC에서 OBS Studio, ManyCam, XSplit, UnityCapture 등의 가상 카메라 드라이버가 존재할 때 발생.
  - 기존 카메라 분류 엔진(`classifyCamera`)이 `cam` 키워드 매칭으로 인해 OBS Virtual Camera를 일반 외장 웹캠(`priority: 2`)으로 오분류하여 1순위로 자동 선택.
  - 앱 시작 시 및 권한 프로브(`requestCameraPermissionProbe`) 시 OBS Virtual Camera에 자동 연결되면서, 모니터 화면을 송출하는 OBS 가상 카메라 특성상 앱 화면 안에 전체 화면이 무한히 복제되어 빨려 들어가는 거울 방 현상(Droste Effect) 유발.
  - 카메라가 아예 0대인 환경에서도 불필요하게 `getUserMedia`가 실행되어 브라우저 오류 대화상자가 발생하던 결함.
- **원천 해결 조치 (Solution)**:
  - **가상 카메라 식별 엔진 (`isVirtualCamera`) 탑재**:
    - `obs virtual`, `obs-camera`, `obs camera`, `virtual camera`, `virtual webcam`, `virtualcam`, `manycam`, `xsplit`, `vmix`, `ndi video`, `unity video capture`, `camo`, `droidcam`, `epoccam`, `ivcam`, `iriun`, `snap camera`, `prism live`, `screen capture`, `desktop capture`, `fake device` 등 화면 루프 유발 가상 기기를 100% 정밀 식별.
    - 하드웨어 USB HDMI 캡처 카드(Cam Link, USB Video Capture 동글 등)는 물리 기기로 정상 유지.
  - **가상 카메라 최하위 우선순위(`priority: 99`) 및 자동 연결 원천 배제**:
    - 가상 카메라는 `[🖥️ 가상 카메라]`로 분류되며, 자동 시작 및 기본 선택(`autoSelect`) 대상에서 영구 제외.
  - **권한 프로브 스트림 승격 차단**:
    - 권한 획득용 1회 프로브(`requestCameraPermissionProbe`)에서 가상 카메라가 감지되면 즉시 트랙을 종료하고 활성 비디오 스트림으로 승격하지 않음.
  - **물리 카메라 부재 시 안전 대기 모드 (Placeholder)**:
    - 카메라가 없거나 가상 카메라만 있는 경우 `getUserMedia`를 실행하지 않고 안전하게 실물화상기 USB 연결 대기 모드(`placeholder`) 유지.
    - 펜·형광펜·도형 판서 및 칠판 배경판은 카메라 연결 없이도 100% 독립 사용 가능.
  - **수동 선택 시 화면 복제 안전 경고 다이얼로그 탑재**:
    - 사용자가 의도적으로 가상 카메라를 선택하거나 시작 버튼을 누를 경우, 화면 무한 복제 가능성을 사전 안내하고 사용자가 승인할 때만 안전하게 실행.
  - **핫플러그(`devicechange`) 안전 연동**:
    - USB 실물화상기가 물리적으로 연결되었을 때만 즉시 감지하여 자동 연결 수행.


### 🎥 동영상 녹화 시 0KB 파일 생성 버그 원천 해결
- **`drawRecFrame` 조기 종료 및 루프 미가동 결함 원천 수정**:
  - `startRecLoop()` 호출 시점에 `recorder`가 아직 활성화되지 않아 `if(!recorder || recorder.state !== 'recording') return;` 조건에 의해 첫 프레임 검사에서 애니메이션 루프가 즉시 종료되고 `requestAnimationFrame`이 스케줄되지 않던 치명적 결함 규명.
  - 전용 상태 플래그 `isRecordingActive` 및 캔버스 초기화/1프레임 즉시 렌더링 함수(`initRecCanvas`, `renderCurrentRecFrame`)를 분리 구축하여, `captureStream(30)` 생성 전부터 프레임이 유효하게 공급되고 녹화 종료 시점까지 지속적으로 프레임이 합성되도록 전면 개선.
- **오디오 트랙 유무에 따른 코덱 불일치(Stall) 해결**:
  - 오디오 트랙이 없는 순수 비디오 캔버스 스트림에 `mp4a.40.2`(AAC) 오디오 코덱을 요구하는 MIME(`video/mp4;codecs=...,mp4a.40.2`)을 지정했을 때, 브라우저의 MediaRecorder 멀티플렉서가 오디오 패킷을 대기하다가 데이터 청크를 생성하지 못하던 현상 해결.
  - 오디오 트랙 존재 여부(`hasAudio`)를 동적으로 감지하여 순수 비디오 코덱(`video/mp4;codecs=avc1.42E01E`, `video/mp4;codecs=avc1`, `video/mp4`)과 오디오 포함 코덱을 지능적으로 분기 선택하도록 개선.
- **녹화 중지 시 버퍼 강제 플러시 (`recorder.requestData()`)**:
  - 녹화 중지(`recorder.stop()`) 직전 `recorder.requestData()`를 명시적으로 호출하여 인코더 버퍼에 남아 있는 잔여 프레임 데이터 청크를 즉각 디스크로 방출하도록 보장.
- **0바이트 다운로드 방지 안전 장치 및 용량 안내**:
  - 청크가 비어 있거나 Blob 크기가 0바이트인 비정상 상황 발생 시 0KB 빈 파일이 저장되는 것을 원천 차단하고 원인 안내 팝업 표시.
  - 정상 다운로드 완료 시 파일 크기(KB/MB 단위)를 상태 알림에 직관적으로 표시.

### 📸 캡처 이미지 포맷 선택(JPG / PNG / WebP) 엔진 탑재
- **하단 툴바 1-클릭 포맷 전환 배지 (`#capFormatBadge`) 신설**:
  - `📸 캡처` 버튼 바로 오른쪽에 직관적인 보라색 칩 배지(`🖼 JPG` 등) 배치.
  - 클릭 시 `JPG` (범용 고압축, 96% 품질) → `PNG` (무손실 원본 보존, 투명도 지원) → `WebP` (차세대 고효율 압축, 92% 품질) 순서로 순환 전환.
  - 브라우저 Canvas의 WebP 포맷 지원 여부를 사전에 동적으로 검사(`checkWebPSupport`)하여 미지원 환경에서는 WebP를 자동으로 안전하게 스킵.
  - 선택한 캡처 포맷은 `localStorage`(`cv_cap_format`)에 영구 보존되어 브라우저 재실행 시에도 유지.
- **포맷별 맞춤 캡처 및 자동 확장자 다운로드 (`capture`)**:
  - 선택된 포맷의 MIME 타입(`image/jpeg`, `image/png`, `image/webp`) 및 품질 계수에 맞춰 캔버스 렌더링 데이터를 생성.
  - 다운로드 파일명을 포맷에 맞는 확장자(`.jpg`, `.png`, `.webp`)로 일관되게 자동 지정 (`실물화상기_YYYY-MM-DD_HH-mm-ss.확장자`).
  - 캡처 완료 시 상태 알림창에 현재 저장된 포맷 정보를 명확히 표시.

### 🎬 캡처 & 동영상 녹화 효과 설정 모달(`mediaFxModal`) 양방향 연동
- **캡처 이미지 저장 포맷 전용 라디오 설정 그룹 추가**:
  - 효과 설정 팝업 창 상단에 `JPG`, `PNG`, `WebP` 포맷별 특성 설명과 함께 라디오 버튼 추가.
  - 브라우저 WebP 지원 상태 배지(`✓ 브라우저 WebP 지원됨` / `! 브라우저 WebP 미지원`) 탑재.
  - 툴바 배지 클릭 변경과 모달 내 라디오 선택 간에 100% 양방향 실시간 동기화(`updateModalInputs`, `updateCapFormatBadge`).

### 🏛️ 순수 창작 네이티브 DLL 결함 수정 및 10대 Win32 API 확장 (`ClassroomVisualizerCore.dll`)
- **기존 DLL 결함 4대 핵심 해결**:
  1. **엔진 버전 상수 불일치 동기화**: `CV_GetVersion` 반환값을 `0x01040400` (v1.4.4)으로 일치시키고 어셈블리 버전 1.4.4.0 갱신.
  2. **체험키 검증 시그니처 파괴 결함 원천 해결**: `CV_VerifyTrialStatus`의 4개 인자 stdcall 규약 및 포인터 역참조(`stind.i4`)를 정확히 구현하여 스택 오정렬 및 크래시 방지.
  3. **예외 안전망(`.try ... catch`) 탑재**: 모든 IL Thunk 메서드에 CLR 예외 처리기를 장착하여 유효하지 않은 포인터 입력 시에도 비정상 종료 없이 0 반환 보장.
  4. **32비트 명시적 타깃팅**: `tools/build_dll.bat`에 `/platform:x86`을 적용하여 32비트 Inno Setup 설치 마법사와의 100% 바이너리 호환성 달성.
- **순수 창작 네이티브 6대 신규 기능 탑재**:
  1. `CV_PreventSleep(enable)`: Win32 `SetThreadExecutionState` 연동으로 수업 중 프로젝터/모니터 절전 꺼짐 방지 및 복원.
  2. `CV_GetMonitorCount()`: 활성 디스플레이 및 빔프로젝터 개수 네이티브 감지.
  3. `CV_GetVirtualScreenBounds(*left, *top, *width, *height)`: 다중 모니터 가상 데스크톱 전체 좌표계 추출.
  4. `CV_GetMachineFingerprintA(pBuf, size)`: SHA-256 기반 단말기 고유 16자리 하드웨어 바인딩 식별자 획득.
  5. `CV_GenerateTrialKeyA(pBuf, size)`: Mod 97 체크섬 부합 유효 30일 체험키 동적 생성.
  6. `CV_PlayAttentionAlert(alertType)`: Win32 `MessageBeep` 기반 무지연 교실 주목 알림 차임벨 재생.
- **Inno Setup 인스톨러(`installer.iss`) 연동**:
  - 설치 초기화 시 DLL 무결성 검증과 동시에 활성 디스플레이 개수 및 엔진 버전을 설치 로그에 기록.
- **10대 API 전수 자동화 검증 스위트 (`src/dll/TestRunner.cs`)**:
  - 빌드 파이프라인에서 10개 네이티브 함수 전수 테스트 통과 (10/10 PASS).
- **공식 기술 문서 등록**:
  - `docs/NATIVE_DLL_ARCHITECTURE.md` 전면 개정 등록 완료.

---

## v1.4.3 수업 도구 풀다운 반응성 복원, 스마트 뷰포트 클램핑 & 하단 툴바 반응형 최적화 (2026-10-26)

### 🧰 수업 도구(`🧰 수업 도구 ▾`) 및 영상/렌즈 조절 팝업 반응성 전면 복원
- **뷰포트 초과 오프스크린(Off-screen) 배치 결함 원천 해결**:
  - 기존 툴바에 많은 제어 버튼이 추가되면서 하단 툴바 전체 너비가 약 1,847px에 달해, 일반 교실 노트북(1366×768) 및 윈도우 기본 125%/150% 배율 환경(1536px, 1280px)에서 `🧰 수업 도구 ▾` 버튼과 팝업 패널이 화면 오른쪽 바깥(X=1,622px)으로 밀려나 잘리던 문제 완전 해결.
  - 반응형 축약 라벨(`.lbl-extra`) 및 컴팩트 칩 스타일링을 적용하여 일반 해상도(1280×800)에서도 모든 버튼이 화면 안에 100% 온전히 배치되도록 최적화.
- **스마트 고정 좌표 클램핑 엔진 (`positionDropdownPanel`) 탑재**:
  - `position: fixed` 기반의 뷰포트 자동 연산 도입으로 부모 요소의 스크롤/오버플로 제약에 영향을 받지 않음.
  - 화면 오른쪽 끝에 위치한 버튼이라도 팝업 패널이 화면 오른쪽 경계(`window.innerWidth - 10px`) 및 왼쪽 경계(`10px`) 안쪽으로 자동 클램핑되어 320px 전체가 항상 온전하게 노출됨.
  - 창 크기 조절(`resize`) 및 툴바 가로 스크롤(`scroll`) 시에도 실시간으로 팝업 위치가 버튼 상단 8px 위치에 부착 유지.
- **수업 지원 9대 도구 전면 반응 및 정상 동작 검증**:
  - `⏱ 타이머`: 타이머 설정 모달 즉각 팝업 및 타이머 패널 자동 정리.
  - `🔲 격자`: 4종 격자(모눈, 점, 줄눈, 없음) 1-클릭 순환 및 활성 상태 반영.
  - `🎨 배경판`: 4종 배경판(화이트보드, 칠판, 그린보드, 다크보드) 순환 및 판서 연동.
  - `🔔 주목 벨`: 4종 효과음(차임, 차임벨, 실로폰, 하프) 무지연 재생 및 중앙 벨 애니메이션.
  - `🖼 2분할 비교`: 캡처 2장 이상 시 즉각 2분할 뷰어 오픈.
  - `🖥 PIP 분할`: 브라우저 Picture-in-Picture 모드 원클릭 진입/해제.
  - `📑 PDF 묶기`: 현재까지 캡처된 모든 프레임을 A4 조판 PDF로 일괄 내보내기.
  - `⏺ 수업 녹화`: 툴바 녹화 버튼과 100% 양방향 연동되어 수업 녹화 시작/중지.
  - `🎬 캡처/녹화 효과`: 효과음 볼륨 및 플래시/펄스 애니메이션 설정 모달 오픈.
- **버튼 활성(`active`) 상태 및 아코디언 피크오픈(`peek-open`) 연동**:
  - `setupFlyoutToggle` 시 버튼에 `.active` 클래스 즉각 토글(블루 하이라이트).
  - 하단 메뉴 고정 해제(`unpinned`) 상태에서 풀다운 메뉴를 열었을 때 자동으로 `peek-open`을 유지하여 메뉴 패널이 화면 밖으로 자동 수축되지 않고 안정적으로 유지됨.
  - 외부 클릭 및 `Esc` 키 입력 시 모든 열린 메뉴가 깔끔하게 닫히도록 완벽한 닫기 이벤트 체계 정립.
- **전역 상태 알림 함수 누락 버그 해결**:
  - 비디오 녹화 청크 완료 시 호출되던 `setStatus` 미정의 오류(`ReferenceError: setStatus is not defined`)를 발견하여 전역 `setStatus(msg)` 엔진을 표준 탑재.

---

## v1.4.2 도형/텍스트 옵션, 해상도 점 인디케이터 & 영상/렌즈 조절 엔진 개편 (2026-10-26)

### ⚙️ 영상 및 렌즈 조절 메뉴(`⚙️ 영상/렌즈 조절 ▾`) 반응 및 조작 엔진 전면 개편
- **드롭다운 패널 클리핑 버그 원천 해결**:
  - 기존 `.bottom-toolbar`의 `overflow-x: auto`로 인해 위쪽으로 팝업되는 모든 드롭다운(`.b-dropdown-panel`)이 상단 음수 스크롤 영역으로 잘려 화면에 나타나지 않던 근본적 결함 해결 (`overflow: visible !important;` 및 `z-index: 120` 적용).
- **🔍 렌즈 줌(Zoom) 컨트롤 신규 탑재**:
  - 4종 프리셋 버튼: `1.0x (기본)`, `1.5x`, `2.0x`, `3.0x` 즉각 이동.
  - 정밀 슬라이더: `1.0x ~ 5.0x` (0.1x 단위) 및 실시간 배율 수치(`1.0x`) 표시.
  - 마우스 휠 줌 및 UVC 하드웨어 줌 지원 기기 광학 줌 동시 연동.
- **🎯 렌즈 초점(Focus) 2대 모드 지원**:
  - `[🎯 터치 초점]`: 화면 클릭 지점으로 초점 링 애니메이션과 함께 초점 수동 맞춤.
  - `[⚡ 자동 초점]`: 카메라 UVC 하드웨어 continuous 자동 초점(AF) 1-클릭 리셋 재트리거.
- **🎨 영상 화질(밝기/대비/노출) 실시간 수치화 및 양방향 동기화**:
  - `☀️ 밝기`: `50% ~ 150%` 슬라이더 + 실시간 퍼센트(`100%`) 표시.
  - `🌓 대비`: `50% ~ 180%` 슬라이더 + 실시간 퍼센트(`100%`) 표시.
  - `☀️ 노출`: `-2.0 ~ +2.0` 슬라이더 + 실시간 EV(`0.0`) 표시.
- **📄 문서 고대비 모드 양방향 토글**:
  - 활성화 시 밝기 110%, 대비 145%로 글씨 강조 / 비활성화 시 100%, 100% 기본값 자동 원복.
- **↺ 1-클릭 기본값 초기화 (`#resetAdjustBtn`)**:
  - 줌 1.0x, 밝기 100%, 대비 100%, 노출 0.0, 문서 모드 해제로 1초 만에 깔끔한 원복 지원.
- **실시간 라이브 동기화 (`syncAdjustPanelDisplay`)**:
  - 메뉴 오픈 시 현재 카메라 배율과 수치가 슬라이더와 텍스트에 100% 자동 동기화.

### 🔘 카메라별 지원 해상도 실시간 점(Dot) 인디케이터 탑재
- **해상도 메뉴 목록 항목별 지원 점(`●` / `○`) 표시**:
  - 카메라 기기 변경 및 감지 시 하드웨어 센서 능력치(`track.getCapabilities()`)를 실시간 분석
  - 해당 카메라에서 지원하는 해상도 항목 오른쪽에 **`●` (지원, 하늘색 강조)** 표시
  - 카메라 하드웨어 최대 센서 해상도를 초과하는 항목 오른쪽에 **`○` (미지원, 흐린 회색)** 표시
  - (예: 1080p 웹캠 연결 시 FHD/HD/SD는 `●`, 4K/8MP/QHD는 `○`로 즉시 식별)
  - (예: 8MP 실물화상기 연결 시 8MP/QHD/FHD/HD/SD에 `●` 표시)
- **하단 툴바 해상도 메뉴 우측 실시간 상태 점 (`#resSupportDot`) 탑재**:
  - `<select id="resolution">` 메뉴 바로 오른쪽에 실시간 원형 발광 인디케이터 점 배치
  - 현재 선택된 해상도가 카메라에서 지원되는 경우: **선명한 에메랄드 녹색 글로우 (`●`)**
  - 선택된 해상도가 카메라 최대 능력치를 초과하는 경우: **경고 주황색 글로우 (`●`)**
  - 툴팁 마우스 호버 시 카메라의 실제 센서 최대 해상도 정보(예: `센서 최대: 1920×1080, 지원: ●`) 즉시 안내
- **기기별 하드웨어 능력치 영구 캐싱**:
  - 감지된 카메라의 센서 스펙을 `localStorage`에 자동 영구 보관하여 카메라 전환 시 0.01초 만에 지원 점 자동 갱신

### 📐 도형(Shapes) 도구 옵션 패널 및 실시간 프리뷰 확장
- **4종 채우기 옵션 (`#shapeFillSelector`)**:
  - `OFF (외곽선만)`: 투명 배경에 테두리만 깔끔하게 렌더링
  - `25% 은은한 반투명`: 아래 카메라 교재 내용이 훤히 비치는 은은한 하이라이트 채우기
  - `50% 선명한 반투명`: 집중도를 높이는 뚜렷한 반투명 채우기
  - `100% 완전 채우기`: 도형 내부를 완벽히 불투명하게 채워 퀴즈 정답 가리기나 블록 강조에 적합
- **3종 테두리 선 스타일 (`#shapeStrokeSelector`)**:
  - `── 실선 (Solid)`: 기본 단단한 실선
  - `╌╌ 파선 (Dashed)`: 일정한 간격의 긴 대시 파선 (`setLineDash`)
  - `┈ 점선 (Dotted)`: 오밀조밀한 점선 테두리
- **4종 테두리 굵기 프리셋 & 슬라이더 (`#shapeSizeSlider`)**:
  - `3px(가는 선)`, `6px(보통)`, `12px(굵게)`, `20px(특대)` 프리셋 및 2px ~ 36px 정밀 슬라이더
- **실시간 도형 프리뷰 캔버스 (`#shapeTipPreviewCanvas`) & 배지 (`#shapeNameBadge`)**:
  - 도형 종류(직선, 사각형, 원, 삼각형, 화살표, 양방향 화살표, 별표), 색상, 테두리 스타일, 채우기 모드가 캔버스 프리뷰에 실시간 렌더링
- **스마트 키보드 단축키 연동**:
  - `F` 키를 누르면 도형 채우기 모드가 순환(OFF → 25% → 50% → 100% → OFF)

### 🏷️ 텍스트(Text) 주석 카드 전용 1-클릭 하위메뉴(Flyout) 및 맞춤 옵션
- **전용 하위메뉴 탑재 (`#textFlyoutWrap`)**:
  - 좌측 툴바 `T 텍스트 ▾` 버튼 1-클릭 시 전용 맞춤 옵션 패널 즉시 오픈
- **4종 카드 배경 스타일 (`#textCardStyleSelector`)**:
  - `⬛ 다크 카드`: 어두운 반투명 라운드 카드로 카메라 화면 위에서 가장 뛰어난 가독성 제공
  - `⬜ 화이트 카드`: 밝은 종이 메모지 느낌의 깔끔한 카드
  - `🟨 포스트잇`: 실제 노란색 점착 메모지(Post-it)를 화면에 붙인 듯한 형광 카드
  - `🚫 투명`: 배경 카드 없이 글자 자체만 또렷한 그림자와 함께 캔버스에 직접 출력
- **4종 글자 크기 프리셋 & 정밀 슬라이더 (`#textSizeSlider`)**:
  - `16px(작게)`, `24px(보통)`, `36px(크게)`, `50px(특대)` 프리셋 및 14px ~ 72px 정밀 슬라이더
- **6색 글자 전용 팔레트 & 커스텀 컬러 피커 (`#textColorPalette`)**:
  - 화이트, 옐로우, 스카이블루, 핑크, 그린, 블랙 + HTML5 컬러 피커
- **실시간 텍스트 프리뷰 캔버스 (`#textTipPreviewCanvas`) & 배지 (`#textCardNameBadge`)**:
  - 선택한 카드 스타일 및 글자 색상이 반영된 미니 카드 배너 실시간 시각화
- **브라우저 설정 영구 보관**:
  - `cv_shape_stroke`, `cv_shape_fill`, `cv_shape_size`, `cv_text_card`, `cv_text_size`, `cv_text_color` `localStorage` 자동 보관

### 📁 변경된 파일
- `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`
- `docs/PATCHNOTES.md`, `docs/WORK_LOG.md`

---

## v1.4.1 캡처 안정화 & 범용 MP4 수업 녹화 지원 & 잔상펜 맞춤 옵션 (2026-10-26)

### 💫 잔상 레이저 펜 전용 하위메뉴(Flyout) 및 커스텀 옵션 탑재
- **4종 잔상 이펙트 스타일 (`#laserStyleSelector`)**:
  - **🌟 네온 레이저 (Neon Glow)**: 강렬한 외곽 글로우와 네온 발광을 지닌 기본 레이저 빔
  - **⚡ 스파크 빔 (Spark/Sharp)**: 중앙의 하얀 코어 빛과 샤프하고 강렬한 포인터 광선
  - **🌈 무지개 레이저 (Rainbow)**: 시간에 따라 HSL 무지개 스펙트럼 색상이 영롱하게 순환
  - **☄️ 혜성 잔상 (Comet/Trail)**: 머리는 굵고 선명하며 꼬리로 갈수록 날렵하게 흩어지는 혜성 궤적
- **⏱️ 잔상 지속 시간(Lifespan) 정밀 조절**:
  - `0.8초(빠름)`, `1.5초(기본)`, `3.0초(여유)`, `5.0초(길게)` 프리셋 버튼 및 0.4초 ~ 6.0초 정밀 슬라이더 제공
- **🎨 레이저 전용 6색 네온 컬러 팔레트 & 커스텀 피커**:
  - 루비 레드, 네온 그린(실제 레이저 포인터 대표색), 사이언 블루, 네온 옐로우, 네온 퍼플, 퓨어 화이트
- **📏 빔 굵기 조절**:
  - 6px(가는 빔), 12px(보통), 20px(굵은 빔), 32px(광선 빔) + 슬라이더
- **🔍 실시간 잔상 프리뷰 배너 (`#laserTipPreviewCanvas`)**:
  - 하위메뉴 상단 미니 캔버스에서 잔상 획과 발광 효과 실시간 시각화
- **실시간 네온 링 호버 커서 (`#penCursor`)**:
  - 캔버스 호버 시 선택한 레이저 색상과 굵기에 맞춘 네온 발광 링 커서 지원
- **설정 영구 저장**:
  - 스타일, 지속시간, 색상, 굵기 브라우저 `localStorage` 자동 영구 보관

### 🎬 동영상 수업 녹화 MP4(.mp4) 포맷 지원 및 확장자 선택기 탑재
- **MP4 직접 인코딩 지원**: 최신 Chromium(Chrome 106+, Edge) 하드웨어 가속 `video/mp4; codecs=avc1/h264` 인코딩을 자체 연동하여, 추가 변환 없이 곧바로 범용 `.mp4` 파일로 녹화·저장 지원.
- **원클릭 포맷 전환 칩 (`#recFormatBadge`)**: 하단 툴바 `⏺ 수업 녹화` 버튼 바로 옆에 `🎬 MP4` 칩을 배치하여 1-클릭으로 **MP4 ↔ WebM** 즉각 전환 지원.
- **실시간 포맷 인디케이터**: 녹화 중 상단 타이머 배지에 `REC [MP4] 00:15`처럼 현재 저장될 포맷이 실시간 표기되어 안심하고 녹화 가능.
- **`🎬 효과` 모달 연동**: 캡처 & 동영상 녹화 설정 모달 내에 브라우저 MP4 지원 여부 진단 배지 및 라디오 선택 옵션 탑재.
- **환경 적응형 스마트 폴백(Smart Fallback)**: 사용 중인 브라우저가 MP4를 미지원하는 경우(Firefox 등) 자동으로 안전한 WebM으로 전환 및 안내.

### 📸 화면 캡처 검정 화면 버그 원인 규명 및 완전 해결
- **문제 원인**: `onCameraSuccess` 함수에서 `video.srcObject`만 바인딩하고 전역 `stream` 변수에 `mediaStream`을 할당하지 않아, `capture()` 함수 내부의 `if(stream && ...)` 분기 조건이 항상 `false`로 판정되어 카메라 영상 대신 검정색 기본 칠판 배경(`#101114`)만 단독 출력되던 치명적 결함 해결.
- **수정 내역**:
  - `onCameraSuccess`: `stream = mediaStream;` 정상 할당 및 `video.play()` 안전 호출 추가.
  - `capture()` 판정 로직 강화: `stream`뿐만 아니라 `video.srcObject`와 `video.videoWidth` 유무를 복합 검증하여 카메라 스트림이 활성화된 경우 100% 정상 캡처되도록 보장.
  - **90도/270도 회전 캡처 완벽 보정**: 카메라 회전 시 가로/세로 캔버스 비율(`isRotated90 ? vh : vw`)을 정확히 동기화하여 왜곡 및 검정 여백 없이 꽉 찬 고화질 캡처 지원.
  - **하드웨어 노출/밝기/대비 필터 반영**: 노출 보정 계수(`expFactor`)가 캡처 시에도 정확히 연동되도록 개선.
  - **⏸ 정지(Freeze) 기능 개선**: 정지 시 `visibility: hidden`으로 화면이 꺼지던 문제를 `video.pause()` / `video.play()` 방식으로 변경하여 정지된 화면이 선명하게 유지된 채 판서 및 캡처 가능하도록 정상화.

---

## v1.4.0 필기감 혁신 (2026-10-25) — 판서 3종 도구(펜·형광펜·지우개) 맞춤 디자인(촉) 및 실시간 프리뷰 전면 탑재

### ✒️ 4대 펜 촉(Tip) 디자인 엔진 구현
- **● 둥근 촉 (Round Tip)**:
  - 가장 부드럽고 친숙한 볼펜 / 사인펜 필기감 (`lineCap = 'round'`)
- **✒️ 캘리 촉 (Calligraphy / Chisel Tip)**:
  - 45도 기울어진 이탤릭 만년필 / 캘리그래피 닙 디자인
  - 대각선 이동 시 가늘고 수직/수평 이동 시 넓어지는 우아한 고급 서체 연출
- **■ 사각 촉 (Square Tip)**:
  - 제도용 로트링 펜 및 사각 보드마카 느낌의 직각 마감 (`lineCap = 'square'`)
- **🖌️ 붓펜 촉 (Brush Tip)**:
  - 필기 속도와 획 거리에 따라 끝이 섬세하게 삐치고 굵어지는 동적 테이퍼링(Dynamic Tapering) 브러시

### 🖍️ 형광펜 동일 4종 촉 디자인 확장 적용
- 형광펜 하위메뉴(`형광펜 ▾`)에도 **둥근 촉·캘리 촉·사각 촉·붓펜 촉** 4종 셀렉터 추가
- 형광펜 전용 **실시간 프리뷰 캔버스** (`#markerTipPreviewCanvas`) — 반투명 네온 컬러로 S자 곡선 미리보기
- 형광펜 전용 **실시간 호버 커서** — 촉 형태(원형/사각/캘리/브러시) + 형광색 + 굵기 가이드 표시
- 형광펜 촉 설정도 `localStorage`에 별도 영구 저장 (`cv_marker_tip`)
- 캘리 촉 형광펜: 반투명 45° 이탤릭 하이라이팅으로 교과서 밑줄에 고급스러운 포인트
- 붓펜 촉 형광펜: 속도에 따라 굵기가 변하는 다이나믹 하이라이터 연출

### 🧹 지우개 4종 디자인(형태) 엔진 탑재
- 지우개 하위메뉴(`지우개 ▾`)에 **둥근 지우개·사각 지우개·가로 지우개·세로 지우개** 4종 선택기 탑재:
  - **● 둥근 지우개**: 원형 정밀 지우개 (곡선 판서 및 점 단위 미세 수정에 최적)
  - **■ 사각 지우개**: 실제 칠판/화이트보드 지우개 스타일 (모서리와 면을 활용한 직관적 지우기)
  - **━ 가로 지우개**: 긴 가로 줄 판서나 밑줄, 단어 한 줄을 한 번에 쓸어 지우는 와이드 지우개
  - **┃ 세로 지우개**: 세로 줄 판서, 열 단위 필기나 세로 수학 식을 깔끔하게 지우는 버티컬 지우개
- **지우개 실시간 프리뷰 캔버스 (`#eraserTipPreviewCanvas`)**: 지우개 하위메뉴 상단에서 판서 격자 배경 위 실제 지우개 면적/모양 실시간 확인
- **지우개 맞춤형 호버 커서 연동**: 선택한 지우개 모양(원/사각/가로직사각형/세로직사각형)에 맞추어 빨간 점선 가이드 링 형태가 실시간 변환
- 지우개 디자인 설정도 `localStorage`에 영구 저장 (`cv_eraser_tip`)

### 🔍 펜 촉 맞춤형 실시간 프리뷰 & 커서 가이드
- **실시간 펜 촉 미리보기 배너 (`#penTipPreviewCanvas`)**:
  - 펜 하위메뉴 상단에 선택된 펜 촉 모양, 색상, 굵기로 그려진 실제 S자 획이 실시간 렌더링되어 쓰기 전 미리 확인 가능
- **펜 촉 지능형 호버 커서 (`#penCursor`)**:
  - 화면에 펜을 가져다 대면 선택된 펜 촉 형태(원형, 사각형, 45도 닙)와 실제 굵기, 잉크 색상이 마우스/스타일러스 아래에 실시간 가이드 링으로 표시
- **설정 영구 저장**:
  - 선택한 펜 촉 디자인은 `localStorage`에 자동 보관되어 재실행 시에도 유지

### 📁 변경된 파일
- `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`

---

## v1.4.0 UX 혁신 (2026-10-25) — 판서 펜/형광펜/지우개 도구별 1-클릭 전용 하위메뉴(Flyout) 탑재

### 🎨 도구 클릭 시 맞춤형 하위메뉴(Flyout) 즉각 제공
- **🖊️ 펜(Pen) 전용 하위메뉴**:
  - `펜 ▾` 버튼 클릭 시 바로 우측에 전용 패널 즉시 슬라이드 오픈
  - **색상 팔레트**: 8가지 주요 펜 색상(빨강, 주황, 노랑, 초록, 파랑, 보라, 흰색, 검정) + 커스텀 컬러 피커
  - **굵기 조절**: 가는선(3px), 보통(6px), 굵게(12px), 특대(24px) 원터치 칩 + 미세 슬라이더
  - **연계 도구 바로가기**: 잔상펜(💫) 및 텍스트 주석(T) 1-클릭 전환
- **🖍️ 형광펜(Highlighter) 전용 하위메뉴**:
  - `형광펜 ▾` 버튼 클릭 시 형광 전용 설정 패널 오픈
  - **형광 네온 컬러**: 형광노랑, 형광연두, 형광핑크, 형광주황, 형광하늘, 형광연보라 6색 + 사용자 색상 픽커
  - **밑줄 굵기 조절**: 12px, 24px, 36px, 48px 최적화 굵기 프리셋 + 미세 슬라이더
  - 글자 가림 없는 반투명 형광 블렌딩 가이드
- **⌫ 지우개(Eraser) 전용 하위메뉴**:
  - `지우개 ▾` 버튼 클릭 시 지우개 크기 및 판서 관리 서브패널 오픈
  - **지우개 크기 조절**: 소(18px), 중(36px), 대(60px), 특대(90px) 4단계 프리셋 + 미세 조절 슬라이더
  - 화면 마우스 지우개 원형 가이드 링 크기 실시간 연동
  - **판서 관리 원터치 기능**: 🗑️ **판서 전체 지우기** (강조 버튼), ↶ **되돌리기 (Ctrl+Z)**, ↷ **다시실행 (Ctrl+Y)**
- **⚡ 판서 집중 모드 (스마트 오토 클로즈)**:
  - 캔버스 화면에 스타일러스나 마우스로 필기를 시작(`pointerdown`)하면 열려 있던 서브메뉴가 화면을 가리지 않도록 자동으로 매끄럽게 닫혀 쾌적한 판서 영역 보장
  - 메인 팔레트 및 단축키(`P`, `M`, `E`, `1~8`, `[`, `]`)와 100% 양방향 실시간 동기화

### 📁 변경된 파일
- `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`

---

## v1.4.0 정책 업데이트 (2026-10-25) — 프로 기능 제약 완전 중지 및 모든 기능 100% 무료 개방

### 🔓 라이선스 제약 전면 해제
- **⭐ 모든 Pro 기능 조건 없이 즉시 사용 가능**:
  - 교실 수업 현장의 편의성을 위해 Pro 라이선스 키 및 30일 체험키 제약을 완전히 중지하고, 모든 고급 기능을 기본 개방
  - `proGate()` 검증 로직을 100% 바이패스 처리하여 업그레이드 모달창 출현 차단
- **🔒 자물쇠 아이콘 및 비활성화 스타일 제거**:
  - 도형 판서 7종(직선, 사각형, 원, 삼각형, 화살표, 양방향, 별표), 잔상 레이저, 텍스트 도구, 조명, 터치 초점, 레이저 포인터, 확대경, 스포트라이트, 가림막, 2분할 비교, PIP, PDF 묶기, 수업 녹화 등 모든 도구의 자물쇠(🔒) 아이콘 및 투명도 제약 제거
- **📺 4K UHD 및 최고화질 해상도 전면 개방**:
  - 해상도 선택 메뉴의 `[Pro]` 라벨 및 선택 차단 로직 제거 (기기 최대 최고화질, 4K UHD, 8MP 문서, QHD 2K 등 모든 해상도 자유 선택 가능)
- **☀️ 센서 노출(EV) 및 고급 격자 전면 개방**:
  - 카메라 하드웨어 노출 보정 슬라이더 즉시 조절 지원
  - 모눈종이, 점선, 줄노트 등 모든 격자 스타일 자유 순환 지원
  - 판서 실행 취소(Undo) 스택 제한 50단계 및 캡처 품질 96% 최고 품질 기본 적용
- **🏷️ 헤더 및 정보창 라이선스 배지 갱신**:
  - 헤더 타이틀에 `PRO (전체 기능 개방)` 배지 적용
  - 정보(`ℹ️ 정보`) 모달에 `Pro 에디션 (모든 기능 제약 없이 완전 개방)` 명시

### 📁 변경된 파일
- `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`

---

## v1.4.0 개선 (2026-10-25) — 동영상 수업 녹화 버튼 하단 메인 툴바 전진 배치 및 단축키(V) 지원

### 🎯 사용성 개선 & UI 복원
- **⏺ 동영상 녹화 버튼 하단 메인 툴바 1-클릭 전진 배치**:
  - `📸 캡처` 버튼 바로 우측에 `⏺ 수업 녹화`(`id="record"`, `.action-chip.record-chip`)를 상시 노출하여 드롭다운을 열 필요 없이 1초 만에 녹화 시작/중지 가능
  - 대기 시 레드 액센트 테두리 칩 스타일, 녹화 진행 시 선명한 레드 배경 및 부드러운 펄스 애니메이션(`recPulse`) 실시간 표시
- **🧰 수업 도구 드롭다운 패널 연동 (`#utilityRecordBtn`)**:
  - `🧰 수업 도구 ▾` 메뉴 내에도 `⏺ 수업 녹화` 항목을 유지하여 양방향 자동 동기화(어느 위치에서 클릭하든 텍스트 및 상태 즉시 반영)
- **⌨️ 동영상 녹화 단축키 추가**:
  - 기존 화면 캡처 `S` 키에 더해, 동영상 수업 녹화 토글 단축키 `V` 신규 지원

### 📁 변경된 파일
- `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`

---

## v1.4.0 핫픽스 (2026-10-25) — 카메라 설정 변경 시 반복 '허용' 권한 팝업 및 경고 바 완전 해결

### 🐛 버그 수정
- **🔒 카메라 설정 변경 시 '허용' 팝업 반복 출현 차단**:
  - 해상도 변경 시 `getUserMedia`를 재호출하지 않고 활성 트랙의 `applyConstraints`를 통해 스트림 유지 상태에서 즉시 해상도를 전환하도록 개선
  - 카메라 장치 전환 및 전면/후면 전환 시 새 스트림 취득 전 구 스트림을 미리 끄지 않는 진정한 **Smooth Handoff**를 적용하여 브라우저 활성 권한 세션 유지
  - 동일 카메라 재선택 시 불필요한 미디어 재요청 방지
- **🚫 크로미움 "지원되지 않는 명령 줄 플래그" 경고 바 차단**:
  - `launcher.vbs`, `AhBiCamViewer.bat`, `ClassroomVisualizer.bat`에 `--use-fake-ui-for-media-stream`과 함께 `--test-type` 플래그를 추가하여 상단 노란색 경고 안내창을 표시하지 않으면서도 권한 팝업을 100% 자동 통과시킴

### 📁 변경된 파일
- `index.html`, `launcher.vbs`, `tools/launcher.vbs`, `tools/AhBiCamViewer.bat`, `tools/ClassroomVisualizer.bat`, 배포용 3개 HTML

---

## v1.4.0 기능 추가 (2026-10-25) — 캡처 및 녹화 시작/종료 애니메이션 & 사운드(효과음) 옵션

### ✨ 신규 기능
- **📸 캡처 플래시 애니메이션 & 셔터 효과음**:
  - 화면 캡처 시 순간 래디얼 플래시 효과와 기계식 SLR 카메라 찰칵 사운드 합성 재생
  - 상단 `📸 찰칵! 캡처 완료` 플로팅 알림 뱃지 표시
- **⏺ 동영상 녹화 시작/종료 애니메이션 & 차임 효과음**:
  - 녹화 시작 시: 화면 테두리 레드 펄스 링 + `● 수업 녹화 시작` 배너 + 경쾌한 상승 차임음 (띵-동 ♬)
  - 녹화 종료 시: 화면 테두리 그린 완료 펄스 링 + `✔ 녹화 파일 저장 완료` 배너 + 차분한 하강 차임음 (동-띵 ♬)
- **🎬 캡처 & 녹화 효과 설정 모달 (`#mediaFxModal`)**:
  - 하단 툴바 `🎬 효과` 버튼 및 🧰 수업 도구 드롭다운 `🎬 캡처/녹화 효과` 메뉴에서 열기
  - 마스터 사운드 ON/OFF 및 볼륨 조절 슬라이더 (0% ~ 100%)
  - 캡처/녹화 시작/녹화 종료별 애니메이션 및 효과음 개별 토글
  - 각 효과음 미리듣기 및 애니메이션 모션 테스트 버튼 제공
  - `localStorage`를 통한 설정값 영구 보존 및 기본값 복원 기능
- **🛡️ 클린 캡처/녹화 무결성 보장**:
  - 시각적 애니메이션 효과는 DOM 레이어에서만 렌더링되며, 실제 저장되는 이미지(JPG) 및 비디오(WebM) 스트림에는 전혀 찍히지 않아 순수 영상과 판서만 깨끗하게 저장됨

### 📁 변경된 파일
- `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`

---

## v1.4.0 핫픽스 (2026-10-25) — 캡처 및 도구 버튼 클릭 이벤트 바인딩 수정

### 🐛 버그 수정
- **📸 캡처 버튼 클릭 무반응 해결**:
  - `capture.onclick = capture;` 구문에서 `function capture()` 선언으로 인한 식별자 섀도잉 현상(함수 객체에 프로퍼티가 바인딩되던 문제)을 `document.getElementById('capture').onclick = capture;`로 수정하여 마우스 클릭 시 즉시 캡처 및 다운로드 동작 보장
- **🧹 전체 판서 지우기 버튼 수정**:
  - `clearDraw` 함수와 버튼 ID 충돌을 해결하여 `document.getElementById('clearDraw').onclick`으로 안전 바인딩
- **↔ 좌우 반전 / 회전 / 전체화면 버튼 안전성 강화**:
  - `let mirror = false` 원시 불리언 변수와의 충돌을 방지하고 `document.getElementById(...)` 명시적 바인딩 적용
- **📢 캡처 피드백 강화**:
  - 캡처 시 하단 상태표시줄에 "📸 화면이 캡처되어 다운로드되었습니다." 즉각 표시
  - 다운로드 앵커 호환성 강화 (`document.body.appendChild` 후 `click()`)

### 📁 변경된 파일
- `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`

---

## v1.4.0 패치 (2026-10-25) — 크로미움 경고 플래그 제거

### 🔧 수정사항
- **크로미움 경고 바 제거**: `--use-fake-ui-for-media-stream` 플래그 완전 제거
  - 이전: 브라우저 상단에 "지원되지 않는 명령 줄 플래그를 사용 중입니다" 노란색 경고 바 표시
  - 이후: 전용 user-data-dir Preferences 파일로 카메라 권한 사전 등록하여 경고 없이 자동 허용
- **카메라 자동 허용 방식 변경**: `%LocalAppData%\AhBiCamViewer_AppProfile` 격리 프로필 사용
  - `Preferences` 파일에 `file://` 패턴 카메라/마이크 허용 설정 자동 생성
  - 크로미움 정식 content_settings API 사용으로 안정성/보안 경고 해소

### 📁 변경된 파일
- `launcher.vbs` — 플래그 제거, user-data-dir + Preferences 자동 생성 로직 추가
- `tools/launcher.vbs` — 동기화
- `tools/AhBiCamViewer.bat` — 플래그 제거, user-data-dir + Preferences 자동 생성 로직 추가
- `tools/ClassroomVisualizer.bat` — 동기화

---

## 📌 유의적 버전 규칙 (Semantic Versioning Guide)
버전 번호는 `MAJOR.MINOR.PATCH`의 3단계 형식으로 표기합니다:

1. **MAJOR (주 버전)**: 호환되지 않는 수준의 대규모 아키텍처 개편, 전체 UI/UX 전면 개편, 브레이킹 체인지(Breaking Changes) 발생 시 증가
2. **MINOR (부 버전)**: 기존 기능과의 하위 호환성을 완벽히 유지하면서 새로운 핵심 기능이 대규모로 추가되거나 기능 개선이 이루어질 때 증가
3. **PATCH (패치 버전)**: 하위 호환성이 유지되는 경미한 버그 수정, 성능 최적화, 긴급 핫픽스, 소규모 UI 미세 조정 시 증가

> ⚠️ **버전 동기화 원칙**: 패치 버전이 올라가면 `version.json`, 애플리케이션 화면 타이틀/배지, `docs/` 문서 및 자동 빌드 스크립트(`build.bat`)의 최종 산출물 파일명(`_vX.Y.Z.exe`)이 자동으로 함께 갱신됩니다.

---

## [1.4.0] - 2026-10-18
### 🚀 MINOR 업데이트: 듀얼 모니터 점프, 카메라 인식 고도화, 좌측/하단 분리형 메뉴 레이아웃, 스탠드얼론 런처, 판서 고도화, 네이티브 DLL 및 Pro 티어 시스템

- **🖥️ 전체화면 선택 시 메뉴 고정 풀림 (아코디언 모드) & 캡처/녹화 시 메뉴 UI 화면 배제**:
  - **전체화면 메뉴 자동 수축 & 호버 드로어 (`toggleFullscreen`)**: 전체화면 진입 시 좌측/하단 메뉴의 고정핀을 자동으로 해제하여 가장자리로 슬림 수축, 마우스 호버 시에만 슬라이드 전개되는 아코디언 모드 탑재. 전체화면 종료 시 이전 고정 상태로 자동 복원.
  - **클린 캡처 (`capture`)**: 캡처 버튼(`📸 캡처`) 또는 단축키 `S` 클릭 시 열려 있는 모든 풀다운/드롭다운을 즉각 닫고, 메뉴 UI를 일체 포함하지 않는 순수 카메라+판서 영상만 JPG로 저장.
  - **고화질 복합 동영상 녹화 엔진 (`record`)**: 오프스크린 캔버스 30 FPS 렌더링 루프로 카메라 영상과 실시간 판서(`draw`)를 완벽 합성 녹화. 메뉴, 툴바, 커서는 녹화 스트림에서 100% 원천 제외되며, 녹화 중 우측 상단 `[🔴 REC 00:00]` 인디케이터 배지 표시.
- **🛡️ 카메라 계속된 권한 허용 팝업 원천 제거 & 런처 자동 승인 플래그 탑재**:
  - **단독 앱 런처 자동 승인 (`--use-fake-ui-for-media-stream`)**: 바탕화면 바로가기 및 VBS/BAT 런처 실행 시 Chromium 공식 플래그를 적용하여, 실제 물리적 카메라 하드웨어를 연결하면서도 브라우저의 번거로운 [허용] 클릭 팝업 UI만 자동으로 우회 승인.
  - **비디오 트랙 인플레이스(In-place) 해상도 변경 (`applyConstraints`)**: 해상도 드롭다운 변경 시 스트림을 닫고 다시 열던 구조를 개선하고 활성 트랙에 `applyConstraints`를 직접 적용하여 깜빡임과 권한 팝업을 0회로 원천 차단.
  - **부드러운 스트림 인계 (Smooth Stream Handoff)**: 기기 전환 시 기존 스트림을 닫기 전에 새 스트림을 먼저 확보하여, 활성 스트림 세션 유지를 통해 브라우저가 권한을 재요청하지 않도록 완벽 구현.
  - **앱 실행 즉시 자동 연결 및 버려지는 프로브 제거**: 실행 즉시 이전 카메라로 자동 접속되어 최초 1회 승인 후 영구 유지.
- **🔍 인식된 카메라 상세정보 진단 모달창 탑재 (`#camInfoModal`)**:
  - **원클릭 상세정보 확인 (`[🔍 상세정보]`)**: 하단 카메라 그룹에 상세정보 버튼 추가.
  - **실시간 비디오 트랙 스트림 진단**: 실제 해상도(가로×세로), 프레임레이트(FPS), 종횡비, 장치 고유 ID, 3대 장치 분류(★ 실물화상기, 🎥 외장 웹캠, 💻 노트북 내장) 실시간 시각화.
  - **UVC 하드웨어 제어 기능 진단**: 줌(Zoom), 초점 모드(Focus), 노출(Exposure), 화이트밸런스, 보조 조명(Torch) 등 11개 세부 하드웨어 기능 지원 여부를 태그 뱃지로 직관적 표시.
  - **다중 카메라 목록 & 모달 내 즉시 전환**: 연결된 모든 비디오 장치 목록 확인 및 원클릭 `[전환]` 버튼으로 기기 즉각 변경 지원.
  - **원클릭 클립보드 복사**: 기술 지원 및 기기 오류 점검을 위한 카메라 스펙 포맷팅 텍스트 원클릭 복사 지원.
- **🔎 돋보기(확대경) 복합 캔버스 렌더러 탑재 & 마우스 휠 크기/배율 조절**:
  - **카메라 영상 + 판서 동시 확대**: 브라우저 렌더링 오차를 유발하던 기존 비디오 스케일링 방식을 전면 개편하고, 실시간 복합 캔버스 렌더러(`renderMagnifier`)를 구축하여 카메라 영상뿐만 아니라 실시간 필기/판서까지 100% 동일한 좌표계로 선명하게 확대.
  - **마우스 휠 액션 크기/배율 제어**: 마우스 휠(`wheel`)로 돋보기 렌즈 반경(60px ~ 240px)을 부드럽게 키우거나 줄일 수 있으며, `Shift + 휠`로 줌 배율(1.5x ~ 5.0x)을 정밀 조절 가능.
- **💡 스포트라이트 마우스 휠 조명 반경 조절**:
  - 마우스 휠(`wheel`)로 수업 집중 스포트라이트 구멍 반경(50px ~ 350px)을 실시간 조절. 시인성을 높여주는 골드 네온 글로우 테두리 추가.
- **📱 하단 툴바 가변 반응형(Responsive) 레이아웃 개편**:
  - 가로 슬림 스크롤(`overflow-x: auto`) 및 3단계 해상도 브레이크포인트(`1100px`, `768px`, `480px`) 적용.
  - 창 너비를 좁게 줄이거나 저해상도 모니터/노트북에서도 버튼이 잘리거나 숨겨지지 않고 모든 기능 칩에 유연하게 접근 가능.
- **🖍️ 형광펜 전용 독립 색상 팔레트 탑재**:
  - 팔레트 메뉴에 `[🎨 일반 펜/도형 색상]`과 `[🖍️ 형광펜 전용 색상]`을 독립 분리.
  - 6종 시그니처 형광 컬러(노랑, 연두, 핑크, 주황, 하늘, 연보라) 및 형광 전용 커스텀 컬러 피커 지원.
  - 일반 펜과 형광펜의 색상이 독립적으로 기억되어, 도구 전환 시 번거로운 색상 재설정 없이 즉시 필기 가능.
- **📌 좌측/하단 툴바 원터치 고정핀(Pin/Unpin) & 아코디언식 자동 수축(Drawer) 모드 탑재**:
  - **좌측 툴바 고정핀 (`#pinLeftBtn` 📌)**: 좌측 판서 도구 모음 최상단에 고정핀 버튼 배치. 고정 해제 시 좌측 화면 밖으로 슬림하게 자동 수축(파란색 세로 힌트 핸들 표시)되며, 마우스 호버 시 부드러운 아코디언 서랍 형태로 펼쳐져 넓은 판서 화면 제공.
  - **하단 툴바 고정핀 (`#pinBottomBtn` 📌)**: 하단 카메라 제어 모음 우측 끝에 고정핀 배치. 고정 해제 시 하단으로 얇게 슬라이드 수축(가로 힌트 바 표시)되며, 마우스 접근 시 위로 부드럽게 팝업.
  - **고정 상태 자동 저장 (`localStorage`)**: `cv_pin_left`, `cv_pin_bottom` 설정을 통해 다음 실행 시에도 사용자 지정 고정/아코디언 모드 유지.
  - **화면 자동 리사이즈 연동**: 고정/해제 시 `resizeCanvas()`를 트리거하여 기존 판서 유실 없이 최적의 종횡비 자동 재계산.
- **🛡️ 카메라 변경 및 옵션 조작 시 반복 권한 요청(자물쇠/배너) 현상 원천 차단**:
  - 세션 내 권한 획득 여부를 추적하는 전역 플래그(`isCameraPermissionGranted`) 및 활성 스트림 가드 도입.
  - 카메라 기기 선택, 해상도 변경, 전/후면 방향 전환, 회전/반전 시마다 불필요하게 브라우저 카메라 권한 팝업이 깜빡이거나 사용 허용을 다시 묻는 현상 완벽 해결.
- **🖥️ 듀얼 모니터(모니터 1 ↔ 모니터 2) 원클릭 점프 이동 지원**:
  - **원클릭 모니터 점프 버튼 (`#jumpMonitor`)**: 하단 퀵 액션 바에 `[🖥️ 모니터 점프]` 버튼 추가. 전자칠판이나 듀얼 모니터 수업 환경에서 버튼 클릭 한 번으로 창을 모니터 1과 모니터 2 사이로 즉각 점프 이동.
  - **Multi-Screen Window Placement API & 하이브리드 Fallback**: 최신 브라우저 멀티스크린 API(`getScreenDetails`)를 연동하여 정확한 모니터 화면 경계를 파악하고, 구형 환경에서는 `window.screen` 및 `screenX` 좌표 계산 기반 `window.moveTo()` 이동 및 Windows 단축키(`Win + Shift + 방향키`) 가이드 안내 제공.
- **📷 카메라 다중 장치 인식 고도화 (실물화상기, 외장 웹캠, 노트북 내장 카메라 지능형 감지 & 분류)**:
  - **3대 카메라 유형 정밀 분류 (`classifyCamera`)**:
    - **1순위 [★ 실물화상기]**: IPEVO, Aver, Lumens, HoverCam, ELMO, V4K, DO-CAM 등 실물화상기 전문 기기 키워드 분석 및 최우선 정렬 (Cyan 강조 배지).
    - **2순위 [🎥 외장 웹캠]**: Logitech, C920, Brio, Razer Kiyo, Anker, OBSBOT, USB Video 등 외장 고화질 웹캠 키워드 분석 (Green 강조 배지).
    - **3순위 [💻 노트북 내장]**: Integrated, Built-in, FaceTime, Front Camera, Chicony, Realtek 등 노트북 내장 웹캠 자동 식별 및 구분.
  - **드롭다운 헤더 실시간 장치 카운트 요약**: 연결된 전체 대수 및 카테고리별 요약 (`카메라 3대 감지됨 (실물화상기 1, 웹캠 1, 노트북 1)`) 직관적 표시.
  - **상단 해상도 배지에 카메라 타입 뱃지 동적 표기**: `[📸 ★ 실물화상기] 1920×1080 (FHD 1080p)`, `[💻 노트북 내장] 1280×720 (HD 720p)` 형태로 현재 작동 중인 장치 종류를 시각적으로 확인 가능.
  - **스마트 권한 프로브(`requestCameraPermissionProbe`)**: 최초 `enumerateDevices` 호출 시 레이블이 빈 문자열(`""`)로 마스킹되는 문제를 해결하기 위해 짧은 `getUserMedia` 프로브를 자동 실행하여 실제 하드웨어 모델명(IPEVO V4K, Logitech C920, 노트북 내장 웹캠 등)을 즉시 확보.
  - **USB 핫플러그 실시간 감지 및 자동 복구**: `navigator.mediaDevices.ondevicechange` 리스너로 USB 꽂힘/뽑힘을 800ms 디바운스로 감지하여 분리 시 안내 메시지 표시, 재연결 시 이전 장치 또는 실물화상기/웹캠 우선으로 1초 내 자동 재접속.
  - **마지막 사용 카메라 및 해상도 자동 복원**: `localStorage`에 마지막 사용 장치 ID(`cv_lastCameraDeviceId`)와 해상도(`cv_lastResolution`)를 저장하여 다음 실행 시 자동 복원.
  - **원인별 맞춤 에러 진단 가이드**: `NotAllowedError`(권한 거부), `NotReadableError`(카메라 점유 충돌), `OverconstrainedError`(해상도 미지원), `NotFoundError`(장치 없음) 등 에러 유형별 구체적인 한국어 해결 가이드 모달 제공.
  - **UVC 하드웨어 능력치 감지(`detectHardwareCapabilities`)**: 줌, 초점 모드, 노출 모드, 팬/틸트, LED 조명 등 UVC 하드웨어 제어 가능 여부를 콘솔에 로깅하여 디버깅 및 기능 활성화 판단에 활용.
  - **카메라 재탐색(🔄) 버튼**: 하단 툴바 카메라 드롭다운 옆에 원터치 재탐색 버튼 추가로 수동 장치 갱신 가능.
- **📐 좌측/하단 분리형 메뉴 레이아웃 개편 (퀵 셀렉트 칩, 풀다운 드롭다운 적용)**:
  - **좌측 세로 툴바 (판서/발표 전용)**: 칠판 및 터치 모니터에서 손쉽게 조작할 수 있도록 펜, 형광펜, 지우개, 잔상 레이저, T 텍스트를 배치하고, 도형(직선/사각형/원/삼각형/화살표/별표)과 발표 도구(레이저/확대경/스포트라이트/가림막), 색상 및 굵기를 오른쪽으로 펼쳐지는 **스마트 플라이아웃 메뉴**로 압축하여 화면 몰입감 극대화.
  - **하단 가로 툴바 (카메라/화질/수업보조 전용)**: 카메라 핵심 제어(시작, 정지, 캡처, 전체화면, 반전, 회전)를 퀵 액션 칩으로 배치하고, 장치/해상도 드롭다운, 영상/렌즈 조절 풀다운, 수업 도구(타이머, 격자, 배경판, 벨, 비교, PIP, PDF, 녹화) 풀다운을 배치.
  - **접이식 캡처 갤러리**: 하단 썸네일 바를 원클릭(`[🖼 캡처 목록 ▾]`)으로 접어 실물화상기 및 판서 공간을 초대형으로 시원하게 사용 가능.
- **🖥️ 스탠드얼론 웹뷰 데스크톱 앱(Chromeless WebView Window) 런처 탑재**:
  - **브라우저 틀 없는 100% 독립 데스크톱 창**: Windows 기본 내장 Microsoft Edge 및 Chrome의 앱 모드(`--app`) 파라미터를 활용하여, 상단 주소창, 탭 바, 뒤로가기 버튼이 일체 없는 독립된 단독 창으로 실행.
  - **스마트 런처(`tools/launcher.vbs`) & 포터블 배치 연동**: Edge 및 Chrome의 시스템 설치 경로를 자동 탐색하여 최적의 단독 창으로 런칭하며, 미설치 시 기본 브라우저 자동 폴백 지원.
  - **인스톨러 바로가기 전면 개편**: 바탕화면 및 시작 메뉴 바로가기, 설치 완료 후 실행 대상을 런처로 연결하여 더블클릭 즉시 독립 데스크톱 프로그램으로 열림.
- **🎨 판서 기능 전면 고도화 (필기감 스무딩, 신규 기하 도형, 잔상 레이저, 원클릭 팔레트)**:
  - **이차 베지에 곡선(`quadraticCurveTo`) 필기 스무딩**: 빠른 손글씨 작성 시 발생하는 각진 선과 꺾임 현상을 원천 제거하여 캘리그래피 수준의 부드럽고 유려한 필기감 구현.
  - **전자칠판 및 스타일러스 필압 보정**: `e.pressure` 감지를 통해 펜 압력에 따라 굵기가 자연스럽게 가변 조절되는 스마트 필압 지원.
  - **진짜 형광펜 투과 렌더링**: 여러 번 덧칠해도 글씨가 탁해지지 않고 밑의 인쇄 텍스트가 화사하게 투과되는 최적화된 마커 효과.
  - **신규 기하 도형 3종 탑재**: **△ 삼각형**, **⬌ 양방향 화살표**, **★ 별표** 추가로 수학/과학/시험 강조 판서 대폭 강화.
  - **⬛ 도형 반투명 채우기(Fill) 모드**: 토글 활성화 시 사각형, 원, 삼각형, 별표 내부가 28% 반투명 색상으로 함께 채워져 원클릭 강조 박스 생성 가능.
  - **Shift 키 제약 스냅**: Shift를 누른 채 그릴 때 1:1 정사각형, 정원, 45도 스냅 직선/화살표 보조.
  - **시각적 지우개 가이드 링**: 지우개 도구 사용 시 지우개 반경 크기에 맞춘 점선 원형 커서가 실시간 시각 피드백 제공.
  - **💫 잔상 레이저 펜 (Disappearing Laser Trail)**: 화면에 그리면 1.4초간 네온 글로우로 빛나다가 부드럽게 페이드아웃되는 수업 시선집중 레이저 펜.
  - **원클릭 빠른 색상 팔레트 & 굵기 프리셋**: 8색 컬러 닷(빨/주/노/초/파/보/흰/검), 커스텀 컬러 피커, 4단계 굵기 버튼(3/6/12/24px) 제공.
  - **가독성 텍스트 주석 카드**: 둥근 반투명 카드 배경과 외곽선 그림자로 복잡한 교재 이미지 위에서도 선명하게 판독 가능한 텍스트 주석.
  - **캔버스 리사이즈 판서 유실 방지**: 브라우저 창 크기 조절 시 오프스크린 백업 버퍼를 통해 기존 판서 내용을 100% 자동 복원.
  - **교실 수업용 키보드 단축키**: `P`(펜), `M`/`H`(형광펜), `E`(지우개), `L`(직선), `R`(사각형), `C`(원), `A`(화살표), `T`(텍스트), `F`(채우기), `[`/`]`(굵기), `1`~`8`(색상).
- **⚙️ 순수 창작 Win32 네이티브 익스포트 DLL (`ClassroomVisualizerCore.dll`) 탑재**:
  - **오프라인 무결성 및 인스톨러 연동**: Inno Setup 설치 마법사 시작 단계에서 네이티브 익스포트(`CV_GetVersion`)를 지연 로딩하여 바이너리 무결성을 자동 검증.
  - **C#/IL 하이브리드 VTable Thunk 아키텍처**: 순수 IL의 `.vtfixup` 및 `.export` 지시어를 활용하여 Windows 순정 .NET Framework 4.0 툴체인(`csc.exe`, `ilasm.exe`)만으로 32비트 stdcall 네이티브 PE 바이너리를 생성.
  - **4대 네이티브 API 제공**: `CV_GetVersion`, `CV_ValidateKeyA`, `CV_IsTrialKeyA`, `CV_VerifyTrialStatus`.
  - **기존 DLL 파일 전수 검사**: 프로젝트 내 외부 DLL 0개(완전한 클린 상태) 확인 완료.
  - **상세 기술 문서 등록**: `docs/NATIVE_DLL_ARCHITECTURE.md`에 아키텍처, PE 메커니즘, API 규격 상세 수록.
- **💎 Free / Pro 에디션 티어 시스템 및 30일 임시 체험키 도입**:
  - **30일 체험키 자동 발급**: 원클릭으로 30일간 Pro 기능을 무료 체험할 수 있는 `TRIAL-` 임시 라이선스 발급 및 유효기간 만료 관리.
  - **카메라 미연결 상태 독립 판서**: 카메라 인식이 되지 않아도 펜, 형광펜, 지우개, 도형, 텍스트 주석 및 고화질 캡처/PDF 저장을 언제든 독립 사용 가능.
  - **Free (일상 수업)**: 핵심 카메라 스트림, FHD 1080p, 기본 판서(펜/형광펜/지우개), 표준 캡처(0.85), 타이머, 주목 벨, 기본 격자(모눈종이) 등 수업 필수 기능 완전 무료 영구 제공
  - **Pro (전문 수업/아카이빙)**: QHD 2K/4K UHD/8MP/Native Max 초고해상도, 4종 도형 판서(직선/사각형/원/화살표) 및 텍스트 주석, 고품질 캡처(0.96) 및 A4 PDF 일괄 묶기, 수업 영상 녹화(WebM), 발표 보조 도구(레이저/확대경/스포트라이트/가림막), 2분할 비교, PIP, 하드웨어 제어(플래시/터치 초점/노출)
  - **오프라인 라이선스 인증**: 인터넷이 없는 교실 환경에서도 즉시 검증 가능한 오프라인 체크섬 기반 16자리 키 인증 및 자유로운 라이선스 해제 지원
- **⭐ 최고화질 자동 탐색 모드 (`Native Max`) 탑재**:
  - 연결된 고성능 UVC 실물화상기(IPEVO, Aver, Lumens 등) 및 4K 웹캠, 스마트폰 웹캠(Iriun/DroidCam)의 최대 하드웨어 센서 해상도를 자동 탐색 및 협상
  - 4:3 센서 고유의 8MP(`3264×2448`), 5MP(`2592×1944`) 및 16:9 UHD(`3840×2160`) 화질 완벽 대응
- **📐 세분화된 고해상도 해상도 프로파일 제공**:
  - `⭐ 최고화질 (기기 최대 해상도)`
  - `4K UHD (3840×2160)`: 초고해상도 교재 및 A3 시험지 판독용
  - `8MP 고해상도 문서 (3264×2448)`: 4:3 고화질 실물화상기 전용 센서 비율
  - `QHD 2K (2560×1440)`: 쿼드 HD 고화질
  - `FHD 1080p (1920×1080)`: 기본 표준 풀HD
  - `HD 720p (1280×720)` & `SD 480p (640×480)`

#### 🔄 Changed (기존 기능 변경 및 개선)
- **🛡️ 유연한 점진적 폴백(Progressive Fallback) 제약 조건**:
  - 특정 기기가 고해상도 제약 조건을 엄격 거부하더라도 충돌 없이 기본 스트림으로 안전하게 연결 복구
- **🎨 실시간 해상도 티어 컬러 인디케이터 배지**:
  - 실제 송출 픽셀과 함께 화질 등급(4K/8MP 초고화질 🟢, QHD/5MP 고화질 🔵, FHD 🔹, HD 🟡) 실시간 시각화
- **📸 캡처 및 PDF 추출 고화질 스케일링 최적화**:
  - `imageSmoothingQuality = 'high'` 적용 및 무손실급 JPEG(0.96) 압축으로 작은 각주와 수식까지 선명하게 보존.
- **하단 단일 툴바를 좌측(판서/발표) 및 하단(카메라/유틸리티)으로 분리 최적화**:
  - 30여 개 버튼의 과도한 밀집 해소 및 중앙 뷰포트 극대화.

#### 🔒 Security & Integrity (보안 및 무결성)
- **순정 Windows PE DLL 서명/체크섬 보호**: 외부 C++ 컴파일러 및 비공식 서드파티 DLL 없이 100% 순수 Windows 내장 .NET ILASM 빌드로 무결성 확보.
- **Inno Setup 인스톨러 사전 진단 연동**: 설치 시작 시 `CV_GetVersion` 함수를 사전 호출하여 변조 방지.

---

## [1.3.1] - 2026-10-09
### 🛠️ PATCH 업데이트: 무선 연결 모듈 제거 및 로컬/USB 유선 웹캠 최적화
- **🔌 무선 연결(QR P2P / WebRTC PeerJS) 모듈 완전 제거**:
  - 모바일 브라우저 보안 제약(HTTPS 의존성) 및 네트워크 불안정 요소가 있는 무선 연결 기능 및 외부 CDN 의존성 제거
  - 툴바의 무선 연결 버튼 및 QR 코드 페어링 모달 삭제
- **⚡ 로컬 하드웨어 카메라 및 USB 유선 연결 전용으로 단일화 및 경량화**:
  - 스마트폰 플래시(조명/Torch), 탭 투 포커스(터치 초점), 센서 노출(Exposure) 보정 등 기기 직접 제어 로직을 로컬 카메라 스트림에만 집중하도록 최적화
  - 외부 통신 라이브러리 제거로 초기 로딩 속도 향상 및 완전 오프라인 교실 환경 100% 보장.

---

## [1.3.0] - 2026-10-08
### 🚀 MINOR 업데이트: 스마트폰 하드웨어 직접 제어 & PC ↔ 스마트폰 무선 P2P 원격 제어
- **🔦 스마트폰 하드웨어 플래시(조명 / Torch) On/Off**:
  - Image Capture API 기반 기기 후면 LED 플래시 직접 점등/소등 제어
  - 어두운 교재나 시험지를 비추는 자체 실물화상기 조명으로 활용
- **🎯 탭 투 포커스 (Tap-to-Focus) 터치 오토포커스**:
  - 화면에서 원하는 글씨/수식 영역을 클릭/터치 시 카메라 렌즈 하드웨어 초점 자동 재조정
- **☀️ 하드웨어 센서 노출(Exposure) 다이얼**:
  - -2EV ~ +2EV 범위의 센서 노출 보정으로 하얀 종이의 눈부심/날아감 및 역광 보정
- **📲 PC ↔ 스마트폰 무선 QR코드 P2P 원격 제어 시스템 탑재**:
  - 교탁 PC에서 [📲 무선 폰 연결] 버튼 클릭 시 일회용 P2P 세션 QR코드 생성
  - 스마트폰 기본 카메라로 QR 스캔 시 무설치 브라우저로 1초 만에 PC와 무선 영상/데이터 페어링
  - **PC 화면의 툴바(플래시, 줌, 포커스, 전/후면 전환) 조작으로 거치대에 놓인 스마트폰을 완벽 원격 제어**
  - WebRTC DataChannel을 통한 지연 없는 초저지연 양방향 원격 제어 명령 프로토콜 구현
- **📱 모바일 송출 전용 UI 자동 전환**:
  - 스마트폰이 카메라 송출기로 접속 시 배터리 절약 모드 및 연결 상태 뷰파인더 모드 자동 활성화.

---

## [1.2.0] - 2026-10-08
### 🚀 MINOR 업데이트: 스마트폰 카메라 및 다중 웹캠 지원 강화
- **📱 전면 / 후면 카메라 전환 (`facingMode`)**:
  - 모바일 기기 접속 시 문서 비추기용 **후면(실물 카메라)**과 **전면(셀프/화상)** 즉시 토글 지원
  - 모바일 화면 우측 하단 플로팅 원터치 전환 버튼(`🔄`) 추가
  - 전면 카메라 선택 시 자연스러운 시야각을 위한 자동 좌우 반전(Mirror) 지원
- **🔍 2손가락 터치 핀치 줌 (Pinch-to-Zoom)**:
  - 스마트폰 화면에서 두 손가락으로 1.0x ~ 5.0x 배율 자유 조절
  - 지원 기기의 경우 MediaStreamTrack 하드웨어 센서 줌(Hardware Zoom) 자동 연동
  - PC 환경에서는 `Ctrl + 마우스 휠` 줌 단축키 지원 및 화면 줌 배율 인디케이터 표시
- **🎥 해상도 프로파일 선택기**:
  - `4K UHD (3840×2160)`, `FHD (1920×1080)`, `HD (1280×720)`, `VGA (640×480)` 즉시 전환 지원
  - 현재 연결된 카메라의 실제 가로×세로 픽셀 해상도 실시간 배지 표시
- **📱 모바일 반응형 UI 고도화**:
  - 모바일 화면 더블탭 브라우저 줌 방지(`user-scalable=no`)
  - 작은 화면에 맞춘 툴바 자동 압축 및 터치 친화적 버튼 크기 설계
- **🔄 GitHub Releases 실시간 자동 업데이트 알림 시스템 탑재**:
  - 애플리케이션 시작 시 GitHub Releases 최신 버전 자동 검사
  - 신규 버전 발견 시 업데이트 팝업 표시 (신규 버전 정보, 다운로드 링크, 깃허브 바로가기)
- **📦 Inno Setup Multi-File 인스톨러 및 방화벽 규칙 자동화 지원**.

---

## [1.1.0] - 2026-10-08
### 🚀 MINOR 업데이트: 교실 수업 편의 기능 대규모 추가
- **⏱ 수업용 타이머 / 스톱워치**:
  - 목표 시간 카운트다운(분/초 설정) 및 경과 시간 스톱워치
  - 카운트다운 10초 전 시각적 경고 점멸 애니메이션 및 종료 비프음 알림
- **📐 4종 도형 판서 도구**:
  - 직선(`╱`), 사각형(`▭`), 원(`◯`), 화살표(`➜`) 실시간 드래그 프리뷰 및 판서 렌더링
- **📝 텍스트 입력 주석**:
  - 화면 원하는 위치를 클릭하여 타이핑 후 캔버스에 직접 텍스트 기입
- **🔲 3종 보조 격자 오버레이**:
  - 모눈종이(격자), 점선지(도트), 줄노트(가로선) 순환 토글로 수학 및 서술형 판서 지원
- **🖼 캡처 이미지 좌우 2분할 비교**:
  - 최근 캡처된 2장의 이미지를 나란히 띄워 학생 풀이 비교 및 전/후 비교 분석
- **🎨 칠판/보드 배경 전환**:
  - 카메라 없이도 수업 판서가 가능한 흰색 보드, 검정 보드, 칠판 녹색 보드 배경 모드
- **↶/↷ 실행 취소(Undo) / 다시 실행(Redo)**:
  - 최대 40단계 판서 히스토리 스택 및 단축키(`Ctrl+Z`, `Ctrl+Y`) 지원
- **🖥 PIP (Picture-in-Picture) 모드**:
  - 다른 교안 창을 띄워둔 상태에서도 실물화상기 화면을 미니 창으로 유지
- **🔔 주목 집중 효과음**:
  - Web Audio API 기반 3가지 톤(벨, 차임, 딩동) 알림음 및 화면 중앙 플래시 효과.

---

## [1.0.0] - 2026-10-08
### 🚀 MAJOR 릴리즈: 웹 기반 무설치 교실용 실물화상기 최초 배포
- **📷 표준 UVC 무설치 WebRTC 카메라 연결**:
  - 별도 드라이버 설치 없이 USB 연결 즉시 1080p 고해상도 출력
- **⏸ 화면 일시정지 (Freeze)** 및 **📸 초고화질 순간 캡처**.
- **↔ 좌우 반전 (Mirror)** 및 **⟳ 90도 회전 (Rotate)**.
- **🖊 판서 도구**: 펜, 형광펜, 지우개, 색상 6종, 굵기 슬라이더.
- **📄 원클릭 문서 보정 프리셋**: 명도/대비 자동 최적화.
- **📑 캡처 모음 PDF 자동 일괄 변환 및 다운로드**.
- **⏺ 수업 실시간 영상 녹화 (WebM)**.
- **수업 집중 집중 4종 도구**:
  - 🔴 레이저 포인터
  - 🔎 2배 돋보기 확대경
  - 💡 스포트라이트 조명
  - ⬛ 가림막 (수평 마스킹).
