# Guía de Resolución de Incidentes: Pasos de Diagnóstico y Remediación (TP Integrador)

## 📌 Protocolo de Respuesta a Incidentes (Paso a Paso)

### Fase 1: Diagnóstico de Almacenamiento (Windows 11)
1. Ejecutar PowerShell como Administrador.
2. Comprobar estado de discos virtuales y particiones:
   ```powershell
   Get-Disk | Where-Object IsVirtual -eq $true
   Get-Volume
   ```
3. Montar y asignar letra de unidad si el volumen está desmontado:
   ```powershell
   Mount-VHD -Path "C:\Temp\TechCorp_Data.vhd"
   ```

---

### Fase 2: Auditoría y Remediación de Permisos (ACL & POSIX)
1. En Windows 11, auditar permisos en carpetas comprometidas:
   ```cmd
   icacls "C:\Temp\TechCorp_Data\Finanzas"
   ```
2. Restablecer propietario y quitar accesos no autorizados:
   ```powershell
   icacls "C:\Temp\TechCorp_Data\Finanzas" /inheritance:r
   icacls "C:\Temp\TechCorp_Data\Finanzas" /grant:r "Administradores:(F)"
   ```
3. En Linux WSL2, asegurar archivos de claves:
   ```bash
   chmod 600 ~/techcorp_keys/*.key
   ```

---

### Fase 3: Conectividad Remota y Firewall
1. Verificar estado del puerto SSH en Linux:
   ```bash
   sudo ss -tulpn | grep 22
   sudo service ssh restart
   ```
2. Permitir el puerto en UFW:
   ```bash
   sudo ufw allow 22/tcp
   ```
3. Probar la conexión SSH desde PowerShell:
   ```powershell
   ssh usuario_techcorp@localhost
   ```

---

### Fase 4: Auditoría Final y Verificación de Salud
Ejecutar el script de monitoreo en Bash y verificar que genere el registro sin errores:
```bash
./auditoria_final.sh
cat /tmp/auditoria_final.log
```
