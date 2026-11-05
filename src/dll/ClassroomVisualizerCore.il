.assembly extern mscorlib
{
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89)
  .ver 4:0:0:0
}
.assembly extern ClassroomVisualizerManaged
{
  .ver 0:0:0:0
}

.assembly ClassroomVisualizerCore
{
  .custom instance void [mscorlib]System.Reflection.AssemblyTitleAttribute::.ctor(string) = ( 01 00 24 28 41 68 42 69 59 6F 75 74 29 20 43 6C 61 73 73 72 6F 6F 6D 20 56 69 73 75 61 6C 69 7A 65 72 20 4E 61 74 69 76 65 20 43 6F 72 65 00 00 ) 
  .custom instance void [mscorlib]System.Reflection.AssemblyCompanyAttribute::.ctor(string) = ( 01 00 10 41 68 42 69 59 6F 75 74 20 28 43 49 53 4E 45 54 29 00 00 )
  .custom instance void [mscorlib]System.Reflection.AssemblyVersionAttribute::.ctor(string) = ( 01 00 07 31 2E 34 2E 34 2E 30 00 00 )
  .hash algorithm 0x00008004
  .ver 1:4:4:0
}

.module ClassroomVisualizerCore.dll
.corflags 0x00000002

.class public abstract auto ansi sealed beforefieldinit AhBiYout.ClassroomVisualizer.Core.NativeLicense
       extends [mscorlib]System.Object
{
  // -------------------------------------------------------------
  // [1] CV_GetVersion: Returns engine version as 0x01040700 (v1.4.7)
  // -------------------------------------------------------------
  .method public static int32 CV_GetVersion() cil managed
  {
    .vtentry 1 : 1
    .export [1] as CV_GetVersion
    .maxstack 1
    ldc.i4 0x01040700
    ret
  }

  // -------------------------------------------------------------
  // [2] CV_ValidateKeyA: Validates 16-char license key
  // -------------------------------------------------------------
  .method public static int32 CV_ValidateKeyA(native int pKeyAnsi) cil managed
  {
    .vtentry 1 : 2
    .export [2] as CV_ValidateKeyA
    .maxstack 2
    .locals init (string V_0)

    .try
    {
      ldarg.0
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s RetZero

      ldarg.0
      call string [mscorlib]System.Runtime.InteropServices.Marshal::PtrToStringAnsi(native int)
      stloc.0

      ldloc.0
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.LicenseCore::ValidateKey(string)
      ret

    RetZero:
      ldc.i4.0
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [3] CV_IsTrialKeyA: Checks if key is a 30-day trial key
  // -------------------------------------------------------------
  .method public static int32 CV_IsTrialKeyA(native int pKeyAnsi) cil managed
  {
    .vtentry 1 : 3
    .export [3] as CV_IsTrialKeyA
    .maxstack 2
    .locals init (string V_0)

    .try
    {
      ldarg.0
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s RetZero

      ldarg.0
      call string [mscorlib]System.Runtime.InteropServices.Marshal::PtrToStringAnsi(native int)
      stloc.0

      ldloc.0
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.LicenseCore::IsTrialKey(string)
      ret

    RetZero:
      ldc.i4.0
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [4] CV_VerifyTrialStatus: Verifies trial expiry & writes remaining days
  // -------------------------------------------------------------
  .method public static int32 CV_VerifyTrialStatus(int32 startDay, int32 currentDay, int32 trialDays, native int pDaysRemaining) cil managed
  {
    .vtentry 1 : 4
    .export [4] as CV_VerifyTrialStatus
    .maxstack 4
    .locals init (int32 V_0, int32 V_1)

    .try
    {
      ldarg.0
      ldarg.1
      ldarg.2
      ldloca.s V_0
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.LicenseCore::VerifyTrialStatusDays(int32, int32, int32, [out] int32&)
      stloc.1

      ldarg.3
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s RetStatus

      ldarg.3
      ldloc.0
      stind.i4

    RetStatus:
      ldloc.1
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [5] CV_GetMachineFingerprintA: Fills buffer with terminal fingerprint hex
  // -------------------------------------------------------------
  .method public static int32 CV_GetMachineFingerprintA(native int pOutBuffer, int32 bufferSize) cil managed
  {
    .vtentry 1 : 5
    .export [5] as CV_GetMachineFingerprintA
    .maxstack 3
    .locals init (string V_0)

    .try
    {
      call string [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.LicenseCore::GetMachineFingerprintHex()
      stloc.0

      ldloc.0
      ldarg.0
      ldarg.1
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.LicenseCore::CopyStringToAnsiBuffer(string, native int, int32)
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [6] CV_GenerateTrialKeyA: Generates valid TR30 trial key into buffer
  // -------------------------------------------------------------
  .method public static int32 CV_GenerateTrialKeyA(native int pOutBuffer, int32 bufferSize) cil managed
  {
    .vtentry 1 : 6
    .export [6] as CV_GenerateTrialKeyA
    .maxstack 3
    .locals init (string V_0)

    .try
    {
      call string [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.LicenseCore::GenerateTrialKey()
      stloc.0

      ldloc.0
      ldarg.0
      ldarg.1
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.LicenseCore::CopyStringToAnsiBuffer(string, native int, int32)
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [7] CV_PreventSleep: Prevents display sleep during presentation
  // -------------------------------------------------------------
  .method public static int32 CV_PreventSleep(int32 enable) cil managed
  {
    .vtentry 1 : 7
    .export [7] as CV_PreventSleep
    .maxstack 1

    .try
    {
      ldarg.0
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.NativeSystemCore::PreventSleep(int32)
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [8] CV_GetMonitorCount: Returns total active display monitor count
  // -------------------------------------------------------------
  .method public static int32 CV_GetMonitorCount() cil managed
  {
    .vtentry 1 : 8
    .export [8] as CV_GetMonitorCount
    .maxstack 1

    .try
    {
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.NativeSystemCore::GetMonitorCount()
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.1
      ret
    }
  }

  // -------------------------------------------------------------
  // [9] CV_GetVirtualScreenBounds: Returns virtual desktop bounding rect
  // -------------------------------------------------------------
  .method public static int32 CV_GetVirtualScreenBounds(native int pLeft, native int pTop, native int pWidth, native int pHeight) cil managed
  {
    .vtentry 1 : 9
    .export [9] as CV_GetVirtualScreenBounds
    .maxstack 4
    .locals init (int32 V_Left, int32 V_Top, int32 V_Width, int32 V_Height, int32 V_Res)

    .try
    {
      ldloca.s V_Left
      ldloca.s V_Top
      ldloca.s V_Width
      ldloca.s V_Height
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.NativeSystemCore::GetVirtualScreenBounds([out] int32&, [out] int32&, [out] int32&, [out] int32&)
      stloc.s V_Res

      ldarg.0
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s CheckTop
      ldarg.0
      ldloc.s V_Left
      stind.i4

    CheckTop:
      ldarg.1
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s CheckWidth
      ldarg.1
      ldloc.s V_Top
      stind.i4

    CheckWidth:
      ldarg.2
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s CheckHeight
      ldarg.2
      ldloc.s V_Width
      stind.i4

    CheckHeight:
      ldarg.3
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s RetRes
      ldarg.3
      ldloc.s V_Height
      stind.i4

    RetRes:
      ldloc.s V_Res
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [10] CV_PlayAttentionAlert: Zero-latency classroom attention chime
  // -------------------------------------------------------------
  .method public static int32 CV_PlayAttentionAlert(int32 alertType) cil managed
  {
    .vtentry 1 : 10
    .export [10] as CV_PlayAttentionAlert
    .maxstack 1

    .try
    {
      ldarg.0
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.NativeSystemCore::PlayAttentionAlert(int32)
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [11] CV_PlayCustomTone: Native hardware tone generator (Hz, ms)
  // -------------------------------------------------------------
  .method public static int32 CV_PlayCustomTone(int32 frequency, int32 durationMs) cil managed
  {
    .vtentry 1 : 11
    .export [11] as CV_PlayCustomTone
    .maxstack 2

    .try
    {
      ldarg.0
      ldarg.1
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.NativeSystemCore::PlayCustomTone(int32, int32)
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [12] CV_GetDiskFreeSpaceMB: Queries free storage in MB
  // -------------------------------------------------------------
  .method public static int32 CV_GetDiskFreeSpaceMB(native int pDrivePathAnsi, native int pFreeMB) cil managed
  {
    .vtentry 1 : 12
    .export [12] as CV_GetDiskFreeSpaceMB
    .maxstack 3
    .locals init (string V_Path, int32 V_FreeMB, int32 V_Res)

    .try
    {
      ldarg.0
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s DefaultPath

      ldarg.0
      call string [mscorlib]System.Runtime.InteropServices.Marshal::PtrToStringAnsi(native int)
      stloc.0
      br.s QueryDisk

    DefaultPath:
      ldstr "C:\\"
      stloc.0

    QueryDisk:
      ldloc.0
      ldloca.s V_FreeMB
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.NativeSystemCore::GetDiskFreeSpaceMB(string, [out] int32&)
      stloc.s V_Res

      ldarg.1
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s RetDiskRes

      ldarg.1
      ldloc.s V_FreeMB
      stind.i4

    RetDiskRes:
      ldloc.s V_Res
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [13] CV_GetDisplayDpi: Returns primary display DPI scaling
  // -------------------------------------------------------------
  .method public static int32 CV_GetDisplayDpi(native int pDpiX, native int pDpiY) cil managed
  {
    .vtentry 1 : 13
    .export [13] as CV_GetDisplayDpi
    .maxstack 3
    .locals init (int32 V_DpiX, int32 V_DpiY, int32 V_Res)

    .try
    {
      ldloca.s V_DpiX
      ldloca.s V_DpiY
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.NativeSystemCore::GetDisplayDpi([out] int32&, [out] int32&)
      stloc.s V_Res

      ldarg.0
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s CheckDpiY

      ldarg.0
      ldloc.s V_DpiX
      stind.i4

    CheckDpiY:
      ldarg.1
      ldsfld native int [mscorlib]System.IntPtr::Zero
      beq.s RetDpiRes

      ldarg.1
      ldloc.s V_DpiY
      stind.i4

    RetDpiRes:
      ldloc.s V_Res
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [14] CV_SetWindowTopmost: Sets Always-On-Top floating state
  // -------------------------------------------------------------
  .method public static int32 CV_SetWindowTopmost(native int hWnd, int32 topmost) cil managed
  {
    .vtentry 1 : 14
    .export [14] as CV_SetWindowTopmost
    .maxstack 2

    .try
    {
      ldarg.0
      ldarg.1
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.NativeSystemCore::SetWindowTopmost(native int, int32)
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }

  // -------------------------------------------------------------
  // [15] CV_GetPerformanceTimeMs: High-resolution timestamp (ms)
  // -------------------------------------------------------------
  .method public static int32 CV_GetPerformanceTimeMs() cil managed
  {
    .vtentry 1 : 15
    .export [15] as CV_GetPerformanceTimeMs
    .maxstack 1

    .try
    {
      call int32 [ClassroomVisualizerManaged]AhBiYout.ClassroomVisualizer.Core.NativeSystemCore::GetPerformanceTimeMs()
      ret
    }
    catch [mscorlib]System.Exception
    {
      pop
      ldc.i4.0
      ret
    }
  }
}

// ---------------------------------------------------------------
// 15 VTable Fixup Slots (4 bytes per slot = 60 bytes)
// ---------------------------------------------------------------
.vtfixup [15] int32 fromunmanaged at D_VTFIXUPS
.data D_VTFIXUPS = bytearray (
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00
)
