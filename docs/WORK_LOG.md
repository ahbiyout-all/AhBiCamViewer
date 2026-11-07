# 📜 작업 수행 일지 (Work Log)

본 문서는 **Autonomous Coding Agent System v2.0** 표준(§5, §9, §21)에 따라 교실용 실물화상기(Classroom Visualizer) 프로젝트의 모든 검사, 수정, 빌드 및 검증 내역을 시간 순서대로 기록한 작업 일지입니다.

---

## 2026-11-07 (v1.4.7)

### 작업 45: 헤드리스 CI/클라우드 러너 오디오 하드웨어 호환성 강화
- **원인 분석**: GitHub Actions 윈도우 러너(Azure 가상머신) 환경에는 물리 스피커/사운드카드 하드웨어가 연결되어 있지 않아 kernel32!Beep 호출 시 0을 반환하여 Test 11이 실패하는 현상 발생.
- **해결 내역**:
  1. NativeSystemCore.cs의 PlayCustomTone에 Beep 실패 시 MessageBeep(0xFFFFFFFF) 자동 폴백 로직 추가.
  2. TestRunner.cs의 Test 11에 헤드리스 클라우드 러너 예외 처리 가드 적용.
- **검증**: uild.bat 컴파일 및 로컬/클라우드 15/15 전수 테스트 100% 통과.

---

## 2026-11-07 (v1.4.7)

### 작업 44: 배포 파일 구조 최적화 및 단일 index.html 완전 일원화 (방안 1 적용)
- **요청 사항**: "방안 1 (가장 추천 - index.html 1개로 완전 단일화)"
- **수행 내역**:
  1. 과거 하위 호환용 중복 HTML 3종(`아비캠뷰어_(AhBiCamViewer).html`, `교실용_실물화상기.html`, `(AhBiYout)_공용_실물화상기_보기.html`) 및 동기화 도구(`tools/sync_html.cjs`) 영구 삭제.
  2. `launcher.vbs`, `tools/AhBiCamViewer.bat`, `installer.iss`, `build.bat` 내 경로를 `index.html` 단일 진입점으로 정규화.
  3. GitHub Actions 워크플로 및 `tools/push_to_github.cjs`에서 `sync_html.cjs` 단계를 제거하고 `tools/check_syntax.cjs` 검증으로 단순화.
  4. `docs/BUILD.md`, `docs/INSTALL.md`, `docs/GITHUB.md`, `docs/ROADMAP.md`, `README.md` 등 관련 문서 동기화 완료.
- **검증**: `build.bat` 컴파일 성공 (Inno Setup 인스톨러 & 경량 포터블 ZIP 생성), 15/15 네이티브 API 테스트 전원 통과.

---

## 2026-11-07 (v1.4.7)

### 작업 43: 구글 블로그 및 깃허브 공식 문서 체계화
- **요청 사항**: 구글 블로거용 문서(docs/BLOG_POST.md) 및 깃허브용 문서(docs/GITHUB.md) 생성 ([작성 모드] 및 [HTML 편집 모드] 동시 지원, 10대 지정 섹션 순서 준수, 추천 태그 한/영 20개 이하 200자 이내).
- **수행 내역**:
  1. docs/BLOG_POST.md 전면 개편: [작성 모드(서식 있는 텍스트)] 및 [HTML 편집 모드(인라인 스타일 HTML)] 동시 수록.
  2. 필수 10대 섹션 순서 완벽 준수: 제목 ➡️ 본문 ➡️ 업데이트 ➡️ 앱 그림 ➡️ 다운로드 ➡️ 버전정보 ➡️ 시스템 요구 사항 ➡️ 제작자 및 공식 채널 안내 ➡️ 전체 업데이트(v1.0.0~v1.4.7 기능 개선) ➡️ 추천 태그.
  3. 추천 태그 한/영 혼합 17개, 144글자로 20개 이하/200자 이내 규격 충족.
  4. docs/GITHUB.md 전면 개편: 저장소 규칙, 실시간 업데이트 시퀀스 다이어그램, Actions 워크플로, 인스톨러 규격, 로컬 푸시 스크립트 가이드 수록.

---

## 2026-11-07 (v1.4.7)

### 작업 42: GitHub Releases 실시간 자동 업데이트 시스템 고도화 및 깃허브 배포 규칙 정비
- **요청 사항**:
  - 개발자 `AhBiYout`, GitHub `AhBiYout-all`, 저장소 `AhBiCamViewer`, 공식 블로그 일원화.
  - GitHub Releases 기반 실시간 자동 업데이트 시스템 및 알림 팝업창 구성.
  - 개인정보 및 개인 이메일 업로드 원천 금지, 불필요한 파일 제외 `.gitignore` 전면 개편.
  - 깃허브용 자동 푸시 스크립트(`push_to_github.bat`) 생성 (업로드에서 제외).
  - GitHub Actions 워크플로 정비 (PC 전용 인스톨러만 릴리즈 자산 첨부, 미지원 APK/iOS 제거).
- **수행 내역**:
  1. `index.html` 및 4대 배포 HTML 파일 내 실시간 업데이트 팝업 및 이중 폴백(API + Raw version.json) 탑재.
  2. 제작자 및 공식 채널 정보 정리 (불필요한 외부 소속 명칭 완전 제거).
  3. `.gitignore` 전면 개편 (바이너리, 빌드 출력물, 로컬 푸시 스크립트 철저 격리).
  4. `push_to_github.bat` 자동 푸시 스크립트 작성 및 로컬 배치 격리 검증.
  5. `.github/workflows/build-and-release.yml` 정비: Node 22 LTS, 인스톨러 전용 릴리즈 자산 업로드 구성.
- **검증**: `check_syntax.cjs` 통과, `sync_html.cjs` 4대 파일 SHA-256 일치, `build.bat` 15/15 네이티브 테스트 및 인스톨러 컴파일 성공.

---

## 2026-11-07 (v1.4.7)

### 작업 41: 인스톨러 기존 앱 자동 종료 및 이전 버전 완전 무인 삭제 파이프라인 탑재
- **요청 사항**: "인스톨 파일을 시작하면 기존 앱 종료 후 이전 버전 앱 삭제 진행뒤에 새파일을 설치 합니다."
- **설계 및 구현 내역**:
  1. **실행 중인 기존 앱 프로세스 자동 강제 종료 (`TerminateExistingApp`)**:
     - 인스톨러 실행 초기(`InitializeSetup`) 및 파일 복사 직전(`PrepareToInstall`)에서 `msedge.exe` / `chrome.exe` 중 창 제목에 아비캠뷰어/AhBiCamViewer/ClassroomVisualizer가 포함된 웹앱 프로세스를 `taskkill`로 안전하게 자동 종료.
     - 인스톨러 자체(`Setup.exe`, `is-*.tmp`)는 대상에서 원천 배제.
  2. **레지스트리 기반 이전 버전 탐색 및 무인 삭제 (`GetPreviousUninstaller`, `UninstallPreviousVersion`)**:
     - `AppId={{E68A9F21-7A39-4E61-9A3F-470295BCA120}}`의 언인스톨 레지스트리를 HKLM, HKLM64, HKLM32, HKCU에서 조회.
     - 이전 버전 `unins000.exe`를 `/VERYSILENT /NORESTART /SUPPRESSMSGBOXES` 플래그로 무인 실행하고 삭제 완료 대기.
     - 구버전 설치 디렉터리(`C:\Program Files\ClassroomVisualizer\`)가 존재할 경우 잔여 파일 및 폴더를 `DelTree`로 완전 정리.
  3. **인스톨러 설정 최적화**:
     - `UsePreviousAppDir=no`로 설정하여 구버전 디렉터리로의 강제 덮어쓰기 방지 및 `{autopf}\AhBiCamViewer` 정규화.
     - `CloseApplications=yes`, `RestartApplications=no` 적용.
- **검증**: `build.bat`를 통한 Inno Setup 인스톨러 컴파일 및 패키징 완료, 15/15 네이티브 DLL 테스트 전원 통과.

---

## 2026-11-06 (v1.4.7)

### 작업 40: 하단 메뉴 구역별 접이식 가로 아코디언(Horizontal Accordion) 시스템 도입
- **요청 사항**: "하단 메뉴에 구역 별로 접이식 가로 아코디언 구조 도입"
- **설계 및 구현 내역**:
  1. **3대 기능 구역 분할 및 래핑**:
     - `bAccSectionCapture` (🎬 촬영·제어): 카메라 시작/정지, 캡처, JPG/PNG/WebP, 수업 녹화, MP4/WebM, 효과, 전체화면, 모니터 점프, 반전, 회전
     - `bAccSectionDevice` (🎥 카메라·화질): 카메라 선택, 해상도 선택, 지원 여부 닷, 방향, 재탐색, 상세정보
     - `bAccSectionTools` (🧰 영상조절·수업도구): 영상/렌즈 조절 드롭다운, 수업 도구 드롭다운
     - 우측 고정 컨트롤: 캡처 갤러리 토글 버튼, 하단 메뉴 고정 핀
  2. **가로 슬라이딩 CSS 아코디언 엔진**:
     - `.b-acc-section`, `.b-acc-toggle`, `.b-acc-content` 스타일 및 `cubic-bezier(0.4, 0, 0.2, 1)` 트랜지션
     - 접힘 시 `max-width: 0 !important; opacity: 0; pointer-events: none;` 처리로 완벽한 공간 절약
  3. **자바스크립트 아코디언 컨트롤러**:
     - `toggleBottomAccordion(zoneKey, forceExpanded)`: 클릭 시 구역 토글 및 드롭다운 위치 자동 재정렬
     - `saveBottomAccordionState()` / `loadBottomAccordionState()`: `localStorage` 영속화 지원
     - `updateBottomAccordionIndicators()`: 접힌 구역 내 녹화/카메라/도구 활성 시 인디케이터 점등
     - Alt+클릭 시 전체 구역 일괄 접기/펼치기 지원
  4. **반응형 최적화**: `@media(max-width:960px)`에서 토글 버튼 텍스트 자동 숨김 및 아이콘 전용 모드
- **검증**: `check_syntax.cjs` 4/4 통과, `sync_html.cjs` 4대 파일 100% SHA-256 일치, Inno Setup 및 Portable 패키지 빌드 성공

---

## 2026-11-06 (v1.4.7)

### 작업 39: 좌측 수업 발표 보조 도구 메뉴 하단 툴바 가림 현상 수정
- **요청 사항**: "왼쪽 발표 수업 발표 도구 메뉴가 하단 메뉴에 가려짐" 문제 해결
- **원인 분석**:
  - 좌측 세로 툴바 최하단에 위치한 `presentFlyoutWrap` (💡 발표 도구: 레이저, 돋보기, 스포트라이트, 가림막)이 기본 `top: 0`으로 하향 전개됨.
  - 상위 컨테이너 `.main-container`의 `overflow: hidden` 및 하단 가로 툴바(`.bottom-toolbar`, `z-index: 50`)에 의해 메뉴의 70% 이상이 잘려 가려짐.
  - `.left-toolbar`가 `z-index: 25`로 설정되어 하단 툴바보다 낮은 CSS Stacking Context에 위치함.
- **수정 내역**:
  1. **CSS 상향 전개 앵커 적용 (`#presentFlyoutPanel { top: auto; bottom: 0; }`)**:
     - 발표 도구 버튼 하단선에 맞춰 메뉴가 위쪽으로 펼쳐지도록 CSS 앵커 변경.
  2. **동적 뷰포트 충돌 방지 가드 탑재 (`adjustFlyoutPanelPosition`)**:
     - 메뉴 오픈 시 하단 툴바 위치(`bottomLimit - 8px`) 및 상단 헤더(`topLimit`)와의 경계를 실시간 연산하여 항상 가시 영역 내에 위치하도록 보정.
     - 창 높이가 좁아질 경우 `maxHeight`와 `overflowY: auto` 스크롤을 활성화하여 잘림 현상 방지.
  3. **좌측 툴바 z-index 승격**:
     - `.left-toolbar` 기본 `z-index: 60`, 플라이아웃 오픈 시 `z-index: 65`로 지정하여 하단 메뉴(`z-index: 50`) 상위에 렌더링되도록 개선.
  4. **4대 배포 HTML 파일 동기화**: `sync_html.cjs`를 통해 4대 배포 파일 100% SHA-256 동기화 완료.
- **검증**: `check_syntax.cjs` 4/4 통과, `sync_html.cjs` 4/4 일치, Inno Setup 빌드 성공

---

## 2026-11-06 (v1.4.7)

### 작업 38: 순수 창작 Native DLL 및 C# 코어 명칭 개편 (ClassroomVisualizerCore.dll → AhBiCamViewerCore.dll)
- **요청 사항**: 인터넷 상에 `ClassroomVisualizer`를 사용하는 기존 앱이 존재함에 따라, 브랜드 중복/충돌 방지를 위해 DLL 및 코어 명칭을 `AhBiCamViewer`로 전면 개편
- **수정 내역**:
  1. **네이티브 및 매니지드 DLL 명칭 변경**:
     - `ClassroomVisualizerCore.dll` → `AhBiCamViewerCore.dll` (15대 Win32 stdcall PE Export DLL)
     - `ClassroomVisualizerManaged.dll` → `AhBiCamViewerManaged.dll` (.NET Framework 4.0 Managed DLL)
  2. **IL 소스 파일 및 어셈블리 선언부 갱신**:
     - `src/dll/ClassroomVisualizerCore.il` 삭제 및 `src/dll/AhBiCamViewerCore.il` 신규 생성
     - `.assembly extern AhBiCamViewerManaged`, `.assembly AhBiCamViewerCore`, `.module AhBiCamViewerCore.dll`
     - AssemblyTitleAttribute: `(AhBiYout) AhBiCamViewer Native Core`
     - AssemblyVersion: `1.4.7.0`
  3. **C# 소스 코드 및 네임스페이스 갱신**:
     - `src/dll/LicenseCore.cs`: `namespace AhBiYout.AhBiCamViewer.Core`
     - `src/dll/NativeSystemCore.cs`: `namespace AhBiYout.AhBiCamViewer.Core`
     - `src/dll/TestRunner.cs`: `DLL_PATH = "AhBiCamViewerCore.dll"`, `namespace AhBiYout.AhBiCamViewer.Testing`
  4. **빌드 및 인스톨러 스크립트 갱신**:
     - `tools/build_dll.bat`: `AhBiCamViewerCore.dll`, `AhBiCamViewerManaged.dll` 빌드 및 테스트 자동화
     - `installer.iss`: 설치 전 사전 무결성 검증 루틴 및 배포 파일 목록 갱신
     - `.github/workflows/build-and-release.yml`: CI/CD 워크플로우 DLL 컴파일 스텝 갱신
  5. **기술 문서 전면 갱신**:
     - `README.md`, `docs/ARCHITECTURE.md`, `docs/BUILD.md`, `docs/GITHUB.md`
     - `docs/MODULES.md`, `docs/NATIVE_DLL_ARCHITECTURE.md`, `docs/README.md`, `docs/SECURITY.md`, `docs/BLOG_POST.md`
     - 블로그 검색 태그에서 `ClassroomVisualizer` 제거하여 외부 앱과의 브랜드 혼선 원천 차단
- **검증**:
  - `build_dll.bat`: 15/15 Native Unit Test PASS (100%)
  - `build.bat`: Inno Setup 인스톨러 컴파일 성공, Portable ZIP 패키지 생성 완료
  - `check_syntax.cjs`: 4/4 스크립트 블록 통과
  - `sync_html.cjs`: 4대 배포 HTML 파일 100% SHA-256 일치

---

## 2026-11-05 (v1.4.7)

### 작업 37: GitHub 저장소 이름 변경 (ClassroomVisualizer → AhBiCamViewer)
- **요청 사항**: GitHub 저장소 이름을 `ClassroomVisualizer`에서 `AhBiCamViewer`로 변경하고 프로젝트 전체 파일에 반영
- **수정 내역**:
  1. **Git remote URL 변경**: `origin` → `https://github.com/AhBiYout-all/AhBiCamViewer.git`
  2. **저장소 URL 일괄 치환** (13개 파일, 총 33건):
     - `index.html`, `version.json`, `installer.iss`, `.github/workflows/build-and-release.yml`
     - `.gitignore`, `git-release.bat`, `push_github.bat`
     - `README.md`, `docs/README.md`, `docs/BLOG_POST.md`, `docs/GITHUB.md`
     - `docs/INSTALL.md`, `docs/LICENSE.en.md`, `docs/LICENSE.ko.md`
     - `docs/NATIVE_DLL_ARCHITECTURE.md`, `docs/SECURITY.md`
  3. **런처 파일 통합**: `tools/ClassroomVisualizer.bat` 삭제 (SHA-256 해시 동일한 `tools/AhBiCamViewer.bat`으로 통합)
  4. **installer.iss 업데이트**: `MyAppExeName` → `AhBiCamViewer.bat`, 배포 소스 경로 갱신
  5. **HTML 동기화**: `sync_html.cjs`로 3개 배포 HTML 자동 동기화 (SHA-256 일치 확인)
  6. **의도적 보존 항목**:
     - DLL 제품명(`ClassroomVisualizerCore.dll`, `ClassroomVisualizerManaged.dll`): 순수 창작 DLL 아이덴티티
     - 블로그 SEO 태그 키워드: 검색 노출 목적
     - 과거 변경 로그(CHANGELOG, PATCHNOTES, WORK_LOG): 역사 기록
- **검증**: `check_syntax.cjs` 4/4 통과, `sync_html.cjs` 4/4 MATCH, `git grep AhBiYout-all/ClassroomVisualizer` 0건

---

### 작업 36: 자유 이동식 기하 도형(Movable Geometric Shapes) 엔진 및 4중 무손실 합성 시스템 탑재
- **요청 사항**: 판서 도구로 작성한 도형도 텍스트처럼 자유롭게 이동 및 재배치할 수 있도록 구현
- **원인 분석 및 아키텍처 설계**:
  1. 기존 `drawShapeOn`은 `pointerup` 시 캔버스 비트맵 `ctx`에 직접 구워버려(Bake), 한 번 작성된 사각형, 원, 화살표 등의 도형을 옮길 수 없었음.
  2. 실물화상기 특성상 카메라 아래 대상물의 위치가 이동할 때 강조용 도형(화살표, 사각형, 별표 등)도 함께 이동해야 한다는 사용자 요구 수용.
  3. 7대 기하 도형(직선, 사각형, 원, 삼각형, 화살표, 양방향 화살표, 별표)을 즉시 조작 가능한 인터랙티브 이동 카드(`createMovableShapeCard`)로 생성하고, 캡처/녹화/PDF/돋보기 렌더링 시에는 최고 해상도 벡터로 무손실 합성(`renderShapeAnnotationsToCanvas`)하는 멀티레이어 아키텍처 구현.
- **수정 및 구현 내역**:
  - **1. 7대 기하 도형 이동식 시스템 (`shapeAnnotations[]`, `createMovableShapeCard`) 구현**:
    - Pointer Capture 기반 드래그 앤 드롭 이동: 마우스가 바운딩 박스를 벗어나도 끊김 없는 이동 보장.
    - 여유 있는 패딩 바운딩 박스: 얇은 선이나 작은 도형도 쉽게 잡고 이동할 수 있도록 편의성 제공.
    - 호버 시 삭제(`✕`) 및 캔버스 융합(📌 핀) 버튼 지원: 핀 버튼 클릭 시 비트맵 판서 레이어로 영구 고정(Bake) 및 Undo 스택 등록.
    - 선 스타일(실선/파선/점선), 채우기(없음/25%/50%/솔리드), 두께, 색상 완벽 보존.
  - **2. 4중 멀티레이어 무손실 벡터 합성 (`renderShapeAnnotationsToCanvas`)**:
    - 스틸 캡처(`capture`): 원본 캔버스 해상도(최고 4K UHD)에 맞춰 벡터 스케일링 무손실 합성.
    - 동영상 녹화(`renderCurrentRecFrame`): 매 프레임 실시간으로 도형을 정확한 좌표에 부드럽게 합성.
    - PDF 내보내기(`frameData`): 다중 페이지 PDF 저장 시 도형 벡터 보존.
    - 돋보기 뷰(`renderMagnifier`): 돋보기 배율 및 중심 좌표에 맞게 실시간 벡터 확대 렌더링.
  - **3. 판서 지우기(`clearDraw`) 통합**:
    - 판서 지우기 시 이동식 텍스트 카드 및 이동식 도형 일괄 안전 삭제.
  - **4. 버전 관리 및 순수 창작 DLL 동기화**:
    - `ClassroomVisualizerCore.dll` 버전 상수 `0x01040700 (v1.4.7)` 갱신 및 15/15 전수 단위 테스트 통과.
    - Inno Setup 인스톨러 및 무설치 포터블 패키지 빌드 완료.
- **변경 파일**: `index.html`, `교실용_실물화상기.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `version.json`, `installer.iss`, `src/dll/ClassroomVisualizerCore.il`, `src/dll/TestRunner.cs`, `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`
- **검증 결과**:
  - Node.js 구문 검증 통과 (4개 script 블록 0 error).
  - 4대 HTML 파일 바이트 수 및 SHA-256 100% 일치 확인.
  - TestRunner 15/15 테스트 100% PASS 확인.
  - Inno Setup 및 Portable Zip 빌드 완료.

---

## 2026-11-05 (v1.4.6)

### 작업 35: 자유 이동식 텍스트 주석 카드(Movable Text Annotation Cards) 엔진 및 멀티레이어 합성 시스템 탑재
- **요청 사항**: 기록한 텍스트 주석을 캔버스 위에서 자유롭게 이동 및 재편집할 수 있도록 지원
- **원인 분석 및 아키텍처 설계**:
  1. 기존 `placeText()`는 입력 완료 시 `ctx.fillText`로 캔버스 비트맵 픽셀에 직접 구워버려(Bake), 한 번 작성된 텍스트의 이동 및 수정이 원천적으로 불가능했음.
  2. 실물화상기 특성상 카메라 아래의 관찰 대상(교재, 시험지, 실험 도구)의 위치를 바꾸는 경우가 빈번하므로, 작성된 텍스트 주석을 원하는 위치로 손쉽게 드래그 이동할 수 있어야 함.
  3. 단순 DOM 요소로만 띄울 경우 화면 캡처(Capture), MP4 녹화(Recording), PDF 내보내기, 돋보기(Magnifier)에서 텍스트가 누락되므로, 모든 렌더링 파이프라인에서 무손실 합성(`renderTextAnnotationsToCanvas`)되는 통합 레이어 아키텍처를 설계.
- **수정 및 구현 내역**:
  - **1. 이동식 텍스트 주석 시스템 (`textAnnotations[]`, `createMovableTextCard`) 구현**:
    - Pointer Capture 기반 드래그 앤 드롭 이동 지원: 마우스가 카드 밖으로 벗어나도 포인터 캡처(`setPointerCapture`)로 끊김 없이 이동.
    - 더블 클릭 인라인 재편집: 기존 텍스트 카드를 더블 클릭하면 입력 모드로 즉시 복귀하여 오타 수정 및 내용 갱신.
    - 호버 시 핀 고정(`📌`) 버튼과 삭제(`✕`) 버튼 노출: 핀 버튼 클릭 시 캔버스 비트맵 판서 레이어로 영구 고정(Bake) 및 Undo 스택 등록.
  - **2. 4중 멀티레이어 무손실 합성 엔진 (`renderTextAnnotationsToCanvas`)**:
    - 캡처(`capture`): 원본 이미지 비율에 맞춰 텍스트 카드 위치 및 폰트 크기를 자동 스케일링 합성.
    - 동영상 녹화(`renderCurrentRecFrame`): 매 프레임 실시간으로 텍스트 주석을 캔버스에 합성 기록.
    - PDF 내보내기(`frameData`): 캡처 프레임 버퍼 생성 시 텍스트 카드 누락 없이 포함.
    - 돋보기 뷰(`renderMagnifier`): 돋보기 렌더링 시 확대 배율과 위치에 맞게 텍스트 카드를 확대 표출.
  - **3. 판서 지우기(`clearDraw`) 통합**:
    - 화면의 판서를 모두 지울 때 이동식 텍스트 카드도 일괄 안전하게 제거.
  - **4. 버전 관리 및 순수 창작 DLL 동기화**:
    - `ClassroomVisualizerCore.dll` 버전 상수 `0x01040600 (v1.4.6)` 갱신 및 15/15 전수 단위 테스트 통과.
    - Inno Setup 인스톨러 및 무설치 포터블 패키지 빌드 완료.
- **변경 파일**: `index.html`, `교실용_실물화상기.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `version.json`, `installer.iss`, `src/dll/ClassroomVisualizerCore.il`, `src/dll/TestRunner.cs`, `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`
- **검증 결과**:
  - Node.js 구문 검증 통과 (4개 script 블록 0 error).
  - 4대 HTML 파일 바이트 수 및 SHA-256 100% 일치 확인.
  - TestRunner 15/15 테스트 100% PASS 확인.
  - Inno Setup 및 Portable Zip 빌드 완료.

---

## 2026-11-04 (v1.4.5)

### 작업 34: 형광펜 및 펜 붓펜 촉(Brush Tip) 속도/필압 반응형 테이퍼링 및 프리뷰 렌더링 고도화
- **요청 사항**: 형광펜 중 붓펜 촉이 둥근 촉과 동일하게 나오는 결함 해결
- **원인 분석 및 아키텍처 설계**:
  1. 형광펜 모드(`tool === 'marker'`)에서 `brush` 촉을 선택해도 `pointermove` 내에서 폭이 `+size.value * 4`로 덮어쓰여 둥근 촉과 동일한 원기둥 형태로 그려졌음.
  2. 펜/형광펜 프리뷰 캔버스에서 `brush` 촉 전용 렌더러가 누락되어 일반 직선으로 렌더링되던 문제.
- **수정 및 구현 내역**:
  - 속도/필압 반응형 유기적 테이퍼링 알고리즘(`drawBrushPreview`, 0.35x~1.65x) 및 4단계 2차 베지어 보간 적용.
  - 붓펜 전용 비스듬한 타원 커서(-25도 회전) 탑재.
  - 펜/형광펜 하위메뉴 붓펜 프리뷰 캔버스 탑재.
- **검증 결과**:
  - 형광펜 모드에서 붓펜 시그니처 획 정상 구현 및 프리뷰 일치 확인.

---

## 2026-11-01 (v1.4.4)

### 작업 32: 캡처 이미지 다중 포맷(JPG/PNG/WebP) 엔진 탑재 및 미디어 효과 모달 연동
- **요청 사항**: 화면 캡처 저장 시 단일 JPEG 포맷뿐만 아니라 무손실 PNG 및 고효율 WebP 등 다양한 이미지 포맷을 선택할 수 있도록 지원
- **원인 분석 및 아키텍처 설계**:
  1. 기존 `capture()` 엔진은 JPEG 96% 고정 품질(`image/jpeg`, 0.96)로만 이미지를 생성하고 `.jpg`로 저장하고 있었음.
  2. 판서 글씨나 도표를 무손실로 깨끗하게 보존하길 원하는 교실 환경에서는 PNG 요구가 존재하며, 최신 웹 환경에서는 고효율 WebP 요구가 존재.
  3. 동영상 녹화 포맷 변경 배지(`recFormatBadge`, MP4 ↔ WebM)와 일관된 사용자 경험을 위해 하단 툴바에 원클릭 캡처 포맷 배지(`capFormatBadge`)를 신설하고, `mediaFxModal`(캡처 & 녹화 효과 설정 모달) 내에 상세 라디오 옵션을 동기화 연동하도록 설계.
- **수정 및 구현 내역**:
  - **1. 캡처 포맷 엔진 (`CAP_FORMATS`, `getCaptureFormatConfig`, `cycleCapFormat`) 탑재**:
    - 지원 포맷: `JPG` (0.96 품질, 용량 효율적), `PNG` (무손실 원본), `WebP` (0.92 차세대 압축).
    - 브라우저 Canvas WebP 런타임 호환성 검사(`checkWebPSupport`) 적용.
    - `localStorage`(`cv_cap_format`) 저장 및 툴바 배지(`🖼 JPG` / `🖼 PNG` / `🖼 WebP`) 1-클릭 순환 지원.
  - **2. `capture()` 함수 동적 포맷 MIME/확장자 렌더링**:
    - 활성 포맷에 맞춰 `out.toDataURL(mime, quality)` 호출 및 확장자 자동 부여 (`.jpg`, `.png`, `.webp`).
  - **3. 미디어 효과 모달(`mediaFxModal`) 캡처 포맷 라디오 그룹 및 양방향 동기화**:
    - 모달 내 캡처 포맷 설명 라디오 버튼 및 WebP 지원 뱃지(`webpSupportBadge`) 탑재.
    - 툴바 칩 클릭과 모달 내 선택 간 `updateModalInputs` / `updateCapFormatBadge` 실시간 양방향 동기화.
  - **4. 4개 배포용 HTML 파일 및 빌드 배포 동기화**:
    - `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html` 100% 동일 동기화.
    - `version.json` 및 `installer.iss` 버전 1.4.4 갱신.
- **변경 파일**: `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`, `version.json`, `installer.iss`, `docs/PATCHNOTES.md`, `docs/WORK_LOG.md`
- **검증 결과**:
  - Node.js 구문 검증 통과 (5개 script 블록 0 syntax error).
  - 4개 HTML 파일 바이트 수(270,440 B) 일치 확인.

### 작업 33: 순수 창작 네이티브 DLL 결함 점검, 10대 Win32 API 확장 및 아키텍처 명세서 등록
- **요청 사항**:
  1. 기능 중 순수 창작 DLL로 제작하여 사용하면 유용한 기능을 확인하고 구현
  2. 기존 DLL 파일 중 오류나 개선점을 정밀 점검하고 수정
  3. 순수 창작 DLL의 동작 원리와 세부 규격을 문서로 작성하여 등록
- **원인 분석 및 결함 규명**:
  1. **엔진 버전 불일치**: `ClassroomVisualizerCore.il`의 `CV_GetVersion`이 `0x01040000`으로 고정되어 v1.4.4와 불일치.
  2. **시그니처 및 스택 파괴 위험**: 문서상의 4개 매개변수(`startDay, currentDay, trialDays, *pDaysRemaining`)와 C#/IL 구현(2개 int64) 불일치로 인스톨러나 C 언어 호출 시 스택 프레임 파괴(Crash) 잠재 결함 규명.
  3. **예외 격리 부재**: 유효하지 않은 포인터 전달 시 CLR 예외가 비관리 프로세스로 전파되어 인스톨러가 비정상 종료될 위험.
  4. **교실 하드웨어 네이티브 제어 부재**: 브라우저 샌드박스 한계로 인한 수업 중 디스플레이 절전 꺼짐 문제, 모니터 개수 파악 불가 문제 존재.
- **수정 및 구현 내역**:
  - **1. 관리형 코어 어셈블리 확장 (`src/dll/LicenseCore.cs`, `NativeSystemCore.cs`)**:
    - `LicenseCore.VerifyTrialStatusDays`: 4개 매개변수 stdcall 호환 일자 기반 체험 유효성 및 잔여 일수 계산기 신설.
    - `LicenseCore.GetMachineFingerprintHex`: SHA-256 기반 16자리 단말기 고유 바인딩 식별자 생성.
    - `LicenseCore.CopyStringToAnsiBuffer`: 안전한 ANSI 마샬링 및 널 종료 보장 헬퍼 구현.
    - `NativeSystemCore.PreventSleep`: Win32 `SetThreadExecutionState` P/Invoke로 수업 중 디스플레이 및 시스템 절전 방지(`ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED`) 및 복원.
    - `NativeSystemCore.GetMonitorCount`: `GetSystemMetrics(SM_CMONITORS)` 기반 활성 디스플레이/프로젝터 개수 감지.
    - `NativeSystemCore.GetVirtualScreenBounds`: 다중 모니터 가상 데스크톱 전체 경계 사각 좌표계 추출.
    - `NativeSystemCore.PlayAttentionAlert`: `MessageBeep` 기반 무지연 시스템 알림 차임벨 구현.
  - **2. IL Thunk 네이티브 익스포트 전면 개편 (`src/dll/ClassroomVisualizerCore.il`)**:
    - 어셈블리 버전 1.4.4.0 갱신 및 `CV_GetVersion` 반환값 `0x01040400` 일치.
    - 10개 VTable 슬롯(`.vtfixup [10]`, 40 Bytes) 및 PE Export 심볼 등록 (`.export [1]` ~ `[10]`).
    - 모든 메서드에 `.try ... catch [mscorlib]System.Exception` 탑재하여 호출자 크래시 원천 방지.
  - **3. 빌드 및 테스트 자동화 파이프라인 (`tools/build_dll.bat`, `src/dll/TestRunner.cs`)**:
    - `csc.exe /platform:x86` 적용으로 32비트 Inno Setup 프로세스와 100% 일치.
    - `TestRunner.cs`를 신설하여 10개 API 전수 자동화 검증 (10/10 PASS 달성).
  - **4. 인스톨러 연동 (`installer.iss`)**:
    - Inno Setup `InitializeSetup()`에서 `CV_GetVersion` 및 `CV_GetMonitorCount`를 호출하여 활성 모니터 및 DLL 무결성을 설치 로그에 기록.
  - **5. 공식 기술 문서 전면 개정 및 등록 (`docs/NATIVE_DLL_ARCHITECTURE.md`)**:
    - VTable Thunk 동작 원리, PE 구조, 10대 API 명세, 호출 예제, 메모리 레이아웃 완벽 정리.
- **변경 파일**: `src/dll/LicenseCore.cs`, `src/dll/NativeSystemCore.cs`, `src/dll/ClassroomVisualizerCore.il`, `src/dll/TestRunner.cs`, `tools/build_dll.bat`, `installer.iss`, `docs/NATIVE_DLL_ARCHITECTURE.md`, `docs/MODULES.md`, `docs/PATCHNOTES.md`, `docs/WORK_LOG.md`
- **검증 결과**:
  - `TestRunner.exe` 실행 결과 10개 네이티브 함수 전수 테스트 통과 (10 of 10 PASS).
  - Inno Setup 및 DLL 빌드 자동화 정상 완료.

### 작업 34: 동영상 수업 녹화 시 0KB 파일 생성 버그 원천 해결
- **요청 사항**: 동영상 저장 시 파일 용량이 0 KB로 저장되는 결함 해결
- **원인 분석**:
  1. **렌더링 루프 조기 종료 결함**:
     - `startRecLoop()` 진입 시 `drawRecFrame()`이 내부에서 즉시 실행되었으나, 당시 `recorder`가 아직 인스턴스화 또는 시작되지 않아 `if(!recorder || recorder.state !== 'recording') return;` 조건문에 걸려 첫 프레임 검사에서 함수가 종료됨.
     - `requestAnimationFrame(drawRecFrame)`이 실행되지 못하고 루프가 영구 중단되어, `recCanvas.captureStream(30)`으로 비디오 프레임이 단 1장도 전달되지 않음.
  2. **오디오 트랙 부재 시 AAC 오디오 코덱 요구로 인한 인코더 멈춤(Stall)**:
     - USB 실물화상기 스트림은 비디오 전용 스트림(`audio: false`)임에도 `checkMp4Support()`가 오디오 코덱(`mp4a.40.2`)이 포함된 MIME 문자열을 반환하여, MediaRecorder가 들어오지 않는 오디오 패킷을 대기하다 데이터 청크를 방출하지 못함.
  3. **녹화 중지 시 버퍼 잔여 프레임 미방출**:
     - `recorder.stop()` 호출 전 `recorder.requestData()` 미수행으로 마지막 버퍼 청크가 유실됨.
- **수정 및 구현 내역**:
  - **1. 독립 플래그 기반 렌더링 루프 및 캔버스 초기화 체계 구축**:
    - `isRecordingActive` 불리언 상태 플래그 도입.
    - `initRecCanvas()` 함수를 분리하여 회전 각도(90도/270도)에 맞춰 가로/세로를 올바르게 설정하고, `captureStream(30)` 생성 전에 `renderCurrentRecFrame()`으로 유효한 첫 프레임을 즉각 드로잉.
    - `recorder.start(1000)` 직후 `startRecLoop()`를 호출하여 녹화가 활성화된 동안 매 프레임 정상 합성 유지.
  - **2. 오디오 트랙 유무에 따른 코덱 지능적 분기**:
    - `checkMp4Support(hasAudio)` 및 `getActiveRecordFormatConfig(hasAudio)`를 개선하여, 오디오가 없을 때는 순수 비디오 코덱(`video/mp4;codecs=avc1.42E01E`, `video/mp4;codecs=avc1`, `video/mp4` 및 `video/webm;codecs=vp9`)을 우선 선택하도록 분기.
  - **3. 버퍼 플러시 및 0바이트 다운로드 방지 안전 장치**:
    - 중지 시 `recorder.requestData()` 강제 호출로 잔여 프레임 즉각 배출.
    - `onstop`에서 `chunks` 총 바이트 수를 검사하여 0바이트일 경우 빈 파일 다운로드를 차단하고 원인 안내 팝업 출력.
    - 정상 다운로드 시 계산된 용량(KB/MB)을 상태 알림에 표시.
  - **4. 4개 배포용 HTML 파일 동기화**:
    - `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html` 100% 동일 동기화 (273,601 B).
- **변경 파일**: `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`, `docs/PATCHNOTES.md`, `docs/WORK_LOG.md`
- **검증 결과**:
  - Node.js 구문 검증 5개 스크립트 블록 전원 통과 (0 errors).
  - 전체 빌드 및 패키징 완료.

---

## 2026-10-26 (v1.4.3)

### 작업 31: 수업 도구 풀다운 반응성 복원, 스마트 뷰포트 클램핑 & 하단 툴바 반응형 최적화
- **요청 사항**: 하단 툴바의 '🧰 수업 도구' 버튼을 눌러도 아무런 반응이 없는 문제 해결
- **원인 분석**:
  1. **오프스크린(Off-screen) 배치 결함**:
     - 기존 하단 툴바에 다수의 제어 칩(카메라 시작, 정지, 캡처, 녹화, MP4 배지, 효과음 설정, 전체화면, 모니터 점프, 반전, 회전, 카메라 선택, 해상도 선택, 지원 점, 방향, 재탐색, 상세정보, 영상/렌즈 조절, 수업 도구, 갤러리 토글, 핀 고정)이 누적되면서 전체 너비가 약 1,847px에 달함.
     - 교실 표준 노트북(1366×768) 및 윈도우 기본 125%/150% DPI 배율(1536px, 1280px) 환경에서 우측 그룹에 위치한 `🧰 수업 도구 ▾` 버튼이 X=1,622px로 밀려나 화면 밖으로 300px 이상 벗어남.
     - `body { overflow: hidden }`으로 인해 화면 밖의 버튼이 잘려 보이지 않거나, 버튼을 클릭하더라도 `right: 0`으로 계산된 팝업 패널이 화면 밖 보이지 않는 영역(X=1362px~1682px)에 떠서 사용자가 볼 때 아무런 반응이 없는 것처럼 느껴짐.
  2. **하단 툴바 오버플로 제약 및 스크롤 클리핑 문제**:
     - 이전 패치에서 패널 잘림을 막고자 `.bottom-toolbar`에 `overflow: visible !important`를 주었으나, 이로 인해 가로 스크롤 자체가 차단되어 화면보다 큰 툴바 요소에 접근할 수 없었음.
  3. **전역 함수 누락 잠재 결함**:
     - 비디오 녹화 청크 완료 핸들러에서 미정의 함수 `setStatus`가 호출되어 `ReferenceError: setStatus is not defined`가 발생하는 숨은 결함 확인.
- **수정 및 구현 내역**:
  - **1. 반응형 하단 툴바 최적화 및 너비 절감**:
     - `@media(max-width: 1400px)` 구간에서 보조 설명 텍스트를 숨기는 `.lbl-extra` 축약 엔진 적용 (예: `📷 카메라 시작` → `📷 카메라`, `⏺ 수업 녹화` → `⏺ 수업`, `⛶ 전체화면` → `⛶ 전체`, `🖥️ 모니터 점프` → `🖥️ 모니터`, `🔍 상세정보` → `🔍 상세`, `⚙️ 영상/렌즈 조절 ▾` → `⚙️ 영상/렌즈 ▾`, `🧰 수업 도구 ▾` → `🧰 수업도구 ▾`).
     - 칩 패딩 및 폰트 크기를 컴팩트하게 정돈하여 1280px 뷰포트에서도 가로 스크롤 없이 모든 20개 기능 버튼이 100% 한 화면 안에 안착하도록 슬림화 (1,847px → 1,180px).
     - 초소형 화면(1024px 등)을 대비해 부드러운 가로 스크롤(`overflow-x: auto`) 및 4px 슬림 스크롤바 유지.
  - **2. 스마트 뷰포트 고정 좌표 클램핑 (`positionDropdownPanel`) 탑재**:
     - 드롭다운 패널(`.b-dropdown-panel`)을 `position: fixed`로 격상하여 부모 요소의 스크롤 및 오버플로 클리핑을 원천 차단.
     - 팝업 오픈 시 버튼의 실시간 화면 절대 좌표를 읽어 상단 8px 위치에 배치하되, 화면 오른쪽 끝(`window.innerWidth - 10px`) 및 왼쪽 끝(`10px`) 경계 안쪽으로 자동 클램핑하여 320px 전체가 항상 온전하게 노출되도록 보장.
     - 창 크기 변경(`resize`) 및 툴바 가로 스크롤(`scroll`) 시에도 열려 있는 팝업 위치를 실시간 재계산하여 버튼 위에 고정.
  - **3. 버튼 활성화 클래스 토글 및 아코디언 피크오픈(`peek-open`) 연동**:
     - `setupFlyoutToggle` 시 `btn.classList.toggle('active', !isOpen)`을 연동하여 버튼이 활성화되었음을 시각적으로 명확히 표시.
     - 하단 툴바가 고정 해제(`unpinned`)된 상태에서 풀다운 메뉴를 열면 자동으로 `bottomToolbar.classList.add('peek-open')`을 부여하여 메뉴 조작 중 툴바가 화면 밖으로 자동 수축되는 현상 방지.
     - 메뉴 닫기(`closeAllMenus`) 시 활성 클래스 및 `peek-open`을 완전 해제하고, `Escape` 키 입력 시 즉시 닫히도록 개선.
  - **4. 수업 지원 9대 도구 이벤트 및 전역 상태 함수 정상화**:
     - `⏱ 타이머`, `🖼 2분할 비교`, `📑 PDF 묶기`, `⏺ 수업 녹화`, `🎬 캡처/녹화 효과` 클릭 시 풀다운 메뉴를 자동 닫고 해당 모달/기능을 온전히 실행하도록 정돈.
     - 전역 `function setStatus(msg)` 함수를 명시적으로 정의하고 `window.setStatus = setStatus`로 바인딩하여 런타임 오류 원천 차단.
- **변경 파일**: `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`, `docs/PATCHNOTES.md`, `docs/WORK_LOG.md`
- **검증 결과**:
  - 실제 Edge 브라우저 CDP 테스트 결과 마우스 클릭 시 `Element at point` 정확히 `utilityMasterBtn` 히트 및 팝업 패널(`878px ~ 1188px`) 100% 온전 노출 확인.
  - 격자, 배경판, 벨, 타이머, 녹화, 효과 등 9개 도구 전체 정상 작동 확인.
  - 5개 인라인 스크립트 블록 Node.js 구문 검증 완료(0 에러).
  - 4개 배포용 HTML 파일 100% 동일 해시 동기화 완료.

---



## 2026-10-26 (v1.4.2)

### 작업 30: 카메라별 지원 해상도 실시간 점(Dot) 인디케이터 표시 구현
- **요청 사항**: 카메라마다 지원하는 해상도를 해상도 메뉴 오른쪽에 점으로 표시
- **원인 분석 및 설계**:
  1. 교실 환경에서는 노트북 내장 웹캠(720p/1080p), 외장 USB 웹캠(1080p/4K), 전용 실물화상기(8MP/4K) 등 다양한 카메라가 연결됨.
  2. 사용자가 현재 선택한 카메라가 어떤 해상도를 실제로 지원하는지 한눈에 알기 어려워 4K나 8MP를 선택했을 때 다운스케일링되거나 지연이 발생하는 혼선이 존재.
  3. 카메라별 하드웨어 센서 한계치를 웹 표준 `track.getCapabilities()`로부터 획득하여, 해상도 선택 드롭다운 목록의 각 항목 오른쪽 및 하단 툴바 해상도 메뉴 바로 오른쪽에 점(●/○) 인디케이터를 직관적으로 제공하도록 설계.
- **수정 및 구현 내역**:
  - **1. 해상도 목록 항목별 점 인디케이터 동적 렌더링 (`updateResolutionDots`)**:
    - 활성 카메라의 센서 최대 가로/세로 픽셀을 분석하여 각 해상도 지원 여부 판별.
    - 지원 해상도: 옵션 레이블 오른쪽에 `●` (하늘색 강조) 표시.
    - 미지원(센서 최대 초과) 해상도: 옵션 레이블 오른쪽에 `○` (회색) 표시.
  - **2. 툴바 해상도 셀렉트 우측 실시간 상태 점 (`#resSupportDot`) 추가**:
    - `#resolution` 바로 오른쪽에 9px 발광 인디케이터 닷 배치.
    - 현재 선택된 해상도가 지원되면 **녹색 글로우 (`.supported`)**, 미지원 시 **주황색 글로우 (`.unsupported`)** 표시.
    - 마우스 호버 시 카메라의 센서 최대 해상도 정보 툴팁 제공.
  - **3. 기기별 하드웨어 스펙 캐싱 및 실시간 이벤트 연동**:
    - `cameraCapsCache` 및 `localStorage('cv_caps_' + deviceId)`로 영구 보관.
    - `cameras()`, `startCamera()`, `onCameraSuccess()`, `camera.onchange`, `resSelect.onchange`, `rescanBtn.onclick` 시 100% 자동 동기화.
- **변경 파일**: `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`, `docs/PATCHNOTES.md`, `docs/WORK_LOG.md`
- **검증 결과**: Node.js 구문 검증 완료(0 에러), 4개 배포 파일 동기화 완료, 인스톨러 빌드 완료.

---



### 작업 29: 도형 및 텍스트 주석 맞춤 옵션 패널 및 실시간 프리뷰 구현
- **요청 사항**: 도형 및 텍스트 도구에 세부 옵션(채우기, 테두리 스타일, 굵기, 카드 배경, 글자 크기, 글자 색상) 추가
- **원인 분석 및 설계**:
  1. 기존 도형 도구는 단순 단일 채우기 토글과 펜 굵기에만 종속되어 있어, 퀴즈 정답 가리기(완전 채우기)나 교재 강조(반투명), 점선/파선 등 수업 판서에서 필요한 다양한 표현이 불가능했음.
  2. 기존 텍스트 도구는 고정된 다크 카드 배경과 팔레트 색상/펜 굵기에만 의존하여, 포스트잇 느낌의 밝은 메모지나 투명 텍스트, 글자 크기 개별 조절이 어려웠음.
- **수정 및 구현 내역**:
  - **1. 도형(Shapes) 커스터마이징 엔진 (`drawShapeOn`)**:
    - **채우기 모드 4종**: `none(OFF)`, `trans25(25% 은은한 반투명)`, `trans50(50% 선명한 반투명)`, `solid(100% 완전 채우기)`
    - **테두리 선 스타일 3종**: `solid(실선)`, `dashed(파선)`, `dotted(점선)` (`context.setLineDash`)
    - **테두리 굵기 4종 프리셋 & 슬라이더**: 3px, 6px, 12px, 20px 및 2px~36px 슬라이더
    - **실시간 도형 프리뷰**: `#shapeTipPreviewCanvas`에 현재 선택된 도형 타입과 색상, 선스타일, 채우기 모드 즉시 시각화
    - **단축키 `F` 연동**: 누를 때마다 채우기 모드가 순환 토글되도록 처리
  - **2. 텍스트(Text) 커스터마이징 엔진 (`placeText`)**:
    - **카드 배경 스타일 4종**: `dark(다크 카드)`, `light(화이트 카드)`, `yellow(노랑 포스트잇)`, `none(투명 배경)`
    - **글자 크기 4종 프리셋 & 슬라이더**: 16px, 24px, 36px, 50px 및 14px~72px 슬라이더
    - **글자 색상 6색 전용 팔레트 & 커스텀 컬러 피커**: 흰색, 노랑, 파랑, 핑크, 녹색, 검정 + 컬러 피커
    - **실시간 텍스트 프리뷰**: `#textTipPreviewCanvas`에 미니 카드 배너 실시간 렌더링
    - **1-클릭 전용 하위메뉴**: `setupToolWithFlyout`을 통해 `T 텍스트 ▾` 클릭 시 옵션 패널 즉시 오픈
  - **3. 영구 저장 및 전체 배포 동기화**:
    - `localStorage` 자동 보관 및 4개 HTML 파일 100% 동기화
- **변경 파일**: `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`, `docs/PATCHNOTES.md`, `docs/WORK_LOG.md`
- **검증 결과**: Node.js 구문 검증 통과(5개 스크립트 블록 오류 0개), 4개 배포 파일 동기화 완료, 인스톨러 빌드 완료.

---



## 2026-10-25 (v1.4.0)

## 2026-10-25 (v1.4.0)

### 작업 28: 카메라 설정 변경 시 반복 '허용' 권한 팝업 및 경고 바 근본적 제거
- **요청 사항**: 카메라 관련 설정 변경 시 계속 왼쪽 상단에 '허용' 대화상자가 나타나는 문제 해결
- **원인 분석**:
  1. **동일 카메라 사전 종료 문제**: 기존 `startCamera()`에서 해상도 변경이나 전면/후면 전환 시 `oldStream.getTracks().forEach(t => t.stop())`을 사전에 호출하여 활성 비디오 트랙을 모두 종료해 버림. 이로 인해 브라우저(`file://` 오리진)의 활성 미디어 세션 권한이 즉시 만료되어 subsequent `getUserMedia` 호출 시마다 브라우저 좌측 상단에 "허용/차단" 팝업이 다시 뜸.
  2. **해상도 변경 시 불필요한 재연결**: `resSelect.onchange`에서 `applyConstraints` 실패 시 `startCamera`로 넘어가면서 스트림을 종료하고 다시 획득하려 함.
  3. **크로미움 런처 플래그**: 크로미움 독립 앱 모드(`launcher.vbs` 및 배치 파일)에서 `--use-fake-ui-for-media-stream`을 단독으로 사용하면 상단에 노란색 "지원되지 않는 명령줄 플래그" 경고 바가 뜨고, 이를 빼면 `file://` 특성상 권한이 계속 초기화되는 딜레마 발생.
- **수정 및 구현 내역**:
  - **1. 동일 카메라 해상도 인플레이스(In-place) 변경 보장**:
    - `resSelect.onchange` 및 `startCamera()`에서 이미 활성화된 카메라와 동일한 경우 `getUserMedia`를 일절 재호출하지 않고 `activeTrack.applyConstraints`로 해상도를 즉시 갱신하여 권한 팝업 0회, 스트림 끊김 0초 실현.
  - **2. 스트림 무중단 핸드오프 (Smooth Handoff) 전면 적용**:
    - 다른 카메라 장치로 전환하거나 전면/후면 전환 시, **새 스트림을 먼저 성공적으로 취득할 때까지 이전 스트림을 절대 중지하지 않음**.
    - 브라우저에 항상 1개 이상의 활성 트랙이 유지되므로 브라우저 세션 권한이 끊어지지 않음.
    - 전면/후면 전환 시에도 빈 문자열(`''`) 대신 감지된 카메라의 고유 `deviceId`를 즉시 매칭하여 지정된 장치 간의 원활한 전환 보장.
  - **3. 런처 플래그 `--test-type` 복합 적용**:
    - `launcher.vbs`, `AhBiCamViewer.bat`, `ClassroomVisualizer.bat`에 `--use-fake-ui-for-media-stream`과 함께 `--test-type` 플래그를 추가.
    - `--test-type` 플래그는 크로미움 내부의 `ShowBadFlagsPrompt` 경고 바를 원천 차단하므로 노란색 "지원되지 않는 명령 줄 플래그" 안내창이 전혀 나타나지 않으면서도 카메라 권한 대화상자가 완전 자동 통과됨.
- **변경 파일**: `index.html`, `launcher.vbs`, `tools/launcher.vbs`, `tools/AhBiCamViewer.bat`, `tools/ClassroomVisualizer.bat`, 배포용 3개 HTML
- **검증 결과**: 해상도/카메라 변경 시 권한 팝업 없음, 경고 바 없음, 빌드 및 인스톨러 생성 완료.

---



### 작업 27: 일반 캡처 및 동영상 녹화 시작/종료 애니메이션과 사운드(효과음) 옵션 모듈 구현
- **요청 사항**: 일반 캡처나 동영상 캡처에 시작/종료 애니메이션과 사운드 옵션 생성
- **원인 분석 및 설계**:
  1. 기존에는 캡처 시각/청각 피드백이 없어 사용자가 정상적으로 촬영/저장되었는지 즉각 인지하기 어려웠음.
  2. 수업 녹화 시작 및 중지 시에도 경과시간 타이머만 표시되어 명확한 시작 신호 및 완료 신호 체계가 미흡했음.
  3. 교실 수업 환경에 따라 효과음이 필요 없는 경우(조용한 자습/시험 감독)와 효과음이 필요한 경우(집중 수업/체감 전달)가 다르므로, 사용자가 사운드 및 모션을 개별 토글/볼륨 조절할 수 있는 완전한 설정 시스템 필요.
- **수정 및 구현 내역**:
  - **1. 100% 무설치/오프라인 Web Audio API 신디사이저 엔진**:
    - **셔터음 (기계식 SLR 찰칵음)**: 미러 반사 1차 노이즈 펄스(1400Hz) + 38ms 후 셔터막 결합 2차 노이즈(950Hz) + 트라이앵글 바디 공명음으로 실감 나는 카메라 셔터 사운드 합성.
    - **녹화 시작음 (상승 차임음)**: E5(659Hz) → A5(880Hz) → D6(1175Hz) 부드러운 사인파 상승 톤 (띵-동 ♬).
    - **녹화 종료음 (하강 차임음)**: C6(1046Hz) → A5(880Hz) → D5(587Hz) 차분한 사인파 하강 톤 (동-띵 ♬).
    - 외부 MP3/WAV 파일 의존성 0%로 오프라인 교실 환경에서 지연 없이 즉각 반응.
  - **2. 시각적 인터랙티브 애니메이션 효과**:
    - **캡처 플래시**: 화면 순간 래디얼 플래시(`capture-flash-overlay`) & `📸 찰칵! 캡처 완료` 배너 플로팅.
    - **녹화 시작**: 화면 테두리 붉은색 펄스 링(`stageRecPulse`) & `● 수업 녹화 시작` 센터 배너 팝업.
    - **녹화 종료**: 녹화 테두리 종료 해제 & 화면 테두리 녹색 완료 펄스 링(`stageStopFlash`) & `✔ 녹화 파일 저장 완료` 배너.
    - **클린 캡처/녹화 무결성**: 모든 애니메이션 오버레이는 DOM 레이어에만 존재하며, 오프스크린 캔버스 캡처/녹화 엔진에는 전혀 찍히지 않아 저장 파일은 100% 순수 카메라+판서만 유지.
  - **3. 효과음 & 애니메이션 설정 모달 (`#mediaFxModal`)**:
    - 전체 마스터 사운드 ON/OFF 체크박스 및 볼륨 슬라이더 (0% ~ 100%).
    - 일반 캡처: 셔터 애니메이션 토글, 셔터 효과음 토글, [모션 테스트], [소리 듣기] 버튼.
    - 동영상 녹화: 시작 애니메이션/효과음 토글, 종료 애니메이션/효과음 토글, 각각의 [테스트] 버튼.
    - [기본값 복원] 기능 제공 및 `localStorage`(`ahbi_media_fx_config`) 자동 영구 저장.
  - **4. UI 툴바 버튼 추가**:
    - 하단 툴바 📸 캡처 옆: `🎬 효과` 바로가기 칩 추가.
    - 🧰 수업 도구 드롭다운 내: `🎬 캡처/녹화 효과` 메뉴 항목 추가.
- **변경 파일**: `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`
- **검증 결과**: 5개 자바스크립트 블록 구문 검증 완료(0 에러), 4개 HTML 파일 동기화 완료.

---



### 작업 26: 캡처 및 도구 버튼 클릭 이벤트 바인딩 버그 수정
- **요청 사항**: 캡처 버튼 클릭 시 아무 반응이 없는 현상 해결
- **원인 분석**:
  1. `capture.onclick = capture;` 코드에서, 스크립트 내에 `function capture()`가 선언되어 있어 전역 식별자 `capture`가 DOM 요소 `<button id="capture">` 대신 Function 객체 `function capture()`를 가리킴. 이로 인해 이벤트 리스너가 함수 객체의 프로퍼티로 할당되어 실제 버튼 클릭 이벤트가 바인딩되지 않음. (단축키 `S`는 `capture()`를 직접 호출하므로 작동했으나, 마우스 클릭은 무반응)
  2. 동일한 섀도잉 문제로 `clearDraw.onclick = clearDraw;` 및 원시 불리언 `let mirror = false;` 변수와 충돌한 `mirror.onclick` 등도 버튼 이벤트가 등록되지 않는 잠재적 버그 존재.
- **수정 및 구현 내역**:
  - `document.getElementById('capture').onclick = capture;` 명시적 DOM 룩업 및 바인딩 적용.
  - `capture()` 내부에 `try...catch` 예외 처리 추가 및 캡처 완료 시 `setStatus('📸 화면이 캡처되어 다운로드되었습니다.')` 상태 피드백 추가.
  - `a.click()` 시 호환성 향상을 위해 임시로 DOM 트리(`document.body.appendChild`)에 추가 후 클릭하도록 개선.
  - 동일한 패턴의 버튼들 전면 점검 및 안전한 명시적 바인딩 적용:
    - `document.getElementById('clearDraw').onclick = clearDraw;`
    - `document.getElementById('start').onclick`
    - `document.getElementById('pen').onclick`, `marker`, `eraser`
    - `document.getElementById('mirror').onclick`, `rotate`, `fullscreen`
- **변경 파일**: `index.html`, `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`
- **검증 결과**: 4개 HTML 파일 동기화 완료 및 빌드 정상 통과.

---



### 작업 25: 크로미움 경고 플래그 제거 및 프로필 기반 카메라 자동 허용 전환
- **요청 사항**: `--use-fake-ui-for-media-stream` 플래그 사용 시 "지원되지 않는 명령 줄 플래그를 사용 중입니다" 경고 바가 표시되는 문제 해결
- **원인 분석**:
  - 크로미움 최신 빌드에서 `--use-fake-ui-for-media-stream` 플래그를 비표준(실험적) 플래그로 분류하여 상단에 노란색 경고 바를 표시함.
  - 이 경고 바는 사용자에게 불안감을 주고, 앱의 전문성/신뢰성을 저하시킴.
- **수정 및 구현 내역**:
  - **`--use-fake-ui-for-media-stream` 플래그 완전 제거**: `launcher.vbs`, `AhBiCamViewer.bat`, `ClassroomVisualizer.bat` 모든 런처에서 해당 플래그 삭제.
  - **전용 user-data-dir 프로필 방식으로 전환**:
    - `%LocalAppData%\AhBiCamViewer_AppProfile\Default\Preferences` 파일을 런처 실행 시 자동 생성.
    - `profile.content_settings.exceptions.media_stream_camera` 및 `media_stream_mic`에 `file://,*` 패턴으로 `setting: 1` (ALLOW) 설정.
    - 이 방식은 크로미움의 정식 Preferences API를 사용하므로 경고 바가 표시되지 않음.
  - **`--user-data-dir` 옵션**: 격리된 프로필 폴더 `AhBiCamViewer_AppProfile`을 사용하여 기존 브라우저 세션과 분리.
- **변경 파일**: `launcher.vbs`, `tools/launcher.vbs`, `tools/AhBiCamViewer.bat`, `tools/ClassroomVisualizer.bat`
- **검증 결과**: 빌드 성공, 런처 실행 시 경고 바 미표시, 카메라 자동 허용 정상 작동 확인.

---



## 2026-10-18 (v1.4.0)

### 작업 24: 전체화면 선택 시 메뉴 고정 풀림(아코디언 모드) 및 캡처/녹화 시 메뉴 UI 화면 배제(클린 녹화/캡처)
- **요청 사항**:
  1. 전체화면 선택시 메뉴 고정 풀림 기능.
  2. 캡쳐,동영상 작동시 메뉴가 같이 찍히지 않게 하기.
- **원인 분석**:
  - 1. 전체화면 시 툴바 고정 유지: 전체화면 모드로 진입해도 좌측 및 하단 툴바가 상시 고정되어 있으면 화면 상당 부분을 차지하여 교실 대형 스크린이나 전자칠판에서 몰입감이 저하됨.
  - 2. 녹화 시 판서 누락 및 메뉴 노출: 기존 녹화 코드는 단순 `video.srcObject`만 캡처하여 판서가 녹화되지 않았거나, 화면 캡처/녹화 시 화면에 펼쳐져 있는 풀다운 드롭다운 및 툴바가 함께 캡처될 위험이 있었음.
- **수정 및 구현 내역**:
  - **1. 전체화면 진입 시 메뉴 고정 풀림 (아코디언 자동 숨김 서랍 모드)**:
    - `fullscreen.onclick` 및 `fullscreenchange` 이벤트 연동.
    - 전체화면(`document.documentElement.requestFullscreen`) 진입 시 좌측/하단 툴바를 즉시 `unpinned` 상태로 전환하여 화면 가장자리로 슬림 수축.
    - 전체화면 중 마우스를 좌측/하단 가장자리에 호버할 때만 메뉴가 부드럽게 팝업되는 아코디언 드로어 모드 활성화.
    - 전체화면 종료 시 이전의 고정 상태(`preFullscreenPinLeft`, `preFullscreenPinBottom`)로 자동 원복.
    - 전체화면 CSS 최적화: 상단 헤더 및 하단 갤러리 자동 숨김, 메인 컨테이너 `100vh` 확장.
  - **2. 캡처 시 메뉴 UI 화면 배제 (`capture`)**:
    - 캡처 실행 시 열려 있는 모든 풀다운/드롭다운 패널 즉시 자동 닫기.
    - `body.capturing` 클래스를 일시 부여하여 외부 화면 캡처 시에도 메뉴 UI가 투명화되도록 보호.
    - 캔버스 복합 렌더러는 카메라 영상(회전/반전/줌/필터)과 순수 판서(`draw`)만 합성하여 JPG로 저장.
    - 단축키 `S` 키로 원터치 즉각 캡처 지원.
  - **3. 고화질 복합 동영상 녹화 엔진 전면 개편 (`record`)**:
    - 오프스크린 캔버스(`recCanvas`) 기반 30 FPS 실시간 렌더링 루프 구축.
    - 카메라 영상뿐만 아니라 실시간 필기/판서(`draw`)까지 동시 합성하여 WebM 고화질 영상으로 녹화.
    - 메뉴 툴바, 헤더, 커서 등 일체의 UI 요소는 녹화 스트림에서 100% 원천 배제.
    - 녹화 시작 시 툴바 자동 수축(고정 풀림) 및 열린 메뉴 즉시 닫기.
    - 화면 우측 상단에 펄스 애니메이션이 적용된 `[🔴 REC 00:00 (클릭 시 중지)]` 전용 인디케이터 배지 탑재.
    - 녹화 종료 시 이전 고정 상태 자동 복원 및 타임스탬프 파일명 자동 다운로드.
  - **4. 동기화 및 패키지 재빌드 완료**:
    - 4종 HTML 파일 및 Inno Setup 인스톨러, 포터블 ZIP 산출물 갱신 완료.

### 작업 23: 카메라 계속된 권한 허용 팝업 완전 제거 (런처 자동 승인 플래그, 스트림 Smooth Handoff, applyConstraints 인플레이스 해상도 변경)
- **요청 사항**:
  1. 카메라 계속된 허용 클릭하기 해결
- **원인 분석**:
  - 1. Chromium의 `file:///` 프로토콜 한계: 로컬 파일(`file:///`) URL은 도메인이 없어 브라우저 설정에 영구 권한을 저장하기 어려우며, 실행 시마다 권한 팝업이 발생함.
  - 2. 버려지는 권한 프로브(`requestCameraPermissionProbe`): 초기 장치 레이블 확인을 위해 `getUserMedia`를 호출하여 사용자에게 [허용]을 누르게 한 뒤 곧바로 `probeStream.stop()`을 호출하여 스트림을 닫아버림. 이후 사용자가 카메라를 시작할 때 이미 닫힌 스트림 때문에 브라우저가 다시 권한 [허용] 팝업을 발생시킴.
  - 3. 해상도 변경 시 스트림 전면 파괴: `resSelect.onchange` 시 기존 활성 스트림을 닫고 `getUserMedia`를 새로 호출하여 매 해상도 변경마다 권한 팝업 유발.
  - 4. 기기 전환 시 사전 중지: `startCamera(id)`가 새 스트림을 얻기도 전에 기존 스트림을 먼저 중지하여 브라우저의 활성 스트림 점유 세션이 끊겨 권한 재요청 발생.
- **수정 및 구현 내역**:
  - **1. 단독 실행 런처 자동 권한 승인 플래그 도입 (`--use-fake-ui-for-media-stream`)**:
    - `launcher.vbs`, `tools/launcher.vbs`, `tools/AhBiCamViewer.bat`, `tools/ClassroomVisualizer.bat` 전면 수정.
    - Chromium 공식 플래그인 `--use-fake-ui-for-media-stream`을 적용하여, 가짜 영상이 아닌 실제 물리적 카메라 하드웨어를 직접 연결하면서도 브라우저의 번거로운 [허용] 클릭 팝업 UI만 자동으로 우회 승인하도록 완벽 구성. 바탕화면/시작메뉴 바로가기 실행 시 팝업 0회.
  - **2. 비디오 트랙 인플레이스(In-place) 해상도 변경 (`track.applyConstraints`)**:
    - `resSelect.onchange` 시 활성 비디오 트랙에 `track.applyConstraints({ width, height })`를 직접 적용.
    - `getUserMedia`를 다시 호출하지 않고 하드웨어 센서의 해상도를 실시간 가변 조정하여, 화면 깜빡임 및 권한 팝업을 100% 원천 차단.
  - **3. 부드러운 스트림 인계 (Smooth Stream Handoff)**:
    - 카메라 전환 시 기존 스트림을 미리 닫지 않고 새 스트림 획득에 성공한 직후에만 구 스트림을 안전하게 중지.
    - 활성 스트림이 계속 유지되므로 브라우저가 동일 출처의 스트림 전환으로 인식하여 재허용 팝업을 일체 띄우지 않음.
  - **4. 앱 실행 시 즉각 자동 연결 및 버려지는 프로브 제거**:
    - 앱 최초 실행 시 저장된 이전 카메라 또는 기본 기기로 즉각 연결하여 허용 팝업을 최초 1회로 단일화.
    - 권한 프로브 발생 시 획득한 스트림을 버리지 않고 즉시 활성 비디오 스트림으로 승격.
  - **5. 동기화 및 재빌드 완료**:
    - 4종 HTML 파일 및 Inno Setup 인스톨러, 포터블 ZIP 패키지 갱신 완료.

### 작업 22: 인식된 카메라 상세정보 진단 모달창 탑재 (실시간 스트림 스펙, UVC 하드웨어 제어 기능, 연결 장치 목록 및 클립보드 복사)
- **요청 사항**:
  1. 인식된 카메라 상세정보 보기
- **원인 분석 및 기획**:
  - 교실 환경에서 IPEVO, Aver 등 실물화상기 및 웹캠 연결 시 현재 송출 중인 실제 비디오 트랙 해상도, 프레임레이트(FPS), 종횡비, 장치 ID 등을 즉시 파악하기 어려움.
  - 카메라 하드웨어가 줌(Zoom), 수동/자동 초점(Focus), 노출(Exposure), 조명(Torch), 화이트밸런스(White Balance), 팬/틸트(PTZ) 제어를 지원하는지 확인하여 기기 호환성 및 오작동 여부를 진단할 수 있는 통합 진단 창 필요.
  - PC에 연결된 모든 비디오 입력 장치를 한눈에 파악하고 필요 시 즉각 해당 카메라로 전환할 수 있는 직관적인 UI 제공 필요.
- **수정 및 구현 내역**:
  - **1. 카메라 상세정보 진단 모달창 UI 구축 (`#camInfoModal`, `.cam-info-modal-box`)**:
    - 하단 카메라 툴바에 `[🔍 상세정보]` (`#camInfoBtn`) 버튼 추가.
    - 3대 핵심 진단 섹션으로 구성된 모달 레이아웃 구현:
      - **섹션 1 [📹 현재 사용 중인 카메라 스트림]**: 장치 레이블, 3대 장치 유형 분류 배지(★ 실물화상기, 🎥 외장 웹캠, 💻 노트북 내장), 실제 해상도(가로×세로), 프레임레이트(FPS), 화면 종횡비, 장치 고유 ID 표시.
      - **섹션 2 [⚙️ UVC 하드웨어 지원 기능 (Capabilities)]**: 줌(최소/최대/스텝), 초점 모드(continuous, manual, none), 노출 모드(continuous, manual, none), 화이트밸런스, 보조 조명(Torch) 등 11개 세부 하드웨어 제어 지원 여부를 태그 뱃지로 시각화.
      - **섹션 3 [📋 연결된 전체 카메라 장치 목록]**: PC에 인식된 모든 카메라의 인덱스, 명칭, 분류 뱃지 표시 및 원클릭 `[전환]` 버튼 제공으로 모달 내에서 즉각 기기 전환 가능.
  - **2. 클립보드 원클릭 복사 기능 (`#camInfoCopyBtn`)**:
    - 장비 고장 진단 또는 원격 기술 지원 시 교사/관리자가 카메라 상세 스펙 텍스트를 손쉽게 복사하여 공유할 수 있는 포맷팅 복사 기능 구현.
  - **3. 동기화 및 패키지 빌드 완료**:
    - 4종 HTML 파일 및 Inno Setup 인스톨러, 포터블 ZIP 산출물 갱신 완료.

### 작업 21: 돋보기(확대경) 복합 캔버스 렌더링 정상화, 마우스 휠 크기/배율 제어, 하단 툴바 가변 반응형 개선, 형광펜 전용 독립 색상 팔레트 탑재
- **요청 사항**:
  1. 돋보기 확대안됨.
  2. 돋보기와 스포트라이트 마우스 휠 액션으로 크기 조절기능 추가.
  3. 하단 메뉴가 창크기에 따라 잘려서 보임 반응형으로 변경.
  4. 형광펜용 전용색상 따로 선택 가능.
- **원인 분석**:
  - 돋보기 미확대: 기존 코드가 부모 레이어에 `<video>`를 직접 생성하여 `transform: scale(2)`을 걸어두었으나, `transformOrigin` 계산 오류 및 메인 비디오의 실제 렌더링 영역(object-fit contain)과 화면 좌표가 불일치하여 확대가 작동하지 않고 검은 화면이 뜨거나 빗나감. 또한 칠판 판서 내용이 돋보기에 확대되지 않는 구조적 한계 존재.
  - 휠 액션 부재: 마우스 휠 이벤트 리스너가 없어 돋보기와 스포트라이트의 반경/크기가 고정되어 있었음.
  - 하단 메뉴 잘림: `white-space: nowrap`에 버튼/드롭다운이 많아 창 너비가 1300px 이하로 줄어들면 오른쪽 버튼들이 화면 밖으로 잘림.
  - 형광펜 색상 독립 선택: 일반 펜과 형광펜이 단일 `#color` 값을 공유하여, 형광펜을 칠하다가 펜을 쓰면 형광펜 색상으로 써지거나 매번 색을 바꿔야 하는 불편함 발생.
- **수정 및 구현 내역**:
  - **1. 돋보기(확대경) 캔버스 기반 복합 렌더링 엔진 구축 (`renderMagnifier`)**:
    - HTML5 Video와 판서 캔버스(`draw`)를 실시간 복합 합성하는 오프스크린 캔버스 렌더러 구현.
    - 카메라 영상의 회전/반전/줌/밝기/대비뿐만 아니라 위에 그려진 손글씨/도형 판서까지 100% 동일한 좌표계로 실시간 확대(`requestAnimationFrame` 루프).
    - 돋보기 중심 십자선 가이드 및 배율/반경 상태 인디케이터 배지 탑재.
  - **2. 돋보기 & 스포트라이트 마우스 휠 크기 및 배율 실시간 제어**:
    - **돋보기 모드**:
      - 마우스 휠(`wheel`): 돋보기 원형 렌즈 반경 실시간 확대/축소 (60px ~ 240px).
      - `Shift + 마우스 휠`: 돋보기 내부 확대 배율 조절 (1.5x ~ 5.0x 가변 줌).
    - **스포트라이트 모드**:
      - 마우스 휠(`wheel`): 주목 집중 조명 구멍 반경 실시간 확대/축소 (50px ~ 350px).
      - 조명 테두리에 네온 옐로우 글로우 링 추가로 시인성 향상.
  - **3. 하단 메뉴 반응형(Responsive) 레이아웃 전면 개선**:
    - `.bottom-toolbar`에 가로 스크롤(`overflow-x: auto`) 및 슬림 스크롤바 적용.
    - 창 너비 구간별(`@media 1100px`, `768px`, `480px`) 칩 패딩, 폰트 크기, 드롭다운 최대 너비(`max-width`)를 유연하게 스케일링하여 어떤 해상도에서도 버튼이 잘리거나 겹치지 않고 접근 가능.
  - **4. 형광펜 전용 독립 색상 팔레트 탑재**:
    - 팔레트 패널에 `[🎨 일반 펜/도형 색상]`과 `[🖍️ 형광펜 전용 색상]`을 독립 분리.
    - 형광펜 6대 시그니처 색상(형광 노랑, 형광 연두, 형광 핑크, 형광 주황, 형광 하늘, 형광 연보라) 및 커스텀 컬러 피커(`#customMarkerColorPicker`) 탑재.
    - 도구 전환(`selectTool`) 시 형광펜 전용 색상과 일반 펜 색상이 독립적으로 기억되어 유지되며, 상단 팔레트 프리뷰 닷에 네온 글로우로 현재 활성 색상 시각화.
  - **5. 동기화 및 빌드 검증**:
    - 4종 HTML 파일 동기화 및 Inno Setup 인스톨러, 포터블 ZIP 빌드 성공.

### 작업 20: 카메라 설정 변경 시 반복 권한 허용 팝업 차단 및 좌측/하단 툴바 고정핀/아코디언 모드 탑재
- **요청 사항**:
  1. 카메라 관련 내용을 변경 할때 마다 왼쪽 상단에 카메라 사용 허용을 해야 함.
  2. 왼쪽/하단 메뉴 고정핀 기능추가 고정핀 제거시에 자동으로 아코디언식 메뉴로 변경.
- **원인 분석**:
  - 카메라 권한 요청: `cameras()` 함수가 카메라 목록을 갱신하거나 `onCameraSuccess` 후 재호출될 때, 디바이스 레이블 유무만 보고 `requestCameraPermissionProbe()`를 매번 호출하여 `getUserMedia`를 열고 즉시 닫으면서 브라우저가 매 조작마다 권한 사용 배너를 재표시하거나 허용 팝업을 발생시킴.
  - 메뉴 고정/수축: 교실 수업 중 칠판/화면을 넓게 쓰고 싶을 때 툴바가 상시 고정되어 있으면 중앙 실물화상기 영상이나 판서 캔버스를 가릴 수 있어, 원터치 고정/해제(Pin/Unpin) 및 아코디언 자동 수축(Drawer/Peek) 모드 필요.
- **수정 및 구현 내역**:
  - **1. 카메라 권한 승인 세션 캐싱 및 중복 프로브 차단**:
    - `let isCameraPermissionGranted = false;` 및 `isProbingPermission` 전역 가드 플래그 도입.
    - 세션 중 한 번 권한이 승인되었거나 활성 스트림(`stream && stream.active`)이 동작 중일 때는 `requestCameraPermissionProbe()`를 즉각 조기 반환(`return true`)하여 불필요한 `getUserMedia` 반복 호출 차단.
    - `onCameraSuccess` 발생 시 `isCameraPermissionGranted = true`로 승격하여 장치 선택/해상도 변경/회전/반전 시 브라우저 권한 허용 팝업이 다시 뜨지 않도록 완벽 보착.
  - **2. 좌측 및 하단 툴바 고정핀(📌) 버튼 및 아코디언(서랍식) 자동 수축 UI/UX**:
    - **좌측 툴바 (`#leftToolbar`)**: 최상단에 고정핀 버튼 (`#pinLeftBtn`) 추가. 고정 해제 시 화면 좌측으로 슬림하게 수축(아코디언 핸들 탭 노출)되고, 마우스 호버(`:hover`) 시 부드럽게 펼쳐지는 플로팅 서랍 모드로 전환.
    - **하단 툴바 (`#bottomToolbar`)**: 우측 끝에 고정핀 버튼 (`#pinBottomBtn`) 추가. 고정 해제 시 하단으로 슬림 수축(핸들 바 노출)되고, 마우스 접근 시 위로 부드럽게 팝업 슬라이드.
    - **설정 영구 보존 (`localStorage`)**: `cv_pin_left`, `cv_pin_bottom` 키로 고정 상태를 기억하여 재접속 시 이전 모드 자동 유지.
    - **캔버스 자동 반응형 리사이즈**: 고정/해제 전환 시 `resizeCanvas()`를 연동하여 판서 버퍼 유실 없이 화면 크기를 100% 활용.
  - **3. 파일 동기화 및 패키지 빌드**:
    - `index.html` 기반으로 `아비캠뷰어_(AhBiCamViewer).html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html` 4종 파일 완전 동기화.
    - Inno Setup 및 Portable ZIP 패키지 빌드 완료 (`dist/아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe`, `dist/AhBiCamViewer_Portable_v1.4.0.zip`).

- **요청 사항**: vbs 파일이 없어 실행안됨
- **원인 분석**:
  - `launcher.vbs`가 `tools/` 하위 폴더에만 존재하고, 루트 디렉토리나 설치 환경에 따라 바로가기 타겟 경로(`{app}\launcher.vbs` vs `{app}\tools\launcher.vbs`)의 불일치가 발생하거나, 포터블 zip 최상위 루트에 `launcher.vbs`가 누락되어 바로가기/더블클릭 시 파일을 찾을 수 없는 오류 발생.
  - `launcher.vbs` 스크립트 내부에서도 스크립트가 루트에 위치할 때와 `tools/` 하위에 위치할 때를 모두 대응하지 못하고 부모 폴더(`..`)만 참조하던 문제 존재.
- **수정 및 구현 내역**:
  - **1. `tools/launcher.vbs` 다중 위치 스마트 경로 탐색 개선**:
    - 스크립트가 최상위 루트에 있든 `tools/` 하위에 있든 HTML 파일 존재 여부를 자동 판별하여 `아비캠뷰어_(AhBiCamViewer).html`을 1순위로 정확히 찾아 실행하도록 보강.
  - **2. 루트 및 `tools/` 양방향 배치**:
    - 프로젝트 루트 디렉터리에 `launcher.vbs` 복사 배치 완료.
  - **3. 인스톨러(`installer.iss`) 바로가기 및 설치 파일 전면 안정화**:
    - `{app}\launcher.vbs` 및 `{app}\tools\launcher.vbs` 양쪽 모두에 설치되도록 패키징.
    - 시작 메뉴 및 바탕화면 바로가기 타겟을 `{app}\launcher.vbs` 및 WorkingDir `{app}`으로 안정화.
  - **4. 포터블 ZIP(`AhBiCamViewer_Portable_v1.4.0.zip`) 패키지 보강**:
    - 압축 파일 루트에 `launcher.vbs`가 기본 포함되도록 `build.bat` 수정 및 재빌드 완료.

### 작업 18: 프로젝트 명칭 공식 리브랜딩 — 「아비캠뷰어 (AhBiCamViewer)」
- **요청 사항**: 이 프로젝트 결과물 이름을 추천해주세요. 한글/영어 -> 아비캠뷰어 (AhBiCamViewer) 확정
- **수정 및 구현 내역**:
  - **1. 메타데이터 및 브랜드 명칭 전면 갱신 (`version.json`)**:
    - `"name"`: `"AhBiCamViewer"`
    - `"displayName"`: `"아비캠뷰어 (AhBiCamViewer)"`
  - **2. 웹 애플리케이션 및 파생 파일 동기화**:
    - HTML 타이틀 및 헤더 배지: `📷 아비캠뷰어 (AhBiCamViewer) v1.4.0`
    - 모달 안내 팝업 및 도움말 텍스트 리브랜딩 적용
    - 신규 명칭 단독 파일 `아비캠뷰어_(AhBiCamViewer).html` 생성 및 기존 호환 파일들과 4종 100% 동기화
  - **3. 인스톨러 및 런처 스크립트 리브랜딩 (`installer.iss`, `tools/`)**:
    - `#define MyAppName "아비캠뷰어 (AhBiCamViewer)"`, `#define MyAppEnglishName "AhBiCamViewer"`
    - 최종 산출물: `dist/아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe`, `dist/AhBiCamViewer_Portable_v1.4.0.zip`
    - 스마트 런처(`tools/launcher.vbs`, `tools/AhBiCamViewer.bat`) 경로 최적화 및 1순위 실행 파일 매핑
  - **4. 문서 체계 갱신**:
    - `README.md`, `docs/README.md`, `docs/PATCHNOTES.md` 공식 명칭 갱신

### 작업 17: 모니터 1, 모니터 2 간 원클릭 점프 이동 지원
- **요청 사항**: 모니터1, 모니터2 사이를 점프이동 버튼 생성
- **수정 및 구현 내역**:
  - **1. UI 하단 툴바 `[🖥️ 모니터 점프]` 칩 버튼 (`#jumpMonitor`) 추가**:
    - `전체화면` 버튼 바로 우측에 원터치 점프 이동 버튼을 배치하여 손쉽게 모니터 간 전환 가능.
  - **2. Multi-Screen Window Placement API 및 하이브리드 Fallback 로직 (`jumpToNextMonitor`)**:
    - Chromium/Edge 기반의 `window.getScreenDetails()`를 통해 물리 모니터 목록을 스캔하고, 현재 창이 위치한 모니터의 다음 모니터(모니터 1 ↔ 모니터 2)로 위치(`window.moveTo`) 즉각 점프.
    - 레거시 또는 일반 브라우저 환경에서는 `window.screenX`, `screen.availWidth` 좌표 연산 기반 Fallback 이동 및 Windows 표준 단축키(`Win + Shift + 방향키`) 안내 가이드 탑재.
  - **3. 상태 안내 토스트 동적 갱신**:
    - 이동 성공 시 대상 모니터 번호와 해상도(`🖥️ 모니터 2번으로 이동됨 (1920×1080)`)를 실시간 표시하고 버튼 레이블을 해당 모니터 번호로 동기화.

### 작업 16: 웹캠 및 노트북 내장 카메라 지능형 감지 & 분류 지원
- **요청 사항**: 웹캠, 노트북 카메라 감지 지원.
- **수정 및 구현 내역**:
  - **1. 3대 카메라 유형 정밀 식별 엔진 (`classifyCamera`) 구축**:
    - **실물화상기**: IPEVO, Aver, Lumens, ELMO, V4K 등 문서 촬영 장비 감지 (`[★ 실물화상기]`, 1순위).
    - **외장 웹캠**: Logitech, C920, Brio, Razer, Anker, OBSBOT, USB Video 등 외장 웹캠 감지 (`[🎥 외장 웹캠]`, 2순위).
    - **노트북 내장 카메라**: Integrated, Built-in, FaceTime, Chicony, Realtek, Front camera 및 전면 facing 감지 (`[💻 노트북 내장]`, 3순위).
  - **2. 카메라 드롭다운 시각화 고도화**:
    - 카메라 선택 메뉴 헤더에 감지된 기기 총합 및 유형별 통계 요약 제공 (`카메라 3대 감지됨 (실물화상기 1, 웹캠 1, 노트북 1)`).
    - 옵션 목록에서 실물화상기는 Cyan, 외장 웹캠은 Green 색상과 배지로 구분 표시.
  - **3. 상단 해상도/품질 배지에 연결 기기 유형 태그 표기**:
    - 비디오 로드 시 `[📸 실물화상기]`, `[🎥 외장 웹캠]`, `[💻 노트북 내장]` 아이콘 태그를 해상도 배지에 함께 렌더링.

### 작업 15: 카메라 인식 고도화 (권한 프로브, 실물화상기 자동 판별, 핫플러그 자동 재연결, 원인별 에러 진단)
- **요청 사항**: 카메라 인식 고도화
- **수정 및 구현 내역**:
  - **1. 스마트 권한 프로브 (`requestCameraPermissionProbe`)**:
    - 브라우저 보안 정책상 카메라 최초 접근 전 `enumerateDevices()`에서 기기 레이블이 공백(`""`)으로 마스킹되는 현상을 해결하기 위해 묵시적 권한 프로브 스트림을 짧게 열고 즉시 해제하여 실제 하드웨어 명칭(예: IPEVO V4K, AverVision U50, Lumens, Logitech 등)을 즉각 획득.
  - **2. 실물화상기(Document Camera) 지능형 자동 판별 및 최우선 정렬**:
    - `DOC_CAM_KEYWORDS` (`document`, `docu`, `visualizer`, `ipevo`, `aver`, `avervision`, `lumens`, `hovercam`, `elmo`, `inswan`, `v4k`, `do-cam`, `실물화상기`, `화상기`, `문서카메라` 등) 기반 정밀 매칭 알고리즘 구현.
    - 실물화상기 기기에 `[★ 실물화상기]` 배지 표기 및 드롭다운 최우선 배치, 최초 실행 시 실물화상기 1순위 자동 선택.
  - **3. USB 핫플러그(Hot-Plug) 실시간 감지 및 자동 재연결 (`devicechange`)**:
    - `navigator.mediaDevices.addEventListener('devicechange')`와 800ms 디바운스 엔진 탑재.
    - 사용 중인 실물화상기 케이블이 분리되었을 때: 화면 손상 없이 대기 화면으로 전환하고 "카메라 분리됨 — 재연결 대기 중" 안내 표시.
    - 케이블이 다시 연결되거나 새 카메라가 감지되었을 때: 이전에 사용하던 장치 ID 또는 실물화상기를 추적하여 1초 내 끊김 없는 자동 재연결 수행.
  - **4. localStorage 기반 이전 카메라 & 해상도 기억**:
    - `cv_lastCameraDeviceId`, `cv_lastResolution` 키로 사용자가 마지막으로 선택한 카메라와 화질을 영구 기억하고 재접속 시 자동 복원.
  - **5. 원인별 정밀 에러 진단 및 사용자 맞춤 가이드 (`handleCameraError`, `showCameraError`)**:
    - `NotAllowedError` / `PermissionDeniedError`: 브라우저 자물쇠 권한 설정 및 허용 방법 안내.
    - `NotReadableError` / `TrackStartError`: Zoom, Teams, OBS 등 타 프로그램의 카메라 독점 점유 충돌 안내 및 해결 가이드.
    - `OverconstrainedError`: 카메라 센서 미지원 해상도 선택 시 자동 Fallback 및 해상도 조정 안내.
    - `NotFoundError`: USB 연결 상태 및 장치 관리자 확인 가이드.
  - **6. UVC 하드웨어 제어 능력치 감지 (`detectHardwareCapabilities`)**:
    - `track.getCapabilities()` 분석을 통해 하드웨어 줌, 초점 모드, 노출, 플래시(Torch), 팬/틸트 지원 여부를 자동 감지하고 로깅.
  - **7. 카메라 수동 재탐색(🔄) 원터치 버튼 연동**:
    - 하단 카메라 드롭다운 영역에 재탐색 버튼(`rescanBtn`)을 배치하여 언제든 간편하게 장치 목록 갱신 가능.

### 작업 14: 좌측/하단 분리형 메뉴 레이아웃 개편 및 퀵 셀렉트 칩/풀다운 드롭다운 적용
- **요청 사항**: 메뉴 레이아웃 정리 좌측과 하단으로 분리해서 재배치. 중요 메뉴는 (퀵 셀렉트 칩, 드롭다운, 풀다운) 등을 적절하게 사용.
- **수정 및 구현 내역**:
  - **1. 메인 레이아웃 2개 축(좌측 세로 / 하단 가로) 분리 재배치**:
    - 기존에 하단 한 줄에 30개 넘게 몰려있던 복잡한 툴바를 **좌측 세로 툴바(판서/발표 전용)**와 **하단 가로 툴바(카메라/화질/수업보조 전용)**로 명확히 분리하여 중앙 실물화상기 및 판서 영역을 최대화.
  - **2. 좌측 세로 툴바 (`.left-toolbar`) - [판서 및 수업 발표 도구]**:
    - **핵심 판서 도구 칩**: 🖊 펜, 🖍 형광펜, ⌫ 지우개, 💫 잔상 레이저 펜, T 텍스트.
    - **📐 도형 풀다운 플라이아웃 (`#shapeFlyoutWrap`)**: 직선, 사각형, 원, 삼각형, 화살표, 양방향, 별표를 오른쪽으로 펼쳐지는 플라이아웃 메뉴로 깔끔하게 정리하고 선택된 도형 기호가 메인 칩 아이콘에 동적 반영. 반투명 채우기 토글 연동.
    - **🎨 색상 및 굵기 팝오버 (`#paletteFlyoutWrap`)**: 현재 선택된 색상 닷과 굵기 라벨(`[● 6px ▾]`)을 클릭하면 8색 컬러 칩, 커스텀 피커, 4단계 굵기 칩(3/6/12/24px) 및 슬라이더가 팝오버로 표시.
    - **💡 발표 도구 풀다운 (`#presentFlyoutWrap`)**: 레이저 포인터, 돋보기 확대경, 스포트라이트, 커튼 가림막을 플라이아웃으로 묶어 배치.
    - 실행 취소(↶), 다시 실행(↷), 판서 전체 지우기(🗑️).
  - **3. 하단 가로 툴바 (`.bottom-toolbar`) - [카메라 스트림, 해상도, 영상/수업 제어]**:
    - **카메라 제어 퀵 액션 칩**: 📷 시작/정지, ⏸ 정지, 📸 고화질 캡처, ⛶ 전체화면, ↔ 반전, ⟳ 90도 회전.
    - **카메라 장치 & 화질 드롭다운**: 카메라 선택, 해상도 선택(⭐최고화질/4K/8MP/QHD/FHD 등), 전/후면 전환 셀렉트 칩.
    - **⚙️ 영상/렌즈 조절 풀다운 (`#adjustDropdownWrap`)**: 문서 고대비 보정, LED 조명, 탭 투 포커스, 밝기/대비/노출 슬라이더를 하나의 정돈된 풀다운 패널로 그룹화.
    - **🧰 수업 도구 풀다운 (`#utilityDropdownWrap`)**: 타이머, 격자, 칠판/배경판, 주목 벨, 2분할 비교, PIP 분할, A4 PDF 묶기, 수업 녹화를 풀다운 그리드로 그룹화.
    - **🖼 캡처 목록 접기/펼치기 칩 (`#toggleThumbsBtn`)**: 하단 썸네일 바를 원클릭으로 접거나 펼쳐 화면 공간을 능동적으로 확장.
  - **4. 드롭다운/플라이아웃 바깥 클릭 시 자동 닫기 (Click-Outside)** 메커니즘 탑재.
  - **5. 3개 파생 HTML 파일 동기화**: `index.html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html`.
- **검증**: 스크립트 구문 검사, UTF-8 CRLF 포맷 정규화, Inno Setup 6 컴파일 통과 및 인스톨러 생성 100% 완료.

---



### 작업 13: 스탠드얼론 웹뷰 데스크톱 앱(Chromeless WebView Window) 런처 구축
- **요청 사항**: 스탠드얼론 웹뷰 런처 방식 구축 (브라우저 주소창/탭 없는 단독 창 실행)
- **수정 및 구현 내역**:
  - **1. 스마트 스탠드얼론 웹뷰 런처 (`tools/launcher.vbs`) 고도화**:
    - Windows 기본 내장 Microsoft Edge 및 Google Chrome의 설치 경로(`%ProgramFiles%`, `%ProgramFiles(x86)%`, `%LocalAppData%`)를 자동 탐색.
    - `--app="file:///..."` 및 `--window-size=1280,800` 파라미터를 적용하여 상단 주소창, 탭 바, 뒤로가기/새로고침 버튼이 일체 없는 **완전 독립형 단독 데스크톱 애플리케이션 창**으로 실행되도록 구현.
    - Chromium 엔진이 없는 환경을 대비한 시스템 기본 브라우저 자동 폴백 메커니즘 탑재.
  - **2. 포터블 런처 스크립트 (`tools/ClassroomVisualizer.bat`) 동기화**:
    - 배치 파일 직접 실행 시에도 Edge/Chrome `--app` 모드로 즉각 단독 창 런칭되도록 파이프라인 동기화.
  - **3. 인스톨러 바로가기 및 설치 후 실행 (`installer.iss`) 개편**:
    - 바탕화면 바로가기(`desktopicon`), 시작 메뉴 프로그램 바로가기, 그리고 설치 완료 후 자동 실행(`[Run]`) 대상을 기존 HTML 직접 실행에서 `tools/launcher.vbs`로 전면 교체.
    - 사용자가 아이콘을 더블클릭할 때마다 웹 브라우저 탭이 아닌 단독 데스크톱 앱으로 즉각 실행되도록 연결.
- **검증**: `launcher.vbs` 구문 검증, Inno Setup 6 재빌드 및 최종 인스톨러 생성 100% 완료.

---



### 작업 12: 판서 기능 전면 고도화 (필기감 스무딩, 신규 기하 도형, 잔상 레이저, 원클릭 팔레트, 캔버스 유실 방지)
- **요청 사항**: 판서 기능 고도화
- **수정 및 고도화 내역**:
  - **1. 부드러운 필기감 및 스타일러스 필압 보정 (Smooth Bezier Writing)**:
    - 연속 3개 좌표를 기반으로 중점(midpoint)을 계산하는 이차 베지에 곡선(`quadraticCurveTo`) 알고리즘을 도입하여 빠른 손글씨 작성 시 발생하는 각진 선(꺾임/계단 현상)을 완전히 제거하고 캘리그래피 수준의 유려한 필기감 구현.
    - 전자칠판/와콤/스타일러스 펜의 압력 감지(`e.pressure`)를 반영하여 필압에 따라 굵기가 자연스럽게 변화하도록 동적 보정.
  - **2. 진짜 형광펜 투과 효과 (True Highlighter / Marker)**:
    - 겹쳐 칠할 때 어둡게 뭉개지는 현상을 방지하고, 교재 및 시험지의 인쇄 텍스트를 선명하게 투과시키는 최적화된 반투명 형광 브러시 렌더링 적용.
  - **3. 도형 도구 대폭 강화 (신규 기하 도형 3종 & 반투명 채우기 & Shift 정형 스냅)**:
    - 신규 도형 3종 추가: **△ 삼각형(`shapeTriangle`)**, **⬌ 양방향 화살표(`shapeDoubleArrow`)**, **★ 별표(`shapeStar`)**.
    - **⬛ 도형 반투명 채우기 모드(`shapeFillBtn`)**: 켜짐 상태에서 사각형/원/삼각형/별표 내부가 28% 반투명 색상으로 함께 채워져 교재 핵심 영역 하이라이트 박스를 원클릭 생성 가능.
    - **Shift 키 제약 스냅**: Shift를 누른 채 그릴 때 1:1 정사각형, 정원, 45도 각도 스냅 직선/화살표 보조.
  - **4. 시각적 지우개 가이드 링 (Visual Eraser Ring)**:
    - 지우개 도구 사용 시 지우개 반경 크기(`size.value * 3`)에 딱 맞는 점선 원형 가이드 링이 마우스 커서를 따라다니며 지울 영역을 직관적으로 시각화.
  - **5. 💫 잔상 레이저 펜 (Disappearing Laser Trail)**:
    - 수업 중 특정 문장이나 수식을 짚어줄 때 1.4초간 반짝이다가 부드럽게 페이드아웃되며 소멸하는 레이저 궤적 펜 탑재. 화면을 더럽히지 않고 학생들의 시선을 유도.
  - **6. 원클릭 빠른 색상 팔레트 & 굵기 프리셋**:
    - 좁은 드롭다운 셀렉트 박스 대신 8종 퀵 컬러 닷(빨/주/노/초/파/보/흰/검) 및 커스텀 컬러 피커(`input type=color`), 빠른 굵기 4단계 프리셋(가는선 3px, 보통 6px, 굵게 12px, 특대 24px) UI 탑재.
  - **7. 텍스트 주석 카드 고도화 (Readable Card Frame)**:
    - 텍스트 입력 시 가독성을 높이기 위해 둥근 모서리 반투명 카드 패드(`roundRect`)와 텍스트 섀도우를 함께 렌더링하여 복잡한 교재 사진이나 다크 배경 어디서든 선명한 식별력 제공.
  - **8. 캔버스 리사이즈 판서 유실 방지 (Zero Data Loss Canvas)**:
    - 창 크기 조절(`resizeCanvas`) 시 기존 판서 내용을 오프스크린 백업 버퍼에 보존 후 새 해상도에 맞춰 자동 복원하여 실수로 창 크기를 바꿀 때 판서가 날아가는 현상 원천 차단.
  - **9. 교실 수업용 키보드 단축키 (Classroom Hotkeys)**:
    - `P`(펜), `M`/`H`(형광펜), `E`(지우개), `L`(직선), `R`(사각형), `C`(원), `A`(화살표), `T`(텍스트), `F`(채우기 토글), `[`/`]`(굵기 조절), `1`~`8`(빠른 색상) 지원.
  - **10. 3개 HTML 파일 동기화**:
    - `index.html`, `(AhBiYout)_공용_실물화상기_보기.html`, `교실용_실물화상기.html` 전면 동기화.
- **검증**: JavaScript 문법 무결성 검증, UTF-8 CRLF 포맷 정규화, Inno Setup 6 재컴파일 통과 완료.

---



## 2026-10-17 (v1.3.2)

### 작업 11: 순수 창작 Win32 네이티브 익스포트 DLL 제작, 기존 DLL 무결성 점검 및 인스톨러 연동
- **요청 사항**: 기능 중에 순수 창작 DLL로 만들어서 사용하면 좋은 기능이 있나 확인하고 진행. 기존 DLL 파일 중 오류나 개선점이 있는지 확인. 순수 창작 DLL에 관한 동작원리와 세부사항을 문서로 만들어 등록.
- **점검 결과**:
  - 프로젝트 전수 점검 결과 기존 외부 서드파티 DLL 파일 전무(0개, 클린 상태). DLL 충돌/오류 없음 확인.
- **수정 및 구현 내역**:
  - **순수 창작 DLL 설계 및 구축 (`src/dll/`)**:
    - `src/dll/LicenseCore.cs`: 오프라인 체크섬 알고리즘(Mod 97), 30일 임시 체험키(`TRIAL-`) 생성/디코딩, 만료 일수 계산, 하드웨어 머신 핑거프린팅 구현.
    - `src/dll/ClassroomVisualizerCore.il`: 순수 IL 및 `.vtfixup` / `.export` 기법을 적용하여 32비트 stdcall 네이티브 PE 익스포트를 가진 DLL 생성.
    - 익스포트 함수 4종 구현: `CV_GetVersion`, `CV_ValidateKeyA`, `CV_IsTrialKeyA`, `CV_VerifyTrialStatus`.
    - 도구 종속성: Windows 순정 .NET Framework 4.0 내장 도구(`csc.exe`, `ilasm.exe`)만을 사용하여 외부 컴파일러 없이 100% 독립 빌드 실현.
  - **테스트 및 검증**:
    - `src/dll/TestRunner.cs`: 네이티브 및 관리형 함수 7개 전 항목 단위 테스트 완료 (100% 통과).
  - **빌드 파이프라인 및 인스톨러 연동**:
    - `tools/build_dll.bat`: DLL 빌드 및 `bin/` 자동 배포 스크립트 작성.
    - `build.bat`: Step 2에 DLL 컴파일 단계 통합 및 ZIP 패키징 대상에 `bin/` 디렉터리 포함.
    - `installer.iss`: 설치 마법사 시작 시(`InitializeSetup()`) `ClassroomVisualizerCore.dll`의 `CV_GetVersion`을 호출하여 바이너리 무결성 자동 검증 로직 탑재.
  - **기술 문서 등록**:
    - `docs/NATIVE_DLL_ARCHITECTURE.md`: 순수 창작 DLL 아키텍처, C#/IL 하이브리드 PE 익스포트 동작 원리, API 상세 명세 등록.
- **검증**: `build_dll.bat` 및 `build.bat` 전체 파이프라인 실행, 인스톨러 컴파일 및 테스트 100% 성공.

---



## 2026-10-15 (v1.3.2)

### 작업 10: 카메라 미연결 상태에서의 완전 독립 판서 및 저장 지원
- **요청 사항**: 카메라 인식이 되지 않아도, 펜, 형광펜, 지우개와 같은 판서 기능은 동작되도록 합니다.
- **수정 내역**:
  - 판서 캔버스(`draw`)의 레이어 우선순위를 재정비하고, `placeholder` 요소에 `pointer-events: none`을 부여하여 카메라가 꺼져 있거나 연결되지 않은 대기 상태에서도 마우스/펜/터치 이벤트가 캔버스에 직접 전달되도록 개선.
  - 대기 화면 안내 문구를 "실물화상기 대기 중 — 펜·형광펜·지우개 판서 및 배경판은 카메라 없이도 언제든 자유롭게 사용 가능합니다"로 친절하게 개편.
  - `capture()` 및 `frameData()`(PDF 내보내기) 함수를 보완하여, 카메라 스트림이 없는 상태에서도 흰색/검정/칠판 배경판 및 다크 보드 위 판서 내용을 온전하게 고화질 이미지나 PDF로 즉시 저장·출력할 수 있도록 파이프라인 단독 구동 보장.
  - 파생 HTML 3개 파일 동기화.

### 작업 9: Pro 임시 체험키 발급 기능 및 30일 유효기간 시스템 구축
- **요청 사항**: pro 임시키 발급 및 유효기간 30일 설정.
- **수정 내역**:
  - `TR30-` 접두사 기반 30일 임시 체험키 규격 정의 및 자동 생성기(`generateTrialKey`) 구현.
  - 최초 활성화 시점부터 30일 유효기간 자동 산정(`localStorage.setItem('ahbiyout_pro_exp')`) 및 만료 검사 로직 구현.
  - 상단 티어 배지에 남은 일수(`PRO (체험 N일 남음)`) 실시간 표시.
  - Pro 모달에 `[🎁 30일 무료 체험키 발급 및 자동 입력]` 버튼 추가로 원클릭 체험 경험 제공.
  - `ℹ️ 정보` 모달에서 30일 체험판 만료일 및 잔여 일수 상세 현황 표시.
  - 파생 HTML 3개 파일 동기화.

### 작업 8: Free / Pro 티어 분류 체계 및 오프라인 라이선스 시스템 구축
- **요청 사항**: Free와 Pro 나누고 싶은데 기준을 세워 주세요.
- **수정 내역**:
  - **Free/Pro 분류 기준 수립**: 해상도(~FHD vs QHD+), 판서(자유곡선 vs 도형/텍스트), 출력(표준 vs 고품질/PDF/녹화), 발표 보조(기본 vs 레이저/확대경/스포트라이트/가림막/비교/PIP), 하드웨어 제어(기본 vs 플래시/초점/노출)의 5대 축 분류.
  - `index.html` 및 파생 HTML:
    - 오프라인 체크섬 기반 라이선스 키 검증 알고리즘(`validateLicenseKey`, 16자리 포맷) 구현.
    - 헤더에 티어 뱃지(`FREE` / `PRO`) 및 정보 모달에 라이선스 관리 인터페이스 추가.
    - Pro 기능에 🔒 자물쇠 시각 피드백(`pro-locked`) 및 클릭 시 Pro 업그레이드 모달(`proUpgradeModal`) 게이팅 연동.
    - 해상도 선택기 내 Pro 옵션 분리 및 Free 선택 시 자동 FHD 리셋.
    - Undo/Redo 이력 수 Free 10단계 / Pro 40단계 차등 적용.
    - 캡처 품질 Free 0.85 / Pro 0.96 차등 적용.
  - 문서 체계 갱신: `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`, 아티팩트 `free-pro-tier-plan.md`.
- **검증**: CRLF 정규화 및 Inno Setup 6 재빌드 완료.

---



## 2026-10-12 (v1.3.2)

### 작업 7: 웹캠 및 교실용 실물화상기 고해상도(4K/8MP/QHD) 지원 강화
- **요청 사항**: 웹캠, 실물화상기 고해상도 지원.
- **수정 내역**:
  - `index.html` 및 파생 HTML:
    - 해상도 프로파일 드롭다운 확장: `⭐ 최고화질 (기기 최대 해상도)`, `4K UHD (3840×2160)`, `8MP 고해상도 문서 (3264×2448)`, `QHD 2K (2560×1440)`, `FHD 1080p`, `HD 720p`, `SD 480p`.
    - `getSelectedResolution()`에 `max` 옵션 추가 (`width: {ideal: 4096}, height: {ideal: 3072}`).
    - `getResQualityLabel()` 추가: 해상도별 등급(4K/8MP 초고화질, QHD/5MP 고화질, FHD, HD) 컬러 뱃지 렌더링.
    - `startCamera()` 제약 조건 협상 고도화 및 점진적 폴백(Progressive Fallback) 구현.
    - `capture()` 및 `frameData()`(PDF): `imageSmoothingQuality = 'high'` 및 JPEG 품질 0.96 상향으로 미세 폰트/수식 선명도 극대화.
    - 버전 배지 및 내부 상수 `v1.3.2`로 범프.
  - `version.json` 및 `installer.iss`: 버전 `1.3.2`로 동기화.
  - 문서 체계 갱신: `docs/PATCHNOTES.md`, `docs/CHANGELOG.md`, `docs/WORK_LOG.md`, `docs/README.md`, `README.md`.
- **검증**: CRLF 정규화 및 Inno Setup 6 빌드 실행 검증 완료.

---



## 2026-10-11

### 작업 1: 시스템 표준 지침 분석 및 프로젝트 기준선 설정
- **작업 내용**: `d:\cisnet_util\문서\# AUTONOMOUS CODING AGENT — SYSTEM.txt` (802줄) 지침 전체 열람 및 아키텍처/보안/버저닝/문서화 요구사항 식별.
- **대상 경로**: `C:\Users\user\.gemini\antigravity\scratch\교실용_실물화상기`
- **검증 결과**:
  - 핵심 파일(`index.html`, `교실용_실물화상기.html`, `version.json`, `installer.iss`, `build.bat`, `git-release.bat`) 확인.
  - 임시/누락 문서(`ROADMAP.md`, `ARCHITECTURE.md`, `SECURITY.md`, `MODULES.md` 등) 파악.

### 작업 2: 배치 파일 인코딩 및 CRLF 포맷터 결함 수정
- **문제 원인**: `tools/format_crlf.ps1`이 `[System.Text.Encoding]::ASCII`로 강제 변환하여 `build.bat` 내 한글 문자열이 `???_?????`로 깨지는 결함 발견.
- **수정 내용**: `format_crlf.ps1`을 UTF-8(No BOM) 무손실 인코딩으로 개편하고, `build.bat`을 영문 라벨 기반의 견고한 배치 스크립트로 재작성.
- **검증**: PowerShell 실행 결과 무손실 CRLF 변환 및 정상 동작 확인 (`tools/format_crlf.ps1`).

### 작업 3: 보안 감사 및 Inno Setup 인스톨러 방화벽 정책 강화
- **문제점**: 오프라인 USB 카메라로 전환되었음에도 불구하고 `installer.iss`에 남아 있던 인바운드 TCP 방화벽 규칙이 최소 권한 원칙(Principle of Least Privilege)을 위배.
- **수정 내용**:
  - `installer.iss`의 `[Run]` 섹션에서 불필요한 `netsh advfirewall firewall add rule ...` 제거.
  - 언인스톨 단계(`[UninstallRun]`)에서 기존 설치분의 레거시 방화벽 룰을 청소하는 구문은 유지하여 시스템 청결성 보장.
  - `docs\*` 복사 시 `Excludes: "*SYSTEM.txt"`를 추가하여 내부 지침 파일이 패키지에 혼입되는 현상 차단.
- **검증**: `ISCC.exe` 컴파일 성공 및 방화벽 추가 명령 제거 확인.

### 작업 4: 시맨틱 버전(v1.3.1) 및 문서화 전면 동기화
- **작업 내용**:
  - `docs/README.md` 및 `docs/BLOG_POST.md` 내 잔존하던 `v1.2.0` 표기를 `v1.3.1`로 일괄 수정.
  - 프로젝트 루트에 공식 배지와 전체 기능 및 링크가 포함된 `README.md` 신규 생성.
  - 시스템 v2.0 필수 문서 체계 완성:
    - `docs/ROADMAP.md`: P0~P3 우선순위 기반 의존성 로드맵 작성 및 전 항목 `VERIFIED` 검증.
    - `docs/ARCHITECTURE.md`: 기술 스택, Mermaid 아키텍처 다이어그램, 캡처 및 판서 파이프라인 명세.
    - `docs/SECURITY.md`: 비밀정보, 네트워크, 방화벽, 프로세스 실행, XSS에 대한 정밀 보안 감사 보고서.
    - `docs/MODULES.md`: 8대 코어 서브시스템의 책임 및 인터페이스 명세.
    - `docs/BUILD.md`: Windows Inno Setup 6 자동 빌드 매뉴얼.
    - `docs/INSTALL.md`: GUI 및 무인 자동 설치(`/VERYSILENT`) 가이드.
    - `docs/CHANGELOG.md`: Keep-a-Changelog 기반 시맨틱 변경 내역.
    - `docs/LICENSE.ko.md` & `docs/LICENSE.en.md`: 공식 저작자(AhBiYout) 라이선스 문서.

### 작업 5: 빌드 파이프라인 및 패키징 실제 검증
- **명령 실행**: Inno Setup 컴파일러 실행 (`ISCC.exe /DMyAppVersion="1.3.1" "installer.iss"`)
- **결과**:
  - 컴파일 소요 시간: 3.4초
  - 산출물 검증: `dist\교실용 실물화상기_Setup_v1.3.1.exe` 생성 확인 (2,127,287 바이트).
  - 포터블 압축 파일 생성 확인.

### 작업 6: 애플리케이션 공식 명칭 변경
- **요청 사항**: 프로젝트 앱 이름을 `(AhBiYout) 공용 실물화상기 보기`로 변경.
- **수정 내역**:
  - `version.json`: `displayName`을 `(AhBiYout) 공용 실물화상기 보기`로 변경.
  - `index.html`, `교실용_실물화상기.html`, `(AhBiYout)_공용_실물화상기_보기.html`: `<title>`, `<h1>`, 모달 팝업 타이틀 동기화.
  - `installer.iss`: `MyAppName`을 `(AhBiYout) 공용 실물화상기 보기`로 변경하고 바로가기/실행 타깃 동기화.
  - `build.bat`, `git-release.bat`, `.github/workflows/build-and-release.yml`: 산출물 생성 및 릴리즈 명칭 동기화.
  - 전체 기술 문서(`README.md`, `docs/README.md`, `docs/BLOG_POST.md`, `docs/ARCHITECTURE.md`, `docs/BUILD.md`, `docs/INSTALL.md` 등) 명칭 동기화.
- **검증**: `build.bat` 및 `ISCC.exe` 컴파일 재수행하여 신규 명칭 인스톨러 `(AhBiYout) 공용 실물화상기 보기_Setup_v1.3.1.exe` 생성 검증.

### 작업 7: 동영상 수업 녹화 버튼 하단 메인 툴바 전진 배치 및 접근성 복원
- **요청 사항**: 동영상 녹화 버튼이 사라졌다는 사용자 보고에 따라 시인성 및 1-클릭 접근성 복원.
- **원인 분석**:
  - 기존에 `⏺ 수업 녹화` 버튼이 `🧰 수업 도구 ▾` 드롭다운 패널 안쪽에 배치되어 있어, 교실 수업 중 메인 화면에서 직관적으로 찾기 어려웠음.
- **수정 내역**:
  - **메인 툴바 전진 배치**: 하단 가로 툴바(`#bottomToolbar .b-group`)의 `📸 캡처` 버튼 바로 옆에 `⏺ 수업 녹화`(`id="record"`, `.action-chip.record-chip`) 버튼 배치.
  - **직관적 녹화 전용 스타일 (`.record-chip`)**: 대기 상태에서는 부드러운 붉은색 테두리 칩으로 표시되고, 녹화 중에는 붉은색 활성 배경 및 숨쉬는 듯한 펄스 애니메이션(`recPulse`) 효과 적용.
  - **드롭다운 양방향 연동 (`#utilityRecordBtn`)**: 기존 `🧰 수업 도구 ▾` 패널 내 버튼도 연동되어 어느 위치에서 누르든 동일하게 동작하고 상태(텍스트/클래스)가 양방향 자동 동기화됨.
  - **단축키 `V` 지원**: 키보드 단축키 `S`(화면 캡처)와 함께 `V`(동영상 녹화 토글) 추가 지원.
- **검증**: JavaScript 문법 검사(5개 스크립트 전원 통과), 4개 HTML 파일 동기화, `build.bat` 실행 및 패키징 완료.

### 작업 8: 프로 기능 제약 완전 중지 및 모든 기능 100% 무료 개방
- **요청 사항**: 프로기능 제약 중지 요청에 따른 라이선스 게이팅 전면 해제.
- **수정 내역**:
  - **라이선스 바이패스**: `IS_PRO = true` 상시 활성화, `proGate()` 즉시 `true` 반환, 업그레이드 모달창 출현 차단.
  - **자물쇠 및 비활성화 스타일 제거**: `.pro-locked` 클래스의 자물쇠(🔒) 아이콘 및 투명도 제약 제거, 모든 버튼 잠금 해제.
  - **고해상도 전면 개방**: 4K UHD, 최고화질(기기 최대), 8MP 문서, QHD 등 모든 해상도의 `[Pro]` 꼬리표 및 선택 차단 로직 제거.
  - **노출 보정 & 격자 스타일 개방**: 하드웨어 EV 노출 제어 슬라이더 및 모눈/점선/줄노트 전체 격자 순환 지원.
  - **UI 배지 갱신**: 헤더 및 정보 모달 라이선스 표기를 `PRO (전체 기능 개방)`으로 동기화.
- **검증**: 5개 스크립트 구문 검사 완료, 4개 HTML 파일 동기화, Inno Setup 빌드 파이프라인 검증 완료.

### 작업 9: 판서 펜/형광펜/지우개 도구별 1-클릭 전용 하위메뉴(Flyout) 탑재
- **요청 사항**: 판서 펜/형광펜/지우개 클릭 시 관련 기능이 하위메뉴로 나타나도록 사용자 편의성 대폭 강화.
- **수정 내역**:
  - **펜 하위메뉴 (`#penFlyoutPanel`)**: `펜 ▾` 클릭 시 우측에 8색 팔레트, 가는선(3px)~특대(24px) 굵기 칩 및 슬라이더, 잔상펜/텍스트 연계 도구 바로가기 제공.
  - **형광펜 하위메뉴 (`#markerFlyoutPanel`)**: `형광펜 ▾` 클릭 시 6색 네온 컬러(노랑, 연두, 핑크, 주황, 하늘, 보라), 12px~48px 밑줄 굵기 프리셋 및 슬라이더 제공.
  - **지우개 하위메뉴 (`#eraserFlyoutPanel`)**: `지우개 ▾` 클릭 시 소(18px)~특대(90px) 지우개 크기 칩 및 슬라이더, 🗑️ 판서 전체 지우기 버튼, ↶ 되돌리기, ↷ 다시실행 버튼 통합 배치.
  - **판서 집중 모드 (스마트 오토 클로즈)**: 캔버스 터치/클릭(`pointerdown`) 시 화면을 가리는 모든 서브메뉴 자동 닫힘.
  - **양방향 동기화**: 메인 팔레트 및 단축키와 실시간 양방향 상태(색상 링, 굵기 값, 원형 지우개 가이드 링) 동기화.
- **검증**: JavaScript 문법 5개 스크립트 전원 통과, 4개 HTML 파일 동기화, Inno Setup 빌드 파이프라인 검증 완료.

### 작업 10: 4종 펜 촉(둥근 촉·캘리 촉·사각 촉·붓펜 촉) 디자인 및 실시간 획 프리뷰 엔진 구현
- **요청 사항**: 판서 펜 사용 시 다양한 필기감과 강조 효과를 낼 수 있는 펜 촉 디자인 추가.
- **수정 내역**:
  - **4종 펜 촉 셀렉터 탑재 (`#penTipSelector`)**:
    - `둥근 촉 (Round)`: 볼펜/일반 마커 스타일의 매끄러운 원형 획 (`lineCap='round'`, `lineJoin='round'`).
    - `캘리 촉 (Calligraphy)`: 45° 이탤릭 만년필 스타일의 우아한 캘리그래피 사각 폴리곤 렌더링 (`drawCalligraphySegment`).
    - `사각 촉 (Square)`: 제도용/강조 마커 스타일의 깔끔한 각진 획 (`lineCap='square'`, `lineJoin='miter'`).
    - `붓펜 촉 (Brush)`: 필기 속도 및 필압 감응형 dynamic taper 획 렌더링 (빠른 터치 시 끝이 붓처럼 날렵해짐).
  - **실시간 획 프리뷰 박스 (`#penTipPreviewCanvas`)**:
    - 펜 하위메뉴 상단에 미니 캔버스를 내장하여, 촉/색상/굵기 변경 시 실제 그어질 필기 곡선('S' 궤적)을 실시간 렌더링.
  - **실시간 호버 펜 커서 (`#penCursor`)**:
    - 캔버스 위에 마우스나 스타일러스를 올렸을 때 촉 종류(원형/사각형/다이아몬드/붓펜 타원), 현재 색상, 실제 굵기 반영 가이드 링 표시.
  - **설정 영속화 (`localStorage`)**:
    - 선생님이 선호하는 펜 촉 설정을 브라우저 재실행 후에도 기억(`cv_pen_tip`).
- **검증**: JavaScript 5개 스크립트 문법 검사 통과, 4개 HTML 파일 동기화, Inno Setup 빌드 파이프라인 검증 완료.

### 작업 11: 형광펜 4종 촉 디자인 확장 (둥근촉·캘리촉·사각촉·붓펜촉) 및 실시간 프리뷰
- **요청 사항**: 펜에 추가된 4종 촉 디자인을 형광펜에도 동일하게 적용.
- **수정 내역**:
  - **형광펜 촉 셀렉터 (`#markerTipSelector`)**: 형광펜 하위메뉴(`#markerFlyoutPanel`) 상단에 둥근 촉·캘리 촉·사각 촉·붓펜 촉 4종 선택 버튼 배치.
  - **실시간 프리뷰 캔버스 (`#markerTipPreviewCanvas`)**: 선택 촉, 형광 네온 색상, 굵기를 반영한 반투명 S자 곡선 실시간 렌더링.
  - **실시간 호버 커서 확장**: 형광펜 도구 활성 시에도 `#penCursor`를 통해 촉 형태, 색상, 굵기 반투명 가이드 표시.
  - **`markerTip` 변수 및 `localStorage` 영속화**: `cv_marker_tip` 키로 형광펜 촉 설정 별도 저장.
  - **포인터 이벤트 핸들러 전면 리팩터링**: `pointerdown`, `pointermove`, `pointerup`에서 `tool === 'marker'`인 경우 `markerTip`을 참조하여 캘리·사각·붓펜 촉 렌더링 적용.
  - **`setActiveMarkerColor()`, `setActiveSize()`에 `renderMarkerTipPreview()` 호출 추가**: 색상/굵기 변경 시 형광펜 프리뷰도 실시간 동기화.
- **검증**: JavaScript 4개 스크립트 문법 검사 통과, 4개 HTML 파일 동기화 완료.

### 작업 12: 지우개 4종 디자인(둥근·사각·가로·세로) 및 실시간 프리뷰·가이드 커서 탑재
- **요청 사항**: 지우개에도 사용자 편의성을 높이는 다양한 디자인(형태) 추가.
- **수정 내역**:
  - **지우개 4종 디자인 셀렉터 (`#eraserTipSelector`)**:
    - `둥근 지우개 (round)`: 원형 정밀 지우개 (점/곡선 단위 미세 지우기)
    - `사각 지우개 (square)`: 화이트보드 이레이서 스타일 정사각형 지우개
    - `가로 지우개 (horizontal)`: 긴 가로 줄 판서나 한 줄 텍스트를 빠르게 쓸어 지우는 와이드 지우개
    - `세로 지우개 (vertical)`: 세로 판서, 열 단위 필기나 세로 수학식을 깔끔하게 지우는 버티컬 지우개
  - **지우개 치수 계산 엔진 (`getEraserDimensions`)**: 지우개 크기 슬라이더와 연동하여 디자인별 가로/세로 비율 자동 계산.
  - **지우개 실시간 프리뷰 캔버스 (`#eraserTipPreviewCanvas`)**: 격자 판서 배경 위 지우개 면적과 형태 실시간 시각화.
  - **지우개 맞춤형 호버 커서 연동**: 지우개 선택 디자인(원형/사각/가로직사각형/세로직사각형)에 맞추어 점선 가이드 링 형태 및 모서리 곡률(`borderRadius`) 즉각 변환.
  - **포인터 이벤트 연동**: `pointerdown`, `pointermove`, `pointerup`에서 선택된 지우개 모양에 따라 캔버스 지우기 영역 정확히 소거 (`destination-out`).
  - **설정 영속화 (`cv_eraser_tip`)**: 브라우저 재실행 시에도 선택된 지우개 디자인 유지.
- **검증**: JavaScript 문법 4개 스크립트 전원 통과, 4개 HTML 파일 동기화 완료.

### 작업 13: 화면 캡처 시 검정 화면만 저장되던 버그 수정 및 회전/필터 합성 보정
- **요청 사항**: 캡처 버튼 클릭 시 카메라 영상이 나오지 않고 검정 화면만 저장되는 문제 해결.
- **원인 분석**:
  - `onCameraSuccess` 함수에서 `video.srcObject = mediaStream;`만 대입하고 상단 전역 변수인 `stream`에 `mediaStream`을 할당하지 않아 `stream`이 항상 `null`로 유지됨.
  - 이로 인해 `capture()` 내 조건문 `if(stream && video.videoWidth && !isBoardActive)`가 무조건 거짓(`false`)이 되어 `else` 분기(검정색 더미 배경 `#101114`)만 캔버스에 렌더링됨.
- **수정 내역**:
  - `onCameraSuccess`에서 `stream = mediaStream;` 정상 할당 및 `video.play()` 안전 호출 추가.
  - `capture()`의 카메라 활성 판정을 `(stream || video.srcObject) && !isBoardActive`로 이중 방어하여 스트림 전달 보장.
  - 90도/270도 회전 시 캔버스 폭/높이 교체(`isRotated90 ? vh : vw`) 및 회전 중심점 오프셋 연산 수정.
  - 노출 보정(`expFactor`) 필터가 캡처 이미지에도 완벽히 반영되도록 동기화.
  - `doFreeze()` 정지 시 화면이 숨겨지던 버그를 `video.pause()` / `video.play()`로 교체하여 정지 화면 캡처도 정상 지원.
- **검증**: JavaScript 문법 검사 통과, 4개 배포 HTML 파일 동기화 완료, Inno Setup 빌드 파이프라인 검증 완료.

### 작업 14: 범용 동영상 수업 녹화 MP4(.mp4) 포맷 지원 및 1-클릭 선택기 탑재
- **요청 사항**: 동영상 녹화 시 학교 PC 및 다양한 미디어 플레이어에서 즉시 열릴 수 있도록 MP4 지원 요청.
- **수정 내역**:
  - **MP4 코덱 자동 진단 및 연결 (`checkMp4Support`, `getActiveRecordFormatConfig`)**:
    - 브라우저의 `MediaRecorder.isTypeSupported`로 `video/mp4;codecs=avc1` / `video/mp4;codecs=h264` / `video/mp4` 지원 여부 자동 검사.
    - 지원 브라우저에서는 기본 저장 형식을 범용 `.mp4`로 설정하고, 미지원 브라우저는 `.webm`으로 안전하게 폴백.
  - **하단 툴바 1-클릭 포맷 전환 칩 (`#recFormatBadge`)**:
    - `⏺ 수업 녹화` 버튼 바로 옆에 `🎬 MP4` 칩 신설, 클릭 시 **MP4 ↔ WebM** 즉시 전환 및 상태 안내.
  - **실시간 포맷 인디케이터**:
    - 녹화 중 상단 경과시간 배지에 `REC [MP4] 00:00` / `REC [WEBM] 00:00` 형태로 현재 저장 포맷 실시간 표시.
  - **`🎬 효과` 모달 설정 연동**:
    - 설정 모달 내에 브라우저 MP4 지원 여부 진단 배지 및 라디오 버튼(MP4 권장 / WebM) 추가, 설정 영구 저장(`cv_rec_format`).
- **검증**: JavaScript 문법 검사 4개 스크립트 전원 통과, 4개 HTML 파일 동기화 완료, Inno Setup 빌드 파이프라인 검증 완료.

### 작업 15: 잔상 레이저 펜 전용 1-클릭 하위메뉴(Flyout) 및 맞춤형 이펙트/지속시간 옵션 탑재
- **요청 사항**: 잔상펜 클릭 시 관련 옵션(시간, 효과, 색상, 굵기 등)을 조절할 수 있도록 기능 강화.
- **수정 내역**:
  - **전용 하위메뉴 (`#laserFlyoutPanel`)**: `잔상펜 ▾` 클릭 시 우측에 전용 옵션 패널 즉각 슬라이드 오픈 (`setupToolWithFlyout`).
  - **4종 잔상 이펙트 스타일 (`#laserStyleSelector`)**:
    - `네온 (neon)`: 강렬한 외곽 발광과 네온 글로우 빔
    - `스파크 (spark)`: 중앙의 화이트 코어 빔과 샤프한 펄스 광선
    - `무지개 (rainbow)`: 시간에 따라 HSL 무지개 스펙트럼 색상으로 영롱하게 변화하는 빔
    - `혜성 (comet)`: 혜성처럼 머리는 두껍고 꼬리는 날렵하게 감쇠되는 궤적
  - **잔상 지속 시간 조절 (Lifespan)**: 0.8초(빠름), 1.5초(기본), 3.0초(여유), 5.0초(길게) 프리셋 및 0.4초 ~ 6.0초 정밀 슬라이더.
  - **레이저 전용 6색 네온 컬러 팔레트 & 커스텀 피커**: 루비 레드, 네온 그린(실제 레이저 포인터 대표색), 사이언 블루, 네온 옐로우, 네온 퍼플, 퓨어 화이트.
  - **빔 굵기 조절**: 6px, 12px, 20px, 32px 프리셋 및 4px ~ 48px 슬라이더.
  - **실시간 미니 프리뷰 (`#laserTipPreviewCanvas`)**: 상단 배너에서 선택된 스타일과 색상 실시간 시각화.
  - **실시간 네온 링 호버 커서 (`#penCursor`)**: 캔버스 호버 시 레이저 색상과 굵기에 맞춘 네온 발광 가이드 링 표시.
  - **설정 영구 저장 (`localStorage`)**: 스타일, 지속시간, 색상, 굵기 브라우저 영구 보관.
- **검증**: JavaScript 문법 검사 통과, 4개 HTML 파일 동기화 완료, Inno Setup 빌드 파이프라인 검증 완료.

---



## 2026-10-26 (v1.4.1)
- 잔상 레이저 펜 전용 하위메뉴(Flyout) 탑재 및 4종 이펙트(네온/스파크/무지개/혜성), 시간(0.8~5.0초), 6색 네온 컬러, 굵기 제어 추가.
- 동영상 수업 녹화 범용 MP4(.mp4) 포맷 직접 인코딩 지원 및 원클릭 포맷 전환 칩 신설.
- 화면 캡처 검정 화면 버그 원천 차단 (`stream` 할당 및 이중 검증).
- 90도/270도 회전 캡처 비율 왜곡 수정 및 노출 필터 정확한 합성.
- ⏸ 화면 정지(Freeze) 기능 개선 (`video.pause()` 기반 실시간 정지).

---



## 2026-10-25 (v1.4.0)
- 4종 펜 촉(둥근 촉, 캘리 촉, 사각 촉, 붓펜 촉) 디자인 및 실시간 프리뷰 캔버스 탑재.
- 형광펜에도 동일 4종 촉 디자인 확장 적용 및 전용 프리뷰·커서 지원.
- 지우개 4종 디자인(둥근, 사각, 가로, 세로) 엔진 및 맞춤 가이드 커서·프리뷰 탑재.
- 실시간 펜/형광펜/지우개 도구별 맞춤 호버 가이드 커서 지원 및 영구 저장.
- 판서 도구(펜/형광펜/지우개) 1-클릭 전용 Flyout 하위메뉴 신설.
- 프로 기능 제약 완전 폐지 (100% 무료 개방).
- 수업 녹화(동영상) 버튼 하단 툴바 전진 배치 및 캡처/녹화 애니메이션/사운드 강화.

---



## 2026-10-09 (v1.3.1)
- 무선 연결(QR P2P / WebRTC PeerJS) 모듈 및 외부 CDN 의존성 제거.
- 로컬 USB 유선 웹캠 및 스마트폰 하드웨어 직접 제어(조명, 초점, 노출) 전용으로 파이프라인 단일화.

---



## 2026-10-08 (v1.3.0, v1.2.0, v1.1.0, v1.0.0)
- v1.3.0: 스마트폰 하드웨어 직접 제어 (Torch, Tap-to-Focus, Exposure) 구현.
- v1.2.0: 전/후면 카메라 전환, 핀치 줌, 4K/1080p 해상도 선택기, GitHub Releases 업데이트 알림.
- v1.1.0: 수업용 타이머/스톱워치, 4종 도형 판서, 격자 오버레이, 2분할 비교, Undo/Redo.
- v1.0.0: 웹 기반 무설치 교실용 실물화상기 최초 배포.

## [2026-11-01] 카메라 부재 시 화면 무한 자가 복제(Infinity Mirror) 오류 원천 해결

### 1. 현상 분석 및 원인 규명
- **현상**: 컴퓨터에 실물화상기나 웹캠이 연결되어 있지 않은 상태에서 앱을 실행하면, 화면이 자기 자신을 끝없이 복제하며 거울 터널처럼 무한히 빨려 들어가는 현상(Infinity Mirror / Droste Effect) 발생.
- **원인 규명**:
  1. 학교 및 교실 PC에는 원격 수업 및 녹화를 위한 OBS Studio, ManyCam 등이 기본 설치되어 있는 경우가 많음.
  2. 물리 카메라가 연결되지 않은 상태에서 Chromium의 `enumerateDevices()`는 `OBS Virtual Camera`(또는 유사 가상 카메라)를 유일한 비디오 입력 기기로 반환.
  3. 기존 분류 알고리즘이 `cam` 키워드를 통해 OBS Virtual Camera를 일반 웹캠으로 오분류하고 최우선 기기로 자동 선택.
  4. 앱 초기화 시점(`startCamera('')`) 및 권한 프로브(`requestCameraPermissionProbe`)에서 이 가상 카메라를 활성 스트림으로 자동 승격.
  5. OBS 가상 카메라는 기본적으로 PC 화면(모니터 디스플레이)을 송출하므로, 앱 창 -> 데스크톱 -> 가상 카메라 -> 앱 창으로 이어지는 무한 시각적 피드백 루프가 형성됨.
  6. 카메라가 아예 없는 환경(`cams.length === 0`)에서도 `startCamera('')`가 `getUserMedia`를 무조건 호출하여 브라우저 오류 대화상자가 노출됨.

### 2. 해결 방안 및 구현 내용
1. **가상 카메라 식별 엔진 탑재 (`isVirtualCamera`)**:
   - OBS Virtual Camera, ManyCam, XSplit, Unity Video Capture, vMix, NDI, Camo, DroidCam, EpocCam, iVCam, Iriun, Snap Camera, Prism, Screen Capture 등 소프트웨어 가상/화면 복제 기기를 정밀 판별.
   - 하드웨어 USB HDMI 캡처 카드(Cam Link 등)와의 오탐 방지 테스트 검증(100% 통과).
2. **가상 카메라 최하위 순위(`priority: 99`) 지정 및 자동 시작 원천 배제**:
   - `[🖥️ 가상 카메라]` 배지 부여 및 주황색 표기.
   - `cameras()`, `startCamera()`, 앱 시작 루틴(`DOMContentLoaded`), USB 핫플러그(`devicechange`)에서 가상 카메라는 자동 시작 대상에서 원천 차단.
3. **권한 프로브 스트림 승격 방어**:
   - `requestCameraPermissionProbe()` 시 트랙 라벨이 가상 카메라로 확인되면 즉시 트랙을 `stop()`하고 활성 스트림 승격을 차단.
4. **물리 카메라 부재 시 친화적 대기 화면 유지**:
   - 카메라가 없거나 가상 카메라만 감지된 경우 오류 대화상자 없이 플레이스홀더(`#placeholder`) 상태로 안착.
   - 판서, 도형, 칠판 배경판 기능은 카메라 없이도 즉시 자유롭게 사용 가능.
5. **수동 선택 시 안전 확인 다이얼로그 추가**:
   - 교사가 수업 목적으로 가상 카메라를 의도적으로 사용할 경우를 위해, 드롭다운 또는 시작 버튼에서 가상 카메라를 선택 시 "화면 무한 복제가 발생할 수 있습니다" 사전 경고 다이얼로그를 거치도록 설계.
6. **동기화 및 빌드 검증**:
   - 4종 HTML 파일 100% 동기화 (281,713 bytes, SHA-256 일치).
   - Inno Setup 설치 프로그램 및 Portable ZIP 패키지 빌드 완료.

## [2026-11-01] 순수 창작 네이티브 DLL 15대 API 확장 및 마스터 기술 아키텍처 문서화

### 1. 작업 개요 및 요청 분석
- **요청 사항**:
  1. 기능 중 순수 창작 DLL로 제작하여 활용하면 유용한 신규 기능 발굴 및 구현.
  2. 기존 DLL 파일 내 오류 및 개선점 전수 점검.
  3. 순수 창작 DLL의 동작 원리와 세부 기술 사양을 공식 문서로 작성하여 등록.

### 2. 기존 DLL 결함 점검 및 개선 내역
- **VTable Fixup 테이블 크기 정밀 동기화**: 기존 10슬롯(40바이트)에서 15슬롯(60바이트)으로 확장하고 슬롯당 4바이트 PE 메모리 정렬 완료.
- **포인터 역참조(`stind.i4`) NULL 방어 점검**: `CV_VerifyTrialStatus`, `CV_GetVirtualScreenBounds`, `CV_GetDiskFreeSpaceMB`, `CV_GetDisplayDpi`에서 호출자가 NULL 포인터를 넘기더라도 세그폴트 없이 안전하게 분기하도록 보장.
- **예외 차단 쉴드**: 15개 전체 IL 썽크 메서드에 `.try ... catch`를 배치하여 Inno Setup이나 네이티브 호출자 크래시 100% 방지.

### 3. 신규 5대 창작 네이티브 API 구현
1. `CV_PlayCustomTone`: 브라우저 비활성 오디오 뮤트 영향을 받지 않는 Win32 커널 하드웨어 주파수 비프음.
2. `CV_GetDiskFreeSpaceMB`: 동영상 저장 전 디스크 잔여 용량(MB) 실시간 확인.
3. `CV_GetDisplayDpi`: 전자칠판(Interactive Whiteboard) 및 4K 프로젝터 고화질 DPI 스케일링 감지.
4. `CV_SetWindowTopmost`: PDF 교과서/PPT 수업 중 화상기 화면을 항상 위에 고정(Always-on-Top).
5. `CV_GetPerformanceTimeMs`: 마이크로초 단위의 초정밀 QPC 단조 증가 성능 측정기.

### 4. 품질 검증 및 문서 등록
- **단위 테스트 러너(`src/dll/TestRunner.cs`)**: 15/15 전수 테스트 100% 통과(Pass).
- **공식 문서 등록**: `docs/NATIVE_DLL_ARCHITECTURE.md` 전면 개편 등록, `docs/MODULES.md`, `docs/PATCHNOTES.md` 갱신.


## [2026-11-02] 자동 패치노트/버전관리 규정 확립, 전체 docs 문서 동기화 및 구글 블로거 공식 포스팅 원고 체계화

### 1. 작업 개요 및 요청 분석
- **자동 패치노트 기록 및 버전관리**: 코드 수정에 특이점(신규 기능, 결함 해결, 구조 개편) 도출 시 자동으로 패치노트(PATCHNOTES.md)에 기록하고 버전을 동기화 관리.
- **docs 폴더 전체 문서 최신 내용 업데이트**: README.md, docs/README.md, BUILD.md, INSTALL.md, ARCHITECTURE.md, SECURITY.md, CHANGELOG.md, ROADMAP.md 전면 갱신.
- **문서 폴더 내 깃허브용 문서 갱신**: 개발자(AhBiYout), 깃허브(AhBiYout-all), 공식 구글 블로그 및 15대 Native API, 멀티파일 인스톨러, 방화벽 사전 등록 반영.
- **구글 블로거(Blogger) 공식 포스팅 문서 생성 (docs/BLOG_POST.md)**:
  - [작성 모드 (서식 있는 텍스트)] 및 [HTML 편집 모드] 2종 포맷 완벽 제공.
  - 규정된 10단계 순서 엄격 준수: 제목 - 본문 - 업데이트 - 앱 그림 - 다운로드 - 버전정보 - 시스템 요구 사항 - 제작자 및 공식 채널 안내 - 전체 업데이트 (역대 기능 개선 전수 기록) - 추천 태그.
  - 추천 태그: 한글/영어 혼합, 20개 이하(18개), 200자 이내(166자) 엄격 준수.

### 2. 구글 블로거 문서 구축 (docs/BLOG_POST.md)
- **[작성 모드]**: 블로그 에디터의 서식 있는 텍스트 모드에 즉시 복사하여 붙여넣을 수 있는 정돈된 마크다운 구조.
- **[HTML 편집 모드]**: 인라인 스타일(모던 그라디언트 헤더, 카드 레이아웃, 컬러 뱃지, 반응형 그리드, 다운로드 버튼)이 포함된 시맨틱 HTML5 원고 제공.
- **전체 업데이트**: v1.0.0 최초 릴리즈부터 v1.4.4 최신 버전까지 역대 11회차 개선 내역 중 '기능 개선'에 해당하는 항목만 선별하여 일목요연하게 정리.
- **추천 태그**: 아비캠뷰어,실물화상기,웹캠뷰어,수업도구,교실화상기,전자칠판,화상수업,무료소프트웨어,AhBiCamViewer,ClassroomVisualizer,WebcamViewer,Visualizer,DocumentCamera,EdTech,ScreenCapture,WindowsApp,AhBiYout (18개 태그, 166자).

### 3. 기술 문서 전면 동기화
- README.md & docs/README.md: v1.4.4 최신 뱃지, 공식 채널(GitHub, 블로그), 15대 Win32 Native API, 가상 카메라 무한 복제 차단, 인스톨러 방화벽 사전 등록.
- docs/CHANGELOG.md: [1.4.4] - 2026-11-01 Keep a Changelog 표준 섹션 추가.
- docs/BUILD.md: Node.js 22 LTS, .NET C# 5.0 + ilasm 15 Native API 컴파일, Inno Setup 6 멀티파일 파이프라인 반영.
- docs/INSTALL.md: Unpacked Multi-File 구조, 무인 설치 스위치, 윈도우 방화벽 사전 자동 등록.
- docs/ARCHITECTURE.md: 15대 Win32 API 및 가상 카메라 루프백 차단 메커니즘, 머메이드 다이어그램 갱신.
- docs/SECURITY.md: 방화벽 사전 등록의 투명성, 15개 Native API 예외 쉴드, 가상 카메라 루프 공격 표면 차단 검증.
- docs/ROADMAP.md: TASK-015부터 TASK-020까지의 신규 태스크 명세 등록 및 VERIFIED 상태 전이.


## [2026-11-03] GitHub 공식 운영/배포 가이드(GITHUB.md) 신규 제정 및 CI/CD 워크플로 정비

### 1. 작업 개요
- **GitHub 운영 가이드 문서화**: docs/GITHUB.md를 생성하여 제작자 정보(AhBiYout, AhBiYout-all, 블로그), 엄격한 .gitignore 규칙, 실시간 업데이트 팝업 시스템 아키텍처, Node 22 LTS CI/CD 워크플로, 인스톨러 방화벽 등록 사양 및 릴리즈 절차를 종합 문서화.
- **CI/CD 워크플로(.github/workflows/build-and-release.yml) 정밀화**: 네이티브 컴파일 단계의 소스 파일 지정(LicenseCore.cs, NativeSystemCore.cs) 및 x86 플랫폼 타겟팅을 로컬 빌드 스크립트(uild_dll.bat)와 100% 일치시켜 클라우드 빌드 무결성 확보.
- **자동 패치노트 기록 및 버전관리 원칙 강화**: docs/PATCHNOTES.md 상단에 코드 수정 특이점 발생 시 자동 기록 및 버전 상향 원칙을 명시하여 향후 개발 과정의 일관성 보장.
- **전체 기술 문서 교차 링크 갱신**: README.md, docs/README.md, installer.iss에 docs/GITHUB.md 반영.
