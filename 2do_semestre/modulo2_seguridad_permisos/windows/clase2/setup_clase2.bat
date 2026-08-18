@echo off
REM ============================================================================
REM Laboratorio de Sistemas Operativos (LSO) - 4to Anio
REM Modulo 2 (Windows) - Clase 2: Permisos NTFS, ACLs, Herencia y Takeown
REM ============================================================================

echo =========================================================
echo  LSO 4to - Setup Clase 2 (Windows): Permisos NTFS ^& ACLs
echo =========================================================

set "LAB_ROOT=C:\Temp\LSO_Modulo2\Clase2"
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
    echo [*] Limpiando entorno previo de Clase 2...
    rmdir /s /q "%LAB_ROOT%" >nul 2>&1
)

REM 2. Creacion de la estructura departamental
echo [+] Creando estructura de carpetas de prueba...
mkdir "%LAB_ROOT%\Empresa_Escuela\Secretaria" >nul 2>&1
mkdir "%LAB_ROOT%\Empresa_Escuela\Docentes_Examenes" >nul 2>&1
mkdir "%LAB_ROOT%\Empresa_Escuela\Alumnos_Buzon" >nul 2>&1
mkdir "%LAB_ROOT%\Empresa_Escuela\Publico_Lectura" >nul 2>&1
mkdir "%LAB_ROOT%\Archivos_Bloqueados" >nul 2>&1

REM 3. Generacion de archivos de prueba
echo Documento Confidencial de Matriculacion > "%LAB_ROOT%\Empresa_Escuela\Secretaria\legajos_alumnos.txt"
echo Examen Final LSO 4to Anio - Noviembre > "%LAB_ROOT%\Empresa_Escuela\Docentes_Examenes\tema_examen_1.txt"
echo Carpeta para subida y entrega de TPs > "%LAB_ROOT%\Empresa_Escuela\Alumnos_Buzon\instrucciones_entrega.txt"
echo Calendario Escolar y Reglamentos Vigentes > "%LAB_ROOT%\Empresa_Escuela\Publico_Lectura\normas_convivencia.txt"
echo Archivo con Propietario Corrupto / Bloqueado para toma de posesion > "%LAB_ROOT%\Archivos_Bloqueados\clave_secreta.txt"

REM 4. Asignacion inicial de permisos base (Permisos estandar de herencia)
echo [+] Configurando ACLs base para practicas...
icacls "%LAB_ROOT%\Empresa_Escuela\Publico_Lectura" /grant:r Everyone:(OI)(CI)R >nul 2>&1

echo.
echo =========================================================
echo  ENTORNO DE LABORATORIO CLASE 2 PREPARADO CON EXITO
echo  Ruta de trabajo: %LAB_ROOT%
echo =========================================================
