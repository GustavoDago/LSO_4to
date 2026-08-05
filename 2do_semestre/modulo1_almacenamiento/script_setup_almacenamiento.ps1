# Script de Setup Automático: Módulo 1 (Almacenamiento en Windows 11)
# Admite Modo A (Nodo Tecnológico Potente - VHD 1 GB) y Modo B (Contingencia Netbooks - VHD 128 MB)

Param(
    [string]$PathVhd = "C:\Temp\LSO_Modulo1.vhd",
    [switch]$UltraLight = $false
)

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Setup Módulo 1: Almacenamiento " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Definir tamaño según modo de laboratorio
$SizeMB = 1024
if ($UltraLight) {
    $SizeMB = 128
    Write-Host "[!] Modo B de Contingencia (Netbooks Escolares): VHD ultra-liviano de 128 MB." -ForegroundColor Yellow
} else {
    Write-Host "[+] Modo A (Nodo Tecnológico): VHD de 1024 MB." -ForegroundColor Green
}

# 1. Crear directorio C:\Temp si no existe
if (-not (Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory | Out-Null
    Write-Host "[+] Directorio C:\Temp creado." -ForegroundColor Green
}

# 2. Desmontar si ya existe una versión previa
if (Test-Path $PathVhd) {
    Write-Host "[!] Limpiando disco virtual previo..." -ForegroundColor Yellow
    Dismount-VHD -Path $PathVhd -ErrorAction SilentlyContinue
    Remove-Item -Path $PathVhd -Force
}

# 3. Crear nuevo VHD
Write-Host "[+] Creando disco virtual VHD de $SizeMB MB..." -ForegroundColor Green
$vhd = New-VHD -Path $PathVhd -SizeBytes ($SizeMB * 1MB) -Dynamic

# 4. Montar e inicializar en GPT
Write-Host "[+] Montando e inicializando el disco virtual..." -ForegroundColor Green
$mounted = Mount-VHD -Path $PathVhd -PassThru
$disk = $mounted | Get-Disk
Initialize-Disk -Number $disk.Number -PartitionStyle GPT

# 5. Crear partición y formatear NTFS
Write-Host "[+] Creando partición NTFS 'LSO_LAB1'..." -ForegroundColor Green
$partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -AssignDriveLetter
Format-Volume -Partition $partition -FileSystem NTFS -NewFileSystemLabel "LSO_LAB1" -Confirm:$false | Out-Null

$driveLetter = $partition.DriveLetter
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "[✓] ENTORNO LISTO EN LA UNIDAD $driveLetter:" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
