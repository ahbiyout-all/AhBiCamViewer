# 📷 아비캠뷰어 (AhBiCamViewer)

[![Release](https://img.shields.io/badge/release-v1.4.7-blue.svg)](https://github.com/AhBiYout-all/AhBiCamViewer/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](docs/LICENSE.en.md)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Web%20%7C%20Desktop-orange.svg)](docs/ARCHITECTURE.md)
[![Build](https://img.shields.io/badge/build-Inno%20Setup%206%20%7C%20Node%2022%20LTS-brightgreen.svg)](docs/BUILD.md)
[![Native Core](https://img.shields.io/badge/native%20APIs-15%20Exports%20(100%25%20Pass)-purple.svg)](docs/NATIVE_DLL_ARCHITECTURE.md)

> **공용 및 교실 환경을 위한 강력한 무설치 웹 & 데스크톱 실물화상기 소프트웨어**  
> 현재 버전: **v1.4.7** | 개발자: **AhBiYout** | 깃허브: **AhBiYout-all**

---

## 📌 핵심 기능 (Core Features)

1. **📐 7대 기하 도형 & 텍스트 주석 자유 이동 및 4중 무손실 벡터 합성 (New in v1.4.7)**
   - **자유 이동식 기하 도형 (Movable Shapes)**: 직선, 사각형, 원, 삼각형, 화살표, 양방향 화살표, 별표 등 7대 기하 도형을 그리기 완료 즉시 인터랙티브 카드로 생성하여 마우스/터치 드래그로 원하는 위치 어디든 자유롭게 이동 (Pointer Capture Drag Engine)
   - **호버 인터랙션 및 핀 고정(📌) & 삭제(✕)**: 도형 호버 시 가이드 점선과 함께 원클릭 핀(📌) 버튼으로 캔버스 비트맵 영구 고정 및 삭제(✕) 지원
   - **자유 이동식 텍스트 주석 (Movable Text)**: 입력한 텍스트 카드를 화면 어디로든 드래그 이동 및 더블 클릭 인라인 재편집
   - **캡처·녹화·PDF·돋보기 4중 무손실 벡터 합성**: 화면에 떠 있는 도형과 텍스트가 스틸 이미지 캡처(FHD~4K), MP4 녹화, PDF 내보내기, 실시간 돋보기 확대 뷰에서 왜곡 없이 무손실 자동 합성
2. **초고해상도 실물화상기 & 웹캠 완벽 지원**
   - ⭐ **최고화질 자동 탐색**: 연결된 카메라의 센서 최고 해상도(Native Max) 자동 협상
   - **4K UHD**(`3840×2160`), **8MP 문서 전용 4:3**(`3264×2448`), **QHD 2K**(`2560×1440`), **FHD**(`1920×1080`) 지원
   - 실시간 해상도 티어 컬러 뱃지 (초고화질 🟢, 고화질 🔵, FHD 🔹, HD 🟡)
   - 고해상도 무손실급 캡처(0.96) 및 A4 PDF 내보내기 최적화 스케일링
3. **🛡️ 가상 카메라 화면 무한 복제(Droste Effect) 원천 차단**
   - DirectShow 가상 캡처 필터(`screen-recorder-device`, `OBS Virtual Camera` 등) 지능형 식별 및 자동 연결 배제
   - 물리 카메라가 없을 때도 화면이 무한히 빨려 들어가는 거울 방 현상 없이 깔끔한 대기 플레이스홀더 화면 유지
4. **⚡ 15대 Win32 순수 창작 Native DLL 탑재 (`AhBiCamViewerCore.dll`, v1.4.7)**
   - **하드웨어 톤 송출 (`CV_PlayCustomTone`)**: `kernel32!Beep` 직접 구동으로 브라우저 탭 스로틀링 없이 즉각적인 수업 타이머/주목음 송출
   - **잔여 디스크 용량 진단 (`CV_GetDiskFreeSpaceMB`)**: 녹화 저장소 용량 사전 검증으로 0KB 동영상 저장 사고 방지
   - **주 모니터 DPI 자동 감지 (`CV_GetDisplayDpi`)**: 전자칠판 및 4K 프로젝터 연결 시 100%~200% 디스플레이 배율 실시간 대응
   - **항상 위 창 고정 (`CV_SetWindowTopmost`)**: PDF/PPT 수업 자료 위에 실물화상기 PIP 플로팅 뷰 모드 지원
   - **고해상도 타이머 (`CV_GetPerformanceTimeMs`)**: 마이크로초 단위 `QueryPerformanceCounter` 정밀 프레임 측정
   - 15개 전수 네이티브 함수에 예외 쉴드(`.try ... catch`) 탑재로 호스트 크래시 0% 보장 (단위 테스트 15/15 100% PASS)
4. **무설치 플러그 앤 플레이 & 하드웨어 UVC 직접 제어**
   - 별도 제조사 드라이버 설치 없이 모든 표준 USB 웹캠, 전용 실물화상기 즉시 인식 및 연결
   - 🔦 **플래시(Torch) On/Off**: Image Capture API 기반 후면 LED 플래시 제어
   - 🎯 **탭 투 포커스 (Tap-to-Focus)**: 화면 터치 지점 자동 초점 재조정
   - ☀️ **센서 노출(Exposure) 보정 다이얼**: -2EV ~ +2EV 범위로 종이 반사광 및 역광 보정
5. **수업 맞춤형 판서 & 주석 도구**
   - 부드러운 베지어 곡선 자유 펜, 반투명 형광펜, 지우개
   - **4대 펜 촉 디자인**: 둥근 촉, 캘리 촉, 사각 촉, 형광펜 촉 및 실시간 촉 프리뷰
   - 도구별 1-클릭 전용 하위메뉴(Flyout), 4종 기하 도형, 텍스트 주석 카드, 최대 40단계 Undo/Redo (`Ctrl+Z`, `Ctrl+Y`)
6. **집중 및 학습 보조 도구**
   - 수업용 카운트다운 타이머, 스톱워치, 3종 보조 격자(모눈종이, 도트, 줄노트)
   - 돋보기(확대경) & 스포트라이트 마우스 휠 조절, 집중 벨 차임 효과음, 가림막, 2분할 캡처 비교 모드
7. **학습 자료 생성 & 아카이빙**
   - 클린 캡처 (메뉴/UI 배제, 단축키 `S`, JPG/PNG)
   - 범용 MP4 / 고화질 WebM 실시간 수업 합성 녹화 (0KB 결함 원천 해결)
   - A4 랜드스케이프 규격 다중 페이지 PDF 일괄 변환 (jsPDF)
8. **📦 Unpacked Multi-File 인스톨러 & 방화벽 사전 등록 (Inno Setup 6)**
   - 폴더 풀림 개별 파일 설치 구조, 구버전 감지 시 덮어쓰기 확인, 무인 설치(`/SILENT`) 지원
   - 윈도우 방화벽 규칙을 기본 이름 및 버전 표기 이름으로 사전 조용히 등록/삭제
9. **🔔 GitHub Releases 실시간 자동 업데이트 팝업 시스템**
   - 릴리스 배포 시 앱 시작 시 버전 정보와 원클릭 업데이트 팝업 자동 실행

---

## 📂 프로젝트 구조 (Repository Layout)

```
교실용_실물화상기/
├── index.html                   # 애플리케이션 진입점 (웹/데스크톱 공용 메인 엔진)
├── 교실용_실물화상기.html       # 독립 단일 파일 애플리케이션 (100% 동기화)
├── 아비캠뷰어_(AhBiCamViewer).html
├── (AhBiYout)_공용_실물화상기_보기.html
├── version.json                 # 시맨틱 버전 및 공식 릴리즈 메타데이터 (v1.4.7)
├── build.bat                    # 윈도우 원클릭 자동 빌드 파이프라인 (DLL+테스트+인스톨러)
├── installer.iss                # Inno Setup 6 멀티파일 인스톨러 스크립트
├── .github/workflows/           # CI/CD 자동화 파이프라인
│   └── build-and-release.yml    # Node.js 22 LTS 기반 DLL 빌드, 테스트 및 인스톨러 릴리즈
├── assets/                      # 고해상도 앱 아이콘 및 리소스
│   ├── icon.svg
│   ├── icon.png
│   └── app.ico
├── src/dll/                     # 순수 창작 Win32 Native DLL 소스코드
│   ├── AhBiCamViewerCore.il # IL 어셈블리 및 VTable Fixup Export Thunk (15 Native APIs)
│   ├── LicenseCore.cs           # 라이선스 및 모듈러 매니지드 코어
│   ├── NativeSystemCore.cs      # Win32 네이티브 시스템 코어 (톤, 디스크, DPI, Topmost, QPC)
│   └── TestRunner.cs            # 네이티브 DLL 15대 API 전수 검증 테스트 수트
├── docs/                        # 종합 기술 문서 및 릴리즈 자료
│   ├── GITHUB.md                # GitHub 저장소 규정, 보안 정책 및 CI/CD 릴리즈 가이드
│   ├── NATIVE_DLL_ARCHITECTURE.md # 순수 창작 DLL 아키텍처 및 15대 API 명세서
│   ├── ARCHITECTURE.md          # 시스템 아키텍처 및 데이터 흐름도
│   ├── ROADMAP.md               # 우선순위 기반 작업 로드맵
│   ├── SECURITY.md              # 보안 감사 및 방화벽/안정성 검토
│   ├── MODULES.md               # 모듈별 상세 사양서
│   ├── BUILD.md                 # 윈도우 빌드 가이드
│   ├── INSTALL.md               # 설치 및 무인 설치 옵션 가이드
│   ├── WORK_LOG.md              # 작업 수행 및 검증 기록
│   ├── CHANGELOG.md             # 시맨틱 변경 내역
│   ├── PATCHNOTES.md            # 배포 패치노트 (v1.0.0 ~ v1.4.7)
│   ├── BLOG_POST.md             # 공식 구글 블로거 포스팅 원고 (서식 텍스트 / HTML 모드)
│   ├── LICENSE.ko.md            # 한국어 라이선스
│   └── LICENSE.en.md            # 영문 라이선스
└── tools/                       # 유틸리티 및 빌드 도구
    ├── build_dll.bat            # 순수 창작 DLL 컴파일 및 15/15 검증 테스트 실행기
    ├── AhBiCamViewer.bat       # 스탠드얼론 실행 배치
    ├── AhBiCamViewer.bat        # 아비캠뷰어 전용 실행 배치
    ├── launcher.vbs             # 무음 창모드 런처
    ├── check_syntax.cjs         # HTML 스크립트 블록 문법 자동 검증기
    └── sync_html.cjs            # 4대 배포용 HTML 100% 바이너리 동기화 도구
```

---

## 🛠 빠른 시작 & 실행

### 1. 웹 브라우저에서 바로 사용
`index.html`을 Chrome, Edge 등 웹 표준 브라우저에서 더블 클릭하여 즉시 실행합니다. 외부 인터넷 연결 없이 100% 로컬에서 동작합니다.

### 2. 윈도우 인스톨러 빌드
프로젝트 루트에서 `build.bat`을 실행하면 다음 과정이 한 번에 자동 진행됩니다:
1. `AhBiCamViewerManaged.dll` 컴파일 (C# 5.0)
2. `AhBiCamViewerCore.dll` 순수 네이티브 DLL 어셈블 (ilasm)
3. `TestRunner.exe` 실행을 통한 15/15 네이티브 API 단위 테스트 전수 검증
4. Inno Setup 6을 통한 멀티파일 인스톨러(`아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.7.exe`) 및 포터블 패키지(`dist/`) 자동 생성

---

## 🔗 [제작자 및 공식 채널 안내]

- **개발자**: AhBiYout
- **GitHub 저장소**: https://github.com/AhBiYout-all
- **공식 구글 블로그**: https://ahbiyoutvibe.blogspot.com/
- **앱 저장소**: https://github.com/AhBiYout-all/AhBiCamViewer
- **라이선스**: MIT License (학교, 관공서, 기업, 개인 누구나 100% 무료)
