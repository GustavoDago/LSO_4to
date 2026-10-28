# ==============================================================================
# DEMO DEL DOCENTE - Módulo 4 / Clase 3: El Portero y su Lista (Reglas del Firewall)
# Laboratorio de Sistemas Operativos (LSO) - 4.º Año
#
# ⚠️ REQUIERE ADMINISTRADOR. Pensado para la máquina proyectada del docente.
#    Crea 4 reglas, una por vez, mostrando primero la "ficha" en castellano y
#    después el comando. Todas quedan en el grupo "LSO-Clase3" para borrarlas
#    juntas. Deep Freeze también las revierte al reiniciar; en una PC personal
#    SIEMPRE ejecutar -Cleanup al final.
#
# Uso:
#   Demo paso a paso:   .\demo_docente_reglas_clase3.ps1 -IpBloqueada <IP_de_un_alumno>
#   Sin regla 3:        .\demo_docente_reglas_clase3.ps1
#   Solo listar:        .\demo_docente_reglas_clase3.ps1 -Listar
#   Limpiar todo:       .\demo_docente_reglas_clase3.ps1 -Cleanup
#
# Nota: por defecto las reglas usan perfil "Any" para que funcionen aunque la
# red del laboratorio esté como Pública (el perfil no es contenido de esta clase).
# (Desde una consola sin política: powershell -ExecutionPolicy Bypass -File ...)
# ==============================================================================
#Requires -RunAsAdministrator

param(
    [switch]$Cleanup,
    [switch]$Listar,
    [string]$IpBloqueada,
    [ValidateSet("Private", "Public", "Domain", "Any")]
    [string]$Perfil = "Any",
    [switch]$SinPausas
)

$grupo = "LSO-Clase3"
$curl  = Join-Path $env:SystemRoot "System32\curl.exe"

function Titulo($texto) {
    Write-Host ""
    Write-Host "==================================================================" -ForegroundColor Cyan
    Write-Host " $texto" -ForegroundColor Cyan
    Write-Host "==================================================================" -ForegroundColor Cyan
}

function Pausa($mensaje = "Presioná ENTER para continuar...") {
    if (-not $SinPausas) { Read-Host "`n$mensaje" | Out-Null }
}

function Mostrar-Reglas {
    $reglas = Get-NetFirewallRule -Group $grupo -ErrorAction SilentlyContinue
    if (-not $reglas) { Write-Host "  (No hay reglas en el grupo $grupo)" -ForegroundColor DarkGray; return }
    $reglas | ForEach-Object {
        $pf = $_ | Get-NetFirewallPortFilter
        $af = $_ | Get-NetFirewallAddressFilter
        $ap = $_ | Get-NetFirewallApplicationFilter
        $puerto = if ("$($_.Direction)" -eq "Inbound") { $pf.LocalPort } else { $pf.RemotePort }
        [PSCustomObject]@{
            Regla       = $_.DisplayName
            EntraSale   = if ("$($_.Direction)" -eq "Inbound") { "Entra" } else { "Sale" }
            Accion      = if ("$($_.Action)" -eq "Allow") { "Permitir" } else { "Bloquear" }
            Tipo        = $pf.Protocol
            Puerto      = ($puerto -join ",")
            Quien       = ($af.RemoteAddress -join ",")
            Programa    = (Split-Path $ap.Program -Leaf)
        }
    } | Format-Table -AutoSize
}

function Nueva-Regla($paso, $titulo, [string[]]$ficha, [hashtable]$params, $prueba) {
    Titulo "Regla $paso - $titulo"
    Write-Host "FICHA (en castellano):" -ForegroundColor Yellow
    $ficha | ForEach-Object { Write-Host "  - $_" -ForegroundColor White }
    $orden = "DisplayName", "Direction", "Action", "Protocol", "LocalPort", "RemoteAddress", "Program", "Profile"
    $vista = ($orden | Where-Object { $params.ContainsKey($_) } |
              ForEach-Object { "-$_ `"$($params[$_])`"" }) -join " "
    Write-Host "COMANDO (la misma ficha, en PowerShell):" -ForegroundColor Yellow
    Write-Host "  New-NetFirewallRule $vista" -ForegroundColor White
    Pausa "ENTER para crear la regla..."
    New-NetFirewallRule @params -Group $grupo | Out-Null
    Write-Host "[+] Regla creada." -ForegroundColor Green
    Write-Host "[?] Ahora prueben: $prueba" -ForegroundColor Magenta
    Pausa
}

# ------------------------------------------------------------------------------
# LIMPIEZA / LISTADO
# ------------------------------------------------------------------------------
if ($Cleanup) {
    Titulo "Limpieza: eliminando reglas del grupo $grupo"
    $r = Get-NetFirewallRule -Group $grupo -ErrorAction SilentlyContinue
    if ($r) {
        $r | Remove-NetFirewallRule
        Write-Host "[+] Eliminadas $(@($r).Count) reglas." -ForegroundColor Green
    } else {
        Write-Host "[i] No había reglas del grupo $grupo." -ForegroundColor Gray
    }
    return
}

if ($Listar) { Titulo "Reglas actuales del grupo $grupo"; Mostrar-Reglas; return }

# ------------------------------------------------------------------------------
# PREPARACIÓN
# ------------------------------------------------------------------------------
Titulo "LSO 4to - Demo Clase 3: El Portero y su Lista"

$ip = (Get-NetIPAddress -AddressFamily IPv4 |
       Where-Object { $_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*" } |
       Select-Object -First 1)

Write-Host "IP del profe (escribila en el pizarrón):  $($ip.IPAddress)" -ForegroundColor Green

# Servidor de prueba en 8080 (sin él, la regla 1 no tiene nada que mostrar)
if (-not (Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue)) {
    $setup = Join-Path $PSScriptRoot "setup_clase3_reglas.ps1"
    if (Test-Path $setup) {
        Write-Host "[*] Levantando servidor de prueba en 8080 con setup_clase3_reglas.ps1..." -ForegroundColor Yellow
        & $setup | Out-Null
    } else {
        Write-Host "[!] No hay nada escuchando en 8080 y no se encontró setup_clase3_reglas.ps1." -ForegroundColor Red
    }
}

# Idempotencia: borrar restos de una demo anterior
Get-NetFirewallRule -Group $grupo -ErrorAction SilentlyContinue | Remove-NetFirewallRule

Titulo "Paso 0 - Antes de crear reglas (el misterio de la Clase 2)"
Write-Host "Pidan a los alumnos que prueben desde sus PC:" -ForegroundColor Magenta
Write-Host "  Test-NetConnection $($ip.IPAddress) -Port 8080     -> False (el portero no los deja entrar)" -ForegroundColor White
Write-Host "  ping $($ip.IPAddress)                              -> no responde" -ForegroundColor White
Write-Host "En esta PC (proyectada):" -ForegroundColor Magenta
Write-Host "  curl.exe -s -m 5 -o NUL -w `"%{http_code}`" http://example.com   -> 200 (anda)" -ForegroundColor White
Pausa

# ------------------------------------------------------------------------------
# REGLAS
# ------------------------------------------------------------------------------
Nueva-Regla 1 "Abrir el puerto 8080 para el aula" @(
    "¿Entra o sale?      Entra (Inbound)",
    "¿Permitir/bloquear? Permitir (Allow)",
    "¿Qué puerto?        TCP 8080",
    "¿Quién?             Las PC del aula (LocalSubnet)") @{
    DisplayName   = "LSO3 - Web 8080 aula"
    Direction     = "Inbound"
    Action        = "Allow"
    Protocol      = "TCP"
    LocalPort     = 8080
    RemoteAddress = "LocalSubnet"
    Profile       = $Perfil
} "Test-NetConnection $($ip.IPAddress) -Port 8080  -> ahora True"

Nueva-Regla 2 "Que el aula me pueda hacer ping" @(
    "¿Entra o sale?      Entra (Inbound)",
    "¿Permitir/bloquear? Permitir (Allow)",
    "¿Qué tipo?          Ping (ICMPv4, no usa puerto)",
    "¿Quién?             Las PC del aula (LocalSubnet)") @{
    DisplayName   = "LSO3 - Ping aula"
    Direction     = "Inbound"
    Action        = "Allow"
    Protocol      = "ICMPv4"
    RemoteAddress = "LocalSubnet"
    Profile       = $Perfil
} "ping $($ip.IPAddress)  -> ahora responde"

if ($IpBloqueada) {
    Nueva-Regla 3 "Bloquear a un compañero (gana el NO)" @(
        "¿Entra o sale?      Entra (Inbound)",
        "¿Permitir/bloquear? Bloquear (Block)",
        "¿Qué puerto?        Todos (no se escribe)",
        "¿Quién?             Solo la PC $IpBloqueada") @{
        DisplayName   = "LSO3 - Bloquear $IpBloqueada"
        Direction     = "Inbound"
        Action        = "Block"
        RemoteAddress = $IpBloqueada
        Profile       = $Perfil
    } "El alumno con IP $IpBloqueada repite Test-NetConnection -> False (la regla 1 lo permite, pero gana Block). El resto sigue en True."
} else {
    Write-Host "[i] Regla 3 omitida: reejecutá con -IpBloqueada <IP_de_un_alumno>." -ForegroundColor DarkYellow
}

Nueva-Regla 4 "Bloquear curl.exe sin cortar Chrome" @(
    "¿Entra o sale?      Sale (Outbound)",
    "¿Permitir/bloquear? Bloquear (Block)",
    "¿Qué puerto?        Todos",
    "¿Qué programa?      curl.exe") @{
    DisplayName = "LSO3 - Sin curl"
    Direction   = "Outbound"
    Action      = "Block"
    Program     = $curl
    Profile     = $Perfil
} "Profe: curl.exe -s -m 5 http://example.com -> falla. Abrir Chrome -> sigue navegando."

# ------------------------------------------------------------------------------
# REPASO Y CIERRE
# ------------------------------------------------------------------------------
Titulo "Repaso: las reglas que creamos hoy"
Mostrar-Reglas

Write-Host "Al terminar la clase:  .\demo_docente_reglas_clase3.ps1 -Cleanup" -ForegroundColor Yellow
