# Clase 1: Dispositivos de Bloque, Esquemas MBR/GPT y Particionamiento con `fdisk`

* **Materia:** Laboratorio de Sistemas Operativos (LSO) — 4.º Año
* **Módulo:** 1 - Almacenamiento y Sistemas de Archivos en Linux
* **Duración:** 2 Horas Reloj (Día Miércoles)
* **Entorno de Trabajo:** Lubuntu / Linux Mint XFCE (Live USB Persistente)

---

## 🎯 Objetivos de la Clase
1. Comprender la filosofía UNIX/Linux: *"Todo es un archivo"* y el rol del directorio `/dev/`.
2. Identificar y clasificar dispositivos de bloque físicos y sintéticos (`/dev/sd*`, `/dev/nvme*`, `/dev/loop*`).
3. Analizar las diferencias arquitectónicas entre esquemas de partición **MBR (dos)** y **GPT (gpt)**.
4. Crear, modificar y diagnosticar tablas de particiones utilizando herramientas de línea de comandos (`lsblk`, `fdisk`, `blkid`).
5. Trabajar de forma segura utilizando imágenes de disco loopback para proteger el almacenamiento del pendrive y los discos de la máquina anfitriona.

---

## 📖 Momento 1: Fundamentación Teórica (15 min)

### 1. ¿Cómo gestiona Linux el Hardware?
En Linux, los dispositivos físicos no se identifican con letras de unidad (como `C:` o `D:` en Windows). El Kernel expone los dispositivos como archivos especiales dentro del pseudo-sistema de archivos `/dev/` (*devices*):

* **Dispositivos de Caracteres (`c`):** Transmiten datos byte a byte en flujo secuencial (ej. terminales `/dev/tty`, puertos serie, `/dev/random`, `/dev/null`).
* **Dispositivos de Bloques (`b`):** Transmiten datos en bloques de tamaño fijo direccionables aleatoriamente (ej. discos duros, SSDs, pendrives, imágenes montadas).

### 2. Nomenclatura de Almacenamiento en Linux
| Dispositivo | Nomenclatura | Ejemplo |
| :--- | :--- | :--- |
| **Discos SATA / SCSI / USB** | `/dev/sd[a-z]` | `/dev/sda` (1.º disco), `/dev/sdb` (2.º disco) |
| **Particiones en discos SATA/USB** | `/dev/sd[a-z][1-9]` | `/dev/sda1` (1.ª partición de `sda`), `/dev/sdb2` |
| **Unidades NVMe M.2** | `/dev/nvme[X]n[Y]` | `/dev/nvme0n1` (Controlador 0, Namespace 1) |
| **Particiones en NVMe** | `/dev/nvme[X]n[Y]p[Z]` | `/dev/nvme0n1p1` (1.ª partición de NVMe) |
| **Dispositivos Loopback (Virtuales)** | `/dev/loop[0-9]` | `/dev/loop0`, `/dev/loop1` |

### 3. MBR vs GPT en Linux
* **MBR (`dos`):**
  * Límite de tamaño: **2 TB**.
  * Máximo **4 particiones primarias** (o 3 primarias + 1 extendida que contiene particiones lógicas `/dev/sda5`, `/dev/sda6`...).
  * Sector 0 (`LBA 0`) almacena el código de arranque y la tabla de particiones (64 bytes). Sin redundancia.
* **GPT (`gpt`):**
  * Límite de tamaño: **9.4 ZB ($9.4 \times 10^{21}$ bytes)**.
  * Soporta hasta **128 particiones primarias** por defecto en Linux.
  * Identificación unívoca de particiones mediante **UUID / GUID**.
  * Posee encabezado primario (`LBA 1`) y encabezado secundario de respaldo (*Backup GPT*) al final del disco con verificación de integridad por **CRC32**.

---

## 💻 Momento 2: Laboratorio Práctico en Terminal (75 min)

> [!CAUTION]
> **Seguridad de Datos en el Laboratorio:**
> Nunca ejecutes comandos de particionado sobre `/dev/sda` o `/dev/sdb` directamente en las máquinas de la escuela sin verificar previamente cuál es la unidad de sistema. Para nuestras prácticas utilizaremos un **disco virtual en formato imagen (`.img`) mapeado como dispositivo Loopback**.

---

### Ejercicio 1: Inspección del Almacenamiento del Sistema

Abre la terminal en Lubuntu (`Ctrl + Alt + T`) y ejecuta los siguientes comandos de diagnóstico:

```bash
# 1. Listar el árbol de dispositivos de bloque con detalles de tamaño y tipo
lsblk

# 2. Ver sistemas de archivos, etiquetas (Labels) y UUIDs de cada bloque
lsblk -f

# 3. Consultar las particiones reconocidas directamente por el Kernel
cat /proc/partitions

# 4. Listar las tablas de particiones de todos los discos conectados (requiere sudo)
sudo fdisk -l
```

**Preguntas de Reflexión:**
* ¿Qué identificador tiene tu pendrive Live USB (`/dev/sda`, `/dev/sdb` o `/dev/sdc`)?
* ¿Tiene particiones tipo `vfat` (EFI) y `ext4` (persistencia `casper-rw`)?

---

### Ejercicio 2: Creación de un Disco Virtual Sintético de Laboratorio

Crearemos un archivo binario de **256 MB** lleno de ceros que simulará nuestro disco rígido físico de laboratorio:

```bash
# Crear directorio de trabajo en el Home del alumno
mkdir -p ~/lab_almacenamiento
cd ~/lab_almacenamiento

# Opción A: Crear disco de 256 MB con dd (dispositivo de entrada: /dev/zero)
dd if=/dev/zero of=disco_lab.img bs=1M count=256 status=progress

# Verificar la creación y tamaño real del archivo
ls -lh disco_lab.img
```

> [!NOTE]
> **Modo Contingencia (Netbooks Escolares):** Si estás trabajando en una máquina con poco espacio libre, puedes crear un archivo de **64 MB** con:
> `dd if=/dev/zero of=disco_lab.img bs=1M count=64 status=progress`

---

### Ejercicio 3: Particionado con `fdisk` (Esquema GPT)

`fdisk` es el particionador estándar por línea de comandos en Linux. Vamos a particionar directamente nuestra imagen `disco_lab.img`:

```bash
fdisk disco_lab.img
```

Dentro del menú interactivo de `fdisk`, ingresa las siguientes opciones en orden:

1. **Crear tabla de particiones GPT:**
   * Presiona `g` y luego `Enter`. (Mensaje: *Created a new GPT disklabel*).
2. **Crear la 1.ª partición (Datos - 100 MB):**
   * Presiona `n` (Nueva partición).
   * Número de partición: Presiona `Enter` (valor por defecto: 1).
   * Primer sector: Presiona `Enter` (primer sector disponible por defecto: 2048).
   * Último sector: Escribe `+100M` y presiona `Enter`.
3. **Crear la 2.ª partición (Swap / Intercambio - 50 MB):**
   * Presiona `n`.
   * Número de partición: Presiona `Enter` (por defecto: 2).
   * Primer sector: Presiona `Enter`.
   * Último sector: Escribe `+50M` y presiona `Enter`.
4. **Cambiar tipo de la 2.ª partición a Linux Swap:**
   * Presiona `t` (Cambiar tipo de partición).
   * Selecciona partición: `2`.
   * Tipo de partición: Escribe `19` (o `swap`, puedes listar tipos con `L`).
5. **Crear la 3.ª partición (Resto del disco):**
   * Presiona `n`.
   * Acepta todos los valores por defecto presionando `Enter` en número, primer sector y último sector para ocupar todo el espacio libre restante.
6. **Imprimir y verificar la tabla de particiones:**
   * Presiona `p` (Print). Observa las 3 particiones creadas con sus sectores iniciales, finales y tipos.
7. **Guardar los cambios en el disco:**
   * Presiona `w` (Write). Esto escribe físicamente la tabla GPT en el archivo y sale de `fdisk`.

---

### Ejercicio 4: Mapeo de Particiones con Dispositivos Loopback (`losetup`)

Para que el Kernel de Linux reconozca las particiones individuales de nuestra imagen como dispositivos de bloque interactivos en `/dev/`, utilizaremos `losetup` con la opción de sondeo de particiones (`-P`):

```bash
# Asociar la imagen al siguiente dispositivo loop libre y escanear particiones
sudo losetup -Pf ~/lab_almacenamiento/disco_lab.img

# Verificar qué dispositivo loop fue asignado
losetup -a
```

Supongamos que fue asignado `/dev/loop0` (o `loop1`, etc.). Ejecuta `lsblk`:

```bash
lsblk
```

**Resultado esperado:**
```text
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0         7:0    0   256M  0 loop 
├─loop0p1     7:1    0   100M  0 loop 
├─loop0p2     7:2    0    50M  0 loop 
└─loop0p3     7:3    0   106M  0 loop 
```

¡Las particiones virtuales `loop0p1`, `loop0p2` y `loop0p3` ya están listas para ser formateadas y utilizadas como si fueran un disco físico real!

---

### Ejercicio 5: Prueba de Desconexión y Limpieza

Para desconectar el dispositivo loop de forma limpia:

```bash
# Desvincular el dispositivo loop (reemplaza loop0 por tu dispositivo asignado)
sudo losetup -d /dev/loop0

# Comprobar que ya no aparece
losetup -a
```

---

## ⚡ Automatización con Script: `setup_clase1.sh`

Para agilizar el inicio o restaurar el entorno en caso de errores, ejecuta el script de setup provisto:

```bash
# Otorgar permisos de ejecución
chmod +x setup_clase1.sh

# Crear y configurar el laboratorio automáticamente
./setup_clase1.sh --create

# Ver el estado actual
./setup_clase1.sh --status

# Limpiar el entorno al finalizar
./setup_clase1.sh --cleanup
```

---

## 🎮 Momento 3: Cierre y Trivia Kahoot (15 min)

Realizaremos la trivia interactiva de 10 preguntas para validar los conocimientos adquiridos. El cuestionario está disponible en [`kahoot_clase1.md`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase1/kahoot_clase1.md).
