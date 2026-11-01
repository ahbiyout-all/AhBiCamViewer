// ==============================================================================
// AhBiYout Classroom Visualizer - Native License Core
// Pure-C# implementation of offline checksum, trial license expiry verification,
// and hardware environment hashing for classroom document camera application.
// ==============================================================================

using System;
using System.IO;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;

namespace AhBiYout.ClassroomVisualizer.Core
{
    public static class LicenseCore
    {
        private const int MODULO_DIVISOR = 97;
        private const int MODULO_REMAINDER = 1;
        private const string VALID_CHARSET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

        /// <summary>
        /// Validates license key structure and checksum:
        /// Key must be 16 characters in 4x4 format (XXXX-XXXX-XXXX-XXXX)
        /// Checksum: sum(char_code * (index + 1)) % 97 == 1
        /// </summary>
        public static int ValidateKey(string key)
        {
            if (string.IsNullOrEmpty(key)) return 0;
            string raw = key.Trim().ToUpper().Replace("-", "");
            if (raw.Length != 16) return 0;

            foreach (char c in raw)
            {
                if (!((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9')))
                    return 0;
            }

            int sum = 0;
            for (int i = 0; i < 16; i++)
            {
                sum += ((int)raw[i]) * (i + 1);
            }

            return (sum % MODULO_DIVISOR == MODULO_REMAINDER) ? 1 : 0;
        }

        /// <summary>
        /// Returns 1 if key starts with TR30 (30-day trial prefix), 0 otherwise.
        /// </summary>
        public static int IsTrialKey(string key)
        {
            if (ValidateKey(key) == 0) return 0;
            string raw = key.Trim().ToUpper().Replace("-", "");
            return raw.StartsWith("TR30") ? 1 : 0;
        }

        /// <summary>
        /// Generates a valid 30-day trial key with prefix TR30 using checksum constraint.
        /// </summary>
        public static string GenerateTrialKey()
        {
            Random rnd = new Random();
            for (int attempt = 0; attempt < 50000; attempt++)
            {
                StringBuilder sb = new StringBuilder("TR30");
                for (int i = 0; i < 10; i++)
                {
                    sb.Append(VALID_CHARSET[rnd.Next(VALID_CHARSET.Length)]);
                }
                string prefix14 = sb.ToString();

                for (int c1 = 0; c1 < VALID_CHARSET.Length; c1++)
                {
                    for (int c2 = 0; c2 < VALID_CHARSET.Length; c2++)
                    {
                        string candidate = prefix14 + VALID_CHARSET[c1] + VALID_CHARSET[c2];
                        int sum = 0;
                        for (int j = 0; j < 16; j++)
                        {
                            sum += ((int)candidate[j]) * (j + 1);
                        }
                        if (sum % MODULO_DIVISOR == MODULO_REMAINDER)
                        {
                            return string.Format("{0}-{1}-{2}-{3}",
                                candidate.Substring(0, 4),
                                candidate.Substring(4, 4),
                                candidate.Substring(8, 4),
                                candidate.Substring(12, 4));
                        }
                    }
                }
            }
            return "TR30-L8ES-9R39-RUEV";
        }

        /// <summary>
        /// Verifies trial expiration using day counters:
        /// Returns 1 if trial is still valid, 0 if expired.
        /// daysRemaining receives remaining days (0 if expired).
        /// </summary>
        public static int VerifyTrialStatusDays(int startDay, int currentDay, int trialDays, out int daysRemaining)
        {
            daysRemaining = 0;
            if (trialDays <= 0 || startDay <= 0 || currentDay < startDay)
            {
                return 0;
            }

            int elapsed = currentDay - startDay;
            if (elapsed >= trialDays)
            {
                daysRemaining = 0;
                return 0; // Expired
            }

            daysRemaining = trialDays - elapsed;
            return 1; // Valid
        }

        /// <summary>
        /// Verifies trial expiration against UTC timestamp (unix seconds).
        /// Returns positive remaining days, or -1 if expired.
        /// </summary>
        public static int VerifyTrialStatusUnix(long expiryUnixSeconds, long currentUnixSeconds)
        {
            if (expiryUnixSeconds <= 0) return 0;
            long diff = expiryUnixSeconds - currentUnixSeconds;
            if (diff <= 0) return -1; // Expired
            return (int)Math.Ceiling(diff / 86400.0);
        }

        /// <summary>
        /// Generates a localized machine fingerprint hex hash for classroom terminal binding.
        /// Returns a 16-character uppercase hex string (e.g. "A1B2C3D4E5F67890").
        /// </summary>
        public static string GetMachineFingerprintHex()
        {
            try
            {
                string info = Environment.MachineName + "|" + Environment.UserName + "|" + Environment.ProcessorCount + "|" + Environment.OSVersion;
                using (SHA256 sha = SHA256.Create())
                {
                    byte[] hash = sha.ComputeHash(Encoding.UTF8.GetBytes(info));
                    StringBuilder sb = new StringBuilder(16);
                    for (int i = 0; i < 8; i++)
                    {
                        sb.Append(hash[i].ToString("X2"));
                    }
                    return sb.ToString();
                }
            }
            catch
            {
                return "0000000000000000";
            }
        }

        /// <summary>
        /// Helper to copy string to unmanaged ANSI buffer with null termination.
        /// Returns byte length written (excluding null terminator).
        /// </summary>
        public static int CopyStringToAnsiBuffer(string src, IntPtr pDest, int maxLen)
        {
            if (pDest == IntPtr.Zero || maxLen <= 0) return 0;
            if (string.IsNullOrEmpty(src))
            {
                Marshal.WriteByte(pDest, 0);
                return 0;
            }

            byte[] bytes = Encoding.Default.GetBytes(src);
            int copyLen = Math.Min(bytes.Length, maxLen - 1);
            Marshal.Copy(bytes, 0, pDest, copyLen);
            Marshal.WriteByte(pDest, copyLen, 0); // Null terminator
            return copyLen;
        }
    }
}
