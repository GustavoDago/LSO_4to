# ==============================================================================
# SETUP Módulo 4 - Clase 1: Diagnóstico de Red y Sockets (Windows 11)
# Laboratorio de Sistemas Operativos (LSO) - 4.º Año
#
# Qué hace (sin privilegios de administrador, sin tocar Deep Freeze):
#   - Lanza UN proceso PowerShell oculto que abre sockets reales en loopback:
#       * 127.0.0.1:8080  -> LISTENING (+ una conexión ESTABLISHED contra sí mismo)
#       * 127.0.0.1:9090  -> LISTENING
#   - Guarda el PID en %TEMP%\LSO_Redes\pid.txt (solo para el docente / restauración)
#   - Crea la plantilla de informe de la clase.
#
# Uso:   powershell -ExecutionPolicy Bypass -File .\setup_clase1_redes.ps1
# Restaurar:  powershell -ExecutionPolicy Bypass -File .\restaurar_clase1_redes.ps1
# ==============================================================================

$ErrorActionPreference = "Stop"
$carpeta = Join-Path $env:TEMP "LSO_Redes"
$pidFile = Join-Path $carpeta "pid.txt"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Setup Módulo 4 / Clase 1 (Red) " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Carpeta de trabajo
New-Item -ItemType Directory -Path $carpeta -Force | Out-Null

# 2. Evitar duplicados si ya se ejecutó el setup
if (Test-Path $pidFile) {
    $viejo = Get-Content $pidFile -ErrorAction SilentlyContinue
    if ($viejo -and (Get-Process -Id $viejo -ErrorAction SilentlyContinue)) {
        Write-Host "[!] El escenario ya estaba activo (PID $viejo). Reiniciando..." -ForegroundColor Yellow
        Stop-Process -Id $viejo -Force -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 500
    }
}

# 3. Verificar que los puertos estén libres
foreach ($p in 8080, 9090) {
    if (Get-NetTCPConnection -LocalPort $p -ErrorAction SilentlyContinue) {
        Write-Host "[X] El puerto $p ya está en uso por otro proceso. Cerrá esa aplicación y reintentá." -ForegroundColor Red
        exit 1
    }
}

# 4. Código del proceso en segundo plano (servidor + cliente en loopback)
$codigoBg = @'
$l1 = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, 8080)
$l2 = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, 9090)
$l1.Start()
$l2.Start()
$cliente  = [System.Net.Sockets.TcpClient]::new('127.0.0.1', 8080)
$aceptado = $l1.AcceptTcpClient()
while ($true) { Start-Sleep -Seconds 5 }
'@
$codificado = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($codigoBg))

$proc = Start-Process -FilePath "powershell.exe" `
    -ArgumentList "-NoProfile", "-WindowStyle", "Hidden", "-EncodedCommand", $codificado `
    -WindowStyle Hidden -PassThru
$proc.Id | Set-Content $pidFile

Start-Sleep -Seconds 2

# 5. Plantilla de informe
$informe = Join-Path $carpeta "informe_clase1_redes.txt"
@"
INFORME - Módulo 4 / Clase 1: Diagnóstico de Red y Sockets
Alumno(s): ____________________   Equipo N.º: ____   Fecha: ___/___/2026

1) Mi IPv4: ________  Máscara: ________  Gateway: ________  DNS: ________
2) ¿Mi IP es APIPA (169.254.x.x)?  SI / NO
3) Latencia promedio a 8.8.8.8: ____ ms     Saltos hasta google.com: ____
4) Puertos en LISTENING del escenario: ____ y ____   -> Proceso dueño (PID y nombre): ________
"@ | Set-Content $informe -Encoding UTF8

# 6. Verificación
$ok = (Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue) -and
      (Get-NetTCPConnection -LocalPort 9090 -State Listen -ErrorAction SilentlyContinue)

if ($ok) {
    Write-Host "[+] Escenario de red activo: puertos 8080 y 9090 en LISTENING." -ForegroundColor Green
    Write-Host "[+] Informe de trabajo: $informe" -ForegroundColor Green
    Write-Host "[i] Misión: descubrir qué proceso está detrás de esos puertos." -ForegroundColor Gray
} else {
    Write-Host "[X] No se pudieron abrir los sockets. Avisá al docente." -ForegroundColor Red
}
Write-Host "==========================================" -ForegroundColor Cyan
