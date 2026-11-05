# 📷 아비캠뷰어 (AhBiCamViewer)

[![Release](https://img.shields.io/badge/release-v1.4.7-blue.svg)](https://github.com/AhBiYout-all/ClassroomVisualizer/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE.en.md)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Web%20%7C%20Desktop-orange.svg)](ARCHITECTURE.md)
[![Build](https://img.shields.io/badge/build-Inno%20Setup%206%20%7C%20Node%2022%20LTS-brightgreen.svg)](BUILD.md)
[![Native Core](https://img.shields.io/badge/native%20APIs-15%20Exports%20(100%25%20Pass)-purple.svg)](NATIVE_DLL_ARCHITECTURE.md)

> **공용 및 교실 환경을 위한 강력한 무설치 웹 & 데스크톱 실물화상기 소프트웨어**  
> 현재 버전: **v1.4.7** | 개발자: **AhBiYout** | 깃허브: **AhBiYout-all** | 소속: **CISNet**

---

## 📌 주요 특징 (v1.4.7)

1. **📐 7대 기하 도형 & 텍스트 주석 자유 이동 및 4중 무손실 벡터 합성 (New in v1.4.7)**:
   - 직선, 사각형, 원, 삼각형, 화살표, 별표 등 7대 기하 도형 및 텍스트 카드 드래그 앤 드롭 이동 (Pointer Capture Drag Engine).
   - 호버 시 핀 고정(📌) 및 개별 삭제(✕), 캡처·녹화·PDF·돋보기 4중 무손실 벡터 자동 합성.
2. **초고해상도 실물화상기 & 웹캠 지원**: ⭐ 최고화질(Native Max) 자동 탐색, 4K UHD, 8MP 문서전용, QHD 2K, FHD 1080p 지원 및 실시간 해상도 티어 컬러 뱃지.
3. **지능형 카메라 3대 유형 감지 & 상세정보 진단**:
   - **실물화상기(★)**(IPEVO, Aver 등), **외장 웹캠(🎥)**(Logitech 등), **노트북 내장(💻)** 지능형 분류 및 우선 정렬.
   - **`[🔍 상세정보]` 진단 모달**: 실제 해상도/FPS/종횡비, 줌/초점/노출/조명 UVC 하드웨어 제어 기능, 전체 장치 목록 및 원클릭 클립보드 복사.
4. **🛡️ 가상 카메라 화면 무한 복제(Droste Effect) 원천 차단**:
   - OBS Virtual Camera, screen-recorder-device 등 가상 카메라 식별 및 자동 연결 배제, 물리 카메라 부재 시에도 안정적 대기 화면 유지.
5. **⚡ 순수 창작 Win32 Native DLL 15종 API 완성 (`ClassroomVisualizerCore.dll`, v1.4.7)**:
   - 하드웨어 비프음(수업 타이머 스로틀링 면역), 디스크 잔여 용량 사전 진단, 주 모니터 DPI 자동 감지, 항상 위 창 고정(PIP), QPC 마이크로초 타이머 탑재.
   - 15개 전수 네이티브 함수에 예외 차단 쉴드 탑재로 포인터 오작동 호스트 크래시 0% 달성 (테스트 15/15 PASS).
5. **카메라 반복 권한 허용 팝업 원천 차단**:
   - 단독 런처 격리 프로필 구성으로 바로가기 실행 시 팝업 0회.
   - 비디오 트랙 인플레이스 해상도 변경(`track.applyConstraints`), 부드러운 스트림 인계(Smooth Handoff)로 끊김 없는 조작.
6. **🖥️ 듀얼 모니터 원클릭 점프 이동 (`#jumpMonitor`)**:
   - Multi-Screen Window Placement API 기반으로 버튼 클릭 한 번에 모니터 1과 모니터 2 사이를 즉시 점프 이동.
7. **📌 좌측/하단 툴바 원터치 고정핀(Pin/Unpin) & 아코디언 자동 수축**:
   - 고정 해제 시 화면 가장자리로 얇게 슬라이드 수축되어 넓은 판서 공간을 확보하며, 마우스 호버 시 부드러운 서랍 전개 (`localStorage` 설정 기억).
8. **🖥️ 전체화면 선택 시 메뉴 고정 풀림 (Clean Viewport)**:
   - 전체화면 진입 시 메뉴 고정핀을 자동으로 해제하여 100% 꽉 찬 대화면 제공, 종료 시 이전 고정 상태로 자동 복원.
9. **📸 클린 캡처 & 🎥 고화질 복합 동영상 녹화 엔진 (0KB 결함 해결)**:
   - **클린 캡처**: 메뉴 툴바와 드롭다운을 100% 배제하고 카메라 영상 + 판서만 고화질 JPG 저장 (단축키 `S`).
   - **고화질 복합 녹화 (MP4 / WebM 30 FPS)**: 카메라 영상과 실시간 판서(`draw`)를 실시간 합성 녹화. 0KB 비정상 저장 문제 완전 해결.
10. **🔎 돋보기(확대경) & 💡 스포트라이트 마우스 휠 조절**:
    - 돋보기 캔버스 복합 렌더러로 영상 + 판서 동시 확대, 마우스 휠 렌즈 반경(60~240px) 및 `Shift+휠` 줌 배율(1.5~5.0x) 조절.
    - 스포트라이트 마우스 휠 조명 반경(50~350px) 조절.
11. **🖍️ 4대 펜 촉 디자인 & 형광펜 전용 독립 6색 팔레트**:
    - 둥근 촉, 캘리 촉, 사각 촉, 형광펜 촉 및 실시간 촉 프리뷰 탑재. 도구별 1-클릭 전용 플라이아웃 메뉴 제공.
12. **📦 Unpacked Multi-File 인스톨러 & 방화벽 사전 등록**:
    - Inno Setup 6 기반 폴더 풀림 개별 파일 설치, 구버전 감지 시 덮어쓰기 확인 대화상자, 무인 설치(`/SILENT`) 지원.
    - 윈도우 방화벽 규칙 사전 조용히 등록 및 삭제 시 완전 정리.
13. **🔔 실시간 GitHub Releases 자동 업데이트 알림 시스템**:
    - 새 릴리스 배포 시 앱 시작 시 버전 정보와 원클릭 업데이트 알림 팝업 자동 실행.

---

## 🔗 제작자 및 공식 채널 안내

- **개발자**: AhBiYout
- **GitHub 저장소**: [https://github.com/AhBiYout-all/ClassroomVisualizer](https://github.com/AhBiYout-all/ClassroomVisualizer)
- **GitHub 조직**: [https://github.com/AhBiYout-all](https://github.com/AhBiYout-all)
- **공식 구글 블로그**: [https://ahbiyoutvibe.blogspot.com/](https://ahbiyoutvibe.blogspot.com/)
- **소속**: [CISNet (https://www.cisnet.co.kr)](https://www.cisnet.co.kr)
- **라이선스**: MIT License
