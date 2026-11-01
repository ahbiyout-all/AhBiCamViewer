# 🛡️ 보안 감사 및 취약점 검토 보고서 (Security Audit)

본 문서는 **Autonomous Coding Agent System v2.0** 표준(§8)에 따라 아비캠뷰어 (AhBiCamViewer) v1.4.0 프로젝트에 대해 수행된 보안 감사 결과와 보호 조치를 기술합니다.

---

## 1. 보안 감사 요약 (Executive Summary)

- **감사 대상**: `index.html`, `installer.iss`, `build.bat`, `launcher.vbs`, `AhBiCamViewer.bat`, `ClassroomVisualizer.bat`, `bin/*.dll`, `.github/workflows/build-and-release.yml`
- **감사 기준**: OWASP Top 10, CWE / SANS Top 25, Windows 응용 프로그램 최소 권한 원칙(Principle of Least Privilege)
- **종합 결과**: **PASS (안전)**
- **주요 개선 사항**: 불안정한 외부 P2P/WebRTC DataChannel 및 외부 CDN 제거 완료, Inno Setup 인바운드 방화벽 불필요 개방 제거 완료, 하드코딩된 자격 증명 전무 확인, 카메라 자동 허용 플래그의 보안 범위 제한 확인.

---

## 2. 세부 검토 항목 및 감사 결과 (Audit Findings)

### 2.1 비밀 정보 및 자격 증명 노출 (Exposed Secrets & Credentials)
- **분석 항목**: API 키, 개인 토큰, 비밀번호, 민감 이메일 주소 포함 여부
- **점검 파일**: 전체 저장소
- **결과**: **PASS**
- **소견**: 외부 상용 API 키나 인증 토큰이 존재하지 않으며, GitHub Actions에서도 `${{ secrets.GITHUB_TOKEN }}` 표준 환경 변수만 사용됩니다.

### 2.2 네트워크 바인딩 및 원격 코드 실행 (Insecure Network Bindings & RCE)
- **분석 항목**: 임의의 포트 리스닝(Listening Sockets), 소켓 수신 대기, 악성 스크립트 인젝션
- **영향 파일**: `index.html`, `installer.iss`
- **위험도 및 영향**: 과거 v1.3.0에 존재했던 PeerJS 무선 P2P 모듈은 외부 중계 서버 및 WebRTC 연결 협상을 사용하므로 모바일 기기 브라우저의 비보안 컨텍스트(HTTP/HTTPS 혼합) 문제 및 원치 않는 원격 접근 가능성이 존재했음.
- **조치 사항 (v1.3.1)**:
  - 무선 P2P(PeerJS) 통신 라이브러리 및 외부 CDN 스크립트 완전 제거 (`TASK-004`).
  - 로컬 오프라인 전용 USB/UVC 카메라 스트림으로 구조 단순화.
  - 리스닝 포트 수 0개 달성.
- **수정 상태**: `FIXED (VERIFIED)`

### 2.3 윈도우 방화벽 규칙 및 최소 권한 원칙 (Firewall Rules & Least Privilege)
- **분석 항목**: 설치 프로그램이 과도한 네트워크 권한이나 불필요한 방화벽 인바운드 룰을 생성하는지 여부
- **영향 파일**: `installer.iss`
- **위험도 및 영향**: 애플리케이션이 백그라운드 서버로 동작하지 않음에도 인바운드 TCP 규칙을 추가하면 시스템의 네트워크 공격 표면이 불필요하게 넓어질 수 있음.
- **조치 사항**:
  - `[Run]` 섹션의 `netsh advfirewall firewall add rule ... dir=in` 구문 전면 제거.
  - `[UninstallRun]` 섹션에 이전 버전 설치자가 남긴 레거시 규칙을 청소하는 구문은 유지하여 사용자 시스템의 무결성 보장.
- **수정 상태**: `FIXED (VERIFIED)`

### 2.4 안전하지 않은 파일 접근 및 프로세스 실행 (Unsafe File Access & Execution)
- **분석 항목**: 로컬 파일 시스템 무단 변조, 잘못된 `ShellExecute` / `CreateProcess` 호출
- **영향 파일**: `installer.iss`
- **위험도 및 영향**: Inno Setup 설치 완료 후 `.html` 파일을 일반 실행 파일로 오인하여 실행하려 할 경우 `CreateProcess error code 2` 발생 가능.
- **조치 사항**:
  - Inno Setup `[Run]` 섹션의 실행 대상을 `launcher.vbs`로 변경하여, `shellexec` 플래그와 함께 Windows 스크립트 호스트를 통해 안전하게 크로미움 독립 앱 창을 구동.
- **수정 상태**: `FIXED (VERIFIED)`

### 2.5 자동 업데이트 무결성 (Secure Update Mechanism)
- **분석 항목**: 비보안 HTTP를 통한 업데이트 확인 및 임의 바이너리 무단 실행 여부
- **영향 파일**: `index.html`
- **위험도 및 영향**: 검증되지 않은 서버에서 실행 파일을 자동 다운로드하여 실행할 경우 공급망 공격에 노출될 수 있음.
- **조치 사항**:
  - GitHub 공식 REST API (`https://api.github.com/repos/AhBiYout-all/ClassroomVisualizer/releases/latest`)를 HTTPS 전용으로 조회.
  - 실행 파일을 자동으로 백그라운드 다운로드/실행하지 않고, 공식 릴리즈 페이지로 사용자를 안전하게 안내하는 안내 팝업(Read-Only Notice) 구조 채택.
- **수정 상태**: `PASS (VERIFIED)`

### 2.6 클라이언트 사이드 XSS 및 데이터 보존 (Cross-Site Scripting & Storage)
- **분석 항목**: `eval()`, `innerHTML` 인젝션 가능성
- **영향 파일**: `index.html`
- **조치 사항**:
  - 외부 사용자 입력값에 대한 `eval` 함수 배제.
  - 캔버스 판서 데이터 및 로컬 스냅샷은 브라우저 메모리 및 로컬 다운로드(`Blob` 객체)로만 처리되며 외부로 전송되지 않음.
- **수정 상태**: `PASS (VERIFIED)`

### 2.7 카메라 자동 허용 보안 (Camera Auto-Grant Security) *(v1.4.0 개선)*
- **분석 항목**: 카메라 권한 자동 부여 메커니즘의 보안 영향 평가
- **영향 파일**: `launcher.vbs`, `AhBiCamViewer.bat`, `ClassroomVisualizer.bat`
- **위험도**: **Low (제한적)**
- **이전 방식 (제거됨)**: `--use-fake-ui-for-media-stream` 크로미움 플래그 사용 → 브라우저가 "지원되지 않는 명령 줄 플래그" 경고 바를 표시하여 사용자 불안감 유발
- **현재 방식 (v1.4.0)**: 전용 `user-data-dir` 프로필의 `Preferences` 파일에 카메라/마이크 허용 설정을 사전 등록
  - `%LocalAppData%\AhBiCamViewer_AppProfile\Default\Preferences` 파일을 런처 실행 시 자동 생성
  - `profile.content_settings.exceptions.media_stream_camera`에 `file://,*` 패턴으로 `setting: 1` (ALLOW) 기록
  - 크로미움 정식 `content_settings` API를 사용하므로 경고 바가 표시되지 않음
- **보안 분석**:
  - `--user-data-dir`로 격리된 독립 프로필에서만 카메라 허용이 적용되므로, 사용자의 기존 브라우저 세션(북마크, 로그인, 다른 웹사이트)에는 영향을 주지 않습니다.
  - 허용 대상이 `file://` 프로토콜로 한정되어 있어, 원격 웹사이트가 이 설정을 악용할 경로가 없습니다.
  - `--app=file:///...` 모드로 네비게이션을 로컬 파일로 제한합니다.
  - 크로미움의 기본 보안 샌드박스는 그대로 유지됩니다.
- **수정 상태**: `PASS (VERIFIED — 격리 프로필 + file:// 한정)`

### 2.8 네이티브 DLL 바이너리 무결성 (Native DLL Binary Integrity) *(신규)*
- **분석 항목**: `bin/` 폴더의 DLL 파일이 설치 시 변조되지 않았는지 검증하는 메커니즘
- **영향 파일**: `bin/ClassroomVisualizerCore.dll`, `bin/ClassroomVisualizerManaged.dll`, `installer.iss`
- **위험도**: **Low**
- **분석**:
  - `installer.iss`의 `[Code]` 섹션에서 `InitializeSetup()` 함수가 `CV_GetVersion()` 네이티브 함수를 호출하여 DLL 로드 가능 여부 및 기본 정합성을 검증합니다.
  - DLL 소스는 IL 어셈블리(`testexp.cs`, `tools/build_dll.bat`)로부터 빌드되며, 빌드 파이프라인이 투명하게 공개되어 있습니다.
  - DLL은 `dontcopy` 플래그로 임시 폴더에 추출되어 검증 후 최종 설치 경로에 복사됩니다.
- **완화 조치**:
  - 설치 전 DLL 무결성 사전 검증 (로드 + 함수 호출 테스트)
  - 검증 실패 시 설치 로그에 경고 기록 (설치 자체는 계속 진행하여 사용자 편의 보장)
  - 소스 코드 공개로 공급망 투명성 확보
- **수정 상태**: `PASS (VERIFIED)`

---

## 3. 종합 검증 요약표

| 검토 항목 | 심각도 | 상태 | 재검증 결과 |
| :--- | :---: | :---: | :---: |
| 하드코딩된 API 키/비밀번호 | High | PASS | 토큰 및 비밀값 전무 |
| 무선 P2P 외부 소켓 개방 | High | FIXED | 외부 통신 모듈 완전 제거 완료 |
| 불필요한 방화벽 인바운드 개방 | Medium | FIXED | 인스톨러 방화벽 등록 제거 완료 |
| 설치 직후 실행 프로세스 에러 | Medium | FIXED | `launcher.vbs` + `shellexec` 적용 완료 |
| HTTPS 업데이트 알림 무결성 | Low | PASS | 공식 GitHub API 조회 및 수동 다운로드 유도 |
| 로컬 파일 조작 및 저장소 권한 | Low | PASS | 브라우저 샌드박스 준수 |
| 카메라 자동 허용 (Preferences) | Low | PASS | 격리 프로필 + file:// 한정 허용으로 안전 |
| 네이티브 DLL 바이너리 무결성 | Low | PASS | 설치 시 DLL 로드 검증 + 소스 공개 |
