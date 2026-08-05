# Guía de Laboratorio Práctico: Conviértete en Arquitecto de Discos con CMD y Diskpart 🛠️

¡Bienvenido al laboratorio de arquitectura de almacenamiento! En esta práctica vas a utilizar la consola de **Símbolo del sistema (CMD)** en modo Administrador y la herramienta interactiva **Diskpart** para crear una "habitación mágica" (un disco virtual VHDX), inicializarla con un plano moderno (GPT), levantar sus paredes (particiones) y pintarlas (darles formato NTFS).

Lo mejor de este laboratorio es que **es 100% seguro y compatible con cualquier edición de Windows (incluyendo Windows 11 Home y Netbooks Escolares)**: trabajaremos dentro de un disco virtual mediante `diskpart`, por lo que no hay ningún riesgo para tus archivos reales.

---

## 📋 Requisitos Previos

1. Una computadora con **Windows 10 o Windows 11** (ediciones Home, Pro o Education).
2. Permisos de Administrador en el equipo.
3. Unos **10 minutos** de concentración y ganas de aprender cómo funciona tu sistema operativo por dentro.

---

## Paso 1: Abrir CMD (Símbolo del Sistema) como Administrador 💻

Para administrar discos y almacenamiento con `diskpart`, necesitamos privilegios elevados de Administrador.

1. Presiona la tecla **Windows** de tu teclado.
2. Escribe **cmd** o **Símbolo del sistema**.
3. Haz clic derecho sobre *Símbolo del sistema* y selecciona **Ejecutar como administrador**.
4. Si aparece la ventana de Control de cuentas de usuario (UAC), haz clic en **Sí**.

---

## Paso 2: Crear la Carpeta Segura para Nuestro Laboratorio 📁

En la consola de CMD, crearemos una carpeta llamada `LabDiscos` en tu disco principal `C:`.

Escribe el siguiente comando y presiona **Enter**:

```cmd
mkdir C:\LabDiscos
```

---

## Paso 3: Iniciar la Herramienta Interactiva Diskpart ⚙️

**Diskpart** es el administrador de particiones por línea de comandos nativo de Windows.

Escribe en la consola CMD:

```cmd
diskpart
```

Verás que el prompt de la consola cambia a `DISKPART>`. Todos los comandos siguientes se ejecutan dentro del entorno Diskpart.

---

## Paso 4: Crear la "Habitación Mágica" (Disco Virtual VHDX) 🔮

Crearemos un disco virtual dinámico de **2 Gigabytes (2048 MB)** almacenado en `C:\LabDiscos\DiscoPrueba.vhdx`. Al ser dinámico (`type=expandable`), no ocupará los 2 GB de inmediato en tu disco real.

Dentro del prompt `DISKPART>`, escribe:

```cmd
create vdisk file="C:\LabDiscos\DiscoPrueba.vhdx" maximum=2048 type=expandable
```

---

## Paso 5: Conectar el Disco Virtual (Montar / Adjuntar) 🔌

Ahora le diremos a Windows que "conecte" este archivo `.vhdx` como si fuera un disco físico real.

Dentro del prompt `DISKPART>`, escribe:

```cmd
attach vdisk
```

---

## Paso 6: Dibujar el Plano de Construcción (Convertir a GPT) 🏗️

Aplicaremos la tabla de particiones moderna **GPT (GUID Partition Table)**.

Dentro del prompt `DISKPART>`, escribe:

```cmd
convert gpt
```

*(Al crear y adjuntar el disco virtual, Diskpart lo selecciona automáticamente para los siguientes comandos).*

---

## Paso 7: Levantar las Paredes (Crear la Partición Principal) 🧱

Crearemos una partición primaria que ocupe todo el espacio disponible en el disco virtual.

Dentro del prompt `DISKPART>`, escribe:

```cmd
create partition primary
```

---

## Paso 8: Pintar las Paredes y Asignar Letra (Formato NTFS) 🎨

Le daremos formato con el sistema de archivos **NTFS**, asignándole la etiqueta de volumen `LabPro` y una letra de unidad (por ejemplo `L:`) para acceder desde el Explorador de Archivos.

Dentro del prompt `DISKPART>`, escribe:

```cmd
format fs=ntfs quick label="LabPro"
assign letter=L
```

¡Felicidades! Abre el **Explorador de Archivos** (teclas `Windows + E`) e ingresa a "Este equipo". Verás una nueva unidad con la letra **L:** llamada **LabPro** lista para guardar archivos.

---

## Paso 9: Salir de Diskpart y Limpieza del Laboratorio 🧹

Cuando termines de explorar tu nuevo disco virtual, puedes desconectarlo y borrar los archivos de prueba.

1. Para desconectar el disco virtual y salir de Diskpart:

```cmd
detach vdisk
exit
```

1. Una vez fuera de Diskpart (de vuelta en el prompt tradicional de `C:\>`), borra la carpeta del laboratorio:

```cmd
rmdir /s /q C:\LabDiscos
```

---
