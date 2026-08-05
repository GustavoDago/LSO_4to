# Trivia Kahoot: Clase 2 - Particionamiento y Formateo NTFS (`diskpart` & PowerShell) (10 Preguntas - 4 Opciones)

---

## ❓ Pregunta 1
**¿Qué función cumple el mecanismo de "Journaling" en el sistema de archivos NTFS?**
* A) Aumentar la velocidad de descarga de archivos desde Internet.
* B) **Registrar las transacciones antes de escribirlas para evitar la corrupción por cortes repentinos de energía.** (Correcto).
* C) Limpiar automáticamente los archivos de la papelera de reciclaje.
* D) Comprimir los archivos para que ocupen la mitad de espacio.

---

## ❓ Pregunta 2
**¿Qué estructura interna de NTFS actúa como base de datos relacional para registrar metadatos, permisos y ubicaciones de archivos?**
* A) La Tabla de Inodos.
* B) **La MFT (Master File Table).** (Correcto - MFT es la estructura central del sistema de archivos NTFS).
* C) El Superbloque.
* D) El Sector MBR.

---

## ❓ Pregunta 3
**En la herramienta interactiva `diskpart`, ¿qué comando limpia completamente todas las particiones y tablas del disco seleccionado?**
* A) `delete partition all`
* B) **`clean`** (Correcto - `clean` deja el disco en estado RAW).
* C) `format quick`
* D) `reset disk`

---

## ❓ Pregunta 4
**En `diskpart`, ¿qué comando asigna la letra de unidad `Z:` al volumen seleccionado?**
* A) `set drive=Z:`
* B) **`assign letter=Z`** (Correcto - Vincula el volumen a la letra de unidad Z:).
* C) `map letter=Z`
* D) `mount Z:`

---

## ❓ Pregunta 5
**En PowerShell de Windows 11, ¿qué cmdlet se utiliza para formatear una partición directamente en NTFS sin abrir `diskpart`?**
* A) `New-Format`
* B) **`Format-Volume`** (Correcto - Sintaxis: `Format-Volume -Partition $partition -FileSystem NTFS`).
* C) `Initialize-NTFS`
* D) `Clear-Volume`

---

## ❓ Pregunta 6
**¿Cuál es el tamaño estándar de la unidad de asignación (Cluster) por defecto en un volumen NTFS en Windows 11?**
* A) 512 bytes.
* B) **4 KB (4096 bytes).** (Correcto - 4 KB es el tamaño de cluster estándar).
* C) 64 KB.
* D) 1 MB.

---

## ❓ Pregunta 7
**¿Qué cmdlet de PowerShell se utiliza para crear una nueva partición asignando automáticamente la máxima capacidad disponible?**
* A) `Create-Partition -Full`
* B) **`New-Partition -UseMaximumSize -AssignDriveLetter`** (Correcto).
* C) `Add-Partition -AllSpace`
* D) `Make-Volume -Max`

---

## ❓ Pregunta 8
**¿Qué sucede con el espacio en disco cuando guardamos un archivo de 1 KB en un sistema de archivos NTFS con cluster de 4 KB?**
* A) Ocupa exactamente 1 KB en el disco físico.
* B) **Ocupa 4 KB de espacio en disco (1 cluster completo asignado).** (Correcto - El cluster es la unidad mínima indivisible).
* C) El archivo se corrompe.
* D) El SO rechaza guardar el archivo.

---

## ❓ Pregunta 9
**¿Qué comando de `diskpart` se utiliza para convertir un disco con tabla MBR al esquema moderno GPT?**
* A) `change style=gpt`
* B) **`convert gpt`** (Correcto - Requiere haber ejecutado `clean` previamente).
* C) `set gpt`
* D) `format gpt`

---

## ❓ Pregunta 10
**Al descargar un script `.ps1` desde Google Drive o Classroom a Windows 11, ¿qué cmdlet de PowerShell elimina la marca de bloqueo Web (`Zone.Identifier`)?**
* A) `Remove-File`
* B) **`Unblock-File`** (Correcto - Sintaxis: `Unblock-File -Path .\script.ps1`).
* C) `Enable-Script`
* D) `Bypass-Security`
