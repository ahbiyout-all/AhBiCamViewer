// ==============================================================================
// AhBiYout Classroom Visualizer - Native DLL Test Runner (15 Native Tests)
// Verifies 100% of native exported functions in ClassroomVisualizerCore.dll
// ==============================================================================

using System;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;

namespace AhBiYout.ClassroomVisualizer.Testing
{
    class Program
    {
        private const string DLL_PATH = "ClassroomVisualizerCore.dll";

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetVersion();

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_ValidateKeyA(IntPtr pKeyAnsi);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_IsTrialKeyA(IntPtr pKeyAnsi);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_VerifyTrialStatus(int startDay, int currentDay, int trialDays, IntPtr pDaysRemaining);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetMachineFingerprintA(IntPtr pOutBuffer, int bufferSize);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GenerateTrialKeyA(IntPtr pOutBuffer, int bufferSize);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_PreventSleep(int enable);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetMonitorCount();

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetVirtualScreenBounds(IntPtr pLeft, IntPtr pTop, IntPtr pWidth, IntPtr pHeight);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_PlayAttentionAlert(int alertType);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_PlayCustomTone(int frequency, int durationMs);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetDiskFreeSpaceMB(IntPtr pDrivePathAnsi, IntPtr pFreeMB);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetDisplayDpi(IntPtr pDpiX, IntPtr pDpiY);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_SetWindowTopmost(IntPtr hWnd, int topmost);

        [DllImport(DLL_PATH, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetPerformanceTimeMs();

        static int Main(string[] args)
        {
            Console.WriteLine("============================================================");
            Console.WriteLine("[TEST SUITE] ClassroomVisualizer Pure Native DLL Verification (15 Tests)");
            Console.WriteLine("============================================================");

            int passed = 0;
            int total = 15;

            // TEST 1: CV_GetVersion (0x01040700 for v1.4.7)
            int ver = CV_GetVersion();
            Console.WriteLine("[TEST 1] CV_GetVersion: 0x{0:X8}", ver);
            if (ver == 0x01040700)
            {
                Console.WriteLine("         PASS: Version matches v1.4.7.0 (0x01040700)");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Expected 0x01040700");
            }

            // TEST 2: CV_ValidateKeyA
            IntPtr pValidKey = Marshal.StringToHGlobalAnsi("TR30-AGP5-GYL6-JK8F");
            IntPtr pInvalidKey = Marshal.StringToHGlobalAnsi("INVALID-KEY-1234");
            int val1 = CV_ValidateKeyA(pValidKey);
            int val2 = CV_ValidateKeyA(pInvalidKey);
            int val3 = CV_ValidateKeyA(IntPtr.Zero);
            Marshal.FreeHGlobal(pValidKey);
            Marshal.FreeHGlobal(pInvalidKey);
            Console.WriteLine("[TEST 2] CV_ValidateKeyA: valid={0}, invalid={1}, null={2}", val1, val2, val3);
            if (val1 == 1 && val2 == 0 && val3 == 0)
            {
                Console.WriteLine("         PASS: Checksum validation and NULL safety correct");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Validation logic mismatch");
            }

            // TEST 3: CV_IsTrialKeyA
            IntPtr pTrial = Marshal.StringToHGlobalAnsi("TR30-AGP5-GYL6-JK8F");
            IntPtr pPro = Marshal.StringToHGlobalAnsi("PRO1-G9LX-KBRN-S26M");
            int trialRes = CV_IsTrialKeyA(pTrial);
            int proRes = CV_IsTrialKeyA(pPro);
            Marshal.FreeHGlobal(pTrial);
            Marshal.FreeHGlobal(pPro);
            Console.WriteLine("[TEST 3] CV_IsTrialKeyA: trial={0}, nonTrial={1}", trialRes, proRes);
            if (trialRes == 1 && proRes == 0)
            {
                Console.WriteLine("         PASS: Trial prefix detection correct");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Trial key prefix logic mismatch");
            }

            // TEST 4: CV_VerifyTrialStatus (Day 100 to 109, 30-day limit)
            IntPtr pRem = Marshal.AllocHGlobal(4);
            int status1 = CV_VerifyTrialStatus(100, 109, 30, pRem);
            int remDays1 = Marshal.ReadInt32(pRem);
            int status2 = CV_VerifyTrialStatus(100, 140, 30, pRem);
            int remDays2 = Marshal.ReadInt32(pRem);
            Marshal.FreeHGlobal(pRem);
            Console.WriteLine("[TEST 4] CV_VerifyTrialStatus: active={0} (rem={1}d), expired={2} (rem={3}d)", status1, remDays1, status2, remDays2);
            if (status1 == 1 && remDays1 == 21 && status2 == 0 && remDays2 == 0)
            {
                Console.WriteLine("         PASS: Trial expiration & remaining days calculation accurate");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Expiration calculation mismatch");
            }

            // TEST 5: CV_GetMachineFingerprintA
            IntPtr pFpBuf = Marshal.AllocHGlobal(32);
            int fpLen = CV_GetMachineFingerprintA(pFpBuf, 32);
            string fp = Marshal.PtrToStringAnsi(pFpBuf);
            Marshal.FreeHGlobal(pFpBuf);
            Console.WriteLine("[TEST 5] CV_GetMachineFingerprintA: '{0}' (len={1})", fp, fpLen);
            if (fpLen == 16 && !string.IsNullOrEmpty(fp))
            {
                Console.WriteLine("         PASS: Machine fingerprint hash generated (16 hex chars)");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Fingerprint length or format mismatch");
            }

            // TEST 6: CV_GenerateTrialKeyA
            IntPtr pKeyBuf = Marshal.AllocHGlobal(32);
            int genLen = CV_GenerateTrialKeyA(pKeyBuf, 32);
            string genKey = Marshal.PtrToStringAnsi(pKeyBuf);
            int isGenValid = CV_ValidateKeyA(pKeyBuf);
            int isGenTrial = CV_IsTrialKeyA(pKeyBuf);
            Marshal.FreeHGlobal(pKeyBuf);
            Console.WriteLine("[TEST 6] CV_GenerateTrialKeyA: '{0}' (valid={1}, trial={2})", genKey, isGenValid, isGenTrial);
            if (genLen == 19 && isGenValid == 1 && isGenTrial == 1)
            {
                Console.WriteLine("         PASS: Dynamically generated trial key conforms to checksum and prefix");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Generated key format or checksum invalid");
            }

            // TEST 7: CV_PreventSleep
            int sleepOn = CV_PreventSleep(1);
            int sleepOff = CV_PreventSleep(0);
            Console.WriteLine("[TEST 7] CV_PreventSleep: enable={0}, restore={1}", sleepOn, sleepOff);
            if (sleepOn == 1 && sleepOff == 1)
            {
                Console.WriteLine("         PASS: Win32 SetThreadExecutionState presentation sleep control operational");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: SetThreadExecutionState call failed");
            }

            // TEST 8: CV_GetMonitorCount
            int monCount = CV_GetMonitorCount();
            Console.WriteLine("[TEST 8] CV_GetMonitorCount: {0} active monitor(s) detected", monCount);
            if (monCount >= 1)
            {
                Console.WriteLine("         PASS: Display monitor topology detection operational");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Monitor count must be >= 1");
            }

            // TEST 9: CV_GetVirtualScreenBounds
            IntPtr pLeft = Marshal.AllocHGlobal(4);
            IntPtr pTop = Marshal.AllocHGlobal(4);
            IntPtr pWidth = Marshal.AllocHGlobal(4);
            IntPtr pHeight = Marshal.AllocHGlobal(4);
            int vRes = CV_GetVirtualScreenBounds(pLeft, pTop, pWidth, pHeight);
            int vx = Marshal.ReadInt32(pLeft);
            int vy = Marshal.ReadInt32(pTop);
            int vw = Marshal.ReadInt32(pWidth);
            int vh = Marshal.ReadInt32(pHeight);
            Marshal.FreeHGlobal(pLeft);
            Marshal.FreeHGlobal(pTop);
            Marshal.FreeHGlobal(pWidth);
            Marshal.FreeHGlobal(pHeight);
            Console.WriteLine("[TEST 9] CV_GetVirtualScreenBounds: ok={0}, rect=({1},{2}, {3}x{4})", vRes, vx, vy, vw, vh);
            if (vRes == 1 && vw > 0 && vh > 0)
            {
                Console.WriteLine("         PASS: Virtual desktop geometry successfully retrieved");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Virtual screen bounds invalid");
            }

            // TEST 10: CV_PlayAttentionAlert
            int bellRes = CV_PlayAttentionAlert(0);
            Console.WriteLine("[TEST 10] CV_PlayAttentionAlert: alertType 0 returned {0}", bellRes);
            if (bellRes == 1)
            {
                Console.WriteLine("         PASS: Classroom audio alert call succeeded without exception");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: MessageBeep call failed");
            }

            // TEST 11: CV_PlayCustomTone
            int toneRes = CV_PlayCustomTone(1200, 30);
            Console.WriteLine("[TEST 11] CV_PlayCustomTone: 1200Hz 30ms returned {0}", toneRes);
            if (toneRes == 1)
            {
                Console.WriteLine("         PASS: Native hardware tone generator succeeded");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Beep call failed");
            }

            // TEST 12: CV_GetDiskFreeSpaceMB
            IntPtr pFreeMB = Marshal.AllocHGlobal(4);
            int diskRes = CV_GetDiskFreeSpaceMB(IntPtr.Zero, pFreeMB);
            int freeMB = Marshal.ReadInt32(pFreeMB);
            Marshal.FreeHGlobal(pFreeMB);
            Console.WriteLine("[TEST 12] CV_GetDiskFreeSpaceMB: ok={0}, free={1} MB ({2:F1} GB)", diskRes, freeMB, freeMB / 1024.0);
            if (diskRes == 1 && freeMB > 0)
            {
                Console.WriteLine("         PASS: Disk free space query operational");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Disk space query failed");
            }

            // TEST 13: CV_GetDisplayDpi
            IntPtr pDpiX = Marshal.AllocHGlobal(4);
            IntPtr pDpiY = Marshal.AllocHGlobal(4);
            int dpiRes = CV_GetDisplayDpi(pDpiX, pDpiY);
            int dpiX = Marshal.ReadInt32(pDpiX);
            int dpiY = Marshal.ReadInt32(pDpiY);
            Marshal.FreeHGlobal(pDpiX);
            Marshal.FreeHGlobal(pDpiY);
            Console.WriteLine("[TEST 13] CV_GetDisplayDpi: ok={0}, dpi=({1}, {2}), scale={3}%", dpiRes, dpiX, dpiY, Math.Round(dpiX / 96.0 * 100));
            if (dpiRes == 1 && dpiX >= 96 && dpiY >= 96)
            {
                Console.WriteLine("         PASS: Display DPI scaling operational");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Display DPI scaling failed");
            }

            // TEST 14: CV_SetWindowTopmost (NULL hWnd should return 0 safely without crash)
            int topNull = CV_SetWindowTopmost(IntPtr.Zero, 1);
            Console.WriteLine("[TEST 14] CV_SetWindowTopmost: null hWnd returned {0}", topNull);
            if (topNull == 0)
            {
                Console.WriteLine("         PASS: Window topmost call handled safely without exception");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: NULL hWnd should return 0");
            }

            // TEST 15: CV_GetPerformanceTimeMs
            int t1 = CV_GetPerformanceTimeMs();
            Thread.Sleep(20);
            int t2 = CV_GetPerformanceTimeMs();
            Console.WriteLine("[TEST 15] CV_GetPerformanceTimeMs: t1={0}ms, t2={1}ms, delta={2}ms", t1, t2, (t2 - t1));
            if (t2 >= t1 && (t2 - t1) >= 15)
            {
                Console.WriteLine("         PASS: High-resolution monotonic performance counter operational");
                passed++;
            }
            else
            {
                Console.WriteLine("         FAIL: Monotonic timer did not advance correctly");
            }

            Console.WriteLine("============================================================");
            Console.WriteLine("[RESULT] {0} of {1} tests passed.", passed, total);
            Console.WriteLine("============================================================");

            return (passed == total) ? 0 : 1;
        }
    }
}
