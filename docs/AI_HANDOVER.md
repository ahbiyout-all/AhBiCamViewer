# 🤖 아비캠뷰어 (AhBiCamViewer) AI 인계 명세서 (AI Handover Document)

본 문서는 **아비캠뷰어 (AhBiCamViewer)** 프로젝트의 개발을 다음 AI 어시스턴트(AI Coding Agent)에게 원활하게 인계하기 위해 작성된 공식 종합 인계 명세서입니다. 본 문서에 명시된 개발 규칙, 아키텍처 원칙, 프로젝트 구조 및 명령어 체계를 엄격히 준수하여 작업을 이어받으시기 바랍니다.

---

## 1. 📌 프로젝트 개요 및 환경 (Executive Overview)

- **프로젝트 명**: 아비캠뷰어 (AhBiCamViewer) — 차세대 스마트 교실용 실물화상기 & 뷰어
- **현재 시맨틱 버전**: `v1.4.8` (버전 단일 진실 공급원: `version.json`)
- **저장소 위치 (로컬)**: `C:\Users\user\.gemini\antigravity\scratch\교실용_실물화상기`
- **원격 GitHub 저장소**: `https://github.com/AhBiYout-all/AhBiCamViewer.git`
- **공식 블로그**: `https://ahbiyoutvibe.blogspot.com/`
- **Git 작성자(Author) 정보 (필수 준수)**:
  - Name: `AhBiYout`
  - Email: `AhBiYout-all@users.noreply.github.com`
  - *모든 Git 커밋은 위 작성자 정보로 서명되어야 합니다.*
- **개발 환경 OS**: Windows (Shell: PowerShell / CMD)

---

## 2. 🏛️ 핵심 아키텍처 및 기술 스택 (Architecture & Philosophy)

### ① Single-Source Web Application (`index.html`)
- UI 마크업, CSS 스타일링, 판서 엔진, 카메라 WebRTC 제어, 텍스트/도형 조작, 오디오 믹싱, PDF/MP4 인코딩 등 모든 프론트엔드 기능이 **`index.html` 단일 파일에 완결적으로 구현**되어 있습니다.
- Webpack, Vite, Parcel 등 번들러나 무거운 npm 패키지(node_modules) 의존성을 일체 두지 않으며, 브라우저 표준 Web API(Canvas 2D, MediaStream, MediaRecorder, Web Audio API, Web Share 등)만으로 구동됩니다.

### ② 순수 창작 Native Win32 DLL (`src/dll/` -> `bin/`)
- 웹 브라우저의 샌드박스 한계를 극복하기 위해 Windows Win32 API를 활용하는 고성능 C# 및 IL 기반 순수 네이티브 DLL을 개발하여 연동합니다.
- 총 15대 Win32 Native API 완비 (하드웨어 비프음, 모니터 토폴로지, 절전 모드 방지, 마이크로초 고정밀 타이머, Always-on-Top 고정 등).
- `.NET Framework 4.0` 내장 도구(`csc.exe`, `ilasm.exe`)로 컴파일되며, 자체 단위 테스트 러너(`TestRunner.cs`)를 통해 15/15 테스트 무결성을 검증합니다.

### ③ 스마트 크롬리스(Chromeless) 런처 (`launcher.vbs`, `tools/AhBiCamViewer.bat`)
- 시스템에 설치된 Microsoft Edge 또는 Google Chrome의 독립 앱 모드(`--app=...`)를 자동 탐색하여 주소창과 툴바가 없는 독립 데스크톱 앱 형태로 실행합니다.
- `AppData\Local\AhBiCamViewer_AppProfile` 격리 프로필에 카메라/마이크/다중모니터 권한을 사전 등록(`Preferences`)하여 교실 환경에서 일체의 권한 허용 팝업이 뜨지 않도록 처리되어 있습니다.

### ④ 6단계 무인 인스톨러 (`installer.iss`)
- Inno Setup 6 기반의 설치 패키지:
  1. 실행 중인 기존 앱 프로세스 자동 감지 및 안전 종료
  2. 레지스트리 기반 구버전 언인스톨러 자동 무인 실행 및 클린 삭제
  3. 라이선스 동의 (한국어/영어)
  4. 본 설치 (경량화된 필수 런타임 파일만 배포)
  5. 바탕화면 및 시작메뉴 바로가기 생성
  6. 설치 완료 후 즉시 앱 실행

---

## 3. ⚠️ 절대 준수 규칙 및 함정 방지 (Strict Rules & Gotchas)

1. **줄바꿈 (Line Endings) 규칙**:
   - Windows 배치 파일(`.bat`, `.vbs`, `.iss`, `.ps1`)은 **반드시 CRLF (`\r\n`)** 형식을 유지해야 합니다.
   - LF로 저장될 경우 Windows `cmd.exe`가 명령어를 잘못 파싱하여 치명적 오작동이 발생합니다. 수정 후 `powershell -File tools/format_crlf.ps1`을 실행하세요.
2. **Git 커밋 작성자 누출 방지**:
   - `git commit` 시 항상 `--author="AhBiYout <AhBiYout-all@users.noreply.github.com>"`을 명시하거나 `git config user.name / user.email`을 확인하세요.
3. **PowerShell 인라인 스크립트 작성 시 주의**:
   - PowerShell 환경에서 `node -e "..."` 실행 시 `<` 나 `>` 문자가 포함되면 파서 에러(`The '<' operator is reserved for future use`)가 발생합니다. 인라인 대신 `tools/`에 임시 `.cjs` 파일을 작성하여 실행 후 삭제하는 패턴을 사용하세요.
4. **CommonJS (`.cjs`) 확장자 사용**:
   - 루트 또는 상위 디렉터리 설정으로 인해 `.js` 파일에서 `require` 사용 시 ES Module 충돌이 발생할 수 있으므로, Node.js 유틸리티는 반드시 `.cjs` 확장자를 사용합니다.
5. **깃허브 푸시 스크립트 원격 업로드 배제 원칙**:
   - `push_to_github.bat`, `tools/push_to_github.cjs` 등 로컬 푸시 스크립트는 `.gitignore`에 등록되어 있으며 **원격 GitHub 저장소에 절대로 푸시되어서는 안 됩니다**.

---

## 4. 📂 디렉터리 구조 및 파일 명세 (Project Inventory)

```
교실용_실물화상기/
├── .github/
│   └── workflows/
│       └── build-and-release.yml   # GitHub Actions CI/CD (Windows 빌드, DLL 테스트, Inno Setup 릴리즈)
├── assets/
│   ├── app.ico                     # 인스톨러 및 윈도우 바로가기 아이콘
│   ├── icon.png                    # 고해상도 앱 아이콘 PNG
│   ├── icon.svg                    # 벡터 SVG 아이콘
│   └── LICENSE.txt                 # Inno Setup 설치 마법사 노출용 MIT 라이선스
├── bin/ (Git 제외)
│   ├── AhBiCamViewerCore.dll       # Win32 네이티브 익스포트 DLL
│   └── AhBiCamViewerManaged.dll    # .NET 매니지드 코어 라이브러리
├── dist/ (Git 제외)
│   ├── 1.4.8/                      # 버전별 배포 산출물 아카이브
│   ├── AhBiCamViewer_Portable_v1.4.8.zip # 포터블 패키지
│   └── 아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.8.exe # Windows 정식 설치 파일
├── docs/                           # 공식 기술 및 사용자 문서
│   ├── ARCHITECTURE.md             # 시스템 및 컴포넌트 아키텍처
│   ├── BLOG_POST.md                # 공식 구글 블로거 포스팅 원고
│   ├── BUILD.md                    # 소스코드 빌드 및 개발환경 가이드
│   ├── CHANGELOG.md                # 영문 변경 이력
│   ├── GITHUB.md                   # GitHub 워크플로 및 릴리즈 명세
│   ├── INSTALL.md                  # 설치 및 실행 매뉴얼
│   ├── LICENSE.ko.md / .en.md      # 국/영문 공식 라이선스
│   ├── MODULES.md                  # 내부 모듈 사양서
│   ├── NATIVE_DLL_ARCHITECTURE.md  # Native Win32 DLL 아키텍처
│   ├── PATCHNOTES.md               # 한글 릴리즈 패치노트 (특이점 발생 시 기록)
│   ├── README.md                   # 사용자 매뉴얼
│   ├── ROADMAP.md                  # 향후 개발 로드맵
│   ├── SECURITY.md                 # 보안 정책
│   ├── WORK_LOG.md                 # 작업 수행 일지 (작업 1 ~ 작업 54)
│   └── AI_HANDOVER.md              # [본 문서] 차기 AI 어시스턴트 인계 명세서
├── src/
│   └── dll/
│       ├── AhBiCamViewerCore.il    # Win32 네이티브 익스포트 IL 어셈블리 소스
│       ├── LicenseCore.cs          # 라이선스/체크섬 로직 C# 소스
│       ├── NativeSystemCore.cs     # 15대 Win32 API 래퍼 C# 소스
│       └── TestRunner.cs           # DLL 검증 단위 테스트 러너 (15/15 PASS)
├── tools/
│   ├── AhBiCamViewer.bat           # 포터블 배치 런처
│   ├── build_dll.bat               # Native DLL 빌드 스크립트
│   ├── check_syntax.cjs            # HTML/JS 구문 무결성 정밀 검사기
│   ├── format_crlf.ps1             # 파일 CRLF 정합 유틸리티
│   ├── launcher.vbs                # 스마트 크롬리스 VBS 런처
│   ├── make_icon.ps1               # ICO 아이콘 생성 도구
│   └── push_to_github.cjs          # (로컬 전용, Git제외) 인터랙티브 푸시/릴리즈 엔진
├── .gitignore                      # 완벽히 정비된 Git 제외 필터
├── build.bat                       # 전체 프로젝트 빌드/테스트/인스톨러 컴파일 파이프라인
├── index.html                      # 핵심 웹 애플리케이션 (Single-Source Core)
├── installer.iss                   # Inno Setup 6 인스톨러 컴파일 스크립트
├── launcher.vbs                    # 루트 런처 (스마트 크롬리스 VBS)
├── README.md                       # 최상위 리드미 (v1.4.8 최신화 완료)
├── version.json                    # 시맨틱 버전 단일 공급원 {"version": "1.4.8"}
├── 소스압축.bat                    # 원본 소스코드 백업 보관 자동화 도구
├── push_to_github.bat              # (로컬 전용, Git제외) 원클릭 푸시 런처
├── push_github.bat                 # (로컬 전용, Git제외) push_to_github.bat 포워딩
└── git-release.bat                 # (로컬 전용, Git제외) push_to_github.bat 포워딩
```

---

## 5. 🛠️ 핵심 실행 명령어 치트시트 (Cheat-Sheet)

| 작업 | 명령어 | 설명 |
| :--- | :--- | :--- |
| **구문 무결성 검증** | `node tools/check_syntax.cjs` | `index.html` 내 모든 JS 스크립트 블록 구문 검사 |
| **전체 빌드 & 테스트** | `.\build.bat` | DLL 빌드, 15/15 단위 테스트, Inno Setup 컴파일, 포터블 ZIP 생성 |
| **DLL 단독 빌드/테스트** | `.\tools\build_dll.bat` | Native DLL 재컴파일 및 `TestRunner.exe` 실행 |
| **원본 소스 백업** | `.\소스압축.bat` | 불필요 바이너리/Git 제외 후 `backup/`에 초경량 소스 ZIP 생성 |
| **CRLF 줄바꿈 정합** | `powershell -File tools/format_crlf.ps1` | 프로젝트 전체 텍스트 파일 CRLF 인코딩 보정 |
| **GitHub 커밋 & 푸시** | `.\push_to_github.bat` | 구문 검증, 버전 태그 질의, 공식 서명 푸시 자동화 |

---

## 6. 📝 최근 완료 작업 요약 (Recent Milestones)

- **작업 50 (v1.4.8 배포)**:
  - 모니터 1, 2 점프 시 권한 팝업 차단 (`window.moveTo` 기반 + Chromium 격리 프로필 권한 사전 등록)
  - 전체화면 시 좌측 상단 카메라 해상도 정보 자동 은폐 및 ON/OFF 토글
  - 수업 녹화 시 마이크 음성 실시간 합성 (오디오 트랙 누락 해결)
  - 텍스트 도구와 이동식 도형(Movable Shapes) 상호 배타성 완벽 분리
  - 도형 내부 색상/투명도 변경 독립 팔레트 탑재
  - 좌측 판서 메뉴 클릭 시 활성/비활성 토글 스위치 적용
- **작업 51**:
  - 인스톨러 및 배포 패키지 전수 점검: 개발자 내부 문서 9종(`WORK_LOG.md` 등) 및 `TestRunner.exe` 제외
- **작업 52**:
  - GitHub 저장소 상태 점검 및 `.gitignore` 전면 개편 (푸시 스크립트, 바이너리, 로그 완전 차단)
- **작업 53**:
  - 원본 소스 보관을 위한 `소스압축.bat` 제작 및 검증 (262KB 초경량 소스 아카이브 생성)
- **작업 54 — 자아성찰(Self-Reflection & Deep Audit)**:
  - 전체 소스코드에 대한 무결성 심층 감사(Deep Audit) 수행, 8대 잠재 결함 발굴 및 전면 수정:
    1. 전체화면 카메라 정보 배지 ON/OFF CSS 충돌 해결
    2. 듀얼 모니터 점프 시 전체화면 보안 차단 해제 파이프라인 탑재
    3. 인스톨러 내 `AI_HANDOVER.md` 누출 방어
    4. 화살표 점선 모드 촉 깨짐 방지
    5. 도형 채우기 툴바 토글 양방향 동기화
    6. 텍스트/도형 카드 `pointercancel` 리스너 추가 (드래그 락 방지)
    7. 녹화 정지 조건 확대 (`'recording'` → `!== 'inactive'`)
    8. Escape 키 판서 도구 해제 + 중복 `pointerleave` 리스너 제거

---

## 7. 🚀 차기 작업 추천 및 확장 로드맵 (Next Steps)

1. **v1.4.9 판서 및 미디어 기능 고도화**:
   - 이동식 도형(Movable Shapes) 크기 조절(Resize Handle) 또는 회전 기능 검토.
   - 2분할 비교 화면(Split View)에서 캡처된 정지 화면 간 확대/축소 동기화 옵션.
2. **다국어(i18n) 지원 확장**:
   - 현재 한국어/영어 기반 UI에서 일본어/스페인어 등 다국어 번역 딕셔너리 확장 고려.
3. **코드 수정 시 의무 사항**:
   - 수정 사항이 생기면 항상 `node tools/check_syntax.cjs` 및 `.\build.bat`를 실행하여 15/15 테스트 통과를 확인하고, `docs/PATCHNOTES.md`와 `docs/WORK_LOG.md`에 기록하세요.
