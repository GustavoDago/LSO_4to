# Trivia Kahoot: Clase 1 - Arquitectura de Almacenamiento, MBR vs. GPT y Discos VHD con Diskpart (10 Preguntas - 4 Opciones)

---

## ❓ Pregunta 1
**¿Cuántas particiones primarias soporta como máximo el esquema MBR?**
* A) 128 particiones primarias.
* B) **4 particiones primarias.** (Correcto - MBR limita la tabla principal a 4 entradas de 16 bytes.)
* C) 2 particiones primarias.
* D) Sin límite de particiones.

---

## ❓ Pregunta 2
**¿Cuál es el límite máximo de almacenamiento soportado por MBR?**
* A) 512 Terabytes.
* B) 100 Gigabytes.
* C) **2 Terabytes.** (Correcto - MBR usa enteros de 32 bits para direccionar sectores, limitándolo a 2 TB con sectores de 512 bytes.)
* D) 9.4 Petabytes.

---

## ❓ Pregunta 3
**¿Qué ventaja de redundancia tiene la tabla GPT frente a MBR?**
* A) **Guarda una copia de respaldo del encabezado (Secondary GPT).** (Correcto - GPT incluye una cabecera secundaria de respaldo (Secondary GPT Header) al final del disco.)
* B) Comprime los archivos automáticamente.
* C) Mantiene una copia del disco en la memoria RAM.
* D) Evita tener que formatear la unidad de disco.

---

## ❓ Pregunta 4
**¿Cuántas particiones soporta como máximo la estructura GPT en Windows?**
* A) 4 particiones.
* B) 8 particiones.
* C) **128 particiones.** (Correcto - El estándar de Windows reserva espacio para 128 particiones GPT primarias.)
* D) 16 particiones.

---

## ❓ Pregunta 5
**En Diskpart, ¿qué comando crea un disco virtual dinámico VHDX?**
* A) **create vdisk file="..." maximum=2048 type=expandable** (Correcto - Sintaxis oficial en Diskpart: create vdisk file="..." maximum=2048 type=expandable)
* B) new vdisk -type dynamic -size 2gb
* C) make vhd -path C:\LabDiscos\disco.vhdx
* D) add disk -format vhdx -size 2048

---

## ❓ Pregunta 6
**¿Qué diferencia a un disco VHD "Dinámico" de uno "Fijo"?**
* A) El dinámico requiere conexión a Internet permanente.
* B) El fijo utiliza memoria RAM en lugar de espacio en disco.
* C) El dinámico no permite instalar sistemas de archivos.
* D) **El dinámico crece según el espacio realmente ocupado.** (Correcto - El dinámico ocupa en el almacenamiento del host solo el espacio utilizado por los archivos.)

---

## ❓ Pregunta 7
**En Diskpart, ¿qué comando convierte un disco seleccionado a GPT?**
* A) format gpt
* B) **convert gpt** (Correcto - El comando convert gpt escribe la estructura inicial de la tabla GPT en el disco seleccionado en Diskpart.)
* C) set partitionstyle=gpt
* D) init disk -gpt

---

## ❓ Pregunta 8
**¿Qué ocurre al reiniciar la PC si creamos un VHD en C:\Temp sin respaldo?**
* A) Se resguarda automáticamente en OneDrive.
* B) Pasa a ser un archivo protegido de solo lectura.
* C) El sistema operativo inhabilita la cuenta de alumno.
* D) **Se borra al reiniciar por el congelador Deep Freeze.** (Correcto - Las PC del Nodo Tecnológico restauran su estado inicial al reiniciar mediante Deep Freeze.)

---

## ❓ Pregunta 9
**En Diskpart, ¿qué comando conecta un disco virtual al sistema?**
* A) mount vdisk
* B) connect vdisk
* C) **attach vdisk** (Correcto - El comando attach vdisk en Diskpart monta el archivo VHDX haciéndolo visible para el sistema operativo.)
* D) online vdisk

---

## ❓ Pregunta 10
**¿Cuál es la principal ventaja del formato VHDX frente a VHD?**
* A) **VHDX admite hasta 64 TB y tiene log de transacciones.** (Correcto - VHDX expande la capacidad hasta 64 TB e incorpora resiliencia ante fallos eléctricos con un log de transacciones.)
* B) VHDX admite hasta 2 TB y VHD soporta 64 TB.
* C) VHDX solo admite MBR y VHD exige obligatoriamente GPT.
* D) VHD incluye cifrado nativo y VHDX no permite cifrar.

---
