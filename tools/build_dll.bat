@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM Build Script: ClassroomVisualizer Native & Managed DLLs
REM Compiles:
REM 1. src\dll\LicenseCore.cs & NativeSystemCore.cs -> src\dll\ClassroomVisualizerManaged.dll
REM 2. src\dll\ClassroomVisualizerCore.il -> src\dll\ClassroomVisualizerCore.dll
REM 3. Copies outputs to bin\
REM 4. Compiles and runs src\dll\TestRunner.cs
REM ============================================================

echo ============================================================
echo [BUILD DLL] Compiling ClassroomVisualizer Pure Native DLLs
echo ============================================================

set "CSC_EXE=C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe"
set "ILASM_EXE=C:\Windows\Microsoft.NET\Framework\v4.0.30319\ilasm.exe"

if not exist "%CSC_EXE%" (
    echo [ERROR] C# Compiler not found at: %CSC_EXE%
    exit /b 1
)

if not exist "%ILASM_EXE%" (
    echo [ERROR] IL Assembler not found at: %ILASM_EXE%
    exit /b 1
)

cd /d "%~dp0\.."

if not exist "bin" mkdir "bin"

echo [*] Compiling Managed Core: src\dll\ClassroomVisualizerManaged.dll...
"%CSC_EXE%" /target:library /platform:x86 /out:src\dll\ClassroomVisualizerManaged.dll src\dll\LicenseCore.cs src\dll\NativeSystemCore.cs
if errorlevel 1 (
    echo [ERROR] Failed to compile ClassroomVisualizerManaged.dll
    exit /b 1
)

echo [*] Assembling Native Export DLL: src\dll\ClassroomVisualizerCore.dll...
"%ILASM_EXE%" /dll /out:src\dll\ClassroomVisualizerCore.dll src\dll\ClassroomVisualizerCore.il
if errorlevel 1 (
    echo [ERROR] Failed to assemble ClassroomVisualizerCore.dll
    exit /b 1
)

echo [*] Copying DLLs to bin\ directory...
copy /y "src\dll\ClassroomVisualizerCore.dll" "bin\" >nul
copy /y "src\dll\ClassroomVisualizerManaged.dll" "bin\" >nul

echo ============================================================
echo [SUCCESS] DLL Build Complete:
echo - bin\ClassroomVisualizerCore.dll
echo - bin\ClassroomVisualizerManaged.dll
echo ============================================================

if exist "src\dll\TestRunner.cs" (
    echo [*] Compiling Native DLL TestRunner...
    "%CSC_EXE%" /target:exe /platform:x86 /out:bin\TestRunner.exe src\dll\TestRunner.cs
    if not errorlevel 1 (
        echo [*] Running Native DLL Verification Suite...
        bin\TestRunner.exe
        if errorlevel 1 (
            echo [WARNING] TestRunner reported one or more test failures!
        ) else (
            echo [*] All native verification tests passed successfully.
        )
    )
)

exit /b 0
