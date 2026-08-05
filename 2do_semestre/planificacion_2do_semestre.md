# Planificación Pedagógica y Didáctica: 2.º Semestre (LSO 4.º Año)
## Tecnicatura en Informática Personal y Profesional

* **Asignatura:** Laboratorio de Sistemas Operativos (LSO)
* **Año:** 4.º Año
* **Carga Horaria Semanal:** 4 Horas Reloj / Cátedra
  * 🔹 **Miércoles:** 2 horas (Teoría Aplicada & Laboratorio 1)
  * 🔹 **Jueves:** 2 horas (Laboratorio 2 & Desafíos Prácticos)
* **Sistemas Operativos Objeto de Estudio:** Windows 11 y Linux (Ubuntu / WSL2)
* **Entorno de Laboratorio:** Computadoras de alto rendimiento con congelador de disco (Deep Freeze)

---

## 🎯 Fundamentación y Estrategia de Entorno (Máquinas Freezadas)

Para responder a la restricción de las computadoras "freezadas" y maximizar el tiempo de práctica efectiva en el laboratorio, la estrategia operativa se basa en:

1. **Persistencia Externa y Cloud (Google Drive / Classroom):** Los alumnos conservan su código y scripts en unidades externas o en sus carpetas personales de Google Drive / entregas de Google Classroom.
2. **Restauración Automática en < 1 Minuto:** Cada módulo incluye scripts automatizados en PowerShell (`setup_env.ps1`) y Bash (`setup_env.sh`) que configuran WSL2, habilitan las características necesarias, crean la estructura de directorios y cargan los escenarios al iniciar la clase.
3. **Desbloqueo de Scripts Descargados (`Unblock-File`):** Al descargar scripts `.ps1` desde Google Drive/Classroom, Windows 11 asigna el flag `Zone.Identifier`. En la primera clase se enseña a desbloquearlos con `Unblock-File -Path .\script.ps1` o `Set-ExecutionPolicy RemoteSigned -Scope Process`.
4. **Dualidad Windows 11 / Linux WSL2:** Se trabaja en paralelo comparando cómo Windows 11 y Linux resuelven los mismos problemas de arquitectura (Almacenamiento, Permisos, Procesos, Redes y Servicios).

---

## 🎮 Herramientas Pedagógicas e Infraestructura Flexible

* **Gamificación con Kahoot:** Cada clase incluye una trivia de repaso lúdico al inicio o cierre (5-8 preguntas de opción múltiple con justificación técnica) para fijar comandos y conceptos clave.
* **Integración con NotebookLM:** Se proveen guías, podcasts/audios explicativos, infografías y cuestionarios integrables a los cuadernos digitales de NotebookLM para facilitar el estudio interactivo fuera del aula.
* **Flexibilidad de Hardware (Plan de Contingencia Netbooks):**
  * **Modo A (Nodo Tecnológico Potente):** Laboratorio con Windows 11, WSL2 (Ubuntu), virtualización Hyper-V y discos VHD dinámicos.
  * **Modo B (Contingencia Netbooks Escolares):** Para días en los que no se disponga del nodo tecnológico, las prácticas cuentan con alternativas livianas ejecutables en Windows/PowerShell básico o Linux nativo de bajos recursos (ej. análisis conceptual en CLI, scripts portables de menor huella de memoria y simulaciones en terminal).

---

## 📅 Cronograma Calendario Semanal (4 hs/semana: Miércoles y Jueves)

### 🗓️ Bloque I: Desarrollo de Contenidos (Agosto a Mediados de Octubre)

* **Semanas 1 y 2 (Agosto):** **Módulo 1 - Almacenamiento y Sistemas de Archivos (Windows 11 vs. Linux)**
  * *Miércoles (2 hs):* MBR vs GPT, MFT vs Inodos, VHDs con `diskpart` y PowerShell.
  * *Jueves (2 hs):* Dispositivos de bloque en Linux (`lsblk`, `fdisk`), formateo EXT4 (`mkfs`), montaje loopback (`mount`).
* **Semanas 3 y 4 (Agosto):** **Módulo 2 - Seguridad, Permisos y Gestión de Usuarios**
  * *Miércoles (2 hs):* Modelos NTFS vs POSIX, herencia de ACLs, comandos `icacls`, `Get-ACL` y `Set-ACL`.
  * *Jueves (2 hs):* Permisos en Linux (`chmod`, `chown`, octal/simbólico), elevación de privilegios (UAC vs `sudo`).
* **Semanas 5 y 6 (Septiembre):** **Módulo 3 - Virtualización Ligera (WSL2) + Bash Scripting (Parte 1)**
  * *Miércoles (2 hs):* Arquitectura WSL2, comandos `wsl`, interoperabilidad con sistema host `/mnt/c`.
  * *Jueves (2 hs):* Sintaxis Bash (`.sh`), shebang, variables, condicionales `if` y lectura de parámetros.
* **Semanas 7 y 8 (Septiembre / Octubre):** **Módulo 3 - Bash Scripting (Parte 2) + Módulo 4 - Redes y SSH**
  * *Miércoles (2 hs):* Bucles `for`/`while`, tuberías (*pipelines*), `grep`/`awk`/`sed` y automatización con `cron`.
  * *Jueves (2 hs):* Pila TCP/IP, puertos/sockets (`ss`, `netstat`), servicio SSH (`sshd`) y claves RSA/ED25519.
* **Semana 9 (Mediados de Octubre):** **Módulo 4 - Firewalls y Cierre de Contenidos**
  * *Miércoles (2 hs):* Filtrado de paquetes con `netsh advfirewall` (Windows 11) y `ufw` (Linux).
  * *Jueves (2 hs):* Evaluación teórica/práctica integradora de los Módulos 1 al 4.

---

### 🏆 Bloque II: Proyecto Integrador Final (Mediados de Octubre a Fin de Año)

* **Semanas 10 a 14 (Mediados de Octubre a Noviembre / Diciembre):** **Desafío Híbrido y Ciberseguridad**
  * *Fase 1 (Semana 10):* Inyección del escenario de incidentes mediante `setup_escenario_integrador.ps1`, diagnóstico inicial de discos y permisos.
  * *Fase 2 (Semana 11):* Remediación de almacenamiento VHD, reconstrucción de ACLs y permisos POSIX.
  * *Fase 3 (Semana 12):* Reconfiguración de servicios SSH, apertura controlada de puertos en UFW y `netsh`.
  * *Fase 4 (Semana 13):* Desarrollo del script de auditoría y monitoreo automatizado en Bash.
  * *Fase 5 (Semana 14):* Pruebas finales, entrega de documentación técnica y **defensa práctica en vivo en la terminal del laboratorio**.

---

## 📋 Resumen por Módulo

### 📁 Módulo 1: Almacenamiento y Sistemas de Archivos (Windows 11 vs. Linux)
* **Contenidos:** Estructura de particiones (MBR vs GPT), sistemas de archivos (NTFS, FAT32, EXT4, Btrfs), volúmenes simples y dinámicos, cuotas de disco, montaje de unidades.
* **Herramientas & Comandos:** `diskpart`, `Get-Disk`, `Get-Partition`, `Format-Volume`, `fdisk`, `mkfs.ext4`, `mount`/`umount`, `df -h`, `lsblk`.

### 📁 Módulo 2: Seguridad, Permisos y Gestión de Usuarios
* **Contenidos:** Modelos de seguridad NTFS vs POSIX, herencia de permisos, Listas de Control de Acceso (ACL), usuarios, grupos de sistema, elevación de privilegios (UAC vs `sudo`), auditoría de accesos.
* **Herramientas & Comandos:** `icacls`, `Get-ACL`, `Set-ACL`, `chmod`, `chown`, `chgrp`, `umask`, `useradd`, `usermod`, `net user`.

### 📁 Módulo 3: Virtualización Ligera (WSL2) + Bash Scripting
* **Contenidos:** Arquitectura de virtualización basada en Hyper-V (WSL2), interoperabilidad entre Windows 11 y Linux (sistema de archivos cruzado `/mnt/c`), scripting en Bash, variables, condicionales, bucles, tuberías (*pipelines*) y automatización con `cron` / Tareas Programadas.
* **Herramientas & Comandos:** `wsl --install`, `wsl --status`, `wsl --export`, `wsl --import`, `bash`, `grep`, `awk`, `sed`, `crontab`.

### 📁 Módulo 4: Redes, Conectividad y Administración Remota
* **Contenidos:** Configuración de pila TCP/IP, resolución de nombres (DNS / hosts file), diagnostico de red, inspección de puertos y sockets, administración remota segura vía SSH, configuración de firewalls (`netsh advfirewall` vs `ufw`).
* **Herramientas & Comandos:** `ipconfig`, `ip a`, `ping`, `traceroute` / `tracepath`, `netstat` / `ss -tulpn`, `ssh`, `scp`, `netsh`, `ufw`.

### 📁 Módulo 5: TP Integrador Final Gamificado
* **Título:** *"Desafío Integrador: Infraestructura Híbrida y Ciberseguridad"*
* **Dinámica:** Simulación de un escenario de producción híbrido (Windows 11 + Linux WSL2) desconfigurado por un ataque informático. Los alumnos deben restablecer almacenamiento, corregir permisos comprometidos, levantar servicios de red y automatizar el monitoreo.
