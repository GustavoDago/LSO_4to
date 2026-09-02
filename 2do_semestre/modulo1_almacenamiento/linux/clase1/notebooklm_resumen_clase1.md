# Resumen Pedagógico: Dispositivos de Bloque y Tablas de Partición en Linux (NotebookLM)

> **Cuaderno de Estudio:** LSO 4to - 2do Semestre  
> **Tema:** Almacenamiento en Linux - Clase 1: Dispositivos de Bloque, MBR vs. GPT y `fdisk`  
> **Nivel:** 4.º Año - Educación Técnico-Profesional (Tecnicatura en Informática)

---

## 📌 1. Principio Fundamental de Linux: "Todo es un Archivo"
A diferencia de sistemas como Windows donde las unidades se abstraen con letras (`C:`, `D:`), en los sistemas basados en UNIX/Linux todo el hardware y los canales de comunicación se proyectan en el árbol de directorios dentro de `/dev/` (*devices*).

### Tipos de Nodos de Dispositivo
* **Dispositivos de Caracteres (`Character Devices` - `c`):**
  * Transfieren datos flujo a flujo (byte a byte) sin almacenamiento en búfer de bloques.
  * Ejemplos: Consolas `/dev/tty`, terminales virtuales `/dev/pts/0`, generadores de aleatoriedad `/dev/urandom`, sumidero de datos `/dev/null`.
* **Dispositivos de Bloques (`Block Devices` - `b`):**
  * Transfieren datos en bloques de tamaño fijo (ej. 512 bytes o 4096 bytes).
  * Permiten acceso aleatorio (*random access*), direccionamiento por sectores/bloques y almacenamiento en búfer de caché (*buffer cache*).
  * Ejemplos: Discos rígidos (`/dev/sda`), unidades de estado sólido NVMe (`/dev/nvme0n1`), pendrives USB, imágenes de disco loopback (`/dev/loop0`).

---

## 🧭 2. Nomenclatura del Almacenamiento en Linux

```text
/dev/sda               -> 1.er Disco SATA/SCSI/USB
 ├── /dev/sda1         -> 1.ª Partición del disco sda
 └── /dev/sda2         -> 2.ª Partición del disco sda

/dev/sdb               -> 2.º Disco (ej. Pendrive Live USB)
 ├── /dev/sdb1         -> Partición EFI (vfat)
 └── /dev/sdb2         -> Partición de Persistencia Casper-RW (ext4)

/dev/nvme0n1           -> Disco SSD NVMe (Controlador 0, Namespace 1)
 ├── /dev/nvme0n1p1    -> 1.ª Partición de la unidad NVMe
 └── /dev/nvme0n1p2    -> 2.ª Partición de la unidad NVMe

/dev/loop0             -> Dispositivo Loopback (Archivo de imagen montado como disco)
 ├── /dev/loop0p1      -> Partición 1 dentro de la imagen
 └── /dev/loop0p2      -> Partición 2 dentro de la imagen
```

---

## ⚖️ 3. MBR vs GPT: Comparativa Arquitectónica

| Característica | MBR (Master Boot Record / DOS) | GPT (GUID Partition Table) |
| :--- | :--- | :--- |
| **Año de Creación** | 1983 (IBM PC DOS 2.0) | 2000s (Estándar UEFI) |
| **Límite Máximo de Disco** | **2 Terabytes** ($2^{32} \times 512$ bytes) | **9.4 Zettabytes** ($2^{64}$ sectores) |
| **Cantidad de Particiones** | Máximo **4 Primarias** (o 3 Primarias + 1 Extendida con Lógicas) | **128 Primarias** por defecto (sin particiones extendidas) |
| **Identificación** | Números de partición básicos (1-4) | **UUID / GUID unívoco global** para cada partición |
| **Seguridad y Redundancia** | **Ninguna.** Si el sector LBA 0 se corrompe, se pierde la tabla completa. | **Alta.** Posee copia de respaldo (*Backup GPT*) al final del disco y verificación por **CRC32**. |
| **Compatibilidad de Arranque** | BIOS Tradicional (Legacy) | Firmware UEFI moderno |

---

## 🛠️ 4. Herramientas Clave de Terminal en Linux

### Comandos de Exploración
* `lsblk`: Muestra el árbol jerárquico de todos los dispositivos de bloque reconocidos.
* `lsblk -f`: Muestra además los sistemas de archivos (`FSTYPE`), etiquetas (`LABEL`) y códigos `UUID`.
* `blkid`: Imprime los atributos de bloques y UUIDs directamente desde el caché del Kernel.
* `cat /proc/partitions`: Muestra la tabla en memoria del Kernel con los números mayor/menor (`major/minor`) y cantidad de bloques.

### Particionamiento con `fdisk`
`fdisk` es un editor interactivo de tablas de particiones. Comandos internos principales:
* `g`: Inicializa una nueva tabla de particiones **GPT vacía**.
* `o`: Inicializa una nueva tabla de particiones **MBR (DOS) vacía**.
* `n`: Crea una nueva partición (permite especificar tamaño: `+100M`, `+2G`).
* `t`: Cambia el código de tipo de partición (ej. Linux filesystem, Linux Swap, EFI System).
* `p`: Imprime en pantalla la tabla de particiones actual antes de aplicar cambios.
* `d`: Elimina una partición seleccionada.
* `w`: Escribe los cambios en el disco y finaliza.
* `q`: Sale sin guardar cambios (aborta cualquier edición errónea).

### Dispositivos Loopback (`losetup`)
Un dispositivo loop permite asociar un archivo regular (ej. `disco.img`) al subsistema de bloques del Kernel:
* `sudo losetup -Pf disco.img`: Asocia el archivo al primer loop libre (`-f`) y analiza automáticamente las particiones internas (`-P`), generando `/dev/loop0p1`, `/dev/loop0p2`, etc.
* `losetup -a`: Lista todos los dispositivos loop activos en el sistema.
* `sudo losetup -d /dev/loop0`: Desvincula y libera el dispositivo loop.

---

## 💡 Preguntas Guía para el Audio/Podcast de NotebookLM
1. *¿Por qué en Linux no existen las letras de unidad C: o D: y cómo se reemplaza ese concepto?*
2. *¿Cuál es el peligro de particionar un disco MBR tradicional frente a la robustez que ofrece GPT con su Backup Header y CRC32?*
3. *¿De qué manera los dispositivos loopback nos permiten practicar administración de almacenamiento en el laboratorio sin comprometer la instalación del sistema operativo?*
