# Trivia Kahoot: Clase 1 - Dispositivos de Bloque, MBR vs. GPT y Particionamiento con fdisk (10 Preguntas - 4 Opciones)

---

## ❓ Pregunta 1
**¿En qué directorio del sistema de archivos de Linux se ubican los nodos de acceso a los dispositivos de hardware?**
* A) `/etc/` (Distractor - En `/etc/` residen archivos de configuración del sistema).
* B) **`/dev/`** (Correcto - El pseudo-directorio `/dev/` contiene los archivos especiales de dispositivos del Kernel).
* C) `/sys/block/` (Distractor - `/sys/` expone información del Kernel, pero los nodos de acceso para herramientas de usuario están en `/dev/`).
* D) `/mnt/` (Distractor - `/mnt/` es el directorio utilizado para puntos de montaje temporales de sistemas de archivos).

---

## ❓ Pregunta 2
**¿Qué diferencia a un dispositivo de bloque (`b`) de uno de caracteres (`c`) en Linux?**
* A) El de caracteres solo funciona en modo texto y el de bloques en modo gráfico.
* B) El de caracteres almacena archivos y el de bloques solo transfiere audio.
* C) **El de bloques transmite datos en bloques de tamaño fijo con acceso aleatorio.** (Correcto - Los dispositivos de bloque transfieren porciones fijas como sectores y permiten lectura/escritura en cualquier posición).
* D) El de bloques transmite byte a byte de forma secuencial sin buffer. (Distractor - Esta es la definición exacta de dispositivo de caracteres).

---

## ❓ Pregunta 3
**¿Cómo identifica Linux a la segunda partición del primer disco SATA/USB conectado al equipo?**
* A) `/dev/sdb1` (Distractor - `sdb1` es la 1.ª partición del segundo disco físico).
* B) `/dev/sda0` (Distractor - Las particiones en Linux se numeran a partir del 1, no del 0).
* C) **`/dev/sda2`** (Correcto - `sda` identifica al primer disco y el número `2` a su segunda partición).
* D) `C:\Partition2` (Distractor - Corresponde a la convención de letras y rutas de Windows).

---

## ❓ Pregunta 4
**¿Cuál es la nomenclatura en Linux para la primera partición de una unidad SSD NVMe moderna?**
* A) `/dev/sda1` (Distractor - Corresponde a unidades SATA, SAS o USB tradicionales).
* B) **`/dev/nvme0n1p1`** (Correcto - Controlador 0, Namespace 1, Partición 1).
* C) `/dev/nvme1` (Distractor - No especifica namespace ni partición).
* D) `/dev/hda1` (Distractor - Antigua nomenclatura para discos IDE/PATA).

---

## ❓ Pregunta 5
**¿Cuál es el límite máximo de almacenamiento direccionable que impone el esquema de partición MBR?**
* A) 512 Gigabytes.
* B) **2 Terabytes.** (Correcto - Al utilizar registros de 32 bits con sectores estándar de 512 bytes, el límite máximo es $2^{32} \times 512 = 2 \text{ TB}$).
* C) 128 Terabytes.
* D) 9.4 Zettabytes. (Distractor - Es el límite teórico del esquema GPT).

---

## ❓ Pregunta 6
**¿Qué mecanismo de seguridad incorpora la tabla de particiones GPT para recuperarse ante corrupciones?**
* A) Cifrado BitLocker obligatorio en cada sector.
* B) Compresión gzip en tiempo real de la tabla de archivos.
* C) **Cabecera secundaria de respaldo (*Backup GPT*) al final del disco y sumas CRC32.** (Correcto - GPT guarda una copia idéntica al final del disco y valida checksums CRC32 para detectar daños).
* D) Duplicación automática en la nube de la partición MBR.

---

## ❓ Pregunta 7
**¿Qué comando se utiliza para visualizar el árbol jerárquico de dispositivos de bloque y sus puntos de montaje?**
* A) `df -h` (Distractor - Muestra espacio ocupado y libre en sistemas de archivos montados, pero no el árbol de bloques).
* B) `top` (Distractor - Muestra procesos en tiempo real y uso de CPU/RAM).
* C) `cat /etc/fstab` (Distractor - Muestra la tabla estática de montajes configurados).
* D) **`lsblk`** (Correcto - `lsblk` lista la jerarquía completa de bloques, particiones y dispositivos loop).

---

## ❓ Pregunta 8
**Dentro del menú interactivo de `fdisk`, ¿qué letra se utiliza para crear una nueva tabla GPT vacía?**
* A) `o` (Distractor - `o` crea una nueva tabla de particiones MBR/DOS).
* B) **`g`** (Correcto - `g` inicializa una nueva tabla de particiones GPT en blanco).
* C) `n` (Distractor - `n` crea una nueva partición dentro de la tabla existente).
* D) `w` (Distractor - `w` escribe los cambios en el disco y sale).

---

## ❓ Pregunta 9
**¿Para qué sirve el comando `losetup -Pf archivo.img` en Linux?**
* A) Para eliminar permanentemente la imagen del disco.
* B) Para formatear la imagen automáticamente en NTFS.
* C) **Para asociar la imagen al subsistema loopback y escanear sus particiones internas.** (Correcto - Asocia el archivo al primer loop libre y la opción `-P` hace que el Kernel detecte y cree nodos para cada partición como `/dev/loop0p1`).
* D) Para comprimir la imagen y enviarla por red vía SSH.

---

## ❓ Pregunta 10
**Si realizamos cambios de particionamiento con `fdisk` y queremos descartar todo sin tocar el disco, ¿qué tecla debemos presionar?**
* A) `w` (Distractor - `w` guarda y aplica permanentemente todos los cambios en el disco).
* B) **`q`** (Correcto - `q` sale inmediatamente de `fdisk` abortando todas las modificaciones realizadas en memoria).
* C) `d` (Distractor - `d` marca una partición para ser eliminada).
* D) `t` (Distractor - `t` cambia el código identificador de tipo de sistema).

---
