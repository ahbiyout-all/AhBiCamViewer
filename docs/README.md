# 📷 아비캠뷰어 (AhBiCamViewer)

> **공용 및 교실 환경을 위한 강력한 무설치 웹 & 데스크톱 실물화상기 소프트웨어**  
> 현재 버전: **v1.4.0** | 개발자: **AhBiYout (AhBiYout-all)**

---

## 📌 주요 특징 (v1.4.0)

1. **초고해상도 실물화상기 & 웹캠 지원**: ⭐ 최고화질(Native Max) 자동 탐색, 4K UHD, 8MP 문서전용, QHD 2K, FHD 1080p 지원 및 실시간 해상도 티어 컬러 뱃지.
2. **지능형 카메라 3대 유형 감지 & 상세정보 진단**:
   - **실물화상기(★)**(IPEVO, Aver 등), **외장 웹캠(🎥)**(Logitech 등), **노트북 내장(💻)** 지능형 분류 및 우선 정렬.
   - **`[🔍 상세정보]` 진단 모달**: 실제 해상도/FPS/종횡비, 줌/초점/노출/조명 UVC 하드웨어 제어 기능, 전체 장치 목록 및 원클릭 클립보드 복사.
3. **카메라 반복 권한 허용 팝업 원천 차단**:
   - 단독 런처 자동 승인 플래그(`--use-fake-ui-for-media-stream`) 탑재로 바로가기 실행 시 팝업 0회.
   - 비디오 트랙 인플레이스 해상도 변경(`track.applyConstraints`), 부드러운 스트림 인계(Smooth Handoff)로 끊김 없는 조작.
4. **🖥️ 듀얼 모니터 원클릭 점프 이동 (`#jumpMonitor`)**:
   - Multi-Screen Window Placement API 기반으로 버튼 클릭 한 번에 모니터 1과 모니터 2 사이를 즉시 점프 이동.
5. **📌 좌측/하단 툴바 원터치 고정핀(Pin/Unpin) & 아코디언 자동 수축**:
   - 고정 해제 시 화면 가장자리로 얇게 슬라이드 수축되어 넓은 판서 공간을 확보하며, 마우스 호버 시 부드러운 서랍 전개 (`localStorage` 설정 기억).
6. **🖥️ 전체화면 선택 시 메뉴 고정 풀림 (Clean Viewport)**:
   - 전체화면 진입 시 메뉴 고정핀을 자동으로 해제하여 100% 꽉 찬 대화면 제공, 종료 시 이전 고정 상태로 자동 복원.
7. **📸 클린 캡처 & 🎥 고화질 복합 동영상 녹화 엔진**:
   - **클린 캡처**: 메뉴 툴바와 드롭다운을 100% 배제하고 카메라 영상 + 판서만 고화질 JPG 저장 (단축키 `S`).
   - **고화질 복합 녹화 (WebM 30 FPS)**: 카메라 영상과 실시간 판서(`draw`)를 실시간 합성 녹화. 메뉴/버튼은 일체 제외되며 `[🔴 REC 00:00]` 인디케이터 표시.
8. **🔎 돋보기(확대경) & 💡 스포트라이트 마우스 휠 조절**:
   - 돋보기 캔버스 복합 렌더러로 영상 + 판서 동시 확대, 마우스 휠 렌즈 반경(60~240px) 및 `Shift+휠` 줌 배율(1.5~5.0x) 조절.
   - 스포트라이트 마우스 휠 조명 반경(50~350px) 조절.
9. **🖍️ 형광펜 전용 독립 6색 팔레트**:
   - 일반 펜과 형광펜의 색상이 독립적으로 분리 기억되어 도구 전환 시 즉시 필기 가능 (6대 형광 컬러 + 커스텀 피커).
10. **풍부한 판서 & 수업 도구**:
    - 부드러운 베지어 곡선 필기, 감압 필압 지원, 기하 도형(직선/사각형/원/삼각형/화살표/별표) 및 반투명 채우기, T 텍스트 카드, Undo/Redo(Ctrl+Z/Y).
    - 수업 타이머/스톱워치, 3종 격자, 레이저 포인터, 가림막, 집중 벨 효과음, 캡처본 2장 비교 모드.
11. **네이티브 Win32 DLL & Pro 티어 라이선스 시스템**:
    - C#/IL 하이브리드 순수 Win32 stdcall DLL(`ClassroomVisualizerCore.dll`) 탑재, 오프라인 정품 키 및 30일 무료 체험(Trial) 라이선스 지원.
12. **스탠드얼론 독립형 웹뷰 런처**:
    - Microsoft Edge / Chrome 기반 주소창 없는 깔끔한 단독 앱 창 모드 구동.

---

## 📂 디렉터리 구조

```
교실용_실물화상기/
├── index.html                           # 주 실행 단일 파일 애플리케이션
├── 아비캠뷰어_(AhBiCamViewer).html        # 정식 명칭 동기화 파일
├── (AhBiYout)_공용_실물화상기_보기.html     # 레거시 호환 동기화 파일
├── 교실용_실물화상기.html                 # 기본 호환 동기화 파일
├── version.json                         # 시맨틱 버전 및 저장소 메타데이터
├── build.bat                            # DLL 빌드, Inno Setup 인스톨러 및 ZIP 자동 빌드 (CRLF)
├── git-release.bat                      # GitHub 자동 커밋 & 릴리즈 태그 배포 스크립트
├── installer.iss                        # Inno Setup 다중 파일 패키징 & 바로가기 스크립트
├── launcher.vbs                         # 루트 단독 실행 VBS 런처 (권한 자동 우회 플래그)
├── assets/                              # 고해상도 앱 아이콘
│   ├── app.ico
│   ├── icon.png
│   └── icon.svg
├── bin/                                 # 컴파일된 네이티브 및 관리 DLL 바이너리
│   ├── ClassroomVisualizerCore.dll
│   └── ClassroomVisualizerManaged.dll
├── src/                                 # 소스 코드
│   └── dll/                             # C# 및 IL DLL 소스
│       ├── ClassroomVisualizerCore.il
│       └── ClassroomVisualizerManaged.cs
├── tools/                               # 빌드 및 실행 보조 도구
│   ├── launcher.vbs                     # 독립 실행 VBS 런처
│   ├── AhBiCamViewer.bat                # 정식 명칭 배치 런처
│   ├── ClassroomVisualizer.bat          # 기본 배치 런처
│   ├── build_dll.bat                    # ilasm 기반 DLL 빌더
│   └── format_crlf.ps1                  # 배치 파일 CRLF 강제 포맷터
├── docs/                                # 기술 문서 모음
│   ├── PATCHNOTES.md                    # 시맨틱 버저닝 릴리즈 패치노트
│   ├── WORK_LOG.md                      # 작업 수행 일지
│   ├── ARCHITECTURE.md                  # 시스템 아키텍처 명세서
│   ├── MODULES.md                       # 서브시스템 모듈 명세서
│   ├── NATIVE_DLL_ARCHITECTURE.md       # Win32 DLL 아키텍처 분석
│   ├── ROADMAP.md                       # 구현 로드맵
│   ├── BUILD.md                         # 빌드 및 패키징 가이드
│   ├── INSTALL.md                       # 설치 및 배포 안내서
│   ├── SECURITY.md                      # 보안 감사 및 취약점 검토
│   ├── BLOG_POST.md                     # 공식 배포 블로그 서식
│   └── README.md                        # 본 안내서
└── .github/
    └── workflows/
        └── build-and-release.yml        # GitHub Actions CI/CD 파이프라인
```

---

## 🛠 빌드 및 배포 방법

1. `build.bat` 실행 시:
   - IL / C# 소스를 컴파일하여 `bin/ClassroomVisualizerCore.dll` 바이너리를 생성합니다.
   - Inno Setup 컴파일러를 통해 `dist/아비캠뷰어 (AhBiCamViewer)_Setup_v1.4.0.exe` 인스톨러를 빌드합니다.
   - 포터블 압축 패키지 `dist/AhBiCamViewer_Portable_v1.4.0.zip`을 빌드합니다.
   - 버전별 격리 폴더 `dist/1.4.0/`에 산출물을 동기화 복사합니다.
2. Inno Setup 설치 시:
   - 개별 파일 풀림(Unpacked Multi-File) 설치
   - 바탕화면 및 시작 메뉴에 단독 실행형 바로가기(`launcher.vbs`) 자동 등록
   - 무인 설치(`/SILENT`, `/VERYSILENT`) 완벽 지원
3. `git-release.bat` 실행 시 변경사항을 안전하게 커밋하고 태그를 생성하여 GitHub Releases로 배포합니다.

---

## 🔗 제작자 및 공식 채널

- **개발자**: AhBiYout
- **GitHub 저장소**: https://github.com/AhBiYout-all
- **공식 구글 블로그**: https://ahbiyoutvibe.blogspot.com/
- **소속**: https://www.cisnet.co.kr
