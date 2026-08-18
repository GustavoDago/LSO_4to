# Resumen Pedagógico para NotebookLM: Clase 2 - NTFS y Diskpart en CMD

## 📌 Sinopsis del Contenido
Estudio de la transición entre la capa física/sintética de almacenamiento (Clase 1) y la capa lógica de datos (Clase 2), profundizando en el desglose del comando de formateo, las estructuras del sistema de archivos **NTFS** en Windows 11 y la administración desde línea de comandos mediante **CMD** y **`diskpart`** utilizando discos virtuales modernos **VHDX**.

---

## 🔗 Transición Didáctica: De la Capa Física (Clase 1) a la Capa Lógica (Clase 2)

* **En la Clase 1 (Estructura Base):** Creamos el medio sintético (**VHDX**), asignamos la tabla de particiones (**GPT vs MBR**) y ejecutamos mecánicamente el comando `format fs=ntfs quick label="LabPro"`.
* **En la Clase 2 (Explicación y Desglose Lógico):** Comprendemos técnicamente cada parámetro de dicho comando y construimos la partición lógica aplicando NTFS sobre la unidad VHDX.

```
[ Disco Físico / VHDX ] ──(Clase 1: convert gpt)──> [ Tabla GPT ] ──(Clase 2: create partition)──> [ Partición RAW ] ──(Clase 2: format fs=ntfs)──> [ Volumen NTFS (MFT + Clusters) ]
```

---

## 🔑 Conceptos Clave

1. **Desglose del Comando `format fs=ntfs quick label="LSO_DATOS"`:**
   * **`format`**: Instrucción de `diskpart` para inicializar y construir la estructura lógica del sistema de archivos.
   * **`fs=ntfs`** (*FileSystem*): Define el sistema de archivos como **NTFS** (New Technology File System), creando la **MFT** y activando **Journaling** y permisos **ACL**.
   * **`quick`**: Formateo rápido que escribe la estructura de metadatos (MFT) en segundos sin verificar sectores físicos ni sobreescribir ceros.
   * **`label="LSO_DATOS"`**: Asigna una etiqueta alfanumérica visible (nombre del volumen, como `"LabPro"` en la Clase 1) que se muestra en el Explorador de Windows.

2. **Características de NTFS (New Technology File System):**
   * **MFT (Master File Table):** Base de datos relacional del sistema de archivos. Todo archivo o directorio tiene al menos un registro de 1024 bytes en la MFT con sus metadatos (nombre, tamaño, fechas, atributos y ubicación física).
   * **Journaling (Registro Transaccional):** Mecanismo de seguridad que registra los cambios antes de escribirlos definitivamente. Si ocurre un corte de energía, el SO lee el *Journal* y recupera la integridad del disco sin corruptelas.
   * **Soporte de ACLs (Access Control Lists):** Permite asociar permisos de seguridad avanzados a nivel de usuario y grupo por cada archivo y carpeta.

3. **Formateo Rápido (`quick`) vs. Formateo Completo:**
   * **Formateo Rápido:** Escribe únicamente la MFT y metadatos en cuestión de segundos.
   * **Formateo Completo:** Revisa cada sector del disco para detectar fallos físicos y sobreescribe los datos existentes con ceros, demorando significativamente más.

4. **Clusters y Slack Space (Fragmentación Interna):**
   * **Cluster (Unidad de Asignación):** Bloque mínimo e indivisible que el SO asigna en disco (estándar de 4 KB / 4096 bytes en NTFS).
   * **Slack Space:** Espacio en disco desperdiciado cuando un archivo ocupa menos del tamaño total del cluster (ej. archivo de 1 KB consume 4 KB reales, dejando 3 KB de *slack space*).

5. **Operaciones con Discos Virtuales (`vdisk` en Diskpart con VHDX):**
   * Diferencia fundamental entre el objeto disco (`select disk N`) y el archivo contenedor sintético (`select vdisk file="ruta.vhdx"`).
   * `attach vdisk`: Conecta el archivo VHDX para que el sistema operativo lo reconozca como un disco físico.
   * `detach vdisk`: Desconecta el VHDX dejando los datos intactos dentro del archivo contenedor.

---

## 💻 Comandos Clave en Consola CMD (`diskpart`)

| Comando | Función Didáctica |
| :--- | :--- |
| `select vdisk file="..."` | Selecciona el archivo contenedor VHDX en el sistema. |
| `attach vdisk` / `detach vdisk` | Monta u oculta el disco virtual VHDX en el sistema operativo. |
| `clean` | Borra la tabla de particiones y firmas (vuelve a estado RAW). |
| `convert gpt` | Inicializa la tabla en esquema GPT. |
| `create partition primary size=500` | Delimita una partición de 500 MB. |
| `format fs=ntfs quick label="LSO_DATOS"` | Formatea rápidamente creando la MFT e instalando NTFS con etiqueta de volumen. |
| `assign letter=Z` | Asigna la letra de unidad Z: para explorar el volumen. |
