# ==============================================================================
# RESTAURACIÓN Módulo 4 - Clase 2: Perfiles de Red y Windows Defender Firewall
# Laboratorio de Sistemas Operativos (LSO) - 4.º Año
#
# Uso: powershell -ExecutionPolicy Bypass -File .\restaurar_clase2_firewall.ps1
# ==============================================================================

$carpeta = Join-Path $env:TEMP "LSO_Redes_Clase2"
$pidFile = Join-Path $carpeta "pid_clase2.txt"

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Restauración y Limpieza: Módulo 4 / Clase 2 " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# 1. Terminar el proceso del escenario si sigue corriendo
if (Test-Path $pidFile) {
    $procId = Get-Content $pidFile -ErrorAction SilentlyContinue
    if ($procId) {
        $p = Get-Process -Id $procId -ErrorAction SilentlyContinue
        if ($p) {
            Write-Host "[*] Deteniendo proceso en segundo plano (PID $procId)..." -ForegroundColor Yellow
            Stop-Process -Id $procId -Force -ErrorAction SilentlyContinue
        }
    }
}

# 2. Asegurar que los puertos 8080 y 9090 queden totalmente liberados
foreach ($port in 8080, 9090) {
    $conn = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
    if ($conn) {
        $residualPid = $conn.OwningProcess | Select-Object -Unique
        foreach ($rPid in $residualPid) {
            Write-Host "[*] Liberando puerto $port (PID $rPid)..." -ForegroundColor Yellow
            Stop-Process -Id $rPid -Force -ErrorAction SilentlyContinue
        }
    }
}

Start-Sleep -Seconds 1

# 3. Comprobar que los puertos no estén en LISTENING
$check8080 = Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue
$check9090 = Get-NetTCPConnection -LocalPort 9090 -State Listen -ErrorAction SilentlyContinue

if (-not $check8080 -and -not $check9090) {
    Write-Host "[+] Limpieza exitosa: puertos 8080 y 9090 completamente cerrados." -ForegroundColor Green
} else {
    Write-Host "[!] Advertencia: aún se detectan sockets abiertos. Cerralos manualmente." -ForegroundColor Red
}

Write-Host "[i] No olvides guardar tu archivo de informe antes de apagar la máquina." -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
