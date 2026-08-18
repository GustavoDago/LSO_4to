@echo off
REM Script de Setup: Clase 2 - Particionamiento y Formateo NTFS con Diskpart (CMD)

echo ====================================================
echo  LSO 4to - Setup Clase 2: Disco VHDX RAW con CMD
echo ====================================================

set "PATH_VHD=C:\Temp\LSO_Clase2.vhdx"
set "SIZE_MB=1024"

if /i "%~1"=="ultralight" set "SIZE_MB=128"
if /i "%~1"=="-ultralight" set "SIZE_MB=128"

if "%SIZE_MB%"=="128" (
    echo [!] Modo B de Contingencia ^(Netbooks^): VHDX de 128 MB.
) else (
    echo [+] Modo A ^(Nodo Tecnologico / PC^): VHDX de 1024 MB.
)

if not exist "C:\Temp" mkdir "C:\Temp"

REM Desmontar y eliminar disco previo si existia
echo select vdisk file="%PATH_VHD%" > "%TEMP%\dp_clean.txt"
echo detach vdisk >> "%TEMP%\dp_clean.txt"
diskpart /s "%TEMP%\dp_clean.txt" >nul 2>&1

if exist "%PATH_VHD%" del /f /q "%PATH_VHD%" >nul 2>&1

REM Crear y montar disco virtual sin inicializar (RAW) para practicar en diskpart
echo [+] Creando y montando VHDX sin inicializar ^(RAW^) con Diskpart...
echo create vdisk file="%PATH_VHD%" maximum=%SIZE_MB% type=expandable > "%TEMP%\dp_create_raw.txt"
echo attach vdisk >> "%TEMP%\dp_create_raw.txt"

diskpart /s "%TEMP%\dp_create_raw.txt" >nul 2>&1

echo [+] DISCO VHDX DE %SIZE_MB% MB CREADO Y MONTADO EN ESTADO RAW ^(SIN INICIALIZAR^).
echo [+] LISTO PARA PRACTICAR 'diskpart' DESDE LA CONSOLA CMD.
