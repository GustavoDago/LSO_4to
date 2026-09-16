@echo off
setlocal EnableDelayedExpansion

:: ====================================================================
:: Script de Setup: Clase 1 Repaso Intensivo (Ticket #401)
:: Laboratorio de Sistemas Operativos (LSO 4to Anno)
:: Compatible con Windows 11 Host, Deep Freeze y Netbooks Escolares
:: ====================================================================

title Setup Repaso Clase 1 - LSO 4to

echo ====================================================================
echo  [LSO 4to] INICIALIZADOR DE ESCENARIO: TICKET #401
echo  Almacenamiento (VHD/NTFS/diskpart) y Seguridad (SAM/SIDs/icacls)
echo ====================================================================
echo.

:: Verificar permisos de Administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Este script requiere privilegios elevados de Administrador.
    echo Por favor, haz clic derecho sobre CMD y selecciona "Ejecutar como administrador".
    pause
    exit /b 1
)

set "TARGET_DIR=C:\LaboratorioLSO\Incidente401"
set "VHD_FILE=%TARGET_DIR%\disco_proyectos.vhdx"
set "SCRIPT_DP=%TEMP%\dp_setup_repaso1.txt"

:: Modo de limpieza
if /I "%~1"=="/clean" goto CLEANUP

echo [*] Preparando directorio de trabajo en: %TARGET_DIR%...
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

:: Si ya existe un VHD montado previamente, intentar desmontarlo
if exist "%VHD_FILE%" (
    echo [*] Desmontando versiones previas del disco virtual...
    (
        echo select vdisk file="%VHD_FILE%"
        echo detach vdisk
    ) > "%SCRIPT_DP%"
    diskpart /s "%SCRIPT_DP%" >nul 2>&1
    del /f /q "%VHD_FILE%" >nul 2>&1
)

echo [*] Generando contenedor de disco virtual dinámico (256 MB)...
(
    echo create vdisk file="%VHD_FILE%" maximum=256 type=expandable
) > "%SCRIPT_DP%"

diskpart /s "%SCRIPT_DP%" >nul 2>&1

if exist "%SCRIPT_DP%" del /f /q "%SCRIPT_DP%"

if exist "%VHD_FILE%" (
    echo [OK] Disco virtual generado exitosamente en:
    echo      %VHD_FILE%
    echo.
    echo [*] NOTA DIDACTICA:
    echo     El disco virtual ha sido CREADO pero NO ADJUNTADO.
    echo     Los alumnos deben iniciar diskpart, ejecutar 'attach vdisk',
    echo     inicializarlo en GPT, formatearlo en NTFS y asignarle la letra V:.
    echo.
    echo ====================================================================
    echo  ESCENARIO LISTO PARA EL DESARROLLO DEL TICKET #401
    echo ====================================================================
    echo.
) else (
    echo [ERROR] No se pudo crear el disco virtual. Revisa permisos o espacio en disco.
    pause
    exit /b 1
)

pause
exit /b 0

:CLEANUP
echo.
echo [*] Iniciando limpieza del escenario del Ticket #401...
if exist "%VHD_FILE%" (
    (
        echo select vdisk file="%VHD_FILE%"
        echo detach vdisk
    ) > "%SCRIPT_DP%"
    diskpart /s "%SCRIPT_DP%" >nul 2>&1
    if exist "%SCRIPT_DP%" del /f /q "%SCRIPT_DP%"
)

if exist "%TARGET_DIR%" (
    rmdir /s /q "%TARGET_DIR%" >nul 2>&1
)

echo [OK] Escenario desmontado y directorio eliminado con exito.
echo.
pause
exit /b 0
