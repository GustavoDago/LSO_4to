# ==============================================================================
# RESTAURACIÓN Módulo 4 - Clase 1: cierra los sockets del escenario y limpia archivos
# Uso: powershell -ExecutionPolicy Bypass -File .\restaurar_clase1_redes.ps1
# ==============================================================================

$carpeta = Join-Path $env:TEMP "LSO_Redes"
$pidFile = Join-Path $carpeta "pid.txt"

if (Test-Path $pidFile) {
    $id = Get-Content $pidFile -ErrorAction SilentlyContinue
    if ($id -and (Get-Process -Id $id -ErrorAction SilentlyContinue)) {
        Stop-Process -Id $id -Force
        Write-Host "[+] Proceso del escenario (PID $id) finalizado." -ForegroundColor Green
    }
}

# Recordatorio: el informe vive en %TEMP% y se pierde al reiniciar (Deep Freeze)
$informe = Join-Path $carpeta "informe_clase1_redes.txt"
if (Test-Path $informe) {
    Write-Host "[i] Recordá copiar tu informe a tu pendrive / Drive antes de limpiar:" -ForegroundColor Yellow
    Write-Host "    $informe" -ForegroundColor Gray
}

Start-Sleep -Seconds 1
$restantes = Get-NetTCPConnection -LocalPort 8080, 9090 -ErrorAction SilentlyContinue
if (-not $restantes) {
    Write-Host "[+] Puertos 8080 y 9090 liberados. Equipo restaurado." -ForegroundColor Green
} else {
    Write-Host "[!] Aún hay sockets abiertos en 8080/9090 (pueden quedar en TIME_WAIT unos segundos)." -ForegroundColor Yellow
}
