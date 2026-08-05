# Módulo 1: Almacenamiento y Sistemas de Archivos (Windows 11 vs. Linux)

* **Duración Total:** 8 Horas Reloj (4 Clases de 2 Horas - Semanas 1 y 2 de Agosto)
* **Días de Clase:** Miércoles (2 hs) y Jueves (2 hs)
* **Entornos Objeto de Estudio:** Windows 11 & Linux (Ubuntu WSL2)
* **Herramientas Pedagógicas:** NotebookLM (Cuaderno pedagógico) + Kahoot (Trivias de cierre) + Scripts de Setup

---

## 🎯 Objetivos del Módulo
1. Comprender la arquitectura de almacenamiento físico y lógico en sistemas operativos modernos (MBR vs GPT).
2. Comparar la estructura interna y metadatos de **NTFS** (MFT) en Windows 11 y **EXT4** (Inodos) en Linux.
3. Operar con soltura comandos de particionamiento, formateo y montaje desde terminal (`diskpart`, PowerShell, `fdisk`, `mkfs`, `mount`).
4. Aplicar técnicas de automatización y contingencia para garantizar prácticas en máquinas freezadas y netbooks escolares.

---

## 📅 Estructura Detallada de Clases (4 Clases de 2 Horas)

### 🗓️ Clase 1 (Miércoles - 2 hs): Arquitectura de Almacenamiento y Discos Virtuales en Windows 11
* **Momento 1 - Inicio (15 min):** Presentación del tema mediante infografía/resumen en **NotebookLM** ("De MBR a GPT: El salto arquitectónico en Windows 11").
* **Momento 2 - Desarrollo (75 min):** 
  * *Nodo Tecnológico:* Ejecución de `script_setup_almacenamiento.ps1`. Creación y montaje de discos virtuales VHD dinámicos (`New-VHD`, `Mount-VHD`).
  * *Contingencia Netbooks:* Uso de VHD ultra-liviano de 128 MB.
  * Análisis de estados de disco con `Get-Disk` y `Initialize-Disk -PartitionStyle GPT`.
* **Momento 3 - Cierre (15 min):** Trivia Kahoot N.º 1 (5 preguntas sobre MBR vs GPT y discos VHD).

---

### 🗓️ Clase 2 (Jueves - 2 hs): Particionamiento y Formateo NTFS por Consola (`diskpart` & PowerShell)
* **Momento 1 - Inicio (15 min):** Introducción a la estructura MFT de NTFS y unidades lógicas con soporte visual de **NotebookLM**.
* **Momento 2 - Desarrollo (75 min):** 
  * Laboratorio CLI en `diskpart`: `list disk`, `select disk`, `clean`, `create partition primary`, `format fs=ntfs quick`, `assign letter`.
  * Equivalencia en cmdlet de PowerShell: `New-Partition`, `Format-Volume -FileSystem NTFS`.
* **Momento 3 - Cierre (15 min):** Trivia Kahoot N.º 2 (5 preguntas sobre comandos de `diskpart` y formateo NTFS).

---

### 🗓️ Clase 3 (Miércoles - 2 hs): Dispositivos de Bloque y Sistemas de Archivos EXT4 en Linux (WSL2)
* **Momento 1 - Inicio (15 min):** Presentación en **NotebookLM** ("Anatomía de Linux: Dispositivos de bloque y la tabla de Inodos").
* **Momento 2 - Desarrollo (75 min):** 
  * Inspección del árbol de bloques con `lsblk -f` y `df -h`.
  * Creación de imagen de disco con `dd if=/dev/zero of=~/disco.img bs=1M count=512` *(o 64 MB en netbooks)*.
  * Particionamiento con `fdisk ~/disco.img` y formateo `sudo mkfs.ext4 ~/disco.img`.
* **Momento 3 - Cierre (15 min):** Trivia Kahoot N.º 3 (5 preguntas sobre `lsblk`, `fdisk` e inodos de EXT4).

---

### 🗓️ Clase 4 (Jueves - 2 hs): Montaje Loopback, `/etc/fstab` y Cuadro Comparativo NTFS vs. EXT4
* **Momento 1 - Inicio (15 min):** Explicación del concepto de punto de montaje y jerarquía de directorio raíz `/` en Linux.
* **Momento 2 - Desarrollo (75 min):** 
  * Práctica de montaje y desmontaje: `sudo mount -o loop ~/disco.img /mnt/disco_lso`, `sudo umount /mnt/disco_lso`.
  * Inspección del archivo de tabla de montajes `/etc/fstab`.
  * Elaboración de la tabla comparativa final entre NTFS (Windows 11) y EXT4 (Linux).
* **Momento 3 - Cierre (15 min):** Trivia Kahoot N.º 4 Integradora del Módulo 1 (6 preguntas integradoras).
