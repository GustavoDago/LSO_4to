# ==============================================================================
# SETUP Módulo 4 - Clase 2: Perfiles de Red y Windows Defender Firewall
# Laboratorio de Sistemas Operativos (LSO) - 4.º Año
#
# Características de Laboratorio:
#   - Sin privilegios de administrador (ejecuta en espacio de usuario).
#   - Compatible con Deep Freeze y Netbooks escolares.
#   - Abre sockets en [System.Net.IPAddress]::Any (0.0.0.0) en puerto 8080 y 9090
#     para permitir el experimento cruzado de firewall con la máquina vecina.
#
# Uso:        powershell -ExecutionPolicy Bypass -File .\setup_clase2_firewall.ps1
# Restaurar:  powershell -ExecutionPolicy Bypass -File .\restaurar_clase2_firewall.ps1
# ==============================================================================

$ErrorActionPreference = "Stop"
$carpeta = Join-Path $env:TEMP "LSO_Redes_Clase2"
$pidFile = Join-Path $carpeta "pid_clase2.txt"

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Setup Módulo 4 / Clase 2: Firewall & Red " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# 1. Crear carpeta temporal de trabajo
New-Item -ItemType Directory -Path $carpeta -Force | Out-Null

# 2. Limpiar instancias previas si existen
if (Test-Path $pidFile) {
    $viejo = Get-Content $pidFile -ErrorAction SilentlyContinue
    if ($viejo -and (Get-Process -Id $viejo -ErrorAction SilentlyContinue)) {
        Write-Host "[!] Proceso previo detectado (PID $viejo). Reiniciando..." -ForegroundColor Yellow
        Stop-Process -Id $viejo -Force -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 500
    }
}

# 3. Validar puertos libres
foreach ($p in 8080, 9090) {
    if (Get-NetTCPConnection -LocalPort $p -ErrorAction SilentlyContinue) {
        Write-Host "[X] El puerto $p ya está en uso. Cerrando proceso residual..." -ForegroundColor Yellow
        $procConflicto = (Get-NetTCPConnection -LocalPort $p -ErrorAction SilentlyContinue).OwningProcess
        if ($procConflicto) {
            Stop-Process -Id $procConflicto -Force -ErrorAction SilentlyContinue
        }
    }
}

# 4. Código del proceso en segundo plano (Escucha en todas las interfaces para prueba cruzada)
$codigoBg = @'
$l1 = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, 8080)
$l2 = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, 9090)
$l1.Start()
$l2.Start()

# Genera una sesión loopback local activa para demostración de ESTABLISHED
$cliente = [System.Net.Sockets.TcpClient]::new('127.0.0.1', 8080)
$aceptado = $l1.AcceptTcpClient()

while ($true) { 
    Start-Sleep -Seconds 5 
}
'@

$codificado = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($codigoBg))

$proc = Start-Process -FilePath "powershell.exe" `
    -ArgumentList "-NoProfile", "-WindowStyle", "Hidden", "-EncodedCommand", $codificado `
    -WindowStyle Hidden -PassThru

$proc.Id | Set-Content $pidFile

Start-Sleep -Seconds 2

# 5. Plantilla de informe para la Clase 2
$informe = Join-Path $carpeta "informe_clase2_firewall.txt"
@"
INFORME DE LABORATORIO - Módulo 4 / Clase 2: Firewall y Perfiles de Red
Alumno(s): __________________________________   Equipo N.º: ____   Fecha: ___/___/2026

1. CIERRE CLASE 1:
   - PID Proceso Detective (puerto 8080): ________   Nombre: ____________________
   - Caso Clínico A (169.254.x.x): Falla en Capa ________ (Causa: DHCP)
   - Caso Clínico B (Falla 8.8.8.8): Falla en Capa ________ (Causa: Gateway/Router)
   - Caso Clínico C (Falla google.com): Falla en Capa ________ (Causa: DNS)

2. AUDITORÍA CLASE 2:
   - Perfil de red activo (NetworkCategory): ____________________
   - Acción por defecto en Firewall Inbound: ____________________
   - ¿Ping a máquina vecina respondió?: SI / NO
   - Estado de la regla ICMPv4-In (Enabled): ____________________
   - Test-NetConnection a puerto 8080 de máquina vecina: ¿True o False? ________
"@ | Set-Content $informe -Encoding UTF8

# 6. Comprobación final de sockets
$ok = (Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue) -and
      (Get-NetTCPConnection -LocalPort 9090 -State Listen -ErrorAction SilentlyContinue)

if ($ok) {
    Write-Host "[+] Escenario listo: Puertos 8080 y 9090 escuchando en 0.0.0.0." -ForegroundColor Green
    Write-Host "[+] PID del proceso misterioso: $($proc.Id) (guardado para control)." -ForegroundColor Gray
    Write-Host "[+] Archivo de informe creado en: $informe" -ForegroundColor Green
    Write-Host "[i] Ya podés comenzar con la Guía de Actividades N.º 2." -ForegroundColor Cyan
} else {
    Write-Host "[X] Error al inicializar los listeners. Consulta al docente." -ForegroundColor Red
}
Write-Host "==================================================" -ForegroundColor Cyan
