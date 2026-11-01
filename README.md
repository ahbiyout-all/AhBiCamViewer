# 📷 아비캠뷰어 (AhBiCamViewer)

[![Release](https://img.shields.io/badge/release-v1.4.4-blue.svg)](https://github.com/AhBiYout-all/ClassroomVisualizer/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](docs/LICENSE.en.md)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Web%20%7C%20Mobile-orange.svg)](docs/ARCHITECTURE.md)
[![Build](https://img.shields.io/badge/build-Inno%20Setup%206-brightgreen.svg)](docs/BUILD.md)

> **공용 및 교실 환경을 위한 강력한 무설치 웹 & 데스크톱 실물화상기 소프트웨어**  
> 현재 버전: **v1.4.4** | 개발자: **AhBiYout (AhBiYout-all)** | 소속: **CISNet**

---

## 📌 핵심 기능 (Core Features)

1. **초고해상도 실물화상기 & 웹캠 완벽 지원 (New in v1.4.4)**
   - ⭐ **최고화질 자동 탐색**: 연결된 카메라가 지원하는 최고 하드웨어 센서 해상도 자동 협상
   - 4K UHD(`3840×2160`), 8MP 문서 전용 4:3(`3264×2448`), QHD 2K(`2560×1440`), FHD(`1920×1080`) 지원
   - 실시간 해상도 티어 컬러 뱃지 (초고화질 🟢, 고화질 🔵, FHD 🔹, HD 🟡)
   - 고해상도 무손실급 캡처(0.96) 및 A4 PDF 내보내기 최적화 스케일링
2. **무설치 플러그 앤 플레이 (UVC 지원)**
   - 별도 제조사 드라이버 설치 없이 모든 표준 USB 웹캠, 전용 실물화상기 즉시 인식 및 연결
   - DroidCam, Iriun Webcam, 안드로이드 순정 UVC 웹캠을 통한 스마트폰 카메라 연동
3. **스마트폰 하드웨어 직접 제어 (Hardware Camera Control)**
   - 🔦 **플래시(조명/Torch) On/Off**: Image Capture API 기반 후면 LED 플래시 직접 제어로 어두운 교재 조명 확보
   - 🎯 **탭 투 포커스 (Tap-to-Focus)**: 화면 클릭/터치 지점에 카메라 렌즈 하드웨어 초점 자동 재조정
   - ☀️ **센서 노출(Exposure) 다이얼**: -2EV ~ +2EV 범위 센서 노출 보정으로 종이 반사광 및 역광 보정
3. **수업 맞춤형 판서 & 주석 도구**
   - 자유 곡선 펜, 반투명 형광펜, 지우개
   - 4종 기하 도형: 직선(`╱`), 사각형(`▭`), 원(`◯`), 화살표(`➜`)
   - 캔버스 텍스트 주석 입력 및 최대 40단계 Undo/Redo (`Ctrl+Z`, `Ctrl+Y`)
4. **집중 및 학습 보조 도구**
   - 수업용 타이머 (카운트다운 경고 점멸) 및 스톱워치
   - 3종 보조 격자 (모눈종이, 도트, 줄노트)
   - 집중 벨 효과음(Web Audio API) 및 화면 플래시
   - 레이저 포인터, 확대경, 스포트라이트, 가림막 집중 도구
   - 최근 캡처 이미지 2분할(좌우) 나란히 비교 모드
5. **학습 자료 생성 & 아카이빙**
   - 무손실 고화질 캡처 (PNG)
   - A4 랜드스케이프 규격 다중 페이지 PDF 일괄 변환 (jsPDF)
   - 실시간 수업 녹화 (WebM)
6. **완전한 오프라인 독립 실행 및 보안**
   - 외부 서버 및 CDN 의존성 없는 100% 로컬 독립 실행
   - 불필요한 방화벽 개방 배제 (최소 권한 원칙)

---

## 📂 프로젝트 구조 (Repository Layout)

```
교실용_실물화상기/
├── index.html                   # 애플리케이션 진입점 (웹/데스크톱 공용)
├── 교실용_실물화상기.html       # 독립 단일 파일 애플리케이션
├── version.json                 # 시맨틱 버전 및 공식 메타데이터
├── build.bat                    # 윈도우 원클릭 자동 빌드 스크립트 (CRLF)
├── git-release.bat              # Git 태그 생성 및 GitHub 릴리즈 푸시 자동화
├── installer.iss                # Inno Setup 6 인스톨러 컴파일 스크립트
├── assets/                      # 고해상도 앱 아이콘 및 리소스
│   ├── icon.svg
│   ├── icon.png
│   └── app.ico
├── docs/                        # 종합 기술 문서 및 릴리즈 자료
│   ├── ARCHITECTURE.md          # 시스템 아키텍처 및 데이터 흐름
│   ├── ROADMAP.md               # 우선순위 기반 작업 로드맵
│   ├── SECURITY.md              # 보안 감사 및 취약점 검토
│   ├── MODULES.md               # 모듈별 상세 사양서
│   ├── BUILD.md                 # 윈도우 빌드 가이드
│   ├── INSTALL.md               # 설치 및 무인 설치 옵션 가이드
│   ├── WORK_LOG.md              # 작업 수행 및 검증 기록
│   ├── CHANGELOG.md             # 시맨틱 변경 내역
│   ├── PATCHNOTES.md            # 배포 패치노트
│   ├── BLOG_POST.md             # 공식 구글 블로그 배포 서식
│   ├── LICENSE.ko.md            # 한국어 라이선스
│   └── LICENSE.en.md            # 영문 라이선스
├── tools/                       # 유틸리티 및 보조 도구
│   ├── ClassroomVisualizer.bat
│   ├── launcher.vbs
│   ├── format_crlf.ps1
│   └── make_icon.ps1
└── dist/                        # 컴파일된 빌드 산출물
    ├── 1.3.1/
    │   ├── (AhBiYout) 공용 실물화상기 보기_Setup_v1.4.4.exe
    │   └── ClassroomVisualizer_Portable_v1.4.4.zip
    └── ...
```

---

## 🛠 빠른 시작 & 실행

### 1. 웹 브라우저에서 바로 사용
`index.html` 또는 `(AhBiYout)_공용_실물화상기_보기.html`을 Chrome, Edge 등 웹 표준 브라우저에서 더블 클릭하여 실행합니다.

### 2. 윈도우 설치형 패키지 빌드
`build.bat`을 실행하면 Inno Setup 6을 통해 무인 설치가 가능한 독립 실행형 인스톨러(`(AhBiYout) 공용 실물화상기 보기_Setup_v1.4.4.exe`)와 포터블 압축 파일(`ClassroomVisualizer_Portable_v1.4.4.zip`)이 `dist/1.3.1/`에 자동 생성됩니다.

---

## 🔗 제작자 및 공식 채널

- **개발자**: AhBiYout
- **GitHub 저장소**: [https://github.com/AhBiYout-all/ClassroomVisualizer](https://github.com/AhBiYout-all/ClassroomVisualizer)
- **공식 블로그**: [https://ahbiyoutvibe.blogspot.com/](https://ahbiyoutvibe.blogspot.com/)
- **소속**: [CISNet (http://www.cisnet.co.kr/)](http://www.cisnet.co.kr/)
- **라이선스**: MIT License
