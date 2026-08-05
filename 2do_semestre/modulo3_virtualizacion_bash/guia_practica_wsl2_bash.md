# Guía Práctica de Laboratorio: Virtualización Ligera con WSL2 y Scripting en Bash

## 🎯 Objetivo Práctico
Configurar la distribución Linux en WSL2 sobre Windows 11 y desarrollar un script en Bash (`.sh`) que realice diagnósticos automatizados del sistema operativo y genere un reporte de salud del servidor.

---

## 🛠️ Parte A: Verificación de WSL2 e Interoperabilidad

### Paso 1: Verificación desde Windows 11 (PowerShell)
```powershell
# Verificar estado y versión de WSL
wsl --status
wsl --list --verbose
```

### Paso 2: Interoperabilidad del Sistema de Archivos
Abre la consola de Ubuntu WSL2:

```bash
# Acceder a la unidad C de Windows desde Linux
cd /mnt/c
ls -la

# Ejecutar un comando de Windows desde la terminal de Linux
ipconfig.exe
```

---

## 🐧 Parte B: Desarrollo del Script de Diagnóstico en Bash

### Paso 1: Crear el Archivo `reporte_sistema.sh`
```bash
nano ~/reporte_sistema.sh
```

### Paso 2: Copiar y Analizar el Código
```bash
#!/bin/bash
# =======================================================
# LSO 4to - Script de Diagnóstico de Sistema en Linux
# =======================================================

REPORT_FILE="salud_sistema_$(date +%Y%m%d).log"

echo "==========================================" > $REPORT_FILE
echo " REPORTE DE SALUD DEL SISTEMA - LSO 4TO " >> $REPORT_FILE
echo " FECHA: $(date)" >> $REPORT_FILE
echo " USUARIO: $(whoami)" >> $REPORT_FILE
echo " HOSTNAME: $(hostname)" >> $REPORT_FILE
echo "==========================================" >> $REPORT_FILE

echo "" >> $REPORT_FILE
echo "[1] USO DE MEMORIA RAM:" >> $REPORT_FILE
free -h >> $REPORT_FILE

echo "" >> $REPORT_FILE
echo "[2] ESPACIO EN DISCO:" >> $REPORT_FILE
df -h / >> $REPORT_FILE

echo "" >> $REPORT_FILE
echo "[3] PROCESOS CON MAYOR CONSUMO DE CPU:" >> $REPORT_FILE
ps aux --sort=-%cpu | head -n 6 >> $REPORT_FILE

echo "Reporte generado con éxito en: $REPORT_FILE"
cat $REPORT_FILE
```

### Paso 3: Asignar Permisos y Ejecutar
```bash
chmod +x ~/reporte_sistema.sh
~/reporte_sistema.sh
```

---

## 📋 Consignas de Entrega
1. Adjuntar captura de la terminal de Linux ejecutando `reporte_sistema.sh` y mostrando el archivo generado.
2. Explicar qué función cumple el encabezado `#!/bin/bash` (*Shebang*) en la primera línea del script.
3. Modificar el script para que envíe una alerta si el uso de espacio en disco supera el 80%.
