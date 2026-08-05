# Script de Setup Automático: Módulo 2 (Permisos y ACLs)
# Prepara una estructura de carpetas de prueba con permisos manipulados para auditar.

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " LSO 4to - Setup Módulo 2: Permisos & ACL " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$baseDir = "C:\Temp\LSO_Modulo2_Permisos"

if (Test-Path $baseDir) {
    Remove-Item -Path $baseDir -Recurse -Force
}

New-Item -Path "$baseDir\Publico" -ItemType Directory -Force | Out-Null
New-Item -Path "$baseDir\Restringido" -ItemType Directory -Force | Out-Null
New-Item -Path "$baseDir\Publico\leeme.txt" -ItemType File -Value "Archivo de acceso público." -Force | Out-Null
New-Item -Path "$baseDir\Restringido\confidencial.txt" -ItemType File -Value "Archivo confidencial de administración." -Force | Out-Null

# Configurar permisos en Restringido
$acl = Get-Acl "$baseDir\Restringido"
$acl.SetAccessRuleProtection($true, $false) # Romper herencia sin copiar
Set-Acl "$baseDir\Restringido" $acl

icacls "$baseDir\Restringido" /grant:r "Administradores:(F)" | Out-Null

Write-Host "[+] Estructura creada en: $baseDir" -ForegroundColor Green
Write-Host "[+] Escenario de prueba listo para auditoría de permisos." -ForegroundColor Green
