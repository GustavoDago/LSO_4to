# Clase 2: Particionamiento y Formateo NTFS por Consola (`diskpart` en CMD)

* **Módulo:** 1 - Almacenamiento y Sistemas de Archivos
* **Duración:** 2 Horas Reloj (Día Jueves)
* **Requisitos:** Windows 11 / CMD (Símbolo del sistema) como Administrador

---

## 🎯 Objetivos de la Clase
1. Comprender el paso de la capa física/sintética (VHDX y GPT de la Clase 1) a la capa lógica de datos (Particiones y NTFS).
2. Desglosar y analizar cada parámetro del comando `format fs=ntfs quick label="..."` (ejecutado mecánicamente en la Clase 1 con la etiqueta `LabPro`).
3. Dominar el particionamiento de bajo nivel y formateo en **NTFS** utilizando `diskpart` en CMD sobre discos **VHDX**.
4. Diferenciar entre el **Formateo Rápido** (`quick`) y el Formateo Completo, analizando el concepto de **Slack Space** (fragmentación de cluster).
5. Administrar la conexión y desconexión de unidades sintéticas VHDX con los comandos `select vdisk`, `attach vdisk` y `detach vdisk`.

---

## 📖 Momento 1: Explicación Teórica con NotebookLM (15 min)
* **Transición Clase 1 -> Clase 2:** En la Clase 1 creamos el medio virtual VHDX y la tabla MBR/GPT, ejecutando el formateo de forma mecánica. En la Clase 2 desglosamos y comprendemos cómo se organiza la partición lógica e instalamos el sistema de archivos **NTFS**.

### 🔍 Desglose del Comando `format fs=ntfs quick label="LSO_DATOS"`
En la Clase 1 ejecutamos `format fs=ntfs quick label="LabPro"`. Hoy desglosamos qué le ordenamos al sistema en cada parámetro:
* **`format`**: Instrucción de `diskpart` que construye la estructura del sistema de archivos sobre la partición seleccionada.
* **`fs=ntfs`** (*FileSystem*): Define el sistema de archivos como **NTFS** (New Technology File System), creando la **MFT** y activando **Journaling** y permisos **ACL**.
* **`quick`**: Modo rápido que escribe la estructura de metadatos (MFT) en segundos sin verificar sectores físicos ni escribir ceros.
* **`label="LSO_DATOS"`**: Asigna un nombre alfanumérico amigable al volumen (en la Clase 1 usamos `"LabPro"`), visible en el Explorador de Windows.

* **Estructura Interna de NTFS:**
  * **MFT (Master File Table):** Base de datos relacional de metadatos (nombres, permisos ACL, fechas, tamaño y ubicación física).
  * **Journaling:** Registro de transacciones previo a la escritura final que previene la corrupción ante apagados repentinos.
* **Clusters y Slack Space:** Un cluster (4 KB) es el bloque mínimo indivisible asignado. Si guardamos un archivo de 1 KB, este consume 1 cluster completo (4 KB), dejando 3 KB de *slack space* (espacio desperdiciado).

---

## 💻 Momento 2: Laboratorio Práctico en Consola (75 min)

### Preparación del Entorno (Creación del VHDX RAW en CMD)
Ejecutar el script de setup para preparar el disco virtual VHDX sin inicializar en la carpeta de laboratorio:

```cmd
:: Ejecutar script de setup en CMD (crea un VHDX de 1024 MB o 128 MB en netbooks)
setup_clase2.bat
:: Para modo ultra-liviano en netbooks:
setup_clase2.bat ultralight
```

---

### Escenario A: Trabajo Interactivo en `diskpart` (Consola CMD)
Abrir **CMD como Administrador** e iniciar el intérprete de discos:

```cmd
diskpart
list disk
select disk <Número_del_VHDX_Clase2>
detail disk
clean
convert gpt
create partition primary size=500
format fs=ntfs quick label="LSO_DATOS"
assign letter=Z
list volume
exit
```

#### 💡 Operación con Discos Virtuales VHDX (Montar y Desmontar VHDX)
Para **desconectar (desmontar)** o **conectar (montar)** un disco virtual en `diskpart`, no basta con seleccionar el número de disco (`select disk N`), se debe seleccionar el archivo VHDX mediante `select vdisk`:

```cmd
diskpart

:: Volver a montar el disco virtual VHDX:
select vdisk file="C:\Temp\LSO_Clase2.vhdx"
attach vdisk

:: Desmontar (ocultar) el disco virtual VHDX:
select vdisk file="C:\Temp\LSO_Clase2.vhdx"
detach vdisk
```

---

## 🎮 Momento 3: Cierre y Trivia Kahoot (15 min)
Resolver el cuestionario interactivo de fijación en Kahoot (disponible en [`kahoot_clase2.md`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/clase2/kahoot_clase2.md)).
