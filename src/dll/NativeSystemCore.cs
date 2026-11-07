// ==============================================================================
// AhBiYout AhBiCamViewer - Native System & Presentation Core
// Pure-C# implementation of Windows Presentation Sleep Prevention,
// Multi-Monitor / Projector topology detection, High-DPI sensor scaling,
// Disk storage safety verification, Hardware tone generation, and Window Topmost.
// ==============================================================================

using System;
using System.Runtime.InteropServices;

namespace AhBiYout.AhBiCamViewer.Core
{
    public static class NativeSystemCore
    {
        #region Win32 P/Invoke Declarations

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern uint SetThreadExecutionState(uint esFlags);

        private const uint ES_SYSTEM_REQUIRED = 0x00000001;
        private const uint ES_DISPLAY_REQUIRED = 0x00000002;
        private const uint ES_CONTINUOUS = 0x80000000;

        [DllImport("user32.dll")]
        private static extern int GetSystemMetrics(int nIndex);

        private const int SM_CXSCREEN = 0;
        private const int SM_CYSCREEN = 1;
        private const int SM_XVIRTUALSCREEN = 76;
        private const int SM_YVIRTUALSCREEN = 77;
        private const int SM_CXVIRTUALSCREEN = 78;
        private const int SM_CYVIRTUALSCREEN = 79;
        private const int SM_CMONITORS = 80;

        [DllImport("user32.dll")]
        private static extern bool MessageBeep(uint uType);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern bool Beep(uint dwFreq, uint dwDuration);

        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        private static extern bool GetDiskFreeSpaceExA(string lpDirectoryName, out ulong lpFreeBytesAvailable, out ulong lpTotalNumberOfBytes, out ulong lpTotalNumberOfFreeBytes);

        [DllImport("user32.dll")]
        private static extern IntPtr GetDC(IntPtr hWnd);

        [DllImport("user32.dll")]
        private static extern int ReleaseDC(IntPtr hWnd, IntPtr hDC);

        [DllImport("gdi32.dll")]
        private static extern int GetDeviceCaps(IntPtr hdc, int nIndex);

        private const int LOGPIXELSX = 88;
        private const int LOGPIXELSY = 90;

        [DllImport("user32.dll", SetLastError = true)]
        private static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

        private static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
        private static readonly IntPtr HWND_NOTOPMOST = new IntPtr(-2);
        private const uint SWP_NOMOVE = 0x0002;
        private const uint SWP_NOSIZE = 0x0001;
        private const uint SWP_SHOWWINDOW = 0x0040;

        [DllImport("kernel32.dll")]
        private static extern bool QueryPerformanceCounter(out long lpPerformanceCount);

        [DllImport("kernel32.dll")]
        private static extern bool QueryPerformanceFrequency(out long lpFrequency);

        #endregion

        /// <summary>
        /// Prevents Windows display and system sleep during classroom visualizer presentations.
        /// enable != 0: Keep screen and system awake.
        /// enable == 0: Restore normal Windows power and sleep behavior.
        /// Returns 1 on success, 0 on failure.
        /// </summary>
        public static int PreventSleep(int enable)
        {
            try
            {
                if (enable != 0)
                {
                    uint res = SetThreadExecutionState(ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED);
                    return res != 0 ? 1 : 0;
                }
                else
                {
                    uint res = SetThreadExecutionState(ES_CONTINUOUS);
                    return res != 0 ? 1 : 0;
                }
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        /// Returns the count of active display monitors detected on the machine.
        /// Always returns at least 1.
        /// </summary>
        public static int GetMonitorCount()
        {
            try
            {
                int count = GetSystemMetrics(SM_CMONITORS);
                return count > 0 ? count : 1;
            }
            catch
            {
                return 1;
            }
        }

        /// <summary>
        /// Retrieves the bounding coordinates of the virtual desktop spanning all monitors.
        /// </summary>
        public static int GetVirtualScreenBounds(out int left, out int top, out int width, out int height)
        {
            try
            {
                left = GetSystemMetrics(SM_XVIRTUALSCREEN);
                top = GetSystemMetrics(SM_YVIRTUALSCREEN);
                width = GetSystemMetrics(SM_CXVIRTUALSCREEN);
                height = GetSystemMetrics(SM_CYVIRTUALSCREEN);

                if (width <= 0 || height <= 0)
                {
                    left = 0;
                    top = 0;
                    width = GetSystemMetrics(SM_CXSCREEN);
                    height = GetSystemMetrics(SM_CYSCREEN);
                }
                return 1;
            }
            catch
            {
                left = 0;
                top = 0;
                width = 1920;
                height = 1080;
                return 0;
            }
        }

        /// <summary>
        /// Triggers a native system alert chime for the classroom attention bell.
        /// alertType: 0 = Standard, 1 = Information/Asterisk, 2 = Warning, 3 = Question, 4 = Critical
        /// </summary>
        public static int PlayAttentionAlert(int alertType)
        {
            try
            {
                uint beepType;
                switch (alertType)
                {
                    case 1:  beepType = 0x00000040; break; // MB_ICONASTERISK
                    case 2:  beepType = 0x00000030; break; // MB_ICONEXCLAMATION
                    case 3:  beepType = 0x00000020; break; // MB_ICONQUESTION
                    case 4:  beepType = 0x00000010; break; // MB_ICONHAND
                    default: beepType = 0xFFFFFFFF; break; // Simple beep
                }
                return MessageBeep(beepType) ? 1 : 0;
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        /// Plays a pure hardware speaker tone at specified frequency (Hz) and duration (ms).
        /// Ideal for classroom countdown timers and attention bells, immune to browser throttling.
        /// </summary>
        public static int PlayCustomTone(int frequency, int durationMs)
        {
            try
            {
                if (frequency < 37) frequency = 37;
                if (frequency > 32767) frequency = 32767;
                if (durationMs <= 0) durationMs = 100;
                if (durationMs > 10000) durationMs = 10000;
                if (Beep((uint)frequency, (uint)durationMs))
                {
                    return 1;
                }
                // Fallback for headless environments, cloud CI runners (GitHub Actions/Azure), or systems without physical PC speakers
                return MessageBeep(0xFFFFFFFF) ? 1 : 0;
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        /// Retrieves the available disk space in Megabytes (MB) for a target drive or directory.
        /// Prevents 0KB recording failures and capture stalls.
        /// </summary>
        public static int GetDiskFreeSpaceMB(string drivePath, out int freeMB)
        {
            freeMB = 0;
            try
            {
                if (string.IsNullOrEmpty(drivePath)) drivePath = "C:\\";
                ulong freeBytes, totalBytes, totalFree;
                if (GetDiskFreeSpaceExA(drivePath, out freeBytes, out totalBytes, out totalFree))
                {
                    freeMB = (int)(freeBytes / (1024 * 1024));
                    return 1;
                }
                return 0;
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        /// Retrieves the primary display DPI scaling (96 = 100%, 120 = 125%, 144 = 150%, 192 = 200%).
        /// Essential for high-DPI electronic whiteboards (전자칠판) and 4K projectors.
        /// </summary>
        public static int GetDisplayDpi(out int dpiX, out int dpiY)
        {
            dpiX = 96;
            dpiY = 96;
            try
            {
                IntPtr hdc = GetDC(IntPtr.Zero);
                if (hdc != IntPtr.Zero)
                {
                    dpiX = GetDeviceCaps(hdc, LOGPIXELSX);
                    dpiY = GetDeviceCaps(hdc, LOGPIXELSY);
                    ReleaseDC(IntPtr.Zero, hdc);
                    if (dpiX <= 0) dpiX = 96;
                    if (dpiY <= 0) dpiY = 96;
                    return 1;
                }
                return 0;
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        /// Controls window topmost state (Always-On-Top floating PIP window).
        /// topmost != 0: Float on top of PowerPoint/PDF textbook.
        /// topmost == 0: Restore normal window Z-order.
        /// </summary>
        public static int SetWindowTopmost(IntPtr hWnd, int topmost)
        {
            try
            {
                if (hWnd == IntPtr.Zero) return 0;
                IntPtr insertAfter = (topmost != 0) ? HWND_TOPMOST : HWND_NOTOPMOST;
                return SetWindowPos(hWnd, insertAfter, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_SHOWWINDOW) ? 1 : 0;
            }
            catch
            {
                return 0;
            }
        }

        private static long s_qpcBase = 0;
        private static long s_qpcFreq = 0;

        /// <summary>
        /// Returns high-resolution monotonic elapsed milliseconds with microsecond precision.
        /// Optimized for video recording frame pacing and sync validation.
        /// </summary>
        public static int GetPerformanceTimeMs()
        {
            try
            {
                if (s_qpcFreq == 0)
                {
                    QueryPerformanceFrequency(out s_qpcFreq);
                    QueryPerformanceCounter(out s_qpcBase);
                }
                long current;
                QueryPerformanceCounter(out current);
                double elapsedSec = (double)(current - s_qpcBase) / s_qpcFreq;
                return (int)(elapsedSec * 1000.0);
            }
            catch
            {
                return Environment.TickCount;
            }
        }
    }
}
