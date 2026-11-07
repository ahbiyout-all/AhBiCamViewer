# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.4.7] - 2026-11-06
### Fixed
- **Presentation Flyout Menu Occlusion**: Fixed the left toolbar's presentation tools flyout menu (`#presentFlyoutPanel`) being hidden/cut off behind the bottom toolbar by anchoring it upwards (`bottom: 0`), implementing real-time boundary collision guard (`adjustFlyoutPanelPosition`), and elevating `.left-toolbar` z-index to 60/65.

### Changed
- **Unified Distribution to Single index.html**:
  - Removed 3 redundant legacy HTML files (`아비캠뷰어_(AhBiCamViewer).html`, `교실용_실물화상기.html`, `(AhBiYout)_공용_실물화상기_보기.html`) and retired `tools/sync_html.cjs`.
  - Streamlined `launcher.vbs`, `tools/AhBiCamViewer.bat`, and Inno Setup `installer.iss` to package and launch directly from standard `index.html`.
  - Reduced repository and installer footprint while eliminating multi-file synchronization overhead.
- **Installer Clean Upgrade Pipeline**:
  - Automatically detect and terminate running app processes (`msedge.exe`, `chrome.exe`, batch, and launcher processes) before installation to prevent file locking.
  - Query registry for previous version uninstaller (`unins000.exe`) and execute silent uninstallation (`/VERYSILENT /NORESTART /SUPPRESSMSGBOXES`) in `PrepareToInstall`.
  - Automatically remove lingering legacy installation folders (e.g. `C:\Program Files\ClassroomVisualizer\`) to ensure a completely clean directory structure.
  - Set `UsePreviousAppDir=no` so new installations standardize on `{autopf}\AhBiCamViewer`.
  - Added `CloseApplications=yes` and `RestartApplications=no` for Windows Restart Manager integration.
- **Pure Native & Managed DLL Rename**:
  - Renamed `ClassroomVisualizerCore.dll` → `AhBiCamViewerCore.dll` and `ClassroomVisualizerManaged.dll` → `AhBiCamViewerManaged.dll` to prevent naming collision with existing external web applications.
  - Renamed IL source `src/dll/ClassroomVisualizerCore.il` → `src/dll/AhBiCamViewerCore.il`.
  - Updated .NET namespaces from `AhBiYout.ClassroomVisualizer.Core` to `AhBiYout.AhBiCamViewer.Core`.
  - Updated Inno Setup installer (`installer.iss`), test suite (`TestRunner.cs`), CI/CD workflow, and all documentation.
- **Repository Rename**: GitHub repository renamed from `ClassroomVisualizer` to `AhBiCamViewer` across all project files.
- **Launcher Consolidation**: Removed duplicate `tools/ClassroomVisualizer.bat`; unified to `tools/AhBiCamViewer.bat`.
- **Installer Update**: `installer.iss` now references `AhBiCamViewer.bat` as the app executable name.

### Added
- **High-Performance Horizontal Collapsible Accordion System in Bottom Toolbar**:
  - Structured the bottom toolbar into 3 collapsible functional zones with individual toggle headers:
    1. 🎬 **Capture & Screen Control** (`capture`): Camera start/stop, freeze, snap, format switch, record, effects, fullscreen, dual-monitor jump, mirror, rotate (11 tools).
    2. 🎥 **Camera Device & Quality** (`device`): Device picker, resolution picker with support indicator dot, facing switch, device rescan, and hardware spec modal (6 tools).
    3. 🧰 **Video Adjust & Teaching Tools** (`tools`): Zoom slider, presets, document contrast, AF, torch, brightness/contrast/exposure sliders, and classroom utility grid (2 tool dropdowns).
  - **Tool Count Badges**: Added live item count indicators (`[11]`, `[6]`, `[2]`) to provide clear visual feedback on collapsed sections.
  - **Master Accordion Toggle Button**: Added a dedicated master button (`#bAccToggleMaster`) in fixed controls displaying `[🗂️ 전체 접기]` / `[📂 전체 펼치기]` with live state reflection.
  - **Classroom Presentation Hotkeys**: Added global keyboard shortcuts for fast, distraction-free projector operation:
    - `Alt+1`: Toggle Zone 1 (Capture & Screen Control)
    - `Alt+2`: Toggle Zone 2 (Camera Device & Quality)
    - `Alt+3`: Toggle Zone 3 (Video Adjust & Tools)
    - `Alt+0`: Master toggle all zones simultaneously
  - **Smooth CSS Chevron Rotation**: Eliminated double-inversion bug by retaining constant `◀` glyph and letting CSS rotate `0deg` (expanded) ↔ `180deg` (collapsed `▶`).
  - **Aesthetic Zone Boundary Styling**: Grouped each section in subtle semi-transparent pill container (`rgba(255,255,255,0.02)`) with border highlight on hover and dimmed dividers on collapse.
  - State persistence in `localStorage` (`cv_bottom_accordion_zones`) across reloads.
  - Active feature indicator dots on collapsed toggle pills (recording pulse red dot, active green dot, tool blue dot).
  - Alt+Click shortcut to toggle all accordion sections at once.
  - Compact responsive display on tablets and narrow viewports (`@media(max-width:960px)`).
- **Movable Geometric Shape Cards & Multi-Layer Compositing Engine**:
  - Implemented movable interactive shape cards for all 7 geometric shape tools (Line, Rectangle, Circle, Triangle, Arrow, Double Arrow, Star).
  - Smooth Pointer Capture drag-and-drop movement across the canvas with comfortable bounding-box padding.
  - Hover interaction with guide boundary, one-click Delete (`✕`), and Canvas Bake (`📌`) to permanently fuse shapes into the drawing layer.
  - Independent preservation of shape styles (solid/dashed/dotted stroke, none/trans25/trans50/solid fill, line width, color).
  - High-precision 4-layer vector compositing pipeline (`renderShapeAnnotationsToCanvas`):
    - Full-resolution vector compositing during still image captures (JPG/PNG/WebP).
    - Real-time frame compositing in MP4/WebM video recording.
    - Multi-page bundled PDF export vector preservation.
    - Real-time magnified vector rendering under the interactive Magnifier tool.
  - Unified shape cleanup in `clearDraw` confirmation flow.
  - Updated Pure Creative Native DLL (`ClassroomVisualizerCore.dll`) version constant to `0x01040700 (v1.4.7)` with 15/15 unit test verification.

---

## [1.4.6] - 2026-11-05
### Added
- **Movable & Editable Text Annotation Cards System**:
  - Implemented interactive movable DOM text annotation card engine supporting smooth pointer capture drag-and-drop.
  - Added double-click in-place text re-editing with ESC cancellation and newline support.
  - Added one-click Delete (`✕`) and Canvas Bake (`📌`) hover action buttons.
  - Multi-layer canvas compositing engine (`renderTextAnnotationsToCanvas`):
    - Full-fidelity rendering in JPG/PNG still capture downloads with resolution-aware coordinate scaling.
    - Real-time frame compositing in MP4/WebM video recording without UI overhead.
    - High-quality compositing in bundled multi-page PDF export (`pdfAll`).
    - Exact real-time magnified rendering in the interactive Magnifier tool (`renderMagnifier`).
  - Integrated text card cleanup into the clear all drawings (`clearDraw`) confirmation flow.
  - Updated Pure Creative Native DLL (`ClassroomVisualizerCore.dll`) version constant to `0x01040600 (v1.4.6)` with 15/15 unit test verification.

---

## [1.4.5] - 2026-11-04
### Added
- **Speed & Pressure Sensitive Brush Tip Engine (`drawBrushPreview`)**:
  - Implemented dynamic organic brush pen width algorithm responding to stroke speed (0.35x to 1.65x) and stylus pressure.
  - Added continuous 4-step quadratic bezier tapering interpolation eliminating stepped or jagged stroke widths.
  - Implemented signature brush stroke preview renderer (`drawBrushPreview`) in both Pen and Highlighter flyout menus.
  - Added custom tilted oval cursor (`-25deg`) for brush tip mode providing intuitive ergonomic visual feedback.

### Fixed
- Fixed highlighter (`marker`) brush tip rendering identical to round tip by removing hardcoded static width override (`+size.value * 4`) and integrating the dynamic brush width pipeline.
- Fixed brush tip preview canvases falling back to generic round line preview.

---

## [1.4.4] - 2026-11-01
### Added
- **15 Pure Creative Native Win32 APIs (`ClassroomVisualizerCore.dll`)**:
  - `CV_PlayCustomTone`: Win32 `kernel32!Beep` hardware tone output, immune to browser background tab throttling.
  - `CV_GetDiskFreeSpaceMB`: Pre-recording storage capacity diagnosis via `GetDiskFreeSpaceExA` preventing 0KB recording failure.
  - `CV_GetDisplayDpi`: Primary display DPI scaling detection (96=100%, 120=125%, 144=150%, 192=200%) for electronic whiteboards and 4K beam projectors.
  - `CV_SetWindowTopmost`: Win32 `SetWindowPos` Always-on-Top floating PIP view for teaching over PDF/PPT.
  - `CV_GetPerformanceTimeMs`: High-precision microsecond monotonic timestamp via `QueryPerformanceCounter`.
  - Comprehensive `.try ... catch [mscorlib]System.Exception` blocks wrapping all 15 native IL exports, guaranteeing 0% host crash rate.
  - 15/15 unit test suite (`TestRunner.exe`) with 100% PASS rate.
- **Virtual Camera Anti-Feedback Protection**:
  - Comprehensive virtual capture filter identification (`screen-recorder-device`, `OBS Virtual Camera`, `ManyCam`, `XSplit`, `vMix`, etc.).
  - Complete exclusion of virtual cameras from auto-connect and auto-start, completely eliminating infinite screen loopback / mirror room (Droste Effect) when no physical camera is attached.
- **Unpacked Multi-File Inno Setup 6 Installer & Windows Firewall Automation**:
  - Unpacked multi-file installation architecture preventing single-file temporary extraction overhead.
  - Existing installation detection with overwrite confirmation dialog.
  - Silent installation support via `/SILENT` and `/VERYSILENT`.
  - Pre-registered Windows Firewall outbound/inbound rules for both base and versioned executable names, and automatic cleanup on uninstallation.
- **GitHub Releases Real-Time Auto-Update System**:
  - Auto-checks releases on launch with interactive update notification popup.
- **CI/CD Pipeline Upgrade**:
  - Migrated GitHub Actions runner to Node.js 22 LTS complying with Node.js 20 deprecation / EOL mandate.
  - Release assets restricted exclusively to setup installer executable.

### Fixed
- Fixed 0KB video file creation bug during recording by refactoring media chunk acquisition and container finalizing.
- Fixed infinite screen replication when opening the application without a physical camera.

---

## [1.4.0] - 2026-10-18
### Added
- **Fullscreen Menu Auto-Unpin & Hover Drawer (`toggleFullscreen`)**:
  - Automatically unpins left and bottom toolbars upon entering fullscreen (`document.documentElement.requestFullscreen`), providing a 100% clean, unobstructed canvas for classroom projectors and electronic whiteboards.
  - Enables smooth accordion drawer mode peeking out only when the cursor hovers near the screen boundaries.
  - Automatically restores previous pinned/unpinned state upon exiting fullscreen.
  - Fullscreen CSS optimizations: hides header and thumbnail strip, expands main viewport to 100vh.
- **Clean Capture Engine (`capture`, Hotkey `S`)**:
  - Instantly dismisses all active flyout menus and dropdowns prior to capturing.
  - Generates high-fidelity JPG snapshots compositing only the camera feed (with filters, zoom, mirror, rotation) and chalkboard annotations (`draw`), completely omitting menu bars, toolbars, and cursor overlays.
  - Added single-key `S` hotkey for instant snapshot capture.
- **High-Fidelity Composite Video Recording Engine (`record`)**:
  - Built real-time 30 FPS off-screen canvas compositor (`recCanvas.captureStream(30)`) simultaneously recording camera video and live drawing annotations without third-party dependencies.
  - Menu toolbars, headers, and UI controls are 100% excluded from the recorded stream.
  - Automatically unpins toolbars and closes active dropdowns on recording start.
  - Displays pulsed `[🔴 REC 00:00 (Click to Stop)]` on-screen status badge with live elapsed timer.
  - Automatically downloads timestamped `.webm` video on stop and restores toolbar pin states.
- **Complete Elimination of Repeated Camera Permission Prompts**:
  - Scoped Chromium `--use-fake-ui-for-media-stream` startup flag in standalone launchers (`launcher.vbs`, `.bat` scripts), connecting real hardware cameras while bypassing browser permission UI popups.
  - Implemented in-place dynamic resolution adjustments via `track.applyConstraints({ width, height })`, eliminating stream teardowns and permission re-prompts on resolution changes.
  - Implemented Smooth Stream Handoff: keeps previous stream active until new camera stream is successfully acquired, preserving the browser's active streaming permission state.
  - Auto-starts camera on application launch, reducing permission prompts to a single initial grant.
- **Camera Hardware Details Diagnostic Modal (`#camInfoModal`)**:
  - Added `[🔍 상세정보]` modal inspecting active stream specs (actual resolution, FPS, aspect ratio, device ID, classification tier).
  - Inspects 11 UVC hardware capabilities (zoom range, focus modes, exposure modes, torch/light, pan/tilt, white balance).
  - Lists all detected video input devices with direct one-click switching buttons and one-click formatted diagnostic clipboard copy.
- **Magnifier Composite Canvas Renderer & Mouse Wheel Control**:
  - Replaced video scaling approach with dual-layer offscreen canvas compositing camera feed and chalkboard handwriting simultaneously at 1:1 coordinates.
  - Added mouse wheel control for circular lens radius (60px ~ 240px) and `Shift + Wheel` for internal zoom magnification (1.5x ~ 5.0x).
- **Spotlight Lighting Mouse Wheel Control**:
  - Real-time mouse wheel adjustment for spotlight aperture radius (50px ~ 350px) with high-visibility gold neon glow border.
- **Responsive Dynamic Bottom Toolbar Layout**:
  - Added horizontal smooth scrolling (`overflow-x: auto`) and 3-tier media query breakpoints (1100px, 768px, 480px) to prevent button clipping on compact laptops and netbooks.
- **Dedicated Highlighter Independent Color Palette**:
  - Separated pen and highlighter colors into independent state slots.
  - Features 6 signature fluorescent colors (yellow, green, pink, orange, sky blue, lavender) and dedicated custom marker color picker.
- **Toolbar Pin/Unpin (📌) & Accordion Auto-Hide Mode**:
  - Added pin toggle buttons on left and bottom toolbars with persistent `localStorage` settings.
  - Smooth sliding accordion drawer mode revealing tools on hover and retracting to edge handles when idle.
- **Dual Monitor Window Jump (`#jumpMonitor`)**:
  - Added one-click monitor jump chip button to move window between primary and secondary displays.
  - Utilizes Multi-Screen Window Placement API (`window.getScreenDetails`) with robust fallback to `window.screen` / `window.moveTo` and Windows shortcut (`Win+Shift+Arrow`) guidance.
- **Smart Camera & Webcam / Laptop Recognition Engine**:
  - Implemented 3-tier camera classification: Document Cameras (`[★ 실물화상기]`), External Webcams (`[🎥 외장 웹캠]`), and Laptop Built-in Cameras (`[💻 노트북 내장]`).
  - Added dynamic dropdown summary indicator (e.g. `카메라 3대 감지됨 (실물화상기 1, 웹캠 1, 노트북 1)`).
  - Added silent permission probe (`requestCameraPermissionProbe`) to unmask device labels prior to explicit user stream request.
  - Added real-time USB hot-plug detection and auto-reconnection via `devicechange` event with debounce.
  - Added camera-type badge integration into resolution header badge.
  - Added customized Korean diagnostic error modals for camera access permissions, busy/occupied locks, and unavailable devices.
- **Split Left & Bottom Toolbar Layout**:
  - Re-architected user interface with a vertical left sidebar for drawing and presentation tools and a horizontal bottom bar for camera, video adjustments, and utility controls.
  - Implemented smart flyout/pulldown dropdown menus for Geometric Shapes, Color & Stroke Palette, Video/Lens Adjustments, and Classroom Utilities.
  - Added collapsible thumbnail gallery toggle (`[🖼 캡처 목록 ▾]`) to maximize canvas workspace.
  - Integrated click-outside detection for clean, automatic popup dismissal.
- **Standalone WebView Desktop App Launcher**:
  - Implemented smart standalone chromeless launcher (`tools/launcher.vbs`) automatically locating Microsoft Edge and Google Chrome to run with `--app="file:///..."` and `--window-size=1280,800`.
  - Updated desktop and start menu installer shortcuts (`installer.iss`) to launch directly into an isolated, address-bar-free desktop window.
  - Synchronized portable batch launcher (`tools/ClassroomVisualizer.bat`) for instant chromeless standalone execution.
- **Enhanced Drawing Engine**:
  - **Smooth Bezier Writing**: Quadratic bezier interpolation (`quadraticCurveTo`) eliminating jagged polyline artifacts for natural, calligraphy-like pen handwriting.
  - **Dynamic Stylus Pressure Sensitivity**: Dynamic stroke width modulation according to `e.pressure` on drawing tablets and smart interactive whiteboards.
  - **True Highlighter Rendering**: Translucent multiplier-like highlighter brush preventing muddy dark overlays on textbook text.
  - **New Geometry Shapes**: Added Triangle (`shapeTriangle`), Double-Ended Arrow (`shapeDoubleArrow`), and 5-Point Star (`shapeStar`).
  - **Translucent Shape Fill Mode**: Optional semi-transparent fill toggle for rectangle, circle, triangle, and star highlight callouts.
  - **Shift Key Geometric Constraint**: Snaps lines/arrows to 45° increments and rectangles/circles/stars to 1:1 aspect ratios.
  - **Visual Eraser Ring Cursor**: Real-time dashed circular preview ring following pointer position indicating exact erase radius.
  - **Disappearing Laser Trail Pen**: 1.4-second fading neon laser trail for temporary instructional attention direction.
  - **Quick Color Dots & Size Presets**: 8-color quick selection dots, HTML5 custom color picker, and 4-tier stroke size buttons (3px, 6px, 12px, 24px).
  - **Readable Text Card Annotations**: Renders rounded card background and soft shadow behind text for guaranteed legibility over complex photos.
  - **Zero Data Loss Canvas Resize**: Automatic off-screen buffer backup and restore preserving annotations across browser window resizes and fullscreen toggles.
  - **Classroom Keyboard Hotkeys**: Single-key shortcuts for Pen (`P`), Marker (`M`/`H`), Eraser (`E`), Line (`L`), Rect (`R`), Circle (`C`), Arrow (`A`), Text (`T`), Fill (`F`), Size (`[`/`]`), and Colors (`1`-`8`).
- **Native Export Win32 DLL (`ClassroomVisualizerCore.dll`)**: Pure C#/IL hybrid architecture using `.vtfixup` and `.export` to provide true 32-bit stdcall native exports without external C++ compilers.
- **Installer Integration**: Connected `CV_GetVersion` directly into Inno Setup's `InitializeSetup()` stage for automatic pre-install binary integrity validation.
- **Native License & Trial APIs**: Implemented `CV_ValidateKeyA`, `CV_IsTrialKeyA`, and `CV_VerifyTrialStatus` for high-speed offline validation.
- **Architecture Documentation**: Added `docs/NATIVE_DLL_ARCHITECTURE.md` detailing PE structure, VTable Thunks, and API reference.
- **Free / Pro Tier System**: Implemented offline license key validation (`XXXX-XXXX-XXXX-XXXX`), dynamic tier badge, locked feature modals, and feature gating.
- **30-Day Pro Trial System**: Added automatic 30-day trial key generation (`TRIAL-XXXX-XXXX-XXXX`) and expiration tracking.
- **Camera-Independent Canvas**: Enabled drawing tools (pen, highlighter, eraser, shapes) and image/PDF export even when no camera hardware is connected.
- **Native Max High-Resolution Auto-Negotiation**: Added `max` mode to automatically discover and request the camera's highest native sensor resolution (4K UHD, 8MP, 5MP).
- **Expanded Document Camera Aspect Ratios**: Added 8MP 4:3 (`3264×2448`) and QHD 2K 16:9 (`2560×1440`) profiles optimized for classroom document cameras and high-definition webcams.
- **Dynamic Resolution Quality Badge**: Added real-time tier pill indicator (4K/8MP green, QHD/5MP blue, FHD cyan, HD orange).
- **High-Fidelity Capture & Export**: Enabled `imageSmoothingQuality = 'high'` and increased JPEG export quality to 0.96 for fine text and mathematical formula legibility.

### Changed
- **Progressive Fallback**: Gracefully recovers and falls back to standard camera constraints if a device rejects high-resolution constraints.

---

## [1.3.1] - 2026-10-09
### Changed
- **Offline / Local USB Webcam Focus**: Removed wireless QR code / PeerJS WebRTC P2P module to ensure complete offline reliability and eliminate mobile HTTPS context barriers.
- **Firewall Policy Hardening**: Removed automatic inbound TCP firewall rules in Inno Setup (`installer.iss`) in accordance with the principle of least privilege, while keeping uninstallation cleanup for legacy rules.
- **Build Pipeline**: Upgraded `build.bat` with robust label-based control flow, version-isolated artifact directories (`dist/1.3.1/`), and lossless UTF-8 CRLF normalization.
- **Documentation**: Completed full documentation suite (`ARCHITECTURE.md`, `ROADMAP.md`, `SECURITY.md`, `MODULES.md`, `BUILD.md`, `INSTALL.md`, `WORK_LOG.md`).

### Fixed
- Fixed potential `CreateProcess error code 2` upon installation by enforcing `shellexec` in Inno Setup.
- Fixed batch script mojibake caused by ASCII re-encoding in CRLF formatter.

---

## [1.3.0] - 2026-10-08
### Added
- **Hardware Camera Direct Control**:
  - LED Torch on/off toggle for low-light document inspection.
  - Tap-to-Focus with visual pulse ring animation.
  - Hardware exposure compensation dial (-2EV to +2EV).
- **P2P Wireless Prototype**: Initial implementation of QR code WebRTC connection.

---

## [1.2.0] - 2026-10-08
### Added
- Front/Back camera switching (`facingMode: environment / user`).
- 2-finger pinch-to-zoom for mobile screens and `Ctrl+Wheel` for desktop.
- Dynamic resolution selector (4K UHD, FHD 1080p, HD 720p, VGA 480p).
- Automated GitHub Releases update notice modal.
- Multi-file Inno Setup installer packaging with desktop shortcuts.

---

## [1.1.0] - 2026-10-08
### Added
- Countdown timer with 10-second warning blink and audio alert.
- Geometry drawing tools: line, rectangle, circle, arrow.
- Text annotation on canvas.
- 3 types of background grids: graph paper, dot grid, ruled lines.
- Dual-image split-view comparison slider.
- Multi-step Undo/Redo history stack (up to 40 steps).
- Picture-in-Picture (PIP) mode.
- Attention bell sound effects (Web Audio API).

---

## [1.0.0] - 2026-10-08
### Added
- Initial release of Classroom Visualizer.
- UVC WebRTC plug-and-play camera stream.
- Screen freeze, instant PNG snapshot, mirror, and 90-degree rotation.
- Freehand pen, highlighter, eraser.
- A4 landscape PDF compilation and WebM video recording.
- Spotlight, magnifying glass, laser pointer, and curtain tools.
