# Clase 1: Arquitectura de Almacenamiento y Discos Virtuales VHD en Windows 11

* **Módulo:** 1 - Almacenamiento y Sistemas de Archivos
* **Duración:** 2 Horas Reloj (Día Miércoles)
* **Requisitos:** Windows 11 / PowerShell con privilegios de Administrador

---

## 🎯 Objetivos de la Clase
1. Comprender la evolución de las tablas de particiones: **MBR** (Master Boot Record) vs. **GPT** (GUID Partition Table).
2. Entender la creación de unidades de disco sintéticas mediante archivos VHD/VHDX en Windows 11.
3. Operar cmdlets de PowerShell para la creación, inicialización y montaje de discos virtuales.

---

## 📖 Momento 1: Explicación Teórica con NotebookLM (15 min)
* **Concepto de MBR:** Creado en 1983. Límite de 2 TB de capacidad utilizable por disco. Soporta un máximo de 4 particiones primarias (o 3 primarias + 1 extendida con particiones lógicas).
* **Concepto de GPT:** Parte del estándar UEFI. Soporta discos de hasta 9.4 ZB ($9.4 \times 10^{21}$ bytes) y hasta 128 particiones primarias en Windows sin necesidad de particiones extendidas.
* **Discos VHD dinámicos:** Archivos regulares en disco Host que simulan unidades de almacenamiento físico sin afectar la estructura real de la máquina.
* **Lectura de Apoyo:** Consultar el manual didáctico [**`Manual_de_Discos_Duros_¡Diseña_tu_propia_Casa_Digital!.md`**](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/clase1/Manual_de_Discos_Duros_%C2%A1Dise%C3%B1a_tu_propia_Casa_Digital%21.md).

---

## 💻 Momento 2: Laboratorio Práctico en Consola (75 min)

### Escenario A y B (Compatibilidad Universal: Windows 11 Home, Pro y Netbooks Escolares)
En este laboratorio utilizaremos la consola de CMD y la herramienta nativa `diskpart`:
📄 **[`guia-laboratorio-cmd.md`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/clase1/guia-laboratorio-cmd.md)**

#### Resumen del flujo de trabajo con CMD y Diskpart:
1. Abrir **CMD (Símbolo del sistema) como Administrador**.
2. Crear carpeta de laboratorio: `mkdir C:\LabDiscos` e iniciar herramienta: `diskpart`.
3. Crear el disco VHDX dinámico: `create vdisk file="C:\LabDiscos\DiscoPrueba.vhdx" maximum=2048 type=expandable`.
4. Conectar la unidad virtual: `attach vdisk`.
5. Inicializar en formato moderno GPT: `convert gpt`.
6. Crear partición principal: `create partition primary`.
7. Formatear en NTFS y asignar letra: `format fs=ntfs quick label="LabPro"` y `assign letter=L`.

---

### Escenario B: Contingencia Netbooks Escolares (Setup Automatizado de 128 MB)
En netbooks escolares, también podés ejecutar la variante automatizada con `diskpart`:

```powershell
# Ejecutar script de setup de contingencia
.\setup_clase1.ps1 -UltraLight
```

---

## 🎮 Momento 3: Cierre y Trivia Kahoot (15 min)
Resolver el cuestionario interactivo de fijación en Kahoot (disponible en **[`kahoot_clase1.md`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo1_almacenamiento/clase1/kahoot_clase1.md)**).
