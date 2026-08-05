# Resumen Pedagógico para NotebookLM: Clase 2 - NTFS y Diskpart

## 📌 Sinopsis del Contenido
Estudio práctico del sistema de archivos NTFS en Windows 11 y la manipulación de la tabla de particiones desde línea de comandos mediante `diskpart` y PowerShell.

---

## 🔑 Conceptos Clave

1. **Características de NTFS (New Technology File System):**
   * **Journaling:** Registro de transacciones que evita la corrupción del sistema de archivos ante cortes de energía repentinos.
   * **MFT (Master File Table):** Base de datos relacional de la estructura de archivos. Cada archivo posee al menos un registro de 1024 bytes en la MFT.
   * **Soporte de ACLs:** Almacena permisos de seguridad por archivo/directorio.

2. **Comandos de `diskpart`:**
   * `clean`: Elimina particiones y firmas.
   * `create partition primary`: Define el bloque lógico utilizable.
   * `format fs=ntfs quick`: Crea la MFT y estructuras NTFS rápidamente.
   * `assign letter`: Vincula el volumen a una letra de unidad en el Shell de Windows.

3. **Glosario:**
   * **Cluster / Tamaño de asignación:** Unidad mínima de espacio en disco que el SO puede asignar a un archivo (por defecto 4 KB en NTFS).
