# Script de Setup: Clase 2 (Particionamiento NTFS y Diskpart)
Param(
    [string]$PathVhd = "C:\Temp\LSO_Clase2.vhd",
    [switch]$UltraLight = $false
)

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Setup Clase 2: Particionado & NTFS" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

$SizeMB = 1024
if ($UltraLight) {
    $SizeMB = 128
    Write-Host "[!] Modo B de Contingencia (Netbooks): VHD de 128 MB." -ForegroundColor Yellow
} else {
    Write-Host "[+] Modo A (Nodo Tecnológico): VHD de 1024 MB." -ForegroundColor Green
}

if (-not (Test-Path "C:\Temp")) { New-Item -Path "C:\Temp" -ItemType Directory | Out-Null }

if (Test-Path $PathVhd) {
    Dismount-VHD -Path $PathVhd -ErrorAction SilentlyContinue
    Remove-Item -Path $PathVhd -Force
}

Write-Host "[+] Creando y montando VHD sin inicializar (RAW)..." -ForegroundColor Green
$vhd = New-VHD -Path $PathVhd -SizeBytes ($SizeMB * 1MB) -Dynamic
$mounted = Mount-VHD -Path $PathVhd -PassThru
$disk = $mounted | Get-Disk

Write-Host "[✓] DISCO N.º $($disk.Number) LISTO EN ESTADO 'RAW' PARA PRACTICAR DISKPART Y POWERSHELL." -ForegroundColor Green
