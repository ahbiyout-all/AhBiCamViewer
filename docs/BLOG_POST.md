# 📢 구글 블로거(Blogger) 공식 포스팅 원고 (AhBiCamViewer v1.4.7)

본 문서는 구글 블로그([ahbiyoutvibe.blogspot.com](https://ahbiyoutvibe.blogspot.com/))에 즉시 게시할 수 있도록 규격화된 공식 포스팅 원고입니다.  
사용자의 편집 편의를 위해 **1. [작성 모드 (서식 있는 텍스트)]**와 **2. [HTML 편집 모드]**를 모두 제공합니다.

---

# 1. 📝 [작성 모드 (서식 있는 텍스트)]
> *구글 블로거 글쓰기 화면 좌측 상단의 연필 아이콘 `[작성 모드(Compose View)]`에서 그대로 복사하여 붙여넣으실 수 있는 서식입니다.*

## 제목
[무료] 스마트 교실과 원격 강의를 위한 최고의 실물화상기 - 아비캠뷰어(AhBiCamViewer) v1.4.7 대규모 업데이트 배포

## 본문
선생님, 강사, 발표자를 위한 교실 및 원격 수업 필수 소프트웨어!  
**아비캠뷰어 (AhBiCamViewer)**는 제조사 전용 드라이버 설치나 유료 라이선스 제약 없이, 표준 USB 웹캠이나 전용 실물화상기를 PC에 연결하기만 하면 **최고 4K UHD 초고화질**로 즉시 작동하는 차세대 스마트 교실용 실물화상기 & 뷰어 프로그램입니다.

수업과 발표에만 100% 집중할 수 있도록 깔끔하고 직관적인 인터페이스를 갖추었으며, 지능형 접이식 아코디언 메뉴, 고성능 실시간 판서(4대 맞춤 펜 촉, 형광펜, 지우개, 기하 도형, 텍스트 주석), 그리고 수업 집중 보조 도구(타이머, 스톱워치, 확대경, 돋보기, 스포트라이트, 가림막, 2분할 비교 화면, PDF 일괄 컴파일)를 모두 무료로 제공합니다.

특히 이번 **v1.4.7 대규모 업데이트**에서는 텍스트에 이어 **7대 기하 도형(직선, 사각형, 원, 삼각형, 화살표, 양방향 화살표, 별표)을 화면 원하는 곳 어디든 자유롭게 끌어다 놓고(Movable Shapes), 핀(📌)으로 캔버스에 영구 고정하거나 삭제할 수 있는 자유 이동식 도형 엔진**이 전격 탑재되었습니다! 캡처, MP4 녹화, PDF 묶기, 돋보기 화면에서도 깨짐 없이 완벽한 무손실 벡터로 자동 합성됩니다.  
또한 **구역별 접이식 가로 아코디언 메뉴**, **앱 구동 시 자동 업데이트 알림 팝업 시스템**, **인스톨러 자동 구버전 삭제 및 클린 설치 파이프라인**이 함께 적용되어 완성도가 한층 높아졌습니다.

## 업데이트 (v1.4.7 핵심 개선 내역)
- **📐 7대 기하 도형 자유 이동(Movable Shapes) 및 캔버스 융합(Bake) 시스템 탑재**:
  - 직선, 사각형, 원, 삼각형, 화살표, 양방향 화살표, 별표 등 모든 기하 도형을 그리기 완료 즉시 인터랙티브 카드로 생성.
  - 마우스/터치 드래그로 화면 원하는 곳 어디든 자유롭게 이동 (Pointer Capture Drag Engine).
  - 얇은 선이나 작은 도형도 쉽게 잡을 수 있는 여유 있는 히트 패딩 바운딩 박스 제공.
  - 호버 시 캔버스 비트맵 영구 고정(📌 핀 버튼) 및 원클릭 삭제(✕ 버튼) 지원.
  - 선 스타일(실선/파선/점선), 채우기(투명/25%/50%/솔리드), 두께, 색상 완벽 보존.
- **📂 하단 메뉴 구역별 접이식 가로 아코디언(Horizontal Accordion) 시스템 도입**:
  - 하단 메뉴를 3대 기능 구역([🎬 촬영·제어], [🎥 카메라·화질], [🧰 영상조절·수업도구])으로 분할하여 개별 접기/펼치기 지원.
  - 부드러운 가로 슬라이딩 CSS 애니메이션 및 로컬 저장소(`localStorage`)를 통한 상태 영속화.
  - 메뉴가 접혀 있어도 녹화 중(🔴), 카메라 활성(🟢), 도구 사용(🔵)을 직관적으로 알려주는 인디케이터 닷 점등.
  - Alt+클릭 시 전체 구역 일괄 접기/펼치기 및 작은 화면 자동 슬림 모드 지원.
- **🎨 좌측 수업 발표 도구 메뉴 하단 툴바 가림 현상 해결**:
  - 레이저, 돋보기, 스포트라이트, 가림막 메뉴가 하단 툴바에 가려지지 않도록 상향 전개 앵커 및 동적 뷰포트 충돌 방지 가드 탑재.
- **🚀 인스톨러 사전 작업 강화 (기존 앱 자동 종료 및 구버전 완전 무인 삭제)**:
  - 인스톨러 실행 시 실행 중인 앱 프로세스를 자동 감지하여 안전하게 종료.
  - 레지스트리 기반으로 구버전 언인스톨러를 무인 실행하여 구버전 파일 및 바로가기를 완전 삭제한 후 최신 버전으로 클린 신규 설치.
- **🐙 GitHub Releases 기반 실시간 자동 업데이트 팝업 시스템 구축**:
  - 앱 실행 2.5초 후 GitHub Releases를 실시간 조회하여 최신 버전 발견 시 안내 팝업창 자동 실행.
  - 최신 버전 뱃지, 패치 내역 스크롤 뷰, 원클릭 인스톨러 다운로드 버튼 완비.
  - GitHub API 레이트 리밋 대비 Raw `version.json` 이중 폴백 안전망 구축.
- **⚡ 순수 창작 Native DLL 15대 Win32 API 완성 (`AhBiCamViewerCore.dll`, v1.4.7)**:
  - 하드웨어 비프 톤(수업 집중벨), 디스크 용량 진단, 모니터 DPI 자동 감지, 항상 위 고정, 마이크로초 고정밀 타이머 등 15개 순수 Win32 API 100% 검증 완료.
- **🛡️ 가상 카메라 무한 복제(Droste Effect) 원천 차단**:
  - OBS Virtual Camera 등 가상 카메라 자동 연결을 배제하고 안정적인 대기 화면 유지.

## 앱 그림
> *(블로그 게시 시 아래 항목에 맞춰 앱 캡처 사진이나 스크린샷 이미지를 삽입해 주세요)*

- **[그림 1] 교실 수업 전체화면 뷰**: 툴바가 자동으로 수축하여 교재와 교구 화면을 100% 시야로 시원하게 보여주는 메인 뷰.
- **[그림 2] 자유 이동식 기하 도형 & 텍스트 주석**: 화면 원하는 곳으로 드래그하고 핀(📌)으로 고정하는 인터랙티브 판서 화면.
- **[그림 3] 하단 접이식 가로 아코디언 메뉴**: 3대 구역(촬영·제어, 카메라·화질, 영상조절·수업도구)을 깔끔하게 접고 펼치는 툴바 레이아웃.
- **[그림 4] 수업 집중 도구 모음**: 타이머, 돋보기, 스포트라이트, 2분할 비교 화면 및 4대 맞춤 펜 촉 팔레트.

## 다운로드
공식 GitHub Releases에서 최신 윈도우 정식 설치 파일을 100% 무료로 다운로드하실 수 있습니다:

- 🚀 **윈도우 정식 설치 프로그램**: [AhBiCamViewer_Setup_v1.4.7.exe 다운로드](https://github.com/AhBiYout-all/AhBiCamViewer/releases/latest)
- 🌐 **GitHub 릴리스 전체 목록**: [https://github.com/AhBiYout-all/AhBiCamViewer/releases](https://github.com/AhBiYout-all/AhBiCamViewer/releases)

## 버전정보
- **소프트웨어 명칭**: 아비캠뷰어 (AhBiCamViewer)
- **현재 배포 버전**: v1.4.7
- **배포일**: 2026-11-07
- **버전 관리 규격**: Semantic Versioning 2.0.0
- **라이선스**: MIT License (학교, 학원, 관공서, 기업, 개인 누구나 100% 무료 자유 사용)

## 시스템 요구 사항
- **운영체제**: Microsoft Windows 10 / 11 (32-bit / 64-bit 지원, 64-bit 권장)
- **웹 런타임**: Microsoft Edge (Chromium 기반) 또는 Google Chrome 최신 버전
- **추가 런타임**: Microsoft .NET Framework 4.8 이상 (네이티브 코어 DLL 연동 시)
- **카메라 장치**: 표준 UVC 지원 USB 웹캠, 전용 실물화상기(IPEVO, Aver 등), 노트북 내장 웹캠

## 제작자 및 공식 채널 안내
- **개발자**: AhBiYout
- **GitHub 저장소**: https://github.com/AhBiYout-all
- **공식 구글 블로그**: https://ahbiyoutvibe.blogspot.com/
- **앱 저장소**: https://github.com/AhBiYout-all/AhBiCamViewer

## 전체 업데이트 (패치노트 기반 기능 개선 기록)
- **v1.4.7 (2026-11-07)**:
  - 7대 기하 도형(Movable Geometric Shapes) 자유 이동/배치, 핀 고정(Bake), 삭제 기능 탑재.
  - 캡처, MP4 녹화, PDF 묶기, 돋보기 4중 무손실 벡터 합성 엔진(`renderShapeAnnotationsToCanvas`) 탑재.
  - 하단 메뉴 구역별 접이식 가로 아코디언(Horizontal Accordion) 시스템 도입 (촬영·제어, 카메라·화질, 영상조절·수업도구).
  - 좌측 수업 발표 보조 도구 메뉴 하단 툴바 가림 현상 수정 (상향 전개 앵커 및 동적 충돌 가드).
  - 인스톨러 사전 작업 강화: 실행 중인 기존 앱 자동 종료 및 이전 버전 완전 무인 삭제 후 신규 설치 파이프라인.
  - GitHub Releases 기반 실시간 자동 업데이트 감지 및 팝업창 시스템 구축.
  - 네이티브 DLL 및 저장소 명칭 전면 개편 (`AhBiCamViewerCore.dll`, `AhBiCamViewerManaged.dll`).
- **v1.4.6 (2026-11-05)**:
  - 작성된 텍스트 주석 카드 자유 이동(Movable Text) 및 인라인 재편집 엔진 탑재.
  - 형광펜 붓펜 촉(Brush Tip) 속도/필압 반응형 4단계 베지어 테이퍼링 및 프리뷰 고도화.
  - 순수 창작 Native DLL 15대 Win32 API 완성 (비프 톤, 디스크 용량, DPI, 항상 위, QPC 타이머 등).
  - 가상 카메라 화면 무한 복제(Droste Effect) 원천 차단 필터 탑재.
  - 캡처 이미지 JPG / PNG / WebP 포맷 선택 엔진 탑재.
  - 캡처 & 동영상 녹화 효과 설정 모달(`mediaFxModal`) 양방향 연동.
- **v1.4.5 (2026-11-04)**:
  - 카메라별 지원 해상도 실시간 점(Dot) 인디케이터 탑재.
  - 도형(Shapes) 도구 옵션 패널 및 실시간 프리뷰 확장.
  - 텍스트(Text) 주석 카드 전용 1-클릭 하위메뉴(Flyout) 및 맞춤 옵션 제공.
  - 잔상 레이저 펜 전용 하위메뉴(Flyout) 및 커스텀 옵션 탑재.
  - 동영상 수업 녹화 MP4(.mp4) 포맷 지원 및 확장자 선택기 탑재.
- **v1.4.4 (2026-11-03)**:
  - 4대 펜 촉(둥근촉, 붓펜촉, 캘리촉, 사각촉) 디자인 엔진 구현.
  - 형광펜 동일 4종 촉 디자인 확장 적용.
  - 지우개 4종 디자인(둥근, 네모, 각진, 포인트) 엔진 탑재.
  - 펜 촉 맞춤형 실시간 프리뷰 & 커서 가이드 제공.
  - 도구 클릭 시 맞춤형 하위메뉴(Flyout) 즉각 제공.
  - Pro 에디션 전 기능 제약 없이 100% 무상 개방.
- **v1.4.3 (2026-10-31)**:
  - 듀얼 모니터 점프(보조 모니터/전자칠판 1클릭 화면 이동) 기능 탑재.
  - 좌측(판서 도구) / 하단(영상 및 수업 도구) 분리형 모던 레이아웃 개편.
  - 스탠드얼론 런처(`launcher.vbs`) 및 카메라 권한 자동 승인 격리 프로필 탑재.
- **v1.4.2 (2026-10-28)**:
  - USB 유선 웹캠 및 실물화상기 전용 로컬 최적화.
  - 브라우저 스로틀링 방지 및 무손실 화면 캡처 버그 해결.
- **v1.4.0 ~ v1.4.1 (2026-10-25)**:
  - 다중 웹캠 전환, 전면/후면 카메라 방향 전환 기능 탑재.
  - 실시간 영상 조절(밝기, 대비, 노출, 문서 고대비 필터, 흑백 반전) 탑재.
- **v1.2.0 ~ v1.3.0 (2026-10-20)**:
  - 교실 수업 편의 도구(수업 타이머, 스톱워치, 분할 비교 화면, 스포트라이트, 가림막, 돋보기) 탑재.
  - 다중 캡처 이미지 A4 PDF 일괄 컴파일 및 갤러리 썸네일 바 탑재.
- **v1.0.0 (2026-10-15)**:
  - 웹 기반 무설치 교실용 실물화상기 최초 배포 (웹캠 연결 즉시 Full HD 화질 렌더링).

## 추천 태그
아비캠뷰어,실물화상기,웹캠뷰어,수업도구,교실화상기,전자칠판,화상수업,온라인강의,무료소프트웨어,AhBiCamViewer,WebcamViewer,Visualizer,DocumentCamera,EdTech,Classroom,ScreenCapture,AhBiYout

---

# 2. 💻 [HTML 편집 모드]
> *구글 블로거 글쓰기 화면 좌측 상단의 연필 아이콘을 클릭하여 `<> [HTML 보기(HTML View)]`로 전환한 후, 아래의 소스코드를 그대로 전체 복사하여 붙여넣으세요.*

```html
<div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; line-height: 1.7; color: #1e293b; max-width: 860px; margin: 0 auto; padding: 10px;">

  <!-- 1. 제목 -->
  <div style="background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 50%, #38bdf8 100%); color: #ffffff; padding: 36px 28px; border-radius: 16px; box-shadow: 0 10px 25px -5px rgba(37, 99, 235, 0.3); text-align: center; margin-bottom: 30px;">
    <span style="display: inline-block; background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(8px); padding: 5px 14px; border-radius: 20px; font-size: 13px; font-weight: 700; letter-spacing: 0.5px; margin-bottom: 12px;">공식 릴리즈 안내</span>
    <h1 style="margin: 0 0 12px 0; font-size: 26px; font-weight: 800; line-height: 1.35; color: #ffffff;">[무료] 스마트 교실과 원격 강의를 위한 최고의 실물화상기<br><span style="color: #fde047;">아비캠뷰어 (AhBiCamViewer) v1.4.7</span> 대규모 업데이트</h1>
    <p style="margin: 0; font-size: 15px; opacity: 0.92;">복잡한 드라이버 없이 USB 웹캠 연결 즉시 4K UHD 고화질 수업 판서 및 녹화 가능</p>
  </div>

  <!-- 2. 본문 -->
  <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 24px; margin-bottom: 24px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);">
    <h2 style="margin-top: 0; font-size: 20px; color: #1e40af; border-bottom: 2px solid #3b82f6; padding-bottom: 8px;">📖 소프트웨어 소개 (본문)</h2>
    <p style="font-size: 15px; color: #334155; margin-bottom: 14px;">
      선생님, 강사, 발표자를 위한 스마트 교실 및 비대면 강의 필수 소프트웨어! <strong>아비캠뷰어 (AhBiCamViewer)</strong>는 제조사별 전용 뷰어 설치나 유료 라이선스 제약 없이, 표준 USB 웹캠이나 전용 실물화상기를 연결하기만 하면 <strong>최고 4K UHD 초고화질</strong>로 즉시 작동하는 차세대 스마트 실물화상기 & 뷰어 프로그램입니다.
    </p>
    <p style="font-size: 15px; color: #334155; margin-bottom: 14px;">
      선생님과 발표자가 수업에만 온전히 집중할 수 있도록 깔끔한 UI, 지능형 접이식 아코디언 메뉴, 고성능 실시간 판서(4대 맞춤 펜 촉, 형광펜, 지우개, 기하 도형, 텍스트 주석), 그리고 수업 집중 보조 도구(타이머, 스톱워치, 확대경, 돋보기, 스포트라이트, 가림막, 2분할 비교 화면, PDF 일괄 컴파일)를 누구나 제약 없이 <strong>100% 무료</strong>로 이용하실 수 있습니다.
    </p>
    <p style="font-size: 15px; color: #334155; margin-bottom: 0;">
      특히 이번 <strong>v1.4.7</strong>에서는 텍스트에 이어 <strong>7대 기하 도형(직선, 사각형, 원, 삼각형, 화살표, 별표 등)을 화면 어디로든 끌어다 놓고(Movable Shapes), 핀(📌)으로 캔버스에 영구 고정하거나 삭제할 수 있는 자유 이동식 도형 엔진</strong>이 전격 탑재되었습니다. 캡처, MP4 녹화, PDF 묶기, 돋보기 확대 뷰에서도 왜곡 없이 무손실 벡터로 자동 합성됩니다!
    </p>
  </div>

  <!-- 3. 업데이트 -->
  <div style="background: #f8fafc; border: 1px solid #cbd5e1; border-left: 6px solid #2563eb; border-radius: 12px; padding: 22px; margin-bottom: 24px;">
    <h2 style="margin-top: 0; font-size: 20px; color: #1e40af; display: flex; align-items: center; gap: 8px;">
      🚀 최신 업데이트 내역 (v1.4.7 핵심 개선)
    </h2>
    <ul style="margin: 0; padding-left: 20px; font-size: 14.5px; color: #334155; line-height: 1.8;">
      <li><strong>📐 7대 기하 도형 자유 이동(Movable Shapes) 및 캔버스 융합(Bake) 탑재</strong>: 직선, 사각형, 원, 삼각형, 화살표, 별표 등을 그리기 즉시 인터랙티브 카드로 생성하여 마우스/터치 드래그 이동, 핀 고정(📌), 원클릭 삭제(✕) 지원.</li>
      <li><strong>📂 하단 메뉴 구역별 접이식 가로 아코디언(Horizontal Accordion) 시스템 도입</strong>: [촬영·제어], [카메라·화질], [영상조절·수업도구] 3대 구역의 부드러운 가로 슬라이딩 접기/펼치기 및 상태 영속화(`localStorage`).</li>
      <li><strong>🎨 좌측 발표 도구 메뉴 하단 툴바 가림 현상 수정</strong>: 발표 보조 도구 플라이아웃이 하단 툴바 위로 올라오도록 상향 전개 앵커 및 뷰포트 충돌 방지 가드 적용.</li>
      <li><strong>🚀 인스톨러 사전 작업 강화</strong>: 설치 실행 시 기존 앱 자동 종료 후 이전 버전 무인 완전 삭제 및 클린 신규 설치 파이프라인 탑재.</li>
      <li><strong>🐙 GitHub Releases 기반 실시간 자동 업데이트 팝업</strong>: 앱 실행 시 최신 버전 실시간 감지 및 패치 내역 안내 팝업창 자동 표출.</li>
      <li><strong>⚡ 15대 Win32 Native API 완성 (`AhBiCamViewerCore.dll`)</strong>: 수업 주목 비프 톤, 디스크 용량 진단, 모니터 DPI 자동 감지 등 100% 검증 완료.</li>
      <li><strong>🛡️ 가상 카메라 무한 복제(Droste Effect) 차단</strong>: DirectShow 가상 캡처 장치 자동 배제 및 깨끗한 대기 화면 유지.</li>
    </ul>
  </div>

  <!-- 4. 앱 그림 -->
  <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 24px; margin-bottom: 24px;">
    <h2 style="margin-top: 0; font-size: 20px; color: #1e40af; border-bottom: 2px solid #3b82f6; padding-bottom: 8px;">🖼️ 앱 화면 및 UI 구성 안내</h2>
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 14px; margin-top: 14px;">
      <div style="background: #f1f5f9; border: 1px dashed #94a3b8; border-radius: 10px; padding: 16px; text-align: center;">
        <div style="font-size: 32px; margin-bottom: 8px;">🖥️</div>
        <strong style="color: #0f172a; font-size: 15px;">교실 전체화면 뷰</strong>
        <p style="font-size: 13px; color: #64748b; margin: 6px 0 0 0;">시야 방해 없는 자동 툴바 수축 및 4K 고화질 실시간 렌더링</p>
      </div>
      <div style="background: #f1f5f9; border: 1px dashed #94a3b8; border-radius: 10px; padding: 16px; text-align: center;">
        <div style="font-size: 32px; margin-bottom: 8px;">📐</div>
        <strong style="color: #0f172a; font-size: 15px;">이동식 도형 & 텍스트 판서</strong>
        <p style="font-size: 13px; color: #64748b; margin: 6px 0 0 0;">7대 기하 도형 및 텍스트 카드를 화면 어디로든 드래그 및 핀 고정</p>
      </div>
      <div style="background: #f1f5f9; border: 1px dashed #94a3b8; border-radius: 10px; padding: 16px; text-align: center;">
        <div style="font-size: 32px; margin-bottom: 8px;">📂</div>
        <strong style="color: #0f172a; font-size: 15px;">가로 아코디언 메뉴</strong>
        <p style="font-size: 13px; color: #64748b; margin: 6px 0 0 0;">3대 구역을 원클릭으로 접고 펼쳐 최적의 작업 공간 확보</p>
      </div>
    </div>
  </div>

  <!-- 5. 다운로드 -->
  <div style="background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%); border: 2px solid #86efac; border-radius: 14px; padding: 24px; text-align: center; margin-bottom: 24px;">
    <h2 style="margin-top: 0; font-size: 21px; color: #166534;">⬇️ 최신 버전 무료 다운로드</h2>
    <p style="font-size: 14px; color: #15803d; margin-bottom: 18px;">공식 GitHub Releases에서 최신 윈도우 인스톨러를 직접 내려받으실 수 있습니다.</p>
    <div style="display: flex; gap: 12px; justify-content: center; flex-wrap: wrap;">
      <a href="https://github.com/AhBiYout-all/AhBiCamViewer/releases/latest" target="_blank" rel="noopener noreferrer" style="background: #16a34a; color: #ffffff; text-decoration: none; font-weight: 700; padding: 12px 24px; border-radius: 8px; box-shadow: 0 4px 12px rgba(22, 163, 74, 0.35); font-size: 15px; display: inline-block;">
        🚀 윈도우 인스톨러 다운로드 (Setup.exe)
      </a>
      <a href="https://github.com/AhBiYout-all/AhBiCamViewer/releases" target="_blank" rel="noopener noreferrer" style="background: #1e293b; color: #ffffff; text-decoration: none; font-weight: 600; padding: 12px 20px; border-radius: 8px; font-size: 15px; display: inline-block;">
        🌐 GitHub Releases 전체 목록
      </a>
    </div>
  </div>

  <!-- 6. 버전정보 & 7. 시스템 요구 사항 (테이블) -->
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 18px; margin-bottom: 24px;">
    <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px;">
      <h3 style="margin-top: 0; font-size: 17px; color: #1e40af; border-bottom: 1px solid #e2e8f0; padding-bottom: 6px;">📋 버전 정보</h3>
      <table style="width: 100%; font-size: 13.5px; border-collapse: collapse; color: #334155;">
        <tr><td style="padding: 6px 0; font-weight: 600; width: 100px;">소프트웨어</td><td>아비캠뷰어 (AhBiCamViewer)</td></tr>
        <tr><td style="padding: 6px 0; font-weight: 600;">현재 버전</td><td><span style="background: #2563eb; color: #fff; padding: 2px 8px; border-radius: 10px; font-size: 12px;">v1.4.7</span></td></tr>
        <tr><td style="padding: 6px 0; font-weight: 600;">배포일자</td><td>2026-11-07</td></tr>
        <tr><td style="padding: 6px 0; font-weight: 600;">라이선스</td><td>MIT License (완전 무료)</td></tr>
      </table>
    </div>

    <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px;">
      <h3 style="margin-top: 0; font-size: 17px; color: #1e40af; border-bottom: 1px solid #e2e8f0; padding-bottom: 6px;">⚙️ 시스템 요구 사항</h3>
      <table style="width: 100%; font-size: 13.5px; border-collapse: collapse; color: #334155;">
        <tr><td style="padding: 6px 0; font-weight: 600; width: 100px;">운영체제</td><td>Windows 10 / 11 (64-bit 권장)</td></tr>
        <tr><td style="padding: 6px 0; font-weight: 600;">웹 런타임</td><td>Microsoft Edge 또는 Chrome 최신</td></tr>
        <tr><td style="padding: 6px 0; font-weight: 600;">추가 런타임</td><td>.NET Framework 4.8 이상</td></tr>
        <tr><td style="padding: 6px 0; font-weight: 600;">카메라 장치</td><td>표준 UVC USB 웹캠 / 실물화상기</td></tr>
      </table>
    </div>
  </div>

  <!-- 8. 제작자 및 공식 채널 안내 -->
  <div style="background: #f8fafc; border: 1px solid #cbd5e1; border-radius: 12px; padding: 20px; margin-bottom: 24px;">
    <h3 style="margin-top: 0; font-size: 17px; color: #0f172a; border-bottom: 1px solid #cbd5e1; padding-bottom: 8px;">👤 제작자 및 공식 채널 안내</h3>
    <ul style="margin: 0; padding-left: 20px; font-size: 14px; color: #334155; line-height: 1.9;">
      <li><strong>개발자</strong>: AhBiYout</li>
      <li><strong>GitHub 저장소</strong>: <a href="https://github.com/AhBiYout-all" target="_blank" rel="noopener noreferrer" style="color: #2563eb; text-decoration: underline;">https://github.com/AhBiYout-all</a></li>
      <li><strong>공식 구글 블로그</strong>: <a href="https://ahbiyoutvibe.blogspot.com/" target="_blank" rel="noopener noreferrer" style="color: #2563eb; text-decoration: underline;">https://ahbiyoutvibe.blogspot.com/</a></li>
      <li><strong>앱 저장소</strong>: <a href="https://github.com/AhBiYout-all/AhBiCamViewer" target="_blank" rel="noopener noreferrer" style="color: #2563eb; text-decoration: underline;">https://github.com/AhBiYout-all/AhBiCamViewer</a></li>
    </ul>
  </div>

  <!-- 9. 전체 업데이트 (기능 개선 히스토리) -->
  <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 22px; margin-bottom: 24px;">
    <h3 style="margin-top: 0; font-size: 18px; color: #1e40af; border-bottom: 2px solid #3b82f6; padding-bottom: 8px;">📜 전체 업데이트 (기능 개선 히스토리)</h3>
    <div style="max-height: 380px; overflow-y: auto; font-size: 13.5px; color: #334155; line-height: 1.8; padding-right: 8px;">
      <p style="margin: 6px 0 2px 0;"><strong>v1.4.7 (2026-11-07)</strong></p>
      <ul style="margin: 0 0 10px 0; padding-left: 20px;">
        <li>7대 기하 도형 자유 이동(Movable Shapes) 및 캔버스 핀 고정(Bake), 삭제 기능 탑재.</li>
        <li>스틸 캡처, MP4 녹화, PDF 묶기, 돋보기 4중 무손실 벡터 합성 엔진(`renderShapeAnnotationsToCanvas`) 탑재.</li>
        <li>하단 메뉴 구역별 접이식 가로 아코디언(Horizontal Accordion) 시스템 도입 ([촬영·제어], [카메라·화질], [영상조절·수업도구]).</li>
        <li>좌측 수업 발표 도구 메뉴 하단 툴바 가림 현상 수정 (상향 전개 앵커 및 뷰포트 충돌 방지 가드).</li>
        <li>인스톨러 사전 작업 강화: 실행 중인 기존 앱 자동 종료 및 이전 버전 완전 무인 삭제 후 신규 설치.</li>
        <li>GitHub Releases 기반 실시간 자동 업데이트 감지 및 팝업창 시스템 구축.</li>
        <li>네이티브 DLL 및 저장소 명칭 전면 개편 (`AhBiCamViewerCore.dll`, `AhBiCamViewerManaged.dll`).</li>
      </ul>

      <p style="margin: 6px 0 2px 0;"><strong>v1.4.6 (2026-11-05)</strong></p>
      <ul style="margin: 0 0 10px 0; padding-left: 20px;">
        <li>작성된 텍스트 주석 카드 자유 이동(Movable Text) 및 인라인 재편집 엔진 탑재.</li>
        <li>형광펜 붓펜 촉(Brush Tip) 속도/필압 반응형 4단계 베지어 테이퍼링 및 프리뷰 고도화.</li>
        <li>순수 창작 Native DLL 15대 Win32 API 완성 (비프 톤, 디스크 용량, DPI, 항상 위, QPC 타이머).</li>
        <li>가상 카메라 무한 복제(Droste Effect) 원천 차단 필터 탑재.</li>
        <li>캡처 이미지 JPG / PNG / WebP 포맷 선택 엔진 탑재.</li>
      </ul>

      <p style="margin: 6px 0 2px 0;"><strong>v1.4.5 (2026-11-04)</strong></p>
      <ul style="margin: 0 0 10px 0; padding-left: 20px;">
        <li>카메라별 지원 해상도 실시간 점(Dot) 인디케이터 탑재.</li>
        <li>도형(Shapes) 도구 옵션 패널 및 실시간 프리뷰 확장.</li>
        <li>텍스트(Text) 주석 카드 전용 1-클릭 하위메뉴(Flyout) 및 맞춤 옵션 제공.</li>
        <li>잔상 레이저 펜 전용 하위메뉴(Flyout) 및 커스텀 옵션 탑재.</li>
        <li>동영상 수업 녹화 MP4(.mp4) 포맷 지원 및 확장자 선택기 탑재.</li>
      </ul>

      <p style="margin: 6px 0 2px 0;"><strong>v1.4.4 (2026-11-03)</strong></p>
      <ul style="margin: 0 0 10px 0; padding-left: 20px;">
        <li>4대 펜 촉(둥근촉, 붓펜촉, 캘리촉, 사각촉) 디자인 엔진 구현.</li>
        <li>형광펜 동일 4종 촉 디자인 확장 적용 및 지우개 4종 디자인 엔진 탑재.</li>
        <li>펜 촉 맞춤형 실시간 프리뷰 & 커서 가이드 제공.</li>
        <li>도구 클릭 시 맞춤형 하위메뉴(Flyout) 즉각 제공.</li>
        <li>Pro 에디션 전 기능 100% 무상 전면 개방.</li>
      </ul>

      <p style="margin: 6px 0 2px 0;"><strong>v1.4.3 (2026-10-31)</strong></p>
      <ul style="margin: 0 0 10px 0; padding-left: 20px;">
        <li>듀얼 모니터 점프(보조 모니터/전자칠판 1클릭 화면 이동) 기능 탑재.</li>
        <li>좌측(판서 도구) / 하단(영상 및 수업 도구) 분리형 모던 레이아웃 개편.</li>
        <li>스탠드얼론 런처(`launcher.vbs`) 및 카메라 권한 자동 승인 격리 프로필 탑재.</li>
      </ul>

      <p style="margin: 6px 0 2px 0;"><strong>v1.4.2 (2026-10-28)</strong></p>
      <ul style="margin: 0 0 10px 0; padding-left: 20px;">
        <li>USB 유선 웹캠 및 실물화상기 전용 로컬 최적화.</li>
        <li>브라우저 스로틀링 방지 및 무손실 화면 캡처 버그 해결.</li>
      </ul>

      <p style="margin: 6px 0 2px 0;"><strong>v1.4.0 ~ v1.4.1 (2026-10-25)</strong></p>
      <ul style="margin: 0 0 10px 0; padding-left: 20px;">
        <li>다중 웹캠 전환, 전면/후면 카메라 방향 전환 기능 탑재.</li>
        <li>실시간 영상 조절(밝기, 대비, 노출, 문서 고대비 필터, 흑백 반전) 탑재.</li>
      </ul>

      <p style="margin: 6px 0 2px 0;"><strong>v1.2.0 ~ v1.3.0 (2026-10-20)</strong></p>
      <ul style="margin: 0 0 10px 0; padding-left: 20px;">
        <li>교실 수업 편의 도구(수업 타이머, 스톱워치, 분할 비교 화면, 스포트라이트, 가림막, 돋보기) 탑재.</li>
        <li>다중 캡처 이미지 A4 PDF 일괄 컴파일 및 갤러리 썸네일 바 탑재.</li>
      </ul>

      <p style="margin: 6px 0 2px 0;"><strong>v1.0.0 (2026-10-15)</strong></p>
      <ul style="margin: 0; padding-left: 20px;">
        <li>웹 기반 무설치 교실용 실물화상기 최초 배포 (웹캠 연결 즉시 Full HD 화질 렌더링).</li>
      </ul>
    </div>
  </div>

  <!-- 10. 추천 태그 -->
  <div style="background: #f1f5f9; border: 1px solid #cbd5e1; border-radius: 10px; padding: 14px 18px;">
    <strong style="color: #0f172a; font-size: 14px;">🏷️ 추천 태그 (복사하여 태그란에 입력):</strong>
    <div style="margin-top: 6px; font-family: monospace; font-size: 13px; color: #0284c7; background: #ffffff; padding: 8px 12px; border-radius: 6px; border: 1px solid #e2e8f0; word-break: break-all;">
      아비캠뷰어,실물화상기,웹캠뷰어,수업도구,교실화상기,전자칠판,화상수업,온라인강의,무료소프트웨어,AhBiCamViewer,WebcamViewer,Visualizer,DocumentCamera,EdTech,Classroom,ScreenCapture,AhBiYout
    </div>
    <span style="font-size: 12px; color: #64748b; margin-top: 4px; display: inline-block;">(총 17개 태그, 167글자 - 한글 및 영문 혼합, 20개 이하 &amp; 200글자 이내 규격 완벽 준수)</span>
  </div>

</div>
```
