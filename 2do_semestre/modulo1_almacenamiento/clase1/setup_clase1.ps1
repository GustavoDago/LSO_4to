# Script de Setup: Clase 1 (Almacenamiento VHDX y GPT con Diskpart)
Param(
    [string]$PathVhd = "C:\Temp\LSO_Clase1.vhdx",
    [switch]$UltraLight = $false
)

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Setup Clase 1: Discos VHD & GPT" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$SizeMB = 1024
if ($UltraLight) {
    $SizeMB = 128
    Write-Host "[!] Modo B de Contingencia (Netbooks): VHD de 128 MB." -ForegroundColor Yellow
} else {
    Write-Host "[+] Modo A (Nodo Tecnologico / PC): VHD de 1024 MB." -ForegroundColor Green
}

if (-not (Test-Path "C:\Temp")) { New-Item -Path "C:\Temp" -ItemType Directory | Out-Null }

# Desmontar si ya existe previamente
$dpDetach = @"
select vdisk file="$PathVhd"
detach vdisk
"@
$dpDetach | Out-File "$env:TEMP\dp_clean.txt" -Encoding ascii
diskpart /s "$env:TEMP\dp_clean.txt" 2>$null | Out-Null

if (Test-Path $PathVhd) { Remove-Item -Path $PathVhd -Force }

Write-Host "[+] Creando y configurando VHDX con Diskpart (compatible con Windows Home)..." -ForegroundColor Green
$dpCreate = @"
create vdisk file="$PathVhd" maximum=$SizeMB type=expandable
attach vdisk
convert gpt
create partition primary
format fs=ntfs quick label="LSO_VHD"
assign
"@
$dpCreate | Out-File "$env:TEMP\dp_create.txt" -Encoding ascii
diskpart /s "$env:TEMP\dp_create.txt" | Out-Null

Write-Host "[+] DISCO VHDX CONFIGURADO Y MONTADO CON EXITO VIA DISKPART" -ForegroundColor Green
