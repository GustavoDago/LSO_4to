# Resumen Pedagógico: Sistemas de Archivos EXT4, Puntos de Montaje e Inodos (NotebookLM)

> **Cuaderno de Estudio:** LSO 4to - 2do Semestre  
> **Tema:** Almacenamiento en Linux - Clase 2: Sistemas de Archivos (EXT4), `mount`, `/etc/fstab` e Inodos  
> **Nivel:** 4.º Año - Educación Técnico-Profesional (Tecnicatura en Informática)

---

## 📌 1. El Concepto de Montaje y el Árbol Raíz Único `/`
En Linux no existen particiones flotantes identificadas por letras (`C:`, `D:`). Todo el almacenamiento disponible se integra dentro de una única jerarquía de directorios jerárquica con origen en la **raíz (`/`)**.

* **Punto de Montaje (*Mount Point*):** Es cualquier directorio ordinario (generalmente ubicado en `/mnt` o `/media`) sobre el cual se "injerta" el sistema de archivos de una partición física o virtual.
* **Operación de Montaje (`mount`):** Instruye al subsistema VFS (*Virtual File System*) del Kernel para que enlace las solicitudes de lectura/escritura de esa ruta con el dispositivo de bloques correspondiente.
* **Operación de Desmontaje (`umount`):** Vacía la caché en memoria RAM (*flush buffer*), sincroniza las escrituras pendientes en el disco físico y desvincula el punto de acceso para evitar pérdidas de datos o corrupción.

---

## 🧩 2. Estructura Interna del Sistema de Archivos EXT4

El sistema de archivos **EXT4** (Extended Filesystem 4) divide la partición en Grupos de Bloques (*Block Groups*), cada uno compuesto por:

1. **Superbloque (*Superblock*):**
   * Almacena los parámetros globales del sistema de archivos: total de bloques, total de inodos, tamaño del bloque (típicamente 4096 bytes), fecha de creación, estado de montaje (limpio / con errores) y UUID.
   * Cuenta con copias de respaldo (*Backup Superblocks*) distribuidas en la partición para permitir recuperaciones automáticas con `e2fsck`.
2. **Tabla de Inodos (*Inode Table*):**
   * Contiene la lista estructurada de todos los inodos de la partición.
   * **¿Qué guarda un Inodo?**
     * Tipo de archivo (regular, directorio, enlace simbólico, socket, etc.).
     * Permisos de acceso POSIX (Lectura `r`, Escritura `w`, Ejecución `x` para Usuario, Grupo y Otros).
     * Propietario (UID) y Grupo (GID).
     * Tamaño exacto en bytes.
     * Marcas temporales (*Timestamps*): `atime` (último acceso), `mtime` (última modificación de contenido), `ctime` (último cambio de metadatos/inodo).
     * **Punteros a bloques de datos (Extents):** Rangos contiguos de bloques físicos donde residen los datos del archivo.
   * > **Dato Clave:** El Inodo **NO almacena el nombre del archivo**. El nombre es simplemente una entrada dentro de un archivo especial de tipo directorio que asocia un texto (nombre) a un número de inodo.
3. **Journaling (Diario de Transacciones):**
   * Registro circular donde se anotan las operaciones de disco antes de escribirlas en las estructuras principales. Si ocurre un corte de luz repentino, el sistema lee el diario en el próximo arranque y repara cualquier inconsistencia en milisegundos sin necesidad de escanear el disco entero.

---

## ⚖️ 3. Comparativa: EXT4 (Linux) vs. NTFS (Windows 11)

| Aspecto Técnico | EXT4 (Linux) | NTFS (Windows 11) |
| :--- | :--- | :--- |
| **Estructura de Metadatos** | Tabla de **Inodos** estática definida al formatear | Tabla Maestra de Archivos (**MFT** - Master File Table) dinámica |
| **Journaling / Registro** | Sí (Modos: *journal*, *ordered*, *writeback*) | Sí (Log transaccional `$LogFile` y `$UsnJrnl`) |
| **Sensibilidad a Mayúsculas** | **Case-Sensitive** (`archivo.txt` y `Archivo.txt` son distintos) | **Case-Insensitive** (No distingue mayúsculas/minúsculas) |
| **Control de Acceso** | Permisos **POSIX** (rwx para Owner, Group, Others) + ACLs | Listas de Control de Acceso (**DACL / ACEs**) granulares |
| **Fragmentación** | Extremadamente baja (asigna por *Extents* contiguos) | Moderada a alta (requiere desfragmentación periódica) |
| **Límites Máximos** | Archivo máx: 16 TB / Volumen máx: 1 EB | Archivo máx: 16 TB / Volumen máx: 8 PB |

---

## ⚙️ 4. La Tabla de Montajes del Sistema: `/etc/fstab`

El archivo `/etc/fstab` define qué particiones y discos se montan automáticamente en cada arranque del sistema operativo.

### Formato de Línea (6 Campos):
```text
[Dispositivo / UUID]   [Punto Montaje]   [Tipo FS]   [Opciones]           [Dump]   [Pass]
UUID=5e8f4c2a-...      /mnt/servidor     ext4        defaults,noatime     0        2
```

* **Campo 1 (Identificador):** Se prefiere siempre el `UUID` obtenido con `blkid` (es inmutable frente a cambios de puertos USB o ranuras SATA).
* **Campo 2 (Punto de Montaje):** Directorio destino absoluto.
* **Campo 3 (Tipo):** `ext4`, `vfat`, `ntfs3`, `xfs`, `swap`.
* **Campo 4 (Opciones de Montaje):**
  * `defaults`: Activa lectura/escritura (`rw`), ejecución de binarios (`exec`), bits SUID (`suid`), dispositivos (`dev`), montaje automático (`auto`), usuario root (`nouser`), escritura asíncrona (`async`).
  * `ro`: Monta la partición en solo lectura.
  * `noatime`: Desactiva la actualización de la marca temporal de acceso para acelerar lecturas en discos mecánicos o pendrives.
* **Campo 5 (Dump):** `0` = No respaldar / `1` = Respaldar con la utilidad dump.
* **Campo 6 (Pass / fsck):**
  * `0` = No comprobar integridad al arrancar.
  * `1` = Comprobar primero con máxima prioridad (exclusivo para la partición raíz `/`).
  * `2` = Comprobar luego del arranque del sistema (particiones de datos secundarias).

---

## 💡 Preguntas de Reflexión y Guía para NotebookLM
1. *¿Por qué un disco puede quedarse sin espacio para guardar nuevos archivos aunque `df -h` muestre que quedan gigabytes libres?*
2. *¿Cuál es la función del Journaling y cómo previene que se corrompa el sistema de archivos ante un corte repentino de energía?*
3. *¿Por qué en `/etc/fstab` es una mala práctica técnica utilizar nombres de dispositivo como `/dev/sdb1` en lugar del identificador UUID?*
