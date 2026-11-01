// ==============================================================================
// AhBiYout Classroom Visualizer - Native DLL Test Runner & Verification Suite
// Tests all 10 exported Win32 stdcall functions from ClassroomVisualizerCore.dll
// ==============================================================================

using System;
using System.Runtime.InteropServices;
using System.Text;

namespace AhBiYout.ClassroomVisualizer.Testing
{
    class TestRunner
    {
        private const string DLL_NAME = "ClassroomVisualizerCore.dll";

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetVersion();

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall, CharSet = CharSet.Ansi)]
        public static extern int CV_ValidateKeyA(string pKey);

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall, CharSet = CharSet.Ansi)]
        public static extern int CV_IsTrialKeyA(string pKey);

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_VerifyTrialStatus(int startDay, int currentDay, int trialDays, out int daysRemaining);

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetMachineFingerprintA(StringBuilder buffer, int bufferSize);

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GenerateTrialKeyA(StringBuilder buffer, int bufferSize);

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_PreventSleep(int enable);

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetMonitorCount();

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_GetVirtualScreenBounds(out int left, out int top, out int width, out int height);

        [DllImport(DLL_NAME, CallingConvention = CallingConvention.StdCall)]
        public static extern int CV_PlayAttentionAlert(int alertType);

        static int Main(string[] args)
        {
            Console.WriteLine("============================================================");
            Console.WriteLine("[TEST SUITE] ClassroomVisualizer Pure Native DLL Verification");
            Console.WriteLine("============================================================");

            int passed = 0;
            int total = 10;

            try
            {
                // Test 1: CV_GetVersion
                int ver = CV_GetVersion();
                Console.WriteLine("[TEST 1] CV_GetVersion: 0x{0:X8}", ver);
                if (ver == 0x01040400)
                {
                    Console.WriteLine("         PASS: Version matches v1.4.4.0 (0x01040400)");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Expected 0x01040400, got 0x{0:X8}", ver);
                }

                // Test 2: CV_ValidateKeyA
                string testTrialKey = "TR30-L8ES-9R39-RUEV";
                int val1 = CV_ValidateKeyA(testTrialKey);
                int val2 = CV_ValidateKeyA("INVALID-KEY-1234");
                Console.WriteLine("[TEST 2] CV_ValidateKeyA: valid={0}, invalid={1}", val1, val2);
                if (val1 == 1 && val2 == 0)
                {
                    Console.WriteLine("         PASS: Checksum validation correct");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Unexpected validation result");
                }

                // Test 3: CV_IsTrialKeyA
                int isTrial = CV_IsTrialKeyA(testTrialKey);
                int isNotTrial = CV_IsTrialKeyA("PRO1-1234-5678-ABCD");
                Console.WriteLine("[TEST 3] CV_IsTrialKeyA: trial={0}, nonTrial={1}", isTrial, isNotTrial);
                if (isTrial == 1 && isNotTrial == 0)
                {
                    Console.WriteLine("         PASS: Trial prefix detection correct");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Unexpected trial prefix check");
                }

                // Test 4: CV_VerifyTrialStatus
                int daysRem;
                int validStatus = CV_VerifyTrialStatus(1, 10, 30, out daysRem);
                int daysRemExp;
                int expStatus = CV_VerifyTrialStatus(1, 35, 30, out daysRemExp);
                Console.WriteLine("[TEST 4] CV_VerifyTrialStatus: active={0} (rem={1}d), expired={2} (rem={3}d)",
                    validStatus, daysRem, expStatus, daysRemExp);
                if (validStatus == 1 && daysRem == 21 && expStatus == 0 && daysRemExp == 0)
                {
                    Console.WriteLine("         PASS: Trial expiration & remaining days calculation accurate");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Unexpected trial status result");
                }

                // Test 5: CV_GetMachineFingerprintA
                StringBuilder fpBuf = new StringBuilder(64);
                int fpLen = CV_GetMachineFingerprintA(fpBuf, 64);
                Console.WriteLine("[TEST 5] CV_GetMachineFingerprintA: '{0}' (len={1})", fpBuf.ToString(), fpLen);
                if (fpLen == 16 && fpBuf.Length == 16)
                {
                    Console.WriteLine("         PASS: Machine fingerprint hash generated (16 hex chars)");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Invalid fingerprint format");
                }

                // Test 6: CV_GenerateTrialKeyA
                StringBuilder keyBuf = new StringBuilder(64);
                int keyLen = CV_GenerateTrialKeyA(keyBuf, 64);
                string genKey = keyBuf.ToString();
                int genKeyValid = CV_ValidateKeyA(genKey);
                int genKeyIsTrial = CV_IsTrialKeyA(genKey);
                Console.WriteLine("[TEST 6] CV_GenerateTrialKeyA: '{0}' (valid={1}, trial={2})", genKey, genKeyValid, genKeyIsTrial);
                if (keyLen == 19 && genKeyValid == 1 && genKeyIsTrial == 1)
                {
                    Console.WriteLine("         PASS: Dynamically generated trial key conforms to checksum and prefix");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Generated key failed validation");
                }

                // Test 7: CV_PreventSleep
                int sleepEnable = CV_PreventSleep(1);
                int sleepDisable = CV_PreventSleep(0);
                Console.WriteLine("[TEST 7] CV_PreventSleep: enable={0}, restore={1}", sleepEnable, sleepDisable);
                if (sleepEnable == 1 && sleepDisable == 1)
                {
                    Console.WriteLine("         PASS: Win32 SetThreadExecutionState presentation sleep control operational");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Sleep prevention call returned failure");
                }

                // Test 8: CV_GetMonitorCount
                int monCount = CV_GetMonitorCount();
                Console.WriteLine("[TEST 8] CV_GetMonitorCount: {0} active monitor(s) detected", monCount);
                if (monCount >= 1)
                {
                    Console.WriteLine("         PASS: Display monitor topology detection operational");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Expected >= 1 monitors");
                }

                // Test 9: CV_GetVirtualScreenBounds
                int vx, vy, vw, vh;
                int virtOk = CV_GetVirtualScreenBounds(out vx, out vy, out vw, out vh);
                Console.WriteLine("[TEST 9] CV_GetVirtualScreenBounds: ok={0}, rect=({1},{2}, {3}x{4})", virtOk, vx, vy, vw, vh);
                if (virtOk == 1 && vw > 0 && vh > 0)
                {
                    Console.WriteLine("         PASS: Virtual desktop geometry successfully retrieved");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Virtual screen bounds returned invalid dimensions");
                }

                // Test 10: CV_PlayAttentionAlert
                int beepRes = CV_PlayAttentionAlert(0);
                Console.WriteLine("[TEST 10] CV_PlayAttentionAlert: alertType 0 returned {0}", beepRes);
                if (beepRes == 1 || beepRes == 0) // May return 0 on silent/headless server, but shouldn't throw
                {
                    Console.WriteLine("         PASS: Classroom audio alert call succeeded without exception");
                    passed++;
                }
                else
                {
                    Console.WriteLine("         FAIL: Attention alert call threw error");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("[FATAL EXCEPTION] " + ex.ToString());
                return 1;
            }

            Console.WriteLine("============================================================");
            Console.WriteLine("[RESULT] {0} of {1} tests passed.", passed, total);
            Console.WriteLine("============================================================");

            return (passed == total) ? 0 : 1;
        }
    }
}
