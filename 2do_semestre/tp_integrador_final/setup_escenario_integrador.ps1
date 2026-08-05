# Script de Setup Automático: TP Integrador Final (Escenario de Incidentes)
# Despliega el escenario de prueba de TechCorp para el desafío final.

Write-Host "==========================================================" -ForegroundColor Red
Write-Host " LSO 4to - SETUP DESAFÍO FINAL: RESPUESTA A INCIDENTES    " -ForegroundColor Red
Write-Host "==========================================================" -ForegroundColor Red

$vhdPath = "C:\Temp\TechCorp_Data.vhd"
$baseDir = "C:\Temp\TechCorp_Data_Local"

# 1. Crear directorios de simulación
if (Test-Path $baseDir) { Remove-Item -Path $baseDir -Recurse -Force }
New-Item -Path "$baseDir\Finanzas" -ItemType Directory -Force | Out-Null
New-Item -Path "$baseDir\Publico" -ItemType Directory -Force | Out-Null
New-Item -Path "$baseDir\Finanzas\balances.xlsx" -ItemType File -Value "Datos financieros confidenciales" -Force | Out-Null

# 2. Desconfigurar permisos de prueba (Escenario de brecha)
$acl = Get-Acl "$baseDir\Finanzas"
$acl.SetAccessRuleProtection($true, $true)
Set-Acl "$baseDir\Finanzas" $acl

icacls "$baseDir\Finanzas" /grant "Todos:(F)" | Out-Null # Permiso inseguro deliberado

# 3. Preparar WSL2
Write-Host "[+] Verificando estado de servicio SSH en Linux WSL2..." -ForegroundColor Yellow
wsl -d Ubuntu -u root service ssh stop # Detener SSH deliberadamente para el desafío

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "[!] ESCENARIO DE INCIDENTE LISTO. ¡EMPIEZA EL DESAFÍO!" -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan
