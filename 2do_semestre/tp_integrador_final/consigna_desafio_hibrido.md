# TP Integrador Final: "Desafío Híbrido y Respuesta a Incidentes" (LSO 4.º Año)

## 🎮 Escenario del Desafío (Lore)
El servidor híbrido de la empresa ficticia *"TechCorp LSO"* ha sufrido una brecha de seguridad combinada. Un atacante logró comprometer permisos de seguridad en el sistema de archivos de Windows 11, alteró la tabla de particiones de un disco virtual, modificó la política de cortafuegos y deshabilitó el servicio SSH de administración remota en el entorno Linux WSL2.

Como equipo de Analistas de Sistemas Operativos, la misión consiste en diagnosticar el estado del servidor, remediar los incidentes y desplegar una infraestructura híbrida segura antes de que venza el tiempo límite del turno de laboratorio.

---

## 🎯 Requisitos de Aprobación
1. **Remediación de Almacenamiento (Módulo 1):** Montar el disco VHD de datos (`C:\Temp\TechCorp_Data.vhd`), reparar el sistema de archivos NTFS corrupto y verificar la salud de los bloques.
2. **Restablecimiento de Permisos y ACLs (Módulo 2):** Quitar accesos no autorizados a cuentas públicas en la carpeta confidencial (`C:\Temp\TechCorp_Data\Finanzas`) y aplicar permisos octales `600` a los archivos de configuración en Linux.
3. **Automatización en Bash y WSL2 (Módulo 3):** Desarrollar un script `.sh` que audite el consumo de memoria RAM y CPU en Linux y genere un archivo de registro diario en el cronjob.
4. **Seguridad de Red y Conectividad Remota (Módulo 4):** Reconfigurar el demonio SSH en Ubuntu WSL2, abrir los puertos estrictamente necesarios en el firewall (`ufw` / `netsh`) y realizar una transferencia segura de archivos auditada desde PowerShell.

---

## 📦 Entregables
* **Informe Técnico de Incidentes:** Documento estructurado con el diagnóstico inicial, los comandos de remediación ejecutados en Windows 11 y Linux, y capturas de pantalla de comprobación.
* **Script de Auditoría `.sh`:** Código fuente del script de monitoreo en Bash.
* **Demostración Práctica:** Defensa en vivo en la terminal del laboratorio.
