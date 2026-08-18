# Módulo 1: Almacenamiento y Sistemas de Archivos (Windows 11 vs. Linux)

* **Duración Total:** 8 Horas Reloj (4 Clases de 2 Horas - Semanas 1 y 2 de Agosto)
* **Días de Clase:** Miércoles (2 hs) y Jueves (2 hs)
* **Entornos Objeto de Estudio:** Windows 11 Host & Linux (Lubuntu / Linux Mint XFCE en Live USB Persistente)
* **Herramientas Pedagógicas:** NotebookLM (Cuaderno pedagógico) + Kahoot (Trivias de cierre de 10 preguntas) + Scripts de Setup

---

## 🎯 Objetivos del Módulo
1. Comprender la arquitectura de almacenamiento físico y lógico en sistemas operativos modernos (MBR vs GPT).
2. Comparar la estructura interna y metadatos de **NTFS** (MFT) en Windows 11 y **EXT4** (Inodos) en Linux.
3. Operar con soltura comandos de particionamiento, formateo y montaje desde terminal (`diskpart` en CMD, PowerShell, `fdisk`, `mkfs`, `mount`).
4. Aplicar técnicas de automatización y contingencia (VHDs dinámicos en Windows, imágenes loopback y pendrives persistentes en Linux) para garantizar prácticas en máquinas freezadas y netbooks escolares.

---

## 📅 Estructura Detallada de Clases (4 Clases de 2 Horas)

### 🗓️ Clase 1 (Miércoles - 2 hs): Arquitectura de Almacenamiento y Discos Virtuales en Windows 11 (CMD & Diskpart)
* **Momento 1 - Inicio (15 min):** Presentación del tema mediante infografía/resumen en **NotebookLM** ("De MBR a GPT: El salto arquitectónico en Windows 11").
* **Momento 2 - Desarrollo (75 min):** 
  * *Nodo Tecnológico:* Uso de la consola **CMD** y la herramienta nativa `diskpart` para la creación y montaje de discos virtuales VHD/VHDX dinámicos (`create vdisk`, `attach vdisk`).
  * *Contingencia Netbooks:* Uso de VHD ultra-liviano de 128 MB ejecutando el script `setup_clase1.bat` en CMD.
  * Inicialización en formato moderno **GPT** (`convert gpt`), particionamiento (`create partition primary`) y asignación de formato NTFS (`format fs=ntfs quick`, `assign letter`).
* **Momento 3 - Cierre (15 min):** Trivia Kahoot N.º 1 (10 preguntas con 4 opciones sobre MBR vs GPT, discos VHD y comandos de `diskpart` en CMD).

---

### 🗓️ Clase 2 (Jueves - 2 hs): Particionamiento y Formateo NTFS por Consola (`diskpart` en CMD & PowerShell)
* **Momento 1 - Inicio (15 min):** Introducción a la estructura MFT de NTFS y unidades lógicas con soporte visual de **NotebookLM**.
* **Momento 2 - Desarrollo (75 min):** 
  * Laboratorio CLI avanzado en CMD con `diskpart`: `list disk`, `select disk`, `clean`, `create partition primary`, `format fs=ntfs quick`, `assign letter`.
  * Análisis conceptual y equivalencia puntual con cmdlets de PowerShell (`New-Partition`, `Format-Volume -FileSystem NTFS`).
* **Momento 3 - Cierre (15 min):** Trivia Kahoot N.º 2 (10 preguntas con 4 opciones sobre comandos de `diskpart` y formateo NTFS).

---

### 🗓️ Clase 3 (Miércoles - 2 hs): Dispositivos de Bloque y Sistemas de Archivos EXT4 en Linux (Live USB)
* **Momento 1 - Inicio (15 min):** Booteo por USB (Boot Menu F12/F11/Esc) y presentación en **NotebookLM** ("Anatomía de Linux: Dispositivos de bloque y la tabla de Inodos").
* **Momento 2 - Desarrollo (75 min):** 
  * Inspección del árbol de bloques con `lsblk -f` y `df -h`.
  * Creación de imagen de disco con `dd if=/dev/zero of=~/disco.img bs=1M count=512` *(o 64 MB en netbooks)*.
  * Particionamiento con `fdisk ~/disco.img` y formateo `sudo mkfs.ext4 ~/disco.img`.
* **Momento 3 - Cierre (15 min):** Trivia Kahoot N.º 3 (10 preguntas con 4 opciones sobre `lsblk`, `fdisk` e inodos de EXT4).

---

### 🗓️ Clase 4 (Jueves - 2 hs): Montaje Loopback, `/etc/fstab` y Cuadro Comparativo NTFS vs. EXT4
* **Momento 1 - Inicio (15 min):** Explicación del concepto de punto de montaje y jerarquía de directorio raíz `/` en Linux.
* **Momento 2 - Desarrollo (75 min):** 
  * Práctica de montaje y desmontaje: `sudo mount -o loop ~/disco.img /mnt/disco_lso`, `sudo umount /mnt/disco_lso`.
  * Inspección del archivo de tabla de montajes `/etc/fstab`.
  * Elaboración de la tabla comparativa final entre NTFS (Windows 11) y EXT4 (Linux).
* **Momento 3 - Cierre (15 min):** Trivia Kahoot N.º 4 Integradora del Módulo 1 (10 preguntas integradoras con 4 opciones).
