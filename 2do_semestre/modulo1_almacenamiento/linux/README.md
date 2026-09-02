# Módulo 1: Almacenamiento en Linux (Lubuntu Live USB Persistente)

* **Carrera:** Tecnicatura en Informática Personal y Profesional (4.º Año)
* **Asignatura:** Laboratorio de Sistemas Operativos (LSO)
* **Entorno de Trabajo:** Sistema operativo **Lubuntu / Linux Mint XFCE** booteado directamente desde pendrive Live USB persistente.
* **Herramientas Pedagógicas:** Cuaderno **NotebookLM** ("LSO 4to - 2do semestre") + Trivias de **Kahoot** (10 preguntas con 4 opciones) + Scripts de automatización en Bash.

---

## 🧭 Planificación de Clases del Bloque Linux

```text
2do_semestre/modulo1_almacenamiento/linux/
├── README.md
├── clase1/                                    # 🗓️ Miércoles (2 Horas)
│   ├── guia_clase1_dispositivos_fdisk.md      # Guía de laboratorio de terminal
│   ├── notebooklm_resumen_clase1.md           # Resumen para el cuaderno NotebookLM
│   ├── kahoot_clase1.md                       # Trivia Kahoot (10 preguntas)
│   └── setup_clase1.sh                        # Script de setup con disco loopback
└── clase2/                                    # 🗓️ Jueves (2 Horas)
    ├── guia_clase2_sistemas_archivos_montaje.md # Guía de formateo, montaje e inodos
    ├── notebooklm_resumen_clase2.md           # Resumen EXT4 y /etc/fstab para NotebookLM
    ├── kahoot_clase2.md                       # Trivia Kahoot (10 preguntas)
    └── setup_clase2.sh                        # Script de formateo y test de inodos
```

---

## 📅 Detalle de Clases

### 🗓️ [Clase 1: Dispositivos de Bloque, Esquemas MBR/GPT y `fdisk`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase1/guia_clase1_dispositivos_fdisk.md) (Miércoles - 2 hs)
* **Contenidos:**
  * Filosofía UNIX/Linux: *"Todo es un archivo"* (`/dev/`).
  * Dispositivos de bloque vs. caracteres: `/dev/sdX`, `/dev/nvmeXnY`, `/dev/loopX`.
  * Esquemas de particionamiento: **MBR (dos)** vs **GPT (gpt)**.
  * Inspección con `lsblk`, `fdisk -l` y creación de particiones con `fdisk`.
  * Creación y aislamiento de discos virtuales mediante imágenes `.img` y `losetup -Pf`.
* **Recursos:**
  * 📄 [Guía de Laboratorio Clase 1](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase1/guia_clase1_dispositivos_fdisk.md)
  * 🧠 [Resumen NotebookLM Clase 1](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase1/notebooklm_resumen_clase1.md)
  * 🎮 [Trivia Kahoot Clase 1 (10 preguntas)](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase1/kahoot_clase1.md)
  * ⚡ [Script de Setup Bash (`setup_clase1.sh`)](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase1/setup_clase1.sh)

---

### 🗓️ [Clase 2: Sistemas de Archivos (EXT4), Montaje, `/etc/fstab` e Inodos](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase2/guia_clase2_sistemas_archivos_montaje.md) (Jueves - 2 hs)
* **Contenidos:**
  * Estructura interna de **EXT4**: Superbloque, Bloques de datos, Journaling y Tabla de **Inodos**.
  * Formateo de particiones con `mkfs.ext4` y `mkfs.vfat`.
  * Concepto de Puntos de Montaje en el árbol raíz único `/` (`mount`, `umount`).
  * Monitoreo y diagnóstico: `df -h`, `df -i`, `du -sh` y `tune2fs`.
  * Experimento práctico: *"Agotamiento de Inodos sin llenar el almacenamiento"*.
  * Análisis de la tabla de montajes persistentes `/etc/fstab` y uso de `UUID`.
* **Recursos:**
  * 📄 [Guía de Laboratorio Clase 2](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase2/guia_clase2_sistemas_archivos_montaje.md)
  * 🧠 [Resumen NotebookLM Clase 2](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase2/notebooklm_resumen_clase2.md)
  * 🎮 [Trivia Kahoot Clase 2 (10 preguntas)](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase2/kahoot_clase2.md)
  * ⚡ [Script de Setup Bash (`setup_clase2.sh`)](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase2/setup_clase2.sh)
