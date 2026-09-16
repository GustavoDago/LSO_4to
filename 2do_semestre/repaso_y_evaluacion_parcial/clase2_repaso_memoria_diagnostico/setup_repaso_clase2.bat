@echo off
setlocal EnableDelayedExpansion

:: ====================================================================
:: Script de Setup: Clase 2 Repaso Intensivo (Ticket #402)
:: Laboratorio de Sistemas Operativos (LSO 4to Anno)
:: Simulación Segura y Controlada de Carga de Memoria en Windows 11
:: ====================================================================

title Setup Repaso Clase 2 - Diagnostico Clinico de Memoria

echo ====================================================================
echo  [LSO 4to] INICIALIZADOR DE ESCENARIO CLINICO: TICKET #402
echo  Diagnostico de Memoria (resmon.exe, Paginacion y Pools de Kernel)
echo ====================================================================
echo.

if /I "%~1"=="/clean" goto CLEANUP

echo [*] Abriendo Monitor de Recursos (resmon.exe) para observacion...
start resmon.exe

echo.
echo [*] Este script ejecutara una asignacion de memoria controlada y segura
echo     (aproximadamente 350 MB) para observar en tiempo real:
echo       1. El incremento del Commit Charge (Memoria Confirmada).
echo       2. El incremento del Working Set en resmon.exe.
echo       3. La transicion de memoria Libre a En uso y Modificada.
echo.
echo Presiona cualquier tecla para INICIAR la carga de memoria...
pause >nul

echo.
echo [*] Asignando memoria controlada en proceso hijo de PowerShell...
echo [*] OBSERVACION CLINICA ACTIVA: No cierres esta ventana.
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$pid_actual = $PID;" ^
    "Write-Host '[INFO] Proceso de diagnostico iniciado con PID:' $pid_actual -ForegroundColor Cyan;" ^
    "Write-Host '[INFO] Busca este PID en la pestana Memoria de resmon.exe' -ForegroundColor Yellow;" ^
    "$tam_mb = 350;" ^
    "$bloques = New-Object System.Collections.Generic.List[byte[]];" ^
    "Write-Host '[+] Asignando memoria en bloques de 50 MB...';" ^
    "for ($i=1; $i -le 7; $i++) {" ^
    "   $bloque = New-Object byte[] (50 * 1024 * 1024);" ^
    "   for ($b = 0; $b -lt $bloque.Length; $b += 4096) { $bloque[$b] = 1 };" ^
    "   $bloques.Add($bloque);" ^
    "   Write-Host ('    [Bloque ' + $i + '/7] Asignados ' + ($i * 50) + ' MB...');" ^
    "   Start-Sleep -Milliseconds 400;" ^
    "};" ^
    "Write-Host '------------------------------------------------------------' -ForegroundColor Green;" ^
    "Write-Host '[LISTO] Memoria retenida exitosamente.' -ForegroundColor Green;" ^
    "Write-Host 'Observa en resmon.exe: Columna Confirmada vs Espacio de Trabajo' -ForegroundColor White;" ^
    "Write-Host 'Presiona ENTER para liberar la memoria y terminar el proceso...' -ForegroundColor Magenta;" ^
    "$null = [Console]::ReadLine();" ^
    "$bloques.Clear();" ^
    "[System.GC]::Collect();" ^
    "Write-Host '[OK] Memoria liberada. Retornando al sistema operativo.' -ForegroundColor Green;"

echo.
echo ====================================================================
echo  [OK] Practica clinica finalizada con exito.
echo ====================================================================
pause
exit /b 0

:CLEANUP
echo [*] Deteniendo procesos residuales de PowerShell de diagnostico...
powershell -Command "Get-Process powershell -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -like '*Diagnostico*' } | Stop-Process" >nul 2>&1
echo [OK] Limpieza completada.
pause
exit /b 0
