# Guía Práctica de Laboratorio: Redes, Administración Remota (SSH) y Firewall (Windows 11 & Linux)

## 🎯 Objetivo Práctico
Auditar la pila de red TCP/IP, levantar el servicio SSH en Linux WSL2, establecer una sesión remota desde Windows 11 y configurar reglas de filtrado en el firewall.

---

## 🛠️ Parte A: Diagnóstico de Red TCP/IP

### Paso 1: Inspección de Direccionamiento y Sockets en Windows 11
Abre PowerShell:

```powershell
# Ver direccionamiento e interfaces de red
Get-NetIPAddress -AddressFamily IPv4 | Select-Object InterfaceAlias, IPAddress

# Inspeccionar puertos abiertos y servicios escuchando
Get-NetTCPConnection -State Listen | Select-Object LocalAddress, LocalPort, OwningProcess
```

### Paso 2: Inspección de Direccionamiento y Sockets en Linux WSL2
En la terminal de Linux:

```bash
# Ver interfaces de red
ip a

# Ver puertos de red en escucha (TCP/UDP)
sudo ss -tulpn
```

---

## 🐧 Parte B: Servidor SSH y Transferencia Remota Segura

### Paso 1: Configurar Servidor SSH en Ubuntu WSL2
```bash
# 1. Instalar servidor SSH si no está presente
sudo apt update && sudo apt install -y openssh-server

# 2. Iniciar el servicio SSH
sudo service ssh start
sudo service ssh status

# 3. Generar par de claves RSA/ED25519 en tu cliente
ssh-keygen -t ed25519 -C "alumno@lso"
```

### Paso 2: Conexión SSH desde Windows 11 (PowerShell)
Abre PowerShell en Windows 11 y conéctate al entorno Linux:

```powershell
# Conectar por SSH a localhost (puerto 22)
ssh usuario_linux@localhost

# Transferir un archivo desde Windows 11 a Linux vía SCP
scp C:\Temp\archivo_prueba.txt usuario_linux@localhost:~/
```

---

## 🛡️ Parte C: Configuración de Firewall

### En Linux (UFW - Uncomplicated Firewall)
```bash
# Habilitar firewall ufw
sudo ufw enable

# Permitir puerto SSH (22) y denegar puerto Web (80)
sudo ufw allow 22/tcp
sudo ufw deny 80/tcp
sudo ufw status verbose
```

### En Windows 11 (Netsh / PowerShell Firewall)
```powershell
# Ver estado del firewall
Get-NetFirewallProfile

# Crear regla para bloquear ping (ICMPv4) de prueba
New-NetFirewallRule -Name "Bloqueo_ICMP_LSO" -DisplayName "Bloquear Ping LSO" -Protocol ICMPv4 -Action Block -Direction Inbound
```

---

## 📋 Consignas de Entrega
1. Adjuntar captura del comando `ss -tulpn` en Linux mostrando el puerto 22 en estado `LISTEN`.
2. Adjuntar captura de la sesión remota SSH establecida desde la PowerShell de Windows 11.
3. Explicar la función de las claves de host (*known_hosts*) al conectarse por primera vez a un servidor SSH.
