# 📦 설치 및 배포 안내서 (Installation Guide)

본 문서는 **아비캠뷰어 (AhBiCamViewer) v1.4.0**의 윈도우 인스톨러 설치, 무인 설치 스위치, 포터블 실행, 독립 런처 실행 및 삭제 방법을 안내합니다.

---

## 1. 일반 GUI 설치 (Standard Installation)

1. `dist/` 폴더 또는 GitHub Releases에서 `아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe`를 다운로드합니다.
2. 실행 파일을 더블 클릭하여 마법사를 시작합니다 (관리자 권한 필요).
3. 설치 대상 폴더(기본값: `C:\Program Files\AhBiCamViewer`) 및 바탕화면 바로가기 생성을 확인합니다.
4. **이전 버전 감지 안내**:
   - 기존 버전(예: v1.2.0, v1.3.1)이 설치되어 있는 경우 대화상자가 표시되며, [예]를 누르면 안전하게 덮어쓰기 업그레이드가 진행됩니다.
5. 설치가 완료되면 [완료] 버튼 클릭 시 `launcher.vbs`를 통해 크로미움 독립 앱 창으로 즉시 실행됩니다.

---

## 2. 무인 자동 설치 스위치 (Silent / Unattended Install)

학교 전산실, 교내 멀티미디어실 등 다수의 PC에 배치 스크립트로 일괄 배포할 때 유용한 무인 설치 스위치를 지원합니다.

### 2.1 완전 무인 설치 (`/VERYSILENT`)
사용자 대화상자 및 진행률 표시줄 없이 조용히 백그라운드에서 설치를 완료합니다.

```cmd
"아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART
```

### 2.2 기본 무인 설치 (`/SILENT`)
진행률 표시줄 창만 띄우고 사용자 입력 없이 자동으로 설치합니다.

```cmd
"아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe" /SILENT
```

### 2.3 설치 경로 지정 (`/DIR`)
기본 경로 대신 특정 경로에 설치할 경우:

```cmd
"아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe" /VERYSILENT /DIR="D:\EduApps\AhBiCamViewer"
```

---

## 3. 독립 런처 실행 (Standalone Launcher)

v1.4.0부터 `launcher.vbs` 스크립트를 통해 크로미움 기반 독립 앱 창으로 실행하는 것이 **권장 실행 방식**입니다.

### 3.1 launcher.vbs의 역할
- **크로미움 독립 앱 창**: Chrome 또는 Edge를 `--app=` 모드로 실행하여 주소창/탭 없는 깔끔한 전용 창을 띄웁니다.
- **카메라 자동 허용**: 전용 프로필 폴더(`%LocalAppData%\AhBiCamViewer_AppProfile`)에 `Preferences` 파일을 사전 생성하여, `file://` URL에 대한 카메라/마이크 권한을 자동으로 허용합니다. 크로미움 정식 content_settings API를 사용하므로 경고 바가 표시되지 않습니다.
- **독립 프로필**: `--user-data-dir` 옵션으로 별도 사용자 데이터 폴더를 사용하므로 기존 브라우저 세션과 충돌하지 않습니다.

### 3.2 실행 방법
- **설치 후**: 바탕화면 또는 시작 메뉴의 `아비캠뷰어 (AhBiCamViewer)` 바로가기 클릭
- **포터블**: `launcher.vbs` 파일을 더블 클릭

### 3.3 배치 파일 실행 (대안)
`launcher.vbs` 대신 배치 파일로도 실행 가능합니다:
- `AhBiCamViewer.bat` — 동일한 크로미움 독립 앱 모드로 실행
- `ClassroomVisualizer.bat` — 동일 기능의 대체 이름

> **참고**: 카메라 권한은 격리된 전용 프로필(`AhBiCamViewer_AppProfile`) 내의 `Preferences` 파일에 `file://` 프로토콜 한정으로 설정됩니다. 사용자의 기존 브라우저 설정에는 영향을 주지 않습니다.

---

## 4. 포터블 무설치 실행 (Portable Execution)

별도의 시스템 설치나 레지스트리 등록 없이 USB 메모리 등에 담아 바로 실행할 수 있습니다.

1. `dist/AhBiCamViewer_Portable_v1.4.0.zip`의 압축을 임의의 폴더에 해제합니다.
2. **권장**: `launcher.vbs`를 더블 클릭하여 독립 앱 창으로 실행합니다 (카메라 자동 허용 포함).
3. **대안**: `index.html` 또는 `아비캠뷰어_(AhBiCamViewer).html`을 웹 브라우저(Chrome, Edge 등)로 직접 열 수도 있습니다 (이 경우 카메라 허용 팝업이 표시될 수 있음).

### 포터블 패키지 포함 파일:
```
AhBiCamViewer_Portable_v1.4.0/
├── index.html                                    # 메인 앱 (개발용)
├── 아비캠뷰어_(AhBiCamViewer).html               # 메인 앱 (사용자용)
├── (AhBiYout)_공용_실물화상기_보기.html            # 메인 앱 (호환명)
├── 교실용_실물화상기.html                          # 메인 앱 (호환명)
├── launcher.vbs                                   # 독립 런처 (권장 실행)
├── version.json                                   # 버전 정보
├── assets/                                        # 아이콘 등 리소스
├── bin/                                           # 네이티브 DLL
├── docs/                                          # 문서
└── tools/                                         # 유틸리티 스크립트
```

---

## 5. 제거 (Uninstallation)

- **제어판 / 설정**: Windows [설정] → [앱 및 기능]에서 `아비캠뷰어 (AhBiCamViewer)`를 선택하고 [제거]를 클릭합니다.
- **시작 메뉴**: [시작] → [아비캠뷰어 (AhBiCamViewer)] 폴더 내의 `프로그램 제거` 바로가기를 실행합니다.
- **클린 삭제**: 프로그램 제거 시 설치된 파일, 시작 메뉴 및 바탕화면 바로가기뿐만 아니라, 이전 버전에서 등록되었을 수 있는 레거시 방화벽 규칙도 자동으로 안전하게 삭제됩니다.
