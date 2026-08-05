@echo off
REM Script de Setup: Clase 1 - Almacenamiento VHDX y GPT con Diskpart (CMD)

echo ==========================================
echo  LSO 4to - Setup Clase 1: Discos VHD ^& GPT
echo ==========================================

set "PATH_VHD=C:\Temp\LSO_Clase1.vhdx"
set "SIZE_MB=1024"

if /i "%~1"=="ultralight" set "SIZE_MB=128"
if /i "%~1"=="-ultralight" set "SIZE_MB=128"

if "%SIZE_MB%"=="128" (
    echo [!] Modo B de Contingencia ^(Netbooks^): VHD de 128 MB.
) else (
    echo [+] Modo A ^(Nodo Tecnologico / PC^): VHD de 1024 MB.
)

if not exist "C:\Temp" mkdir "C:\Temp"

REM Desmontar y eliminar disco previo si existia
echo select vdisk file="%PATH_VHD%" > "%TEMP%\dp_clean.txt"
echo detach vdisk >> "%TEMP%\dp_clean.txt"
diskpart /s "%TEMP%\dp_clean.txt" >nul 2>&1

if exist "%PATH_VHD%" del /f /q "%PATH_VHD%" >nul 2>&1

REM Crear y configurar disco virtual con Diskpart
echo [+] Creando y configurando VHDX con Diskpart...
echo create vdisk file="%PATH_VHD%" maximum=%SIZE_MB% type=expandable > "%TEMP%\dp_create.txt"
echo attach vdisk >> "%TEMP%\dp_create.txt"
echo convert gpt >> "%TEMP%\dp_create.txt"
echo create partition primary >> "%TEMP%\dp_create.txt"
echo format fs=ntfs quick label="LSO_VHD" >> "%TEMP%\dp_create.txt"
echo assign >> "%TEMP%\dp_create.txt"

diskpart /s "%TEMP%\dp_create.txt" >nul 2>&1

echo [+] DISCO VHDX CONFIGURADO Y MONTADO CON EXITO VIA DISKPART
