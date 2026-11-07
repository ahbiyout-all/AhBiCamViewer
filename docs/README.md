# 📷 아비캠뷰어 (AhBiCamViewer)

[![Release](https://img.shields.io/badge/release-v1.4.8-blue.svg)](https://github.com/AhBiYout-all/AhBiCamViewer/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE.en.md)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Web%20%7C%20Desktop-orange.svg)](ARCHITECTURE.md)
[![Build](https://img.shields.io/badge/build-Inno%20Setup%206%20%7C%20Node%2022%20LTS-brightgreen.svg)](BUILD.md)
[![Native Core](https://img.shields.io/badge/native%20APIs-15%20Exports%20(100%25%20Pass)-purple.svg)](NATIVE_DLL_ARCHITECTURE.md)

> **공용 및 교실 환경을 위한 강력한 무설치 웹 & 데스크톱 실물화상기 소프트웨어**  
> 현재 버전: **v1.4.8** | 개발자: **AhBiYout** | 깃허브: **AhBiYout-all**

---

## 📌 주요 특징 (v1.4.8)

1. **🎙️ 수업 녹화 마이크 음성 실시간 합성 (New in v1.4.8)**:
   - 교실 수업 녹화 시 카메라 영상과 실시간 판서에 더해 **선생님의 설명 목소리(마이크 오디오 트랙)**를 자동 합성하여 MP4/WebM 고음질 강의 비디오로 저장.
   - 마이크 미연결 시 영상 전용 녹화로 안전 자동 전환되며 녹화 종료 시 하드웨어 리소스 즉시 반환.
2. **🎨 도형 내부 독립 채우기 색상(Fill Color) 엔진 (New in v1.4.8)**:
   - 테두리 선 색상과 분리된 도형 내부 전용 색상 팔레트(7색 및 커스텀 컬러 피커) 제공.
   - 채우기 모드(OFF, 25%, 50%, 100%)와 결합하여 반투명 형광 채우기 및 완전 채우기를 자유롭게 지정.
3. **🖥️ 듀얼 모니터 무팝업 점프 & 권한 허용창 원천 차단 (New in v1.4.8)**:
   - 모니터 1 ↔ 모니터 2 이동 시 브라우저 권한 허용 팝업을 사전에 차단하고 윈도우 좌표 계산(`moveTo`)으로 부드럽게 점프.
4. **👁️ 전체화면 카메라 정보 자동 숨김 및 ON/OFF 토글 (New in v1.4.8)**:
   - 전체화면 진입 시 좌측 상단 카메라 해상도 배지가 자동으로 은폐되어 시야 간섭 원천 배제.
   - 하단 툴바 및 상단 헤더의 `ℹ️ 정보 ON/OFF` 토글 버튼을 통해 평상시에도 원클릭으로 켜고 끄기 지원 (`localStorage` 보존).
5. **🔄 좌측 판서 도구 클릭 시 활성/비활성(일반 커서) 토글 (New in v1.4.8)**:
   - 이미 활성화된 판서 도구(펜, 마커, 지우개, 레이저, 도형, 텍스트)를 다시 클릭하면 즉시 비활성화되어 일반 마우스 커서 모드로 전환.
   - 텍스트 주석과 도형 도구 간의 상호 배타적 선택을 보장하여 동시 선택 결함 완전 해결.
6. **📐 7대 기하 도형 & 텍스트 주석 자유 이동 및 4중 무손실 벡터 합성**:
   - 직선, 사각형, 원, 삼각형, 화살표, 양방향, 별표 등 7대 기하 도형 및 텍스트 카드 드래그 앤 드롭 이동 (Pointer Capture Drag Engine).
   - 호버 시 핀 고정(📌) 및 개별 삭제(✕), 캡처·녹화·PDF·돋보기 4중 무손실 벡터 자동 합성.
7. **초고해상도 실물화상기 & 웹캠 지원**: ⭐ 최고화질(Native Max) 자동 탐색, 4K UHD, 8MP 문서전용, QHD 2K, FHD 1080p 지원 및 실시간 해상도 티어 컬러 뱃지.
8. **지능형 카메라 3대 유형 감지 & 상세정보 진단**:
   - **실물화상기(★)**(IPEVO, Aver 등), **외장 웹캠(🎥)**(Logitech 등), **노트북 내장(💻)** 지능형 분류 및 우선 정렬.
   - **`[🔍 상세정보]` 진단 모달**: 실제 해상도/FPS/종횡비, 줌/초점/노출/조명 UVC 하드웨어 제어 기능, 전체 장치 목록 및 원클릭 클립보드 복사.
9. **🛡️ 가상 카메라 화면 무한 복제(Droste Effect) 원천 차단**:
   - OBS Virtual Camera, screen-recorder-device 등 가상 카메라 식별 및 자동 연결 배제, 물리 카메라 부재 시에도 안정적 대기 화면 유지.
10. **⚡ 순수 창작 Win32 Native DLL 15종 API 완성 (`AhBiCamViewerCore.dll`, v1.4.8)**:
    - 하드웨어 비프음(수업 타이머 스로틀링 면역), 디스크 잔여 용량 사전 진단, 주 모니터 DPI 자동 감지, 항상 위 창 고정(PIP), QPC 마이크로초 타이머 탑재.
    - 15개 전수 네이티브 함수에 예외 차단 쉴드 탑재로 포인터 오작동 호스트 크래시 0% 달성 (테스트 15/15 PASS).
11. **📌 좌측/하단 툴바 원터치 고정핀(Pin/Unpin) & 가로 아코디언 접이식 시스템**:
    - 고정 해제 시 화면 가장자리로 얇게 슬라이드 수축되어 넓은 판서 공간을 확보하며, 마우스 호버 시 부드러운 서랍 전개 (`localStorage` 설정 기억).
12. **📦 Unpacked Multi-File 인스톨러 & 6단계 설치 시퀀스**:
    - 실행 중인 기존 앱 감지 및 사전 안내 팝업 종료, 이전 버전 완전 삭제/덮어쓰기 분기, 한글 MIT 라이선스 동의, 바탕화면 바로가기 기본 체크, 설치 후 즉시 실행.
13. **🔔 실시간 GitHub Releases 자동 업데이트 알림 시스템**:
    - 새 릴리스 배포 시 앱 시작 시 버전 정보와 원클릭 업데이트 알림 팝업 자동 실행.

---

## 🔗 [제작자 및 공식 채널 안내]

- **개발자**: AhBiYout
- **GitHub 저장소**: https://github.com/AhBiYout-all
- **공식 구글 블로그**: https://ahbiyoutvibe.blogspot.com/
- **앱 저장소**: https://github.com/AhBiYout-all/AhBiCamViewer
- **라이선스**: MIT License
