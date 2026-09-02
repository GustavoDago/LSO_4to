# Trivia Kahoot: Clase 2 - Sistemas de Archivos (EXT4), Montaje, /etc/fstab e Inodos (10 Preguntas - 4 Opciones)

---

## ❓ Pregunta 1
**¿Qué comando se utiliza en Linux para formatear una partición con el sistema de archivos EXT4 asignándole una etiqueta identificatoria?**
* A) `format /dev/loop0p1 -fs ext4 -label Datos` (Distractor - Sintaxis ficticia similar a Windows Diskpart).
* B) **`sudo mkfs.ext4 -L "DatosLSO" /dev/loop0p1`** (Correcto - `mkfs.ext4` crea el sistema de archivos y el parámetro `-L` define la etiqueta o *Volume Label*).
* C) `new-filesystem ext4 /dev/loop0p1` (Distractor - Nombre de comando inexistente).
* D) `fdisk --format ext4 /dev/loop0p1` (Distractor - `fdisk` solo gestiona particiones, no formatea sistemas de archivos).

---

## ❓ Pregunta 2
**¿Qué información fundamental sobre un archivo se almacena en su Inodo dentro de un sistema EXT4?**
* A) El nombre del archivo y la contraseña del usuario root.
* B) La versión del sistema operativo y la dirección IP de origen.
* C) **Permisos POSIX, propietario (UID), tamaño en bytes y punteros a bloques de datos.** (Correcto - El Inodo reúne todos los metadatos y ubicaciones físicas del archivo en el disco).
* D) Una copia de seguridad completa del contenido del archivo.

---

## ❓ Pregunta 3
**¿Dónde se almacena el NOMBRE de un archivo en Linux?**
* A) Dentro del sector de arranque MBR.
* B) En el propio encabezado del Inodo del archivo. (Distractor - El inodo contiene metadatos y punteros a datos, pero no el nombre).
* C) **En la estructura de datos del directorio que contiene el archivo.** (Correcto - Un directorio en Linux es un archivo especial que asocia nombres de texto con números de inodo).
* D) En el archivo `/etc/passwd`.

---

## ❓ Pregunta 4
**¿Cuál es la función principal de la característica de "Journaling" en sistemas de archivos como EXT4 y NTFS?**
* A) Aumentar la velocidad de descarga en Internet.
* B) Comprimir automáticamente los archivos grandes para ahorrar espacio.
* C) **Registrar transacciones previas en un diario para evitar corrupciones ante cortes de energía.** (Correcto - El Journaling garantiza la integridad del sistema permitiendo recuperaciones ultrarrápidas tras caídas imprevistas).
* D) Borrar los archivos temporales cada medianoche.

---

## ❓ Pregunta 5
**¿Qué comando se utiliza para montar una partición `/dev/loop0p1` en el directorio `/mnt/datos_lso`?**
* A) `attach /dev/loop0p1 to /mnt/datos_lso` (Distractor - Sintaxis de Diskpart en Windows).
* B) `sudo link /dev/loop0p1 /mnt/datos_lso` (Distractor - El comando `link` crea enlaces duros de archivos, no monta particiones).
* C) **`sudo mount /dev/loop0p1 /mnt/datos_lso`** (Correcto - Sintaxis estándar: `mount <origen> <destino/punto_de_montaje>`).
* D) `sudo connect /dev/loop0p1 /mnt/datos_lso`

---

## ❓ Pregunta 6
**¿Qué parámetro del comando `df` muestra el porcentaje de uso y la cantidad de INODOS disponibles en lugar de megabytes?**
* A) `df -h` (Distractor - `-h` muestra espacio en formato legible: MB, GB).
* B) **`df -i`** (Correcto - `-i` o `--inodes` lista el total de inodos, los usados y los libres por partición).
* C) `df -m` (Distractor - `-m` muestra el espacio en bloques de 1 Megabyte).
* D) `df -s` (Distractor - Opción no válida en `df`; el resumen por carpeta se realiza con `du -s`).

---

## ❓ Pregunta 7
**¿Por qué un sistema Linux puede arrojar el error "No space left on device" si `df -h` muestra 10 GB libres?**
* A) Porque el procesador está sobrecalentado.
* B) Porque el pendrive está configurado en modo solo lectura.
* C) Porque la memoria Swap está deshabilitada.
* D) **Porque se crearon millones de archivos pequeños y se agotó el 100% de los Inodos.** (Correcto - Al llegar a 0 inodos libres, el sistema no puede crear nuevos archivos aunque sobre espacio en megabytes).

---

## ❓ Pregunta 8
**En el archivo `/etc/fstab`, ¿por qué se recomienda identificar las particiones por su UUID en vez de rutas como `/dev/sdb1`?**
* A) Porque el UUID es más corto y fácil de escribir.
* B) **Porque el UUID es inmutable y no cambia si el disco se conecta a otro puerto o si cambia el orden de booteo.** (Correcto - La asignación de letras `/dev/sd*` es dinámica en el Kernel, mientras que el UUID es único e invariable).
* C) Porque Linux no permite escribir nombres de dispositivo en `/etc/fstab`.
* D) Porque el UUID activa automáticamente el cifrado BitLocker.

---

## ❓ Pregunta 9
**En `/etc/fstab`, ¿qué significado tiene un valor de `1` en el 6.º campo (`fs_passno`)?**
* A) Que la partición se montará en solo lectura.
* B) **Que la partición es la raíz (`/`) y debe comprobarse con máxima prioridad por `fsck`.** (Correcto - El valor `1` está reservado exclusivamente para la partición raíz `/`; las demás llevan `2` o `0`).
* C) Que la partición se ignorará por completo durante el chequeo de disco.
* D) Que se creará un respaldo de volcado diario.

---

## ❓ Pregunta 10
**Si intentamos ejecutar `sudo umount /mnt/datos_lso` y la terminal responde "target is busy", ¿cuál es la causa más común?**
* A) El cable USB del pendrive está desconectado físicamente.
* B) El disco rígido se encuentra desfragmentándose.
* C) **Una terminal o proceso tiene su directorio de trabajo actual dentro de `/mnt/datos_lso`.** (Correcto - Si algún proceso o la terminal activa se encuentra dentro de la ruta montada, el Kernel bloquea el desmontaje por seguridad).
* D) La partición está formateada en FAT32 y no en EXT4.

---
