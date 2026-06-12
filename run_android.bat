@echo off
setlocal

:: Configuration
set "AVD_NAME=Phone"
set "SDK_PATH=C:\Users\sushi\AppData\Local\Android\Sdk"
set "EMULATOR_PATH=%SDK_PATH%\emulator\emulator.exe"
set "ADB_PATH=%SDK_PATH%\platform-tools\adb.exe"

echo [1/5] Checking for running Android devices...
"%ADB_PATH%" devices | findstr "emulator" > nul
if %errorlevel% neq 0 (
    echo [1/5] No running emulator found. Launching "%AVD_NAME%"...
    start /b "" "%EMULATOR_PATH%" -avd %AVD_NAME% -no-snapshot-load
    
    echo [2/5] Waiting for emulator to initialize...
    "%ADB_PATH%" wait-for-device
    
    echo [2/5] Powering on and waiting for boot completion...
    :wait_boot
    "%ADB_PATH%" shell getprop sys.boot_completed 2>nul | findstr "1" > nul
    if %errorlevel% neq 0 (
        timeout /t 2 /nobreak > nul
        goto wait_boot
    )
    echo [2/5] Emulator is powered on and ready.
) else (
    echo [1/5] Android device already connected and running.
    echo [2/5] Skipping emulator launch.
)

echo [3/5] Deleting old builds and cleaning project...
cd source
if exist build (
    echo [3/5] Removing build directory...
    rmdir /s /q build
)
:: Also run flutter clean for a deep clean
call flutter clean

echo [4/5] Installing and launching the app on the device...
:: Using flutter run which handles build, install and launch
call flutter run

echo [5/5] App is running!
pause
endlocal
