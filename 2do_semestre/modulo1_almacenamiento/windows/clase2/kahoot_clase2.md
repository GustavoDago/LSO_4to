# Trivia Kahoot: Clase 2 - Particionamiento y Formateo NTFS por Consola (`diskpart` en CMD) (10 Preguntas - 4 Opciones)

---

## ❓ Pregunta 1
**¿Qué función cumple el mecanismo de 'Journaling' en el sistema de archivos NTFS?**
* A) Aumentar la velocidad de descarga de archivos desde Internet.
* B) Limpiar automáticamente los archivos de la papelera de reciclaje.
* C) **Registrar las transacciones antes de escribirlas para evitar corrupción.** (Correcto - Mantiene la integridad y consistencia del disco).
* D) Comprimir los archivos para que ocupen la mitad de espacio.

---

## ❓ Pregunta 2
**¿Qué estructura de NTFS actúa como base de datos relacional para registrar metadatos, permisos y archivos?**
* A) **La MFT (Master File Table).** (Correcto - La MFT es la estructura central donde todo archivo posee registros de 1024 bytes).
* B) La Tabla de Inodos.
* C) El Superbloque.
* D) El Sector MBR.

---

## 3. Pregunta 3
**En diskpart, ¿qué comando borra la tabla de particiones y firmas dejando el disco en estado RAW (sin inicializar)?**
* A) `delete partition all`
* B) `format quick`
* C) `reset disk`
* D) **`clean`** (Correcto - `clean` elimina la información de configuración dejando el disco en estado puro o RAW).

---

## ❓ Pregunta 4
**Para desconectar (ocultar) un disco virtual VHDX en diskpart sin eliminar datos, ¿cuál es el procedimiento correcto?**
* A) Ejecutar `detach disk` habiendo usado `select disk 3`.
* B) **Seleccionar el VHDX con `select vdisk file="..."` y ejecutar `detach vdisk`.** (Correcto - El comando `detach vdisk` requiere primero dar foco al archivo contenedor).
* C) Ejecutar `delete vdisk`.
* D) Formatear el disco con `format /detach`.

---

## ❓ Pregunta 5
**Al ejecutar `format fs=ntfs quick label="LSO_DATOS"` en diskpart, ¿qué función cumple el parámetro `label="..."`?**
* A) **Asignar un nombre amigable al volumen para identificarlo en Windows.** (Correcto - Como la etiqueta `"LabPro"` usada en la Clase 1).
* B) Definir el tamaño máximo de la partición en Megabytes.
* C) Encriptar el disco con una clave de seguridad.
* D) Cambiar automáticamente la letra de unidad asignada.

---

## ❓ Pregunta 6
**¿Qué diferencia existe entre el Formateo Rápido (`format fs=ntfs quick`) y el Formateo Completo en diskpart?**
* A) El formateo rápido instala Linux y el completo instala Windows.
* B) El formateo completo borra la BIOS del equipo.
* C) **El rápido escribe la MFT en segundos; el completo escanea y ceréa el disco.** (Correcto - El formateo completo toma mucho más tiempo).
* D) No existe ninguna diferencia técnica entre ambos.

---

## ❓ Pregunta 7
**¿Cómo se denomina al espacio interno desperdiciado cuando un archivo de 1 KB se guarda en un cluster de 4 KB?**
* A) Fragmentación Externa.
* B) Memoria Cache.
* C) Sector Defectuoso.
* D) **Slack Space (o espacio inutilizado del cluster).** (Correcto - Es la diferencia entre el tamaño del archivo y el bloque mínimo de 4 KB).

---

## ❓ Pregunta 8
**En `diskpart` (CMD), ¿qué comando permite inspeccionar la lista de volúmenes creados y sus letras asignadas?**
* A) `show all`
* B) **`list volume`** (Correcto - Muestra todos los volúmenes, etiquetas, letras de unidad y sistema de archivos formateado).
* C) `get drives`
* D) `view partitions`

---

## ❓ Pregunta 9
**En `diskpart` (CMD), ¿qué comando se utiliza para inicializar un disco limpio en la tabla de particiones GPT?**
* A) **`convert gpt`** (Correcto - Requiere haber ejecutado `clean` previamente sobre el disco).
* B) `change style=gpt`
* C) `set gpt`
* D) `format gpt`

---

## ❓ Pregunta 10
**¿Cuál es la relación entre la Capa Sintética (Clase 1: VHDX/GPT) y la Capa Lógica de Datos (Clase 2: NTFS)?**
* A) En la Clase 1 creamos carpetas y en la Clase 2 compramos discos rígidos.
* B) MBR y GPT solo funcionan si formateamos en EXT4.
* C) **Clase 1 crea el VHDX y GPT; Clase 2 delimita la Partición y el NTFS.** (Correcto).
* D) Las particiones lógicas reemplazan por completo a la memoria RAM.
