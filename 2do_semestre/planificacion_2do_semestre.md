# Planificación Pedagógica y Didáctica: 2.º Semestre (LSO 4.º Año)
## Tecnicatura en Informática Personal y Profesional

* **Asignatura:** Laboratorio de Sistemas Operativos (LSO)
* **Año:** 4.º Año
* **Carga Horaria Semanal:** 4 Horas Reloj / Cátedra
  * 🔹 **Miércoles:** 2 horas (Teoría Aplicada & Laboratorio 1)
  * 🔹 **Jueves:** 2 horas (Laboratorio 2 & Desafíos Prácticos)
* **Sistemas Operativos Objeto de Estudio:** Windows 11 y Linux (Lubuntu / Linux Mint XFCE en Pendrive Persistente)
* **Entorno de Laboratorio:** Computadoras con Windows 11 Home freezadas (Deep Freeze) + Arranque por Live USB Persistente (Rufus)

---

## 🎯 Fundamentación y Estrategia de Entorno (Máquinas Freezadas & Windows 11 Home)

Para superar las restricciones de las computadoras con **Windows 11 Home** y **Deep Freeze activo sin credenciales de administración**, y maximizar el tiempo de práctica efectiva en el laboratorio, la estrategia operativa se basa en:

1. **Dualidad Operativa Host Windows 11 / Live USB Linux:**
   * **Prácticas Windows:** Se ejecutan de forma nativa en el sistema anfitrión (`diskpart`, VHDs dinámicos, NTFS, `icacls`, `Get-ACL`, firewall de Windows).
   * **Prácticas Linux:** Se ejecutan booteando desde un **Pendrive Persistente** (preparado con **Lubuntu / Linux Mint XFCE** mediante **Rufus** y partición de persistencia `casper-rw`). Esto otorga acceso completo a Kernel, `systemd`, `fdisk`, `mkfs.ext4`, `mount`, `sshd` y `ufw` sin tocar el disco del colegio ni alterar la congelación.
2. **Persistencia Híbrida (Pendrive + Cloud):** Los alumnos conservan su sistema Linux, configuraciones y paquetes en la partición persistente de su pendrive, y respaldan sus scripts y entregas en Google Drive / Google Classroom.
3. **Arranque Rápido por Menú de Inicio (Boot Menu):** El inicio en Linux se realiza seleccionando la unidad USB mediante teclas de acceso directo (**F12, F11 o Esc**) sin requerir ingreso a la configuración del BIOS ni descongelar Deep Freeze.
4. **Scripts de Setup Inmediatos (< 1 Minuto):** Cada clase cuenta con scripts en Batch (`setup_claseX.bat`) para Windows y scripts Bash (`setup_claseX.sh`) para Linux que preparan los escenarios y archivos de prueba al instante.

---

## 🎮 Herramientas Pedagógicas e Infraestructura Flexible

* **Gamificación con Kahoot (10 Preguntas con 4 Opciones):** Cada clase desarrollada incluye una trivia de repaso lúdico al inicio o cierre con al menos 10 preguntas de opción múltiple (1 correcta y 3 distractores técnicos justificados) para fijar comandos y conceptos clave.
* **Integración con NotebookLM:** Se proveen guías, podcasts/audios explicativos, infografías y cuestionarios integrables al cuaderno digital **"LSO 4to - 2do semestre"** en NotebookLM para facilitar el estudio interactivo dentro y fuera del aula.
* **Flexibilidad de Hardware (Plan de Contingencia Netbooks):**
  * **Modo A (Laboratorio Principal con Windows 11 + Live USB):** Prácticas completas en Windows 11 con discos VHD y arranque en Linux Lubuntu/Mint con persistencia de 4 GB o superior.
  * **Modo B (Contingencia Netbooks Escolares):** Para días con netbooks de bajos recursos, se utilizan imágenes reducidas (VHD de 128 MB en Windows, imágenes loop de 64 MB en Linux) y scripts portables de baja huella de memoria.

---

## 📅 Cronograma Calendario Semanal (4 hs/semana: Miércoles y Jueves)

### 🗓️ Bloque I: Desarrollo de Contenidos (Agosto a Mediados de Octubre)

* **Semanas 1 y 2 (Agosto) — Bloque Windows Inicial:**
  * **Módulo 1 (Windows - 4 hs):**
    * *Clase 1 (2 hs):* Discos físicos y lógicos, MBR vs GPT, discos virtuales VHDX dinámicos con `diskpart` (CMD/PowerShell).
    * *Clase 2 (2 hs):* Sistemas de archivos, arquitectura NTFS, creación de volúmenes y formateo con `diskpart`.
  * **Módulo 2 (Windows - 4 hs):**
    * *Clase 1 (2 hs):* Cuentas de usuario locales, grupos de seguridad, SIDs, base SAM y Control de Cuentas de Usuario (UAC).
    * *Clase 2 (2 hs):* Permisos NTFS, Listas de Control de Acceso (DACL/ACEs), herencia (`icacls`), toma de posesión (`takeown`) y precedencia Deny/Allow.

* **Semanas 3 y 4 (Agosto / Septiembre) — Bloque Linux (Lubuntu Live USB Persistente):**
  * **Módulo 1 (Linux - 4 hs):**
    * *Clase 1 (2 hs):* Dispositivos de bloque (`lsblk`, `fdisk`), tablas GPT/MBR y particionamiento en Linux.
    * *Clase 2 (2 hs):* Sistemas de archivos (`mkfs.ext4`, `mkfs.vfat`), puntos de montaje (`mount`), `/etc/fstab` y dispositivos loopback.
  * **Módulo 2 (Linux - 4 hs):**
    * *Clase 1 (2 hs):* Modelo POSIX, permisos octales y simbólicos (`chmod`), propietarios (`chown`, `chgrp`) y máscara `umask`.
    * *Clase 2 (2 hs):* Permisos especiales (SUID, SGID, Sticky Bit), administración de cuentas (`useradd`, `/etc/passwd`, `/etc/shadow`) y elevación con `sudo` (`/etc/sudoers`).

* **Semanas 5 y 6 (Septiembre):** **Módulo 3 - Administración Linux & Bash Scripting (Parte 1)**
  * *Miércoles (2 hs):* Arquitectura del Kernel Linux, árbol de directorios `/`, variables de entorno, permisos de ejecución y estructura de scripts `.sh`.
  * *Jueves (2 hs):* Sintaxis Bash (`.sh`), shebang, variables, condicionales `if`, códigos de salida (`$?`) y lectura de parámetros (`$1`, `$@`).
* **Semanas 7 y 8 (Septiembre / Octubre):** **Módulo 3 - Bash Scripting (Parte 2) + Módulo 4 - Redes y SSH**
  * *Miércoles (2 hs):* Bucles `for`/`while`, tuberías (*pipelines*), filtros (`grep`, `awk`, `sed`) y automatización con `cron` (`crontab`).
  * *Jueves (2 hs):* Pila TCP/IP, puertos/sockets (`ss`, `netstat`), servicio SSH nativo (`openssh-server`), configuración de `/etc/ssh/sshd_config` y claves criptográficas.
* **Semana 9 (Mediados de Octubre):** **Módulo 4 - Firewalls y Cierre de Contenidos**
  * *Miércoles (2 hs):* Filtrado de paquetes con `netsh advfirewall` (Windows 11) y `ufw` / `iptables` (Linux).
  * *Jueves (2 hs):* Evaluación teórica/práctica integradora de los Módulos 1 al 4.

---

### 🏆 Bloque II: Proyecto Integrador Final (Mediados de Octubre a Fin de Año)

* **Semanas 10 a 14 (Mediados de Octubre a Noviembre / Diciembre):** **Desafío Híbrido y Ciberseguridad**
  * *Fase 1 (Semana 10):* Inyección del escenario de incidentes mediante scripts automatizados, diagnóstico de discos y permisos en ambos entornos.
  * *Fase 2 (Semana 11):* Remediación de almacenamiento (VHD en Windows / discos loopback en Linux), reconstrucción de ACLs y permisos POSIX.
  * *Fase 3 (Semana 12):* Reconfiguración de servicios SSH, generación de claves, apertura controlada de puertos en UFW y `netsh`.
  * *Fase 4 (Semana 13):* Desarrollo del script de auditoría, monitoreo y respaldo automatizado en Bash.
  * *Fase 5 (Semana 14):* Pruebas finales de interconectividad, entrega de documentación técnica y **defensa práctica en vivo en la terminal del laboratorio**.

---

## 📋 Resumen por Módulo

### 📁 Módulo 1: Almacenamiento y Sistemas de Archivos (Windows 11 vs. Linux)
* **Contenidos:** Estructura de particiones (MBR vs GPT), sistemas de archivos (NTFS, FAT32, EXT4), volúmenes simples, montaje de unidades, inodos vs tabla MFT.
* **Herramientas & Comandos:** `diskpart`, `Get-Disk`, `Get-Partition`, `Format-Volume`, `fdisk`, `mkfs.ext4`, `mount`/`umount`, `df -h`, `lsblk`.

### 📁 Módulo 2: Seguridad, Permisos y Gestión de Usuarios
* **Contenidos:** Modelos de seguridad NTFS vs POSIX, herencia de permisos, Listas de Control de Acceso (ACL), usuarios, grupos de sistema, elevación de privilegios (UAC vs `sudo`), auditoría de accesos.
* **Herramientas & Comandos:** `icacls`, `Get-ACL`, `Set-ACL`, `chmod`, `chown`, `chgrp`, `umask`, `useradd`, `usermod`, `net user`.

### 📁 Módulo 3: Administración de Sistemas Linux & Bash Scripting
* **Contenidos:** Jerarquía del FHS de Linux, administración de procesos, scripting en Bash, variables, estructuras de control, tuberías (*pipelines*), filtros de texto (`grep`, `awk`, `sed`) y automatización con `cron`.
* **Herramientas & Comandos:** `bash`, `chmod +x`, `ps aux`, `top`/`htop`, `kill`, `grep`, `awk`, `sed`, `crontab`.

### 📁 Módulo 4: Redes, Conectividad y Administración Remota
* **Contenidos:** Configuración de pila TCP/IP, resolución de nombres (DNS / `/etc/hosts`), diagnóstico de red, inspección de puertos y sockets, administración remota segura vía SSH, configuración de firewalls (`netsh advfirewall` vs `ufw`).
* **Herramientas & Comandos:** `ipconfig`, `ip a`, `ping`, `traceroute` / `tracepath`, `netstat` / `ss -tulpn`, `ssh`, `scp`, `systemctl`, `netsh`, `ufw`.

### 📁 Módulo 5: TP Integrador Final Gamificado
* **Título:** *"Desafío Integrador: Infraestructura Híbrida y Ciberseguridad"*
* **Dinámica:** Simulación de un escenario de producción híbrido (Windows 11 Host + Linux Live USB en red de laboratorio) desconfigurado por un incidente de seguridad. Los alumnos deben restablecer almacenamiento, corregir permisos comprometidos, levantar servicios SSH seguros y automatizar el monitoreo.
