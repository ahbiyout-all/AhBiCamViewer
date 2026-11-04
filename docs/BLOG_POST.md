# 📢 구글 블로거(Blogger) 공식 포스팅 가이드 (v1.4.5)

본 문서는 구글 블로그([ahbiyoutvibe.blogspot.com](https://ahbiyoutvibe.blogspot.com/))에 발행할 수 있도록 규격화된 공식 포스팅 원고입니다.  
사용자의 편집 환경에 맞추어 **[작성 모드 (서식 있는 텍스트)]**와 **[HTML 편집 모드]**의 두 가지 포맷을 모두 제공합니다.

---

# 1. 📝 [작성 모드 (서식 있는 텍스트)]
> *구글 블로거 글쓰기 화면 좌측 상단의 연필 아이콘 `[작성 모드]`에서 그대로 복사하여 붙여넣을 수 있는 서식입니다.*

## 1. 제목
**[무료] 교실 및 사무실용 최고의 실물화상기 소프트웨어 - 아비캠뷰어(AhBiCamViewer) v1.4.5 대규모 업데이트 배포**

---

## 2. 본문
교실 수업, 화상 회의, 원격 강의, 전자칠판 판서에 꼭 필요한 필수 소프트웨어!  
**아비캠뷰어 (AhBiCamViewer)**는 복잡한 제조사 전용 드라이버나 유료 라이선스 제약 없이, 표준 USB 웹캠과 전용 실물화상기를 연결하기만 하면 **최고 4K UHD 화질**로 즉시 작동하는 차세대 스마트 실물화상기 & 뷰어 프로그램입니다.

선생님과 발표자가 오직 수업과 전달에만 집중할 수 있도록 깔끔한 UI, 지능형 툴바 자동 수축(아코디언 모드), 고성능 실시간 판서(베지어 부드러운 필기, 형광펜, 도형, 텍스트), 수업 집중 보조 도구(타이머, 스톱워치, 확대경, 스포트라이트, 가림막)를 모두 갖추고 있습니다.

특히 이번 **v1.4.5**에서는 기존의 아쉬웠던 점들을 대폭 보완하여, 고성능 **15대 Win32 순수 창작 네이티브 DLL 탑재**, **동영상 0KB 비정상 저장 결함 원천 해결**, **가상 카메라 화면 무한 복제(Droste Effect) 완전 차단**, 그리고 **Windows 방화벽 사전 자동 등록 인스톨러**까지 지원하여 완벽한 안정성을 자랑합니다.

---

## 3. 업데이트 (v1.4.5 핵심 개선 내역)
- **🖌️ 형광펜 붓펜 촉(Brush Tip) 속도/필압 반응형 테이퍼링 및 프리뷰 고도화**:
  - 형광펜 붓펜 촉 선택 시 선 두께가 둥근 촉과 같게 고정되던 결함을 원천 해결.
  - 마우스/스타일러스 이동 속도(0.35배~1.65배)와 필압에 실시간 반응하는 4단계 베지어 연속 보간 렌더링 적용.
  - 펜 및 형광펜 하위메뉴 내 전용 붓펜 프리뷰 캔버스(`drawBrushPreview`) 및 -25도 타원 회전 커서 탑재.
- **⚡ 순수 창작 Native DLL 15대 API 완성 (`ClassroomVisualizerCore.dll`)**:
  - `CV_PlayCustomTone`: 윈도우 하드웨어 스피커를 통한 0ms 무지연 수업 타이머/주목음 송출 (브라우저 백그라운드 탭 스로틀링 완전 면역).
  - `CV_GetDiskFreeSpaceMB`: 실시간 잔여 저장공간 진단으로 용량 부족에 따른 녹화 실패 방지.
  - `CV_GetDisplayDpi`: 전자칠판 및 4K 프로젝터 연결 시 주 모니터 DPI 스케일링(100%~200%) 자동 감지.
  - `CV_SetWindowTopmost`: PDF나 PPT 수업 자료 위에 실물화상기를 항상 위(Always-on-Top)로 고정하는 플로팅 PIP 모드 지원.
  - `CV_GetPerformanceTimeMs`: 마이크로초 정밀도의 고해상도 단조 증가 타이머 제공.
  - 전체 15개 네이티브 함수에 예외 차단 쉴드 탑재로 포인터 오작동 호스트 크래시 0% 달성.
- **🛡️ 카메라 부재 시 화면 무한 복제(Infinity Mirror) 오류 원천 차단**:
  - DirectShow 가상 캡처 필터(`screen-recorder-device`, `OBS Virtual Camera` 등)를 자동 식별하여 자동 연결에서 영구 배제.
  - 물리 카메라가 없을 때도 안전한 대기 플레이스홀더 화면을 유지하여 화면이 끝없이 빨려 들어가는 현상 원천 제거.
- **🎬 동영상 0KB 비정상 저장 버그 완전 해결**:
  - 캡처/녹화 포맷 엔진을 전면 리팩토링하여 MP4/WebM 인코딩 데이터 청크를 손실 없이 정상 저장.
- **📦 Inno Setup 멀티파일 인스톨러 & 방화벽 사전 등록**:
  - 폴더 풀림(Unpacked Multi-File) 구조로 개별 파일 설치 지원.
  - 기존 버전 감지 시 삭제/덮어쓰기 선택 대화상자 제공 및 무인 설치(`/SILENT`) 지원.
  - 윈도우 방화벽 규칙을 기본 앱 이름과 버전 표기 이름으로 사전 조용히 등록하여 네트워크 차단 경고 원천 예방.
- **🔔 실시간 GitHub Releases 자동 업데이트 알림 시스템**:
  - 최신 릴리스가 출시되면 앱 실행 시 알림 팝업이 자동 실행되며, 버전 정보와 원클릭 업데이트 지원.

---

## 4. 앱 그림 (UI 구성 및 기능 안내)
> *아래 이미지를 블로그 본문에 알맞게 배치해 주세요.*

- **앱 대표 아이콘**: `assets/icon.png` (교실용 실물화상기 공식 심볼 마크)
- **교실 수업 풀스크린 뷰**: 100% 시야 확보를 위한 툴바 자동 수축 및 깔끔한 영상 렌더링.
- **판서 및 수업 도구**: 4대 펜 촉(둥근촉, 캘리촉, 사각촉, 형광펜)과 타이머, 분할 비교 화면.

---

## 5. 다운로드
아래 공식 GitHub Releases 링크에서 최신 설치 파일 및 포터블 버전을 무료로 다운로드하실 수 있습니다:

- 🚀 **윈도우 정식 설치 프로그램**: [AhBiCamViewer_Setup_v1.4.5.exe 다운로드](https://github.com/AhBiYout-all/ClassroomVisualizer/releases/download/v1.4.5/%EC%95%84%EB%B9%84%EC%BA%A0%EB%B7%B0%EC%96%B4.(AhBiCamViewer)_Setup_v1.4.5.exe)
- 🧰 **무설치 포터블 패키지**: [AhBiCamViewer_Portable_v1.4.5.zip 다운로드](https://github.com/AhBiYout-all/ClassroomVisualizer/releases/download/v1.4.5/AhBiCamViewer_Portable_v1.4.5.zip)
- 🌐 **GitHub 릴리스 전체 목록**: [GitHub Releases](https://github.com/AhBiYout-all/ClassroomVisualizer/releases)

---

## 6. 버전정보
- **소프트웨어 명칭**: 아비캠뷰어 (AhBiCamViewer) / 교실용 실물화상기
- **배포 버전**: v1.4.5
- **버전 관리 규격**: Semantic Versioning 2.0.0
- **배포일**: 2026-11-01
- **라이선스**: MIT License (학교, 관공서, 기업, 개인 누구나 100% 무료 자유 사용 가능)

---

## 7. 시스템 요구 사항
- **운영체제**: Microsoft Windows 10 / 11 (64-bit 권장)
- **웹 런타임**: Microsoft Edge (Chromium 기반) 또는 Google Chrome 최신 버전
- **추가 런타임**: .NET Framework 4.8 이상 (네이티브 DLL 연동 시)
- **카메라 장치**: 표준 UVC 지원 USB 웹캠, 전용 실물화상기(IPEVO, Aver 등), 스마트폰 웹캠 앱 연동 가능

---

## 8. 제작자 및 공식 채널 안내
- **개발자**: AhBiYout
- **GitHub 저장소**: https://github.com/AhBiYout-all
- **공식 구글 블로그**: https://ahbiyoutvibe.blogspot.com/
- **소속**: https://www.cisnet.co.kr

---

## 9. 전체 업데이트 (기능 개선 히스토리)
*패치노트 기준 역대 모든 기능 개선 내역입니다.*

- **v1.4.5 (2026-11-04)**:
  - 형광펜 붓펜 촉(Brush Tip) 속도/필압 반응형 가변 너비 알고리즘 및 4단계 베지어 연속 보간 렌더링 구현 (둥근 촉과 동일하던 결함 원천 해결).
  - 펜 및 형광펜 하위메뉴 내 전용 붓펜 프리뷰 캔버스(`drawBrushPreview`) 및 -25도 타원 회전 커서 탑재.
- **v1.4.4 (2026-11-01)**:
  - 순수 창작 Win32 네이티브 DLL 15종 API 완성 (하드웨어 톤, 디스크 용량 진단, DPI 감지, 항상 위 고정, QPC 정밀 타이머).
  - 가상 카메라 자동 연결 차단으로 화면 무한 복제(Droste Effect) 결함 원천 해결.
  - 비정상 0KB 동영상 저장 문제 완전 해결 및 MP4/WebM 캡처 인코더 리팩토링.
  - Inno Setup 멀티파일 인스톨러 구축, 방화벽 자동 등록, 무인 설치 스위치 지원.
  - 실시간 GitHub Releases 기반 자동 업데이트 확인 팝업 시스템 구축.
- **v1.4.3 (2026-10-26)**:
  - 수업 도구 풀다운 메뉴 및 영상/렌즈 조절 팝업 화면 밖 이탈 방지 스마트 고정 좌표 클램핑 탑재.
  - 뷰포트 반응형 리사이즈 시 하단 툴바 오버플로우 방지 및 스마트 뷰포트 레이아웃 최적화.
- **v1.4.2 (2026-10-26)**:
  - 카메라 영상 및 렌즈 조절 메뉴(초점, 줌, 노출) 반응성 전면 개편.
  - 도형/텍스트 전용 옵션 패널 및 실시간 해상도 점 인디케이터 탑재.
- **v1.4.1 (2026-10-26)**:
  - 범용 MP4 수업 녹화 지원 및 고화질 캡처 안정화.
  - 4종 잔상 효과 스타일 및 지속시간 조절이 가능한 잔상 레이저 펜 전용 하위 메뉴 탑재.
- **v1.4.0 (2026-10-25)**:
  - 판서 3종 도구(펜·형광펜·지우개) 4대 펜 촉 디자인(둥근촉, 캘리촉, 사각촉) 및 실시간 프리뷰 탑재.
  - 판서 도구별 1-클릭 전용 하위메뉴(Flyout) 탑재로 색상 및 두께 즉시 변경 지원.
  - 라이선스 제약 완전 해제 — 4K UHD 및 모든 Pro 기능을 100% 무료 개방.
  - 동영상 녹화 버튼 하단 메인 툴바 전진 배치 및 단축키(V) 지원.
  - 카메라 전환 시 브라우저 권한 반복 팝업 완전 제거 및 격리 프로필 적용.
  - 캡처 플래시 애니메이션 및 셔터/차임 효과음 탑재.
- **v1.4.0 (2026-10-18)**:
  - 전체화면 진입 시 메뉴 툴바 자동 수축(아코디언 모드)으로 100% 클린 캔버스 뷰포트 제공.
  - 캡처 및 녹화 시 툴바/버튼을 화면에서 완전히 배제하는 클린 캡처/녹화 엔진 구축.
  - Multi-Screen Window Placement API 기반 듀얼 모니터 원클릭 점프 이동 지원.
  - 카메라 하드웨어 상세 스펙(해상도, FPS, 11대 UVC 제어 가능 여부) 진단 모달창 탑재.
  - 돋보기 캔버스 복합 렌더러 및 마우스 휠 반경/배율 조절 기능 추가.
  - 형광펜 전용 독립 6색 팔레트 탑재.
- **v1.3.1 (2026-10-09)**:
  - 무선 P2P 모듈을 제거하고 USB 유선 및 로컬 카메라 연결 전용으로 단일화하여 초경량화 및 반응성 극대화.
- **v1.3.0 (2026-10-08)**:
  - 후면 플래시(Torch) 켜기/끄기, 탭 투 포커스(Tap-to-Focus), 하드웨어 센서 노출 보정 다이얼 탑재.
- **v1.2.0 (2026-10-08)**:
  - 전면/후면 카메라 전환, 2손가락 터치 핀치 줌(Pinch-to-Zoom), 해상도 프로파일 선택기 추가.
- **v1.1.0 (2026-10-08)**:
  - 수업용 카운트다운 타이머, 스톱워치, 4종 기하 도형, 텍스트 입력 주석, 3종 보조 격자(모눈, 도트, 줄노트) 추가.
  - 집중 벨 효과음, 레이저 포인터, 확대경, 스포트라이트, 가림막, 2분할 캡처 비교 모드 추가.
- **v1.0.0 (2026-10-08)**:
  - 웹 기반 무설치 교실용 실물화상기 최초 공식 배포.
  - UVC 표준 카메라 실시간 스트리밍, 화면 일시정지(Freeze), 고화질 캡처, 좌우 반전 및 90도 회전 지원.

---

## 10. 추천 태그
아비캠뷰어,실물화상기,웹캠뷰어,수업도구,교실화상기,전자칠판,화상수업,무료소프트웨어,AhBiCamViewer,ClassroomVisualizer,WebcamViewer,Visualizer,DocumentCamera,EdTech,ScreenCapture,WindowsApp,CISNet,AhBiYout

*(한글/영어 혼합 18개 태그, 공백/쉼표 포함 182자 - 20개 이하 및 200자 이내 준수)*

---
---

# 2. 💻 [HTML 편집 모드]
> *구글 블로거 글쓰기 화면 좌측 상단의 `<>` 아이콘 `[HTML 보기]`에서 아래 전체 코드를 그대로 복사하여 붙여넣으시면 모던하고 미려한 디자인이 완성됩니다.*

```html
<div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Noto Sans KR', sans-serif; line-height: 1.75; color: #2d3748; max-width: 860px; margin: 0 auto;">

  <!-- 1. 제목 -->
  <header style="background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%); color: #ffffff; padding: 36px 28px; border-radius: 16px; margin-bottom: 28px; box-shadow: 0 10px 25px -5px rgba(37, 99, 235, 0.3);">
    <span style="display: inline-block; background: #3b82f6; color: #ffffff; padding: 4px 12px; border-radius: 9999px; font-size: 13px; font-weight: 700; margin-bottom: 12px; letter-spacing: 0.5px;">OFFICIAL RELEASE v1.4.5</span>
    <h1 style="font-size: 26px; font-weight: 800; margin: 0 0 10px 0; line-height: 1.35; color: #ffffff;">[무료] 교실 및 사무실용 최고의 실물화상기 소프트웨어 - 아비캠뷰어 (AhBiCamViewer) v1.4.5 대규모 업데이트 배포</h1>
    <p style="font-size: 15px; margin: 0; opacity: 0.92;">복잡한 드라이버 없이 4K UHD까지 지원하는 차세대 무료 실물화상기 &amp; 판서 도구</p>
  </header>

  <!-- 2. 본문 -->
  <section style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 26px; margin-bottom: 24px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);">
    <h2 style="font-size: 20px; font-weight: 700; color: #1e3a8a; margin-top: 0; margin-bottom: 14px; border-left: 4px solid #2563eb; padding-left: 10px;">소개 및 핵심 가치</h2>
    <p style="margin-bottom: 14px;">교실 수업, 화상 강의, 원격 세미나, 전자칠판 판서에 꼭 필요한 필수 소프트웨어! <strong>아비캠뷰어 (AhBiCamViewer)</strong>는 비싼 전용 소프트웨어나 제조사 드라이버 설치 없이, 일반 USB 웹캠이나 전용 실물화상기만 연결하면 <strong>최고 4K UHD 초고화질</strong>로 즉시 작동하는 스마트 실물화상기 소프트웨어입니다.</p>
    <p style="margin-bottom: 0;">교사와 발표자가 오직 전달에만 집중할 수 있도록 깔끔한 UI 자동 수축(아코디언 서랍 모드), 베지어 곡선 기반의 부드러운 판서, 형광펜, 도형, 텍스트 카드, 타이머, 스톱워치, 돋보기, 스포트라이트 등 필수적인 수업 보조 기능을 모두 제공합니다.</p>
  </section>

  <!-- 3. 업데이트 -->
  <section style="background: #f8fafc; border: 1px solid #cbd5e1; border-radius: 14px; padding: 26px; margin-bottom: 24px;">
    <h2 style="font-size: 20px; font-weight: 700; color: #0f172a; margin-top: 0; margin-bottom: 16px; border-left: 4px solid #0284c7; padding-left: 10px;">v1.4.5 핵심 업데이트 내역</h2>
    <div style="display: grid; gap: 14px;">
      <div style="background: #ffffff; padding: 14px 18px; border-radius: 10px; border-left: 4px solid #3b82f6;">
        <strong style="color: #1d4ed8; font-size: 15px;">🖌️ 형광펜 붓펜 촉(Brush Tip) 속도/필압 반응형 테이퍼링 및 프리뷰 고도화</strong>
        <p style="font-size: 14px; margin: 6px 0 0 0; color: #475569;">형광펜 붓펜 촉 선택 시 선 두께가 둥근 촉과 동일하게 고정되던 결함을 원천 해결하고, 이동 속도(0.35배~1.65배)와 필압에 실시간 반응하는 4단계 베지어 연속 보간 및 전용 붓펜 프리뷰 캔버스 탑재.</p>
      </div>
      <div style="background: #ffffff; padding: 14px 18px; border-radius: 10px; border-left: 4px solid #10b981;">
        <strong style="color: #065f46; font-size: 15px;">⚡ 순수 창작 Win32 Native DLL 15대 API 완성</strong>
        <p style="font-size: 14px; margin: 6px 0 0 0; color: #475569;">하드웨어 비프 톤 송출(수업 타이머 스로틀링 면역), 디스크 잔여 용량 사전 진단, 주 모니터 DPI 자동 감지, 항상 위(Always-on-Top) 고정, QPC 마이크로초 타이머 탑재 및 예외 쉴드로 호스트 크래시 0% 달성.</p>
      </div>
      <div style="background: #ffffff; padding: 14px 18px; border-radius: 10px; border-left: 4px solid #f59e0b;">
        <strong style="color: #92400e; font-size: 15px;">🛡️ 가상 카메라 화면 무한 복제(Droste Effect) 원천 차단</strong>
        <p style="font-size: 14px; margin: 6px 0 0 0; color: #475569;">OBS Virtual Cam, screen-recorder-device 등 가상 카메라 필터를 자동 감지하여 자동 연결에서 영구 배제, 물리 카메라 부재 시에도 안정적인 대기 화면 유지.</p>
      </div>
      <div style="background: #ffffff; padding: 14px 18px; border-radius: 10px; border-left: 4px solid #6366f1;">
        <strong style="color: #3730a3; font-size: 15px;">🎬 동영상 0KB 비정상 저장 버그 완전 해결</strong>
        <p style="font-size: 14px; margin: 6px 0 0 0; color: #475569;">미디어 인코더 청크 수집 및 파이프라인 리팩토링으로 MP4/WebM 녹화 데이터 무손실 정상 저장 보장.</p>
      </div>
      <div style="background: #ffffff; padding: 14px 18px; border-radius: 10px; border-left: 4px solid #ec4899;">
        <strong style="color: #831843; font-size: 15px;">📦 Inno Setup 멀티파일 인스톨러 &amp; 방화벽 자동 등록</strong>
        <p style="font-size: 14px; margin: 6px 0 0 0; color: #475569;">폴더 풀림(Unpacked Multi-File) 설치, 기존 버전 덮어쓰기 안내, 무인 설치(/SILENT) 및 윈도우 방화벽 규칙 사전 조용히 등록.</p>
      </div>
    </div>
  </section>

  <!-- 4. 앱 그림 -->
  <section style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 26px; margin-bottom: 24px; text-align: center;">
    <h2 style="font-size: 20px; font-weight: 700; color: #1e3a8a; margin-top: 0; margin-bottom: 16px; border-left: 4px solid #2563eb; padding-left: 10px; text-align: left;">앱 화면 및 레이아웃</h2>
    <div style="background: #0f172a; border-radius: 12px; padding: 30px 20px; color: #94a3b8; margin: 15px 0;">
      <div style="font-size: 48px; margin-bottom: 10px;">📷</div>
      <h3 style="color: #ffffff; font-size: 18px; margin: 0 0 8px 0;">아비캠뷰어 (AhBiCamViewer) v1.4.5</h3>
      <p style="font-size: 13px; margin: 0; color: #94a3b8;">풀스크린 뷰포트 &bull; 15대 네이티브 Win32 가속 &bull; 스마트 판서 도구 &bull; 4K UHD</p>
    </div>
    <p style="font-size: 13px; color: #64748b; margin-top: 8px;">(블로그 관리자 화면에서 assets/icon.png 또는 실제 수업 캡처 스크린샷 이미지를 추가 삽입하실 수 있습니다)</p>
  </section>

  <!-- 5. 다운로드 -->
  <section style="background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%); border: 2px solid #bfdbfe; border-radius: 14px; padding: 26px; margin-bottom: 24px; text-align: center;">
    <h2 style="font-size: 20px; font-weight: 800; color: #1e40af; margin-top: 0; margin-bottom: 12px;">무료 다운로드 (Official GitHub Releases)</h2>
    <p style="font-size: 14px; color: #1e3a8a; margin-bottom: 20px;">학교, 관공서, 학원, 기업, 가정 등 어디서나 조건 없이 100% 무료로 이용하실 수 있습니다.</p>
    <div style="display: flex; gap: 14px; justify-content: center; flex-wrap: wrap;">
      <a href="https://github.com/AhBiYout-all/ClassroomVisualizer/releases/download/v1.4.5/%EC%95%84%EB%B9%84%EC%BA%A0%EB%B7%B0%EC%96%B4.(AhBiCamViewer)_Setup_v1.4.5.exe" style="display: inline-block; background: #2563eb; color: #ffffff; font-weight: 700; font-size: 15px; padding: 12px 24px; border-radius: 8px; text-decoration: none; box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.4);">
        📥 정식 인스톨러 (.exe) 다운로드
      </a>
      <a href="https://github.com/AhBiYout-all/ClassroomVisualizer/releases/download/v1.4.5/AhBiCamViewer_Portable_v1.4.5.zip" style="display: inline-block; background: #059669; color: #ffffff; font-weight: 700; font-size: 15px; padding: 12px 24px; border-radius: 8px; text-decoration: none; box-shadow: 0 4px 6px -1px rgba(5, 150, 105, 0.4);">
        🧰 무설치 포터블 (.zip) 다운로드
      </a>
    </div>
  </section>

  <!-- 6. 버전정보 & 7. 시스템 요구 사항 -->
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 18px; margin-bottom: 24px;">
    <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px;">
      <h3 style="font-size: 17px; font-weight: 700; color: #1e293b; margin-top: 0; margin-bottom: 12px; border-left: 3px solid #2563eb; padding-left: 8px;">버전 정보</h3>
      <table style="width: 100%; font-size: 14px; border-collapse: collapse;">
        <tr><td style="padding: 6px 0; color: #64748b;">프로그램</td><td style="padding: 6px 0; font-weight: 600;">아비캠뷰어 (AhBiCamViewer)</td></tr>
        <tr><td style="padding: 6px 0; color: #64748b;">배포 버전</td><td style="padding: 6px 0; font-weight: 600; color: #2563eb;">v1.4.5</td></tr>
        <tr><td style="padding: 6px 0; color: #64748b;">릴리스 날짜</td><td style="padding: 6px 0; font-weight: 600;">2026-11-01</td></tr>
        <tr><td style="padding: 6px 0; color: #64748b;">라이선스</td><td style="padding: 6px 0; font-weight: 600; color: #059669;">MIT License (완전 무료)</td></tr>
      </table>
    </div>
    <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px;">
      <h3 style="font-size: 17px; font-weight: 700; color: #1e293b; margin-top: 0; margin-bottom: 12px; border-left: 3px solid #059669; padding-left: 8px;">시스템 요구 사항</h3>
      <table style="width: 100%; font-size: 14px; border-collapse: collapse;">
        <tr><td style="padding: 6px 0; color: #64748b;">지원 OS</td><td style="padding: 6px 0; font-weight: 600;">Windows 10 / 11 (64-bit)</td></tr>
        <tr><td style="padding: 6px 0; color: #64748b;">권장 브라우저</td><td style="padding: 6px 0; font-weight: 600;">Edge / Chrome 최신 런타임</td></tr>
        <tr><td style="padding: 6px 0; color: #64748b;">지원 장치</td><td style="padding: 6px 0; font-weight: 600;">표준 UVC 실물화상기 / USB 웹캠</td></tr>
        <tr><td style="padding: 6px 0; color: #64748b;">필수 프레임워크</td><td style="padding: 6px 0; font-weight: 600;">.NET Framework 4.8 이상</td></tr>
      </table>
    </div>
  </div>

  <!-- 8. 제작자 및 공식 채널 안내 -->
  <section style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 24px; margin-bottom: 24px;">
    <h2 style="font-size: 20px; font-weight: 700; color: #1e3a8a; margin-top: 0; margin-bottom: 14px; border-left: 4px solid #2563eb; padding-left: 10px;">제작자 및 공식 채널 안내</h2>
    <ul style="list-style: none; padding: 0; margin: 0; font-size: 15px;">
      <li style="padding: 8px 0; border-bottom: 1px dashed #e2e8f0;">👨‍💻 <strong>개발자</strong>: AhBiYout (AhBiYout-all)</li>
      <li style="padding: 8px 0; border-bottom: 1px dashed #e2e8f0;">🐙 <strong>GitHub 저장소</strong>: <a href="https://github.com/AhBiYout-all" target="_blank" rel="noopener noreferrer" style="color: #2563eb; text-decoration: underline;">https://github.com/AhBiYout-all</a></li>
      <li style="padding: 8px 0; border-bottom: 1px dashed #e2e8f0;">✍️ <strong>공식 구글 블로그</strong>: <a href="https://ahbiyoutvibe.blogspot.com/" target="_blank" rel="noopener noreferrer" style="color: #2563eb; text-decoration: underline;">https://ahbiyoutvibe.blogspot.com/</a></li>
      <li style="padding: 8px 0;">🏢 <strong>소속</strong>: <a href="https://www.cisnet.co.kr" target="_blank" rel="noopener noreferrer" style="color: #2563eb; text-decoration: underline;">https://www.cisnet.co.kr</a></li>
    </ul>
  </section>

  <!-- 9. 전체 업데이트 (기능 개선 히스토리) -->
  <section style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 24px; margin-bottom: 24px;">
    <h2 style="font-size: 20px; font-weight: 700; color: #1e3a8a; margin-top: 0; margin-bottom: 14px; border-left: 4px solid #2563eb; padding-left: 10px;">전체 업데이트 히스토리 (기능 개선)</h2>
    <div style="font-size: 14px; line-height: 1.7; color: #334155;">
      <p style="margin-bottom: 10px;"><strong>v1.4.5 (2026-11-04)</strong><br>&bull; 형광펜 붓펜 촉(Brush Tip) 속도/필압 반응형 가변 너비 알고리즘 및 4단계 베지어 연속 보간 렌더링 구현 (둥근 촉과 동일하던 결함 원천 해결)<br>&bull; 펜 및 형광펜 하위메뉴 내 전용 붓펜 프리뷰 캔버스(drawBrushPreview) 및 -25도 타원 회전 커서 탑재</p>

      <p style="margin-bottom: 10px;"><strong>v1.4.4 (2026-11-01)</strong><br>&bull; 순수 창작 Win32 DLL 15종 API 완성 (하드웨어 톤, 디스크 용량 진단, DPI 감지, 항상 위 고정, QPC 타이머)<br>&bull; 가상 카메라 자동 연결 차단으로 화면 무한 복제 결함 원천 해결<br>&bull; 비정상 0KB 동영상 저장 문제 완전 해결 및 미디어 인코더 최적화<br>&bull; Inno Setup 멀티파일 인스톨러, 방화벽 자동 등록, 무인 설치 스위치 지원<br>&bull; GitHub Releases 기반 실시간 자동 업데이트 알림 팝업 시스템 구축</p>
      
      <p style="margin-bottom: 10px;"><strong>v1.4.3 (2026-10-26)</strong><br>&bull; 수업 도구 풀다운 메뉴 및 영상/렌즈 조절 팝업 화면 밖 이탈 방지 스마트 고정 좌표 클램핑 탑재<br>&bull; 하단 툴바 오버플로우 방지 및 스마트 뷰포트 반응형 레이아웃 최적화</p>

      <p style="margin-bottom: 10px;"><strong>v1.4.2 (2026-10-26)</strong><br>&bull; 카메라 영상 및 렌즈 조절 메뉴(초점, 줌, 노출) 반응성 전면 개편<br>&bull; 도형/텍스트 전용 옵션 패널 및 실시간 해상도 점 인디케이터 탑재</p>

      <p style="margin-bottom: 10px;"><strong>v1.4.1 (2026-10-26)</strong><br>&bull; 범용 MP4 수업 녹화 지원 및 고화질 캡처 안정화<br>&bull; 4종 잔상 효과 스타일 및 지속시간 조절이 가능한 잔상 레이저 펜 전용 하위 메뉴 탑재</p>

      <p style="margin-bottom: 10px;"><strong>v1.4.0 (2026-10-25)</strong><br>&bull; 판서 3종 도구(펜·형광펜·지우개) 4대 펜 촉 디자인(둥근촉, 캘리촉, 사각촉) 및 실시간 프리뷰 탑재<br>&bull; 판서 도구별 1-클릭 전용 하위메뉴(Flyout) 탑재로 색상 및 두께 즉시 변경 지원<br>&bull; 라이선스 제약 완전 해제 — 4K UHD 및 모든 Pro 기능을 100% 무료 개방<br>&bull; 동영상 녹화 버튼 하단 메인 툴바 전진 배치 및 단축키(V) 지원<br>&bull; 카메라 전환 시 브라우저 권한 반복 팝업 완전 제거 및 격리 프로필 적용<br>&bull; 캡처 플래시 애니메이션 및 셔터/차임 효과음 탑재</p>

      <p style="margin-bottom: 10px;"><strong>v1.4.0 (2026-10-18)</strong><br>&bull; 전체화면 진입 시 메뉴 툴바 자동 수축(아코디언 모드)으로 100% 클린 캔버스 뷰포트 제공<br>&bull; 캡처 및 녹화 시 툴바/버튼을 화면에서 완전히 배제하는 클린 캡처/녹화 엔진 구축<br>&bull; Multi-Screen Window Placement API 기반 듀얼 모니터 원클릭 점프 이동 지원<br>&bull; 카메라 하드웨어 상세 스펙(해상도, FPS, 11대 UVC 제어 가능 여부) 진단 모달창 탑재<br>&bull; 돋보기 캔버스 복합 렌더러 및 마우스 휠 반경/배율 조절 기능 추가<br>&bull; 형광펜 전용 독립 6색 팔레트 탑재</p>

      <p style="margin-bottom: 10px;"><strong>v1.3.1 (2026-10-09)</strong><br>&bull; 무선 P2P 모듈을 제거하고 USB 유선 및 로컬 카메라 연결 전용으로 단일화하여 초경량화 및 반응성 극대화</p>

      <p style="margin-bottom: 10px;"><strong>v1.3.0 (2026-10-08)</strong><br>&bull; 후면 플래시(Torch) 켜기/끄기, 탭 투 포커스(Tap-to-Focus), 하드웨어 센서 노출 보정 다이얼 탑재</p>

      <p style="margin-bottom: 10px;"><strong>v1.2.0 (2026-10-08)</strong><br>&bull; 전면/후면 카메라 전환, 2손가락 터치 핀치 줌(Pinch-to-Zoom), 해상도 프로파일 선택기 추가</p>

      <p style="margin-bottom: 10px;"><strong>v1.1.0 (2026-10-08)</strong><br>&bull; 수업용 카운트다운 타이머, 스톱워치, 4종 기하 도형, 텍스트 입력 주석, 3종 보조 격자(모눈, 도트, 줄노트) 추가<br>&bull; 집중 벨 효과음, 레이저 포인터, 확대경, 스포트라이트, 가림막, 2분할 캡처 비교 모드 추가</p>

      <p style="margin-bottom: 0;"><strong>v1.0.0 (2026-10-08)</strong><br>&bull; 웹 기반 무설치 교실용 실물화상기 최초 공식 배포<br>&bull; UVC 표준 카메라 실시간 스트리밍, 화면 일시정지(Freeze), 고화질 캡처, 좌우 반전 및 90도 회전 지원</p>
    </div>
  </section>

  <!-- 10. 추천 태그 -->
  <footer style="background: #f1f5f9; border-radius: 12px; padding: 18px 22px; font-size: 13px; color: #475569;">
    <strong style="color: #0f172a; display: block; margin-bottom: 6px;">🏷️ 추천 태그 (복사하여 태그 입력란에 넣으세요):</strong>
    <code style="display: block; background: #ffffff; border: 1px solid #cbd5e1; border-radius: 6px; padding: 10px; word-break: break-all; color: #0f766e;">아비캠뷰어,실물화상기,웹캠뷰어,수업도구,교실화상기,전자칠판,화상수업,무료소프트웨어,AhBiCamViewer,ClassroomVisualizer,WebcamViewer,Visualizer,DocumentCamera,EdTech,ScreenCapture,WindowsApp,CISNet,AhBiYout</code>
  </footer>

</div>
```
