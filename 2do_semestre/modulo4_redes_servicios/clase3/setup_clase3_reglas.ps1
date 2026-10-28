# ==============================================================================
# SETUP Módulo 4 - Clase 3: El Portero y su Lista (Reglas del Firewall)
# Laboratorio de Sistemas Operativos (LSO) - 4.º Año
#
# Características de Laboratorio:
#   - Sin privilegios de administrador (ejecuta en espacio de usuario).
#   - Compatible con Deep Freeze y Netbooks escolares.
#   - Abre un socket en 0.0.0.0:8080 para que tu PC sea el "servidor" de prueba:
#       * En el laboratorio: comprobás que, sin regla Allow, nadie entra.
#       * En tu PC personal (con admin): creás la regla y verificás que sí entra.
#   - Genera la plantilla de informe de la Clase 3.
#
# Uso:        powershell -ExecutionPolicy Bypass -File .\setup_clase3_reglas.ps1
# Restaurar:  powershell -ExecutionPolicy Bypass -File .\restaurar_clase3_reglas.ps1
# ==============================================================================

$ErrorActionPreference = "Stop"
$carpeta = Join-Path $env:TEMP "LSO_Redes_Clase3"
$pidFile = Join-Path $carpeta "pid_clase3.txt"
$puerto  = 8080

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Setup Módulo 4 / Clase 3: Reglas de Firewall " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# 1. Carpeta temporal de trabajo
New-Item -ItemType Directory -Path $carpeta -Force | Out-Null

# 2. Limpiar instancia previa (si se ejecutó dos veces)
if (Test-Path $pidFile) {
    $viejo = Get-Content $pidFile -ErrorAction SilentlyContinue
    if ($viejo -and (Get-Process -Id $viejo -ErrorAction SilentlyContinue)) {
        Write-Host "[!] Proceso previo detectado (PID $viejo). Reiniciando..." -ForegroundColor Yellow
        Stop-Process -Id $viejo -Force -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 500
    }
}

# 3. Liberar el puerto si quedó ocupado (por ejemplo, por el setup de la Clase 2)
$conflicto = Get-NetTCPConnection -LocalPort $puerto -State Listen -ErrorAction SilentlyContinue
if ($conflicto) {
    foreach ($procConflicto in ($conflicto.OwningProcess | Select-Object -Unique)) {
        Write-Host "[!] El puerto $puerto está en uso (PID $procConflicto). Cerrando proceso residual..." -ForegroundColor Yellow
        Stop-Process -Id $procConflicto -Force -ErrorAction SilentlyContinue
    }
    Start-Sleep -Milliseconds 500
}

# 4. Servidor mínimo en segundo plano: escucha en todas las interfaces y
#    responde un saludo a cada cliente que logre atravesar el firewall.
$codigoBg = @'
$l = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, 8080)
$l.Start()
while ($true) {
    try {
        $c = $l.AcceptTcpClient()
        $w = [System.IO.StreamWriter]::new($c.GetStream())
        $w.WriteLine("LSO4 Clase 3 - Atravesaste el firewall de " + $env:COMPUTERNAME)
        $w.Flush()
        $c.Close()
    } catch { Start-Sleep -Milliseconds 200 }
}
'@

$codificado = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($codigoBg))

$proc = Start-Process -FilePath "powershell.exe" `
    -ArgumentList "-NoProfile", "-WindowStyle", "Hidden", "-EncodedCommand", $codificado `
    -WindowStyle Hidden -PassThru

$proc.Id | Set-Content $pidFile
Start-Sleep -Seconds 2

# 5. Datos de la terminal para el informe
$ip = (Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue |
       Where-Object { $_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*" } |
       Select-Object -First 1).IPAddress
$perfil = (Get-NetConnectionProfile -ErrorAction SilentlyContinue | Select-Object -First 1).NetworkCategory

# 6. Plantilla de informe
$informe = Join-Path $carpeta "informe_clase3_reglas.txt"
@"
INFORME DE LABORATORIO - Módulo 4 / Clase 3: El Portero y su Lista
Alumno(s): __________________________________   PC N.º: ____   Fecha: ___/___/2026
IP de mi PC: $ip     Perfil de red: $perfil

1. DEMO DEL PROFE (antes -> después):
   - Regla 1 (Web 8080 aula):          Test-NetConnection -> ______ -> ______
   - Regla 2 (Ping aula):              ping               -> ______ -> ______
   - Regla 3 (Bloquear a un compañero): ¿el compañero entró? ______
   - Regla 4 (Sin curl):               ¿curl anduvo? ______  ¿Chrome anduvo? ______

2. ¿Por qué el compañero bloqueado no pudo entrar?
   ______________________________________________________________

3. SIMULADOR "EL PORTERO": Puntaje final ______ / 5

4. DETECTIVE DE ERRORES (regla de Martina):
   Error 1: ___________________  Error 2: ___________________  Mejora: ___________________

5. ESPIAR MI PC: reglas que permiten entrar: ______  reglas que bloquean: ______
"@ | Set-Content $informe -Encoding UTF8

# 7. Comprobación final
if (Get-NetTCPConnection -LocalPort $puerto -State Listen -ErrorAction SilentlyContinue) {
    Write-Host "[+] ¡Listo! Tu PC tiene un servidor de prueba en el puerto $puerto." -ForegroundColor Green
    Write-Host "[+] Tu IP es: $ip  (anotala en la guía)" -ForegroundColor Green
    Write-Host "[+] Informe creado en: $informe" -ForegroundColor Green
    Write-Host "[i] Probá desde tu propia PC:  Test-NetConnection 127.0.0.1 -Port $puerto  -> True" -ForegroundColor Cyan
    Write-Host "[i] (Desde otra PC va a dar False: el portero no deja entrar sin regla.)" -ForegroundColor Cyan
    Write-Host "[i] Ya podés empezar la Guía N.º 3." -ForegroundColor Cyan
} else {
    Write-Host "[X] No se pudo abrir el puerto $puerto. Consultá al docente." -ForegroundColor Red
}
Write-Host "==================================================" -ForegroundColor Cyan
