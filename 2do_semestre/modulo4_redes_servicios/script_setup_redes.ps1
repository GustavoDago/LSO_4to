# Script de Setup Automático: Módulo 4 (Redes y SSH)
# Verifica la presencia del cliente SSH nativo de Windows 11 y prepara WSL2.

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Setup Módulo 4: Redes & SSH    " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Verificación de OpenSSH Client en Windows 11
$sshClient = Get-Command ssh -ErrorAction SilentlyContinue

if ($null -ne $sshClient) {
    Write-Host "[+] Cliente OpenSSH nativo de Windows 11 instalado:" -ForegroundColor Green
    Write-Host "    Ubicación: $($sshClient.Source)" -ForegroundColor Gray
} else {
    Write-Host "[!] Cliente OpenSSH no detectado. Habilitando característica opcional..." -ForegroundColor Yellow
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0 | Out-Null
}

# 2. Iniciar SSH en WSL2
Write-Host "[+] Enviando orden de inicio de servicio SSH a WSL2..." -ForegroundColor Green
wsl -d Ubuntu -u root service ssh start

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "[✓] Servidor SSH en Linux listo en localhost:22" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
