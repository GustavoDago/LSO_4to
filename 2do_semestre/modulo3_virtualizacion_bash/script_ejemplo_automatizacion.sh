#!/bin/bash
# Script de Automatización de Ejemplo: Auditoría de Seguridad y Limpieza
# Módulo 3 - LSO 4to Año

LOG_FILE="/tmp/auditoria_lso.log"

echo "=== INICIANDO AUDITORÍA DE SISTEMA EN LINUX WSL2 ===" | tee $LOG_FILE
echo "Fecha y hora: $(date)" | tee -a $LOG_FILE

# 1. Comprobar usuarios activos con shell Bash
echo -e "\n[+] Cuentas de usuario registradas:" | tee -a $LOG_FILE
grep "/bin/bash" /etc/passwd | cut -d: -f1 | tee -a $LOG_FILE

# 2. Comprobar permisos inseguros en /tmp
echo -e "\n[+] Verificando archivos ejecutables en /tmp:" | tee -a $LOG_FILE
find /tmp -type f -executable 2>/dev/null | tee -a $LOG_FILE

# 3. Comprobar si el servicio cron o SSH está activo
echo -e "\n[+] Estado de servicios principales:" | tee -a $LOG_FILE
if pgrep -x "cron" > /dev/null; then
    echo " -> Servicio CRON: EN EJECUCIÓN" | tee -a $LOG_FILE
else
    echo " -> Servicio CRON: DETENIDO" | tee -a $LOG_FILE
fi

echo -e "\n=== AUDITORÍA FINALIZADA ===" | tee -a $LOG_FILE
