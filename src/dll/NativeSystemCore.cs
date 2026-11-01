// ==============================================================================
// AhBiYout Classroom Visualizer - Native System & Presentation Core
// Pure-C# implementation of Windows Presentation Sleep Prevention,
// Multi-Monitor / Projector topology detection, and classroom audio alerts.
// ==============================================================================

using System;
using System.Runtime.InteropServices;

namespace AhBiYout.ClassroomVisualizer.Core
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
    }
}
