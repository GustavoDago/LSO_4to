# Clase 2: Sistemas de Archivos (EXT4), Puntos de Montaje (`mount`), `/etc/fstab` e Inodos

* **Materia:** Laboratorio de Sistemas Operativos (LSO) — 4.º Año
* **Módulo:** 1 - Almacenamiento y Sistemas de Archivos en Linux
* **Duración:** 2 Horas Reloj (Día Jueves)
* **Entorno de Trabajo:** Lubuntu / Linux Mint XFCE (Live USB Persistente)

---

## 🎯 Objetivos de la Clase
1. Comprender la estructura interna de un sistema de archivos moderno en Linux: **EXT4** (Superbloque, Bloques de datos, Journaling y Tabla de Inodos).
2. Formatear particiones de disco en diferentes sistemas de archivos (`mkfs.ext4`, `mkfs.vfat`).
3. Dominar el concepto y la práctica de **Puntos de Montaje** dentro de la jerarquía de directorio raíz único `/` (`mount`, `umount`).
4. Monitorear y diagnosticar el uso de espacio en disco e inodos (`df -h`, `df -i`, `du -sh`, `tune2fs`).
5. Realizar el experimento de laboratorio: *"Agotamiento de Inodos vs. Agotamiento de Espacio"*.
6. Analizar la estructura del archivo de configuración del sistema `/etc/fstab` para montajes persistentes.

---

## 📖 Momento 1: Fundamentación Teórica (15 min)

### 1. La Jerarquía de Montaje en Linux
En Windows, cada partición recibe una letra de unidad independiente (`C:`, `D:`, `E:`).  
En Linux, existe **un único árbol jerárquico unificado que nace en la raíz `/`**. Para acceder a una partición o disco, este debe **montarse** (*injertarse*) dentro de una carpeta vacía existente (denominada **Punto de Montaje** o *Mount Point*).

```text
/ (Directorio Raíz)
 ├── bin/
 ├── etc/
 ├── home/
 └── mnt/
      └── datos_lso/  <--- [Partición /dev/loop0p1 montada aquí]
           ├── reporte.txt
           └── backup.tar.gz
```

### 2. Anatomía Interna de EXT4 (Extended Filesystem 4)
* **Superbloque (*Superblock*):** Bloque fundamental que contiene la geometría y metadatos globales del sistema de archivos (tamaño total de bloques, cantidad de inodos, estado del sistema, fecha de último montaje). Se duplica en varios grupos de bloques por seguridad.
* **Bloques de Datos (*Data Blocks*):** Zonas de 4 KB (o 1/2 KB) donde se almacena el contenido real de los archivos.
* **Inodo (*Index Node*):** Estructura de datos fija (generalmente 256 bytes) que contiene todos los metadatos de un archivo:
  * Propietario (UID) y Grupo (GID).
  * Permisos POSIX (Lectura, Escritura, Ejecución).
  * Fechas (creación, acceso, modificación).
  * Tamaño del archivo.
  * **Punteros a los bloques de datos** donde está el contenido.
  * *(Nota técnica: El Inodo NO almacena el nombre del archivo; el nombre reside en la estructura del directorio que apunta al número de inodo).*
* **Journaling (Diario de Transacciones):** Mecanismo de registro previo a la escritura en disco que evita corrupciones ante cortes imprevistos de energía eléctrica.

---

## 💻 Momento 2: Laboratorio Práctico en Terminal (75 min)

> [!TIP]
> **Preparación del Escenario:** Si no tienes las particiones de la Clase 1 cargadas, ejecuta `./setup_clase2.sh --prepare` para inicializar el disco loopback con 3 particiones listas.

---

### Ejercicio 1: Formateo de Particiones (`mkfs`)

Verifica primero cuál es el dispositivo loop activo asignado con `losetup -a` o `lsblk`.  
*(En los siguientes ejemplos asumiremos `/dev/loop0p1` y `/dev/loop0p2`)*:

```bash
# 1. Formatear la primera partición en EXT4 con etiqueta 'DatosLSO'
sudo mkfs.ext4 -L "DatosLSO" /dev/loop0p1

# 2. Formatear la segunda partición en FAT32 con etiqueta 'USB_COMPARTIDO'
sudo mkfs.vfat -F 32 -n "USB_COMPARTIDO" /dev/loop0p2

# 3. Comprobar que el Kernel reconoce los sistemas de archivos y etiquetas
lsblk -f
```

---

### Ejercicio 2: Creación de Puntos de Montaje y Montaje Manual (`mount`)

```bash
# 1. Crear directorios que servirán como puntos de montaje
sudo mkdir -p /mnt/datos_lso
sudo mkdir -p /mnt/usb_fat

# 2. Montar la partición EXT4 en /mnt/datos_lso
sudo mount /dev/loop0p1 /mnt/datos_lso

# 3. Montar la partición FAT32 en /mnt/usb_fat
sudo mount /dev/loop0p2 /mnt/usb_fat

# 4. Verificar qué particiones están montadas actualmente
mount | grep loop
```

---

### Ejercicio 3: Lectura y Diagnóstico de Almacenamiento e Inodos

```bash
# 1. Ver espacio ocupado y disponible en formato legible por humanos (-h)
df -h /mnt/datos_lso

# 2. Ver la cantidad de Inodos totales, usados y libres (-i)
df -i /mnt/datos_lso

# 3. Inspeccionar los metadatos y superbloque del sistema EXT4 con tune2fs
sudo tune2fs -l /dev/loop0p1 | grep -E "Inode count|Block count|Free inodes|Free blocks"
```

---

### Ejercicio 4: Experimento de Laboratorio — *"Agotamiento de Inodos"*

> [!IMPORTANT]
> **El Enigma del Administrador:** Un sistema puede reportar **"No space left on device" (Disco lleno)** incluso si tiene gigabytes de espacio libre en megabytes, si se han agotado todos los inodos disponibles.

Vamos a comprobarlo en vivo en nuestra partición de prueba `/mnt/datos_lso`:

```bash
# 1. Crear carpeta de prueba con permisos para nuestro usuario
sudo chown -R $USER:$USER /mnt/datos_lso
mkdir -p /mnt/datos_lso/test_inodos

# 2. Ver el estado inicial de inodos
df -i /mnt/datos_lso

# 3. Crear 10.000 archivos vacíos de 0 bytes para consumir inodos rápidamente
echo "Creando archivos de 0 bytes..."
for i in $(seq 1 10000); do
    touch /mnt/datos_lso/test_inodos/file_$i.txt 2>/dev/null || break
done

# 4. Comprobar el nuevo consumo de inodos vs consumo de espacio en MB
echo "--- Consumo de Inodos (-i) ---"
df -i /mnt/datos_lso
echo "--- Consumo de Espacio (-h) ---"
df -h /mnt/datos_lso
```

**Conclusión técnica:** Los archivos de 0 bytes no ocupan bloques de datos (0 MB ocupados), pero cada uno consume exactamente **1 Inodo**. Si la tabla de inodos llega al 100%, el sistema bloquea cualquier creación de nuevos archivos o directorios.

---

### Ejercicio 5: Análisis de la Tabla de Montajes Persistentes (`/etc/fstab`)

El archivo `/etc/fstab` (*File System Table*) es leído por el proceso de arranque de Linux para montar automáticamente las unidades de almacenamiento.

Inspecciona el archivo del sistema:

```bash
cat /etc/fstab
```

#### Estructura de una línea en `/etc/fstab` (6 Columnas):
```text
<Dispositivo o UUID>    <Punto Montaje>    <FSType>    <Opciones>           <Dump>    <Pass>
UUID=a1b2c3d4-e5f6...    /mnt/datos_lso     ext4        defaults,noatime     0         2
```

1. **Dispositivo / UUID:** Identificador unívoco obtenido con `blkid` (se recomienda UUID en lugar de `/dev/sd*` porque las letras pueden cambiar de orden entre reinicios).
2. **Punto de Montaje:** Directorio donde se montará (ej. `/`, `/home`, `/mnt/datos_lso`).
3. **Tipo de Sistema de Archivos (`FSType`):** `ext4`, `vfat`, `ntfs3`, `xfs`, `btrfs`, `swap`.
4. **Opciones:** `defaults` (rw, suid, dev, exec, auto, nouser, async), `ro` (solo lectura), `noatime` (no actualizar fecha de acceso, mejora rendimiento).
5. **Dump (Respaldo):** `0` (ignorar) o `1` (incluir en respaldos con la herramienta dump).
6. **Pass (Chequeo `fsck` al iniciar):**
   * `0` = No verificar (ej. swap o NTFS).
   * `1` = Máxima prioridad (reservado exclusivamente para la partición raíz `/`).
   * `2` = Resto de particiones de datos.

---

### Ejercicio 6: Desmontaje Limpio (`umount`)

Al terminar las operaciones, los sistemas de archivos deben desmontarse antes de desconectar el dispositivo:

```bash
# 1. Asegurarse de no estar situado dentro de la carpeta a desmontar
cd ~

# 2. Desmontar los directorios
sudo umount /mnt/datos_lso
sudo umount /mnt/usb_fat

# 3. Comprobar que ya no figuran montados
df -h | grep /mnt/
```

---

## ⚡ Automatización con Script: `setup_clase2.sh`

```bash
# Otorgar permisos de ejecución
chmod +x setup_clase2.sh

# Preparar y formatear escenario completo automáticamente
./setup_clase2.sh --prepare

# Ejecutar la prueba de estrés de inodos
./setup_clase2.sh --test-inodes

# Desmontar y limpiar todo
./setup_clase2.sh --cleanup
```

---

## 🎮 Momento 3: Cierre y Trivia Kahoot (15 min)

Realizaremos la trivia interactiva de 10 preguntas para consolidar los conceptos de sistemas de archivos, inodos y `/etc/fstab`. El cuestionario está disponible en [`kahoot_clase2.md`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/linux/clase2/kahoot_clase2.md).
