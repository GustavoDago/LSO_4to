@echo off
REM ============================================================================
REM Laboratorio de Sistemas Operativos (LSO) - 4to Anio
REM Modulo 2 (Windows) - Clase 1: Gestion de Usuarios, Grupos Locales y UAC
REM ============================================================================

echo =========================================================
echo  LSO 4to - Setup Clase 1 (Windows): Usuarios y Grupos
echo =========================================================

set "LAB_ROOT=C:\Temp\LSO_Modulo2\Clase1"
set "MODE=Modo A (Estandar)"

if /i "%~1"=="ultralight" (
    set "MODE=Modo B (Netbooks / Ultralight)"
)
if /i "%~1"=="-ultralight" (
    set "MODE=Modo B (Netbooks / Ultralight)"
)

echo [+] Modo seleccionado: %MODE%
echo [+] Directorio de trabajo: %LAB_ROOT%

REM 1. Limpieza de laboratorio anterior
if exist "%LAB_ROOT%" (
    echo [*] Limpiando entorno previo de Clase 1...
    rmdir /s /q "%LAB_ROOT%" >nul 2>&1
)

REM 2. Creacion de la estructura departamental simulada
echo [+] Creando estructura de laboratorio simulada...
mkdir "%LAB_ROOT%\Auditoria" >nul 2>&1
mkdir "%LAB_ROOT%\Directorio_Escolar\Direccion" >nul 2>&1
mkdir "%LAB_ROOT%\Directorio_Escolar\Docentes" >nul 2>&1
mkdir "%LAB_ROOT%\Directorio_Escolar\Alumnos" >nul 2>&1
mkdir "%LAB_ROOT%\Publico" >nul 2>&1

REM 3. Generacion de archivos de prueba
echo Documento Confidencial de Auditoria - Solo Administradores > "%LAB_ROOT%\Auditoria\informe_seguridad.txt"
echo Planificacion Institucional 2026 - Acceso Direccion > "%LAB_ROOT%\Directorio_Escolar\Direccion\acta_reunion.txt"
echo Planilla de Calificaciones - Solo Docentes > "%LAB_ROOT%\Directorio_Escolar\Docentes\calificaciones_4to.txt"
echo Guia de Trabajos Practicos LSO - Acceso General > "%LAB_ROOT%\Directorio_Escolar\Alumnos\consignas_tp.txt"
echo Informacion Publica de la Institucion Educativa > "%LAB_ROOT%\Publico\cartelera_avisos.txt"

REM 4. Verificacion de permisos de ejecucion (Elevacion UAC)
net session >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Consola ejecutandose con Privilegios Elevados (Administrador).
    echo      Podras ejecutar comandos de administracion de cuentas reales del sistema.
) else (
    echo [!] AVISO: Consola SIN privilegios elevados (Usuario Estandar).
    echo     Podras explorar consultas 'net user' y 'Get-LocalUser', pero para crear
    echo     o modificar cuentas reales requeriras ejecutar CMD/PowerShell como Administrador.
)

echo.
echo =========================================================
echo  ENTORNO DE LABORATORIO CLASE 1 PREPARADO CON EXITO
echo  Ruta de trabajo: %LAB_ROOT%
echo =========================================================
