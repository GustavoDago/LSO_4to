# ==============================================================================
# RESTAURACIÓN Módulo 4 - Clase 3: El Portero y su Lista (Reglas del Firewall)
# Laboratorio de Sistemas Operativos (LSO) - 4.º Año
#
# - Detiene el servidor de prueba (puerto 8080) y borra la carpeta temporal.
# - Si se ejecuta COMO ADMINISTRADOR (PC personal), también elimina las reglas
#   del grupo "LSO-Clase3" que el alumno haya creado al replicar la práctica.
#
# Uso: powershell -ExecutionPolicy Bypass -File .\restaurar_clase3_reglas.ps1
# ==============================================================================

$carpeta = Join-Path $env:TEMP "LSO_Redes_Clase3"
$pidFile = Join-Path $carpeta "pid_clase3.txt"
$informe = Join-Path $carpeta "informe_clase3_reglas.txt"
$grupo   = "LSO-Clase3"

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Restauración y Limpieza: Módulo 4 / Clase 3 " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# 1. Respaldar el informe en el Escritorio antes de borrar la carpeta
if (Test-Path $informe) {
    $destino = Join-Path ([Environment]::GetFolderPath("Desktop")) "informe_clase3_reglas.txt"
    Copy-Item $informe $destino -Force -ErrorAction SilentlyContinue
    Write-Host "[+] Informe copiado al Escritorio: $destino" -ForegroundColor Green
}

# 2. Detener el servidor de prueba
if (Test-Path $pidFile) {
    $procId = Get-Content $pidFile -ErrorAction SilentlyContinue
    if ($procId -and (Get-Process -Id $procId -ErrorAction SilentlyContinue)) {
        Write-Host "[*] Deteniendo servidor de prueba (PID $procId)..." -ForegroundColor Yellow
        Stop-Process -Id $procId -Force -ErrorAction SilentlyContinue
    }
}

# 3. Liberar el puerto 8080 si quedó algún residuo
$conn = Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue
foreach ($rPid in ($conn.OwningProcess | Select-Object -Unique)) {
    if ($rPid) {
        Write-Host "[*] Liberando puerto 8080 (PID $rPid)..." -ForegroundColor Yellow
        Stop-Process -Id $rPid -Force -ErrorAction SilentlyContinue
    }
}

# 4. Eliminar reglas del grupo LSO-Clase3 (solo si hay privilegios de administrador)
$esAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)
$reglas = Get-NetFirewallRule -Group $grupo -ErrorAction SilentlyContinue
if ($reglas) {
    if ($esAdmin) {
        $reglas | Remove-NetFirewallRule
        Write-Host "[+] Eliminadas $(@($reglas).Count) reglas del grupo '$grupo'." -ForegroundColor Green
    } else {
        Write-Host "[!] Hay reglas del grupo '$grupo', pero se necesita admin para borrarlas." -ForegroundColor Yellow
        Write-Host "    Ejecutá esta restauración como administrador." -ForegroundColor Yellow
    }
}

Start-Sleep -Seconds 1

# 5. Borrar carpeta temporal y verificar
Remove-Item $carpeta -Recurse -Force -ErrorAction SilentlyContinue

if (-not (Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue)) {
    Write-Host "[+] Limpieza exitosa: puerto 8080 cerrado y carpeta temporal eliminada." -ForegroundColor Green
} else {
    Write-Host "[!] Advertencia: el puerto 8080 sigue en LISTENING. Consultá al docente." -ForegroundColor Red
}
Write-Host "==================================================" -ForegroundColor Cyan
