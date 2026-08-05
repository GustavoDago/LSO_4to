# Trivias de Kahoot: Módulo 1 (Almacenamiento y Sistemas de Archivos)

---

## 🎯 Trivia Clase 1: MBR vs. GPT y Discos Virtuales VHD

### ❓ Pregunta 1 (Verdadero / Falso)
**En una tabla de particiones GPT se pueden crear hasta 128 particiones primarias en Windows 11 sin necesidad de particiones extendidas.**
* [X] **Verdadero** (Correcto - GPT elimina el límite de 4 particiones primarias del viejo MBR).
* [ ] Falso.

### ❓ Pregunta 2 (Opción Múltiple)
**¿Qué cmdlet de PowerShell se utiliza para crear un nuevo archivo de disco virtual dinámico en Windows 11?**
* [ ] `New-Disk`
* [X] **`New-VHD`** (Correcto - `New-VHD` genera el archivo .vhd/.vhdx).
* [ ] `Create-VirtualVolume`
* [ ] `Mount-VHD`

---

## 🎯 Trivia Clase 2: Particionamiento y Formateo NTFS (`diskpart`)

### ❓ Pregunta 3 (Opción Múltiple)
**¿Qué estructura interna utiliza NTFS para registrar todos los metadatos y ubicaciones de archivos en el disco?**
* [ ] Tabla de Inodos.
* [X] **MFT - Master File Table** (Correcto - MFT es la estructura relacional central de NTFS).
* [ ] Registro de Eventos.
* [ ] FAT32.

### ❓ Pregunta 4 (Opción Múltiple)
**En la herramienta `diskpart`, ¿qué comando elimina todas las particiones y firmas del disco seleccionado?**
* [ ] `delete partition`
* [X] **`clean`** (Correcto - `clean` deja el disco a cero para cambiar su tabla).
* [ ] `reset disk`
* [ ] `format quick`

---

## 🎯 Trivia Clase 3: Dispositivos de Bloque y EXT4 en Linux

### ❓ Pregunta 5 (Opción Múltiple)
**¿Qué comando en Linux nos permite ver en árbol todos los dispositivos de bloque y sus puntos de montaje?**
* [ ] `df -h`
* [X] **`lsblk`** (Correcto - `lsblk` muestra la jerarquía de bloques de disco).
* [ ] `fdisk -l`
* [ ] `cat /proc/partitions`

### ❓ Pregunta 6 (Opción Múltiple)
**¿Qué elemento de un sistema de archivos EXT4 almacena los metadatos de un archivo (permisos, tamaño, fechas) pero NO su nombre?**
* [ ] El bloque de datos.
* [X] **El Inodo** (Correcto - El inodo guarda los metadatos; el nombre se guarda en el directorio).
* [ ] El Superbloque.
* [ ] La MFT.

---

## 🎯 Trivia Clase 4: Montaje, `/etc/fstab` e Integración del Módulo 1

### ❓ Pregunta 7 (Opción Múltiple)
**Para montar un archivo de imagen en Linux como si fuera un disco físico en `/mnt/disco_lso`, ¿qué opción de `mount` utilizamos?**
* [ ] `-t ntfs`
* [X] **`-o loop`** (Correcto - La opción `loop` asocia un archivo regular a un dispositivo de bloque).
* [ ] `-f quick`
* [ ] `--bind`

### ❓ Pregunta 8 (Opción Múltiple)
**¿Qué archivo de configuración en Linux contiene las tablas de montaje permanente del sistema operativo?**
* [ ] `/etc/hosts`
* [X] **`/etc/fstab`** (Correcto - `/etc/fstab` define los puntos de montaje al arrancar).
* [ ] `/etc/exports`
* [ ] `/var/log/syslog`
