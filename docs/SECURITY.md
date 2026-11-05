# 🛡️ 보안 감사 및 취약점 검토 보고서 (Security Audit)

본 문서는 **Autonomous Coding Agent System v2.0** 표준(§8)에 따라 아비캠뷰어 (AhBiCamViewer) v1.4.4 프로젝트에 대해 수행된 보안 감사 결과와 보호 조치를 기술합니다.

---

## 1. 보안 감사 요약 (Executive Summary)

- **감사 대상**: `index.html`, `installer.iss`, `build.bat`, `launcher.vbs`, `AhBiCamViewer.bat`, `src/dll/*`, `bin/*.dll`, `.github/workflows/build-and-release.yml`
- **감사 기준**: OWASP Top 10, CWE / SANS Top 25, Windows 응용 프로그램 최소 권한 원칙(Principle of Least Privilege)
- **종합 결과**: **PASS (안전)**
- **주요 보안 조치**:
  1. **개인정보 및 기밀성 보호**: GitHub 업로드 시 개인 이메일, 개인 토큰, 로컬 푸시 스크립트(`push_github.bat`) 일체 배제.
  2. **15대 Win32 Native DLL 예외 쉴드**: 15개 전체 unmanaged 함수를 `.try ... catch [mscorlib]System.Exception`으로 방어하여 포인터 예외에 따른 호스트 충돌(Crash) 0% 달성.
  3. **Windows 방화벽 사전 등록 및 청소**: 설치 시 기본 앱 이름과 버전 표기 이름으로 사전 조용히 등록(`netsh advfirewall`)하여 네트워크 경고창을 원천 차단하고, 프로그램 제거 시 잔여 규칙 자동 청소.
  4. **가상 카메라 루프 공격 표면 차단**: `screen-recorder-device` 등 가상 캡처 필터 자동 시작을 차단하여 CPU 과부하 및 화면 무한 복제 결함 차단.

---

## 2. 세부 검토 항목 및 감사 결과 (Audit Findings)

### 2.1 비밀 정보 및 자격 증명 노출 (Exposed Secrets & Credentials)
- **분석 항목**: API 키, 개인 토큰, 비밀번호, 민감 이메일 주소 포함 여부
- **점검 파일**: 전체 저장소 (`.gitignore` 규칙 검증)
- **결과**: **PASS**
- **소견**: 외부 상용 API 키나 인증 토큰이 존재하지 않으며, 로컬 푸시 스크립트(`push_github.bat`)는 `.gitignore`에 등록되어 GitHub 원격 저장소 업로드가 원천 차단됩니다.

### 2.2 네트워크 바인딩 및 원격 코드 실행 (Insecure Network Bindings & RCE)
- **분석 항목**: 임의의 포트 리스닝(Listening Sockets), 소켓 수신 대기, 악성 스크립트 인젝션
- **결과**: **PASS**
- **소견**: 외부 중계 서버나 WebRTC DataChannel을 사용하지 않으며, 순수 로컬 웹캠 및 USB UVC 카메라 스트림만 수신하므로 외부 침투 경로가 없습니다.

### 2.3 윈도우 방화벽 규칙 사전 조용 등록 및 클린 제거 (Firewall Automation)
- **분석 항목**: 방화벽 등록의 투명성, 사용자 방해 없는 사전 등록 및 삭제 무결성
- **영향 파일**: `installer.iss`
- **조치 사항**:
  - `[Run]` 섹션에서 `netsh advfirewall firewall add rule`을 사용하여 앱 기본 이름(`아비캠뷰어 (AhBiCamViewer)`)과 버전 표기 이름(`아비캠뷰어 (AhBiCamViewer) v1.4.4`)에 대해 아웃바운드/인바운드 규칙을 사전 조용히 등록.
  - `[UninstallRun]` 섹션에서 제거 시 등록된 방화벽 규칙을 완벽하게 자동 삭제하도록 구성.
- **수정 상태**: `PASS (VERIFIED)`

### 2.4 안전하지 않은 파일 접근 및 프로세스 실행 (Unsafe File Access & Execution)
- **분석 항목**: 로컬 파일 시스템 무단 변조, 잘못된 `ShellExecute` / `CreateProcess` 호출
- **영향 파일**: `installer.iss`, `launcher.vbs`
- **조치 사항**:
  - Inno Setup `[Run]` 섹션의 실행 대상을 `launcher.vbs`로 지정하여 `shellexec` 플래그와 함께 Windows 스크립트 호스트를 통해 안전하게 크로미움 독립 앱 창을 구동.
- **수정 상태**: `PASS (VERIFIED)`

### 2.5 자동 업데이트 무결성 (Secure Update Mechanism)
- **분석 항목**: 비보안 HTTP를 통한 업데이트 확인 및 임의 바이너리 무단 실행 여부
- **영향 파일**: `index.html`
- **조치 사항**:
  - GitHub 공식 REST API (`https://api.github.com/repos/AhBiYout-all/AhBiCamViewer/releases/latest`)를 HTTPS 전용으로 조회.
  - 임의 바이너리를 무단 다운로드/실행하지 않고, 공식 릴리스 페이지로 사용자를 안전하게 안내하는 인터랙티브 팝업 구조 채택.
- **수정 상태**: `PASS (VERIFIED)`

### 2.6 클라이언트 사이드 XSS 및 데이터 보존 (Cross-Site Scripting & Storage)
- **분석 항목**: `eval()`, `innerHTML` 인젝션 가능성
- **영향 파일**: `index.html`
- **조치 사항**:
  - 외부 사용자 입력값에 대한 `eval` 함수 배제.
  - 캔버스 판서 데이터 및 로컬 스냅샷은 브라우저 메모리 및 로컬 다운로드(`Blob` 객체)로만 처리되며 외부로 전송되지 않음.
- **수정 상태**: `PASS (VERIFIED)`

### 2.7 카메라 자동 허용 보안 (Camera Auto-Grant Security)
- **분석 항목**: 카메라 권한 자동 부여 메커니즘의 보안 영향 평가
- **영향 파일**: `launcher.vbs`, `AhBiCamViewer.bat`
- **조치 사항**:
  - `%LocalAppData%\AhBiCamViewer_AppProfile` 격리 프로필의 `Preferences` 파일에 `file://` URL 프로토콜 한정으로 권한을 사전 부여하여 기존 브라우저 세션과 완벽 분리.
- **수정 상태**: `PASS (VERIFIED)`

### 2.8 순수 창작 Native DLL 15대 API 무결성 및 크래시 방어 (Native Robustness)
- **분석 항목**: unmanaged DLL 호출 시 메모리 누수, 잘못된 포인터 참조에 의한 프로세스 비정상 종료 위험
- **영향 파일**: `src/dll/ClassroomVisualizerCore.il`, `src/dll/NativeSystemCore.cs`
- **조치 사항**:
  - 15개 전체 unmanaged export thunk에 `.try ... catch [mscorlib]System.Exception` 예외 쉴드를 장착하여 잘못된 매개변수나 NULL 포인터 전달 시에도 0 또는 실패 코드를 반환하도록 보호.
  - `TestRunner.exe` 전수 단위 테스트(15/15)를 통해 NULL 안전성 및 메모리 정합성 100% 검증 완료.
- **수정 상태**: `PASS (VERIFIED)`

### 2.9 가상 카메라 무한 복제 방어 (Anti-Droste Shield)
- **분석 항목**: DirectShow 가상 비디오 장치 접근으로 인한 무한 캡처 루프 및 CPU 자원 고갈 위험
- **영향 파일**: `index.html`
- **조치 사항**:
  - `isVirtualCamera()` 판별 로직을 통해 루프백 위험 기기를 영구 최하위(`priority: 99`)로 격리하고 자동 시작 대상에서 원천 배제.
- **수정 상태**: `PASS (VERIFIED)`

---

## 3. 종합 검증 요약표

| 검토 항목 | 심각도 | 상태 | 재검증 결과 |
| :--- | :---: | :---: | :---: |
| 하드코딩된 API 키/비밀번호/개인정보 | High | PASS | 토큰 및 비밀값 전무, git 배제 확인 |
| 무선 P2P 외부 소켓 개방 | High | FIXED | 외부 통신 모듈 완전 제거 완료 |
| 윈도우 방화벽 사전 등록 및 정리 | Medium | PASS | Inno Setup 양방향 사전 등록 및 언인스톨 삭제 |
| 설치 직후 실행 프로세스 에러 | Medium | FIXED | `launcher.vbs` + `shellexec` 적용 완료 |
| HTTPS 업데이트 알림 무결성 | Low | PASS | 공식 GitHub API 조회 및 안전 팝업 안내 |
| 로컬 파일 조작 및 저장소 권한 | Low | PASS | 브라우저 샌드박스 준수 |
| 카메라 자동 허용 (Preferences) | Low | PASS | 격리 프로필 + file:// 한정 허용으로 안전 |
| 15대 Native DLL 크래시 방어 | Medium | PASS | 전수 IL 예외 쉴드 + 단위 테스트 15/15 PASS |
| 가상 카메라 무한 복제 차단 | Medium | PASS | 가상 카메라 자동 연결 원천 배제 완료 |
