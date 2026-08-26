# INFORME DE LABORATORIO: INSTALACIÓN DE LUBUNTU EN DUAL-BOOT (WINDOWS 11 / LINUX)

> **Documento de Trabajo para Google Docs / Google Classroom**  
> *Instrucciones para el alumno:* Completa los datos del encabezado, responde las consignas técnicas y pega las capturas de pantalla solicitadas en cada recuadro designado. Al finalizar, exporta este documento en formato PDF o entrégalo a través de Google Classroom.

---

## 📋 1. Datos de Identificación y Hardware

| Campo | Información del Alumno / Grupo |
| :--- | :--- |
| **Institución:** | Escuela de Educación Secundaria Técnica |
| **Materia:** | Laboratorio de Sistemas Operativos (LSO) |
| **Curso y División:** | 4.º Año — División: `_____` |
| **Nombre y Apellido del Alumno / Grupo:** | 1. `______________________________________`<br>2. `______________________________________` |
| **Fecha de Realización:** | `____ / ____ / 2026` |
| **Fecha de Entrega:** | `____ / ____ / 2026` |
| **Calificación y Firma Docente:** | Nota: `______` \| Firma: `____________________` |

### Ficha Técnica de la Computadora de Laboratorio:
* **Marca y Modelo del Equipo:** `________________________________________`
* **Procesador (CPU):** `________________________________________`
* **Memoria RAM Total:** `_______ GB`
* **Tipo y Capacidad de Almacenamiento:** `[ ] SSD  [ ] NVMe  [ ] HDD` — Capacidad: `_______ GB`
* **Modo de Firmware / Tabla de Particiones:** `[ ] UEFI / GPT`  `[ ] BIOS Heredado / MBR`

---

## 🪟 MÓDULO 1: Preparación del Almacenamiento y Seguridad en Windows 11

### Actividad 1.1: Desactivación del "Inicio Rápido" (Fast Startup)
Ejecuta el comando `powercfg /h off` en una consola de Administrador (CMD o PowerShell) para evitar que Windows bloquee la partición NTFS en modo hibernación.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 1.1: Ejecución de powercfg /h off en CMD/PowerShell como Administrador       │
│                                                                                                                  │
│                                                                                                                  │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                                       │
│                                                                                                                  │
│                                                                                                                  │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

* **Pregunta Técnica 1.1:** ¿Por qué es peligroso que Linux intente escribir en una partición NTFS si Windows 11 no se apagó completamente debido al Fast Startup?
  > **Respuesta del alumno:**  
  > `____________________________________________________________________________________________________`  
  > `____________________________________________________________________________________________________`

---

### Actividad 1.2: Reducción de Volumen y Creación de Espacio No Asignado
Abre **Administración de discos** (`diskmgmt.msc`), achica la unidad `(C:)` para liberar entre **20 GB y 30 GB** (o **15 GB** en netbooks) y asegúrate de que el bloque liberado quede como **"No Asignado"** (color negro).

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 1.2: Administrador de Discos mostrando el bloque "No asignado"                │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                               │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

* **Registro de Valores:**
  * Espacio total original del disco: `__________ GB`
  * Cantidad de megabytes reducidos: `__________ MB`
  * Espacio final disponible como "No Asignado": `__________ GB`

---

## 🐧 MÓDULO 2: Arranque en Modo Live ("Probar Lubuntu") y Validación de Hardware

### Actividad 2.1: Acceso al Menú de Booteo (Boot Menu)
Conecta el pendrive booteable, enciende el equipo pulsando la tecla de arranque (`F12`, `F11`, `F9` o `Esc`) y selecciona la opción UEFI del pendrive.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA / FOTO 2.1: Menú de Booteo UEFI o pantalla de bienvenida de GRUB              │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA FOTO O CAPTURA ]                                    │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

---

### Actividad 2.2: Carga del Entorno LXQt y Prueba de Conectividad
Inicia en modo **"Try or Install Lubuntu"** (ejecución 100% en memoria RAM). Conéctate a la red Wi-Fi o Ethernet del laboratorio y realiza una prueba de ping a un servidor externo.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 2.2: Escritorio LXQt de Lubuntu con terminal ejecutando ping -c 3 google.com   │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                               │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

---

### Actividad 2.3: Inspección de Dispositivos de Bloque (`lsblk -f`)
Abre la terminal (`Ctrl + Alt + T`) y corre el comando `lsblk -f` para verificar cómo reconoce Linux los discos internos de la máquina y el pendrive.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 2.3: Salida completa del comando lsblk -f en la terminal de Lubuntu           │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                               │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

* **Tabla de Mapeo de Dispositivos identificados:**

| Identificador de Dispositivo | Sistema de Archivos (FSTYPE) | Tamaño | Etiqueta / Función |
| :--- | :--- | :--- | :--- |
| Ej: `/dev/nvme0n1p1` o `/dev/sda1` | `vfat` / `FAT32` | `100 MB` | Partición EFI (ESP) |
| `______________________` | `_________________` | `______` | Partición Windows (C:) |
| `______________________` | `[Espacio Libre]` | `______` | Espacio destinado a Lubuntu |
| `______________________` | `iso9660` / `vfat` | `______` | Pendrive Booteable Live |

---

## 💿 MÓDULO 3: Instalación de Lubuntu con Calamares

### Actividad 3.1: Configuración de Teclado y Prueba de Caracteres Especiales
En el asistente Calamares, selecciona la distribución **Español (Latinoamericano)** o **Español** y prueba en el campo de texto la escritura de teclas especiales (`@`, `/`, `\`, `~`, `|`).

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 3.1: Pantalla de Teclado en Calamares con los caracteres de prueba escritos   │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                               │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

---

### Actividad 3.2: Particionado de Disco (Punto Crítico de la Práctica)
Configura el particionado manual o asistido asignando el punto de montaje `/boot/efi` (**sin formatear**) a la partición EFI existente y creando la partición raíz `/` en formato `ext4`.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 3.2: Esquema de particionado final en Calamares antes de aplicar cambios       │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                               │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

* **Detalle de Configuración de Particiones:**
  * Partición EFI seleccionada: `/dev/________` — Punto de montaje: `/boot/efi` — ¿Se formateó?: **[ ] SÍ  [ ] NO (Correcto)**
  * Partición Raíz de Linux: `/dev/________` — Formato: `ext4` — Tamaño: `________ MB` — Punto de montaje: `/`
  * Ubicación del gestor de arranque GRUB: `________________________________________`

---

### Actividad 3.3: Configuración de Usuario y Resumen de Instalación
Define el nombre de usuario (`alumno`), el nombre de host de la máquina (`pc-lso-XX`) y captura la pantalla de **Resumen general** previo a la confirmación de escritura.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 3.3: Pantalla de Resumen en Calamares indicando operaciones en disco          │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                               │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

---

### Actividad 3.4: Finalización de la Instalación
Captura el mensaje final de Calamares que indica: *"¡Todo listo! Lubuntu ha sido instalado en su equipo"*.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 3.4: Mensaje de instalación finalizada con éxito al 100%                      │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                               │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🚀 MÓDULO 4: Verificación Post-Instalación y Diagnóstico Dual-Boot

### Actividad 4.1: Menú de Arranque GRUB2
Reinicia el equipo, retira el pendrive USB al solicitarlo el sistema y toma una fotografía/captura del menú **GRUB2** mostrando las entradas de **Lubuntu** y **Windows Boot Manager**.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA / FOTO 4.1: Menú GRUB2 mostrando Lubuntu y Windows Boot Manager               │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA FOTO O CAPTURA ]                                    │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

---

### Actividad 4.2: Primer Inicio en Lubuntu y Puesta a Punto
Inicia sesión en tu nuevo Lubuntu instalado en disco, abre la terminal y ejecuta:
`sudo apt update && sudo apt install -y neofetch && neofetch`

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 4.2: Terminal en Lubuntu mostrando neofetch y el Kernel instalado              │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                               │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

---

### Actividad 4.3: Comprobación de Integridad de Windows 11
Reinicia el equipo, selecciona **Windows Boot Manager** en GRUB e inicia sesión en Windows 11 para certificar que el sistema anfitrión no sufrió pérdida de datos.

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ 📷 CAPTURA 4.3: Escritorio de Windows 11 iniciado con normalidad tras la instalación     │
│                                                                                          │
│                                                                                          │
│                      [ PEGAR AQUÍ LA CAPTURA DE PANTALLA ]                               │
│                                                                                          │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🧠 MÓDULO 5: Cuestionario de Comprensión Técnica

Responde de forma clara y fundamentada con tus propias palabras:

**1. ¿Qué función cumple la partición EFI System Partition (ESP) y por qué ambos sistemas operativos (Windows y Linux) pueden compartirla sin borrarse entre sí?**
> `____________________________________________________________________________________________________`  
> `____________________________________________________________________________________________________`  
> `____________________________________________________________________________________________________`

**2. ¿Qué diferencia existe entre el sistema de archivos NTFS de Windows y el EXT4 de Lubuntu en cuanto al manejo de permisos y estructura de archivos?**
> `____________________________________________________________________________________________________`  
> `____________________________________________________________________________________________________`  
> `____________________________________________________________________________________________________`

**3. Si al encender la computadora la máquina ingresa directamente a Windows 11 sin dar la opción de elegir Lubuntu, ¿cómo se soluciona técnicamente el problema desde el BIOS/UEFI?**
> `____________________________________________________________________________________________________`  
> `____________________________________________________________________________________________________`  
> `____________________________________________________________________________________________________`

**4. ¿Qué ventaja ofrece un archivo de intercambio (`/swapfile`) frente a una partición física `swap` dedicada en discos de estado sólido (SSD)?**
> `____________________________________________________________________________________________________`  
> `____________________________________________________________________________________________________`  
> `____________________________________________________________________________________________________`

---

## 📊 Rúbrica de Evaluación del Informe de Laboratorio

| Criterio de Evaluación | Excelente (10 - 9 pts) | Bueno (8 - 7 pts) | Regular (6 - 5 pts) | Insuficiente (4 - 1 pts) |
| :--- | :--- | :--- | :--- | :--- |
| **Preparación y Seguridad (Mód. 1)** | Desactiva Fast Startup con comando exacto y reduce volumen dejando espacio no asignado sin errores. | Reduce el volumen pero omite la justificación o tiene dudas menores en el comando. | Reduce el volumen pero crea partición NTFS incorrecta o no desactiva Fast Startup. | No logra reducir el disco o compromete el volumen de Windows. |
| **Diagnóstico Live y Hardware (Mód. 2)** | Documenta conectividad, red y mapeo completo de bloques con `lsblk -f`. | Muestra capturas pero la tabla de dispositivos está incompleta. | Solo muestra escritorio Live sin comandos de diagnóstico de bloques. | No realiza la sesión de prueba Live. |
| **Instalación y Particionado (Mód. 3)** | Esquema de particionado perfecto (EFI sin formatear, `/` en ext4), teclado verificado y usuario creado. | Instala correctamente en modo automático pero no domina el particionado manual. | Errores menores en puntos de montaje que requirieron asistencia docente. | Formateó por error la partición EFI o borró particiones de Windows. |
| **Post-Instalación y Dual-Boot (Mód. 4)** | Documenta GRUB2 funcionando, actualización de paquetes en Lubuntu y Windows intacto. | Lubuntu inicia pero no documentó el reinicio de prueba en Windows 11. | Fallas en el orden de booteo de UEFI resueltas con asistencia. | No logra arrancar el sistema instalado. |
| **Rigor Técnico y Respuestas (Mód. 5)** | Respuestas fundamentadas con terminología técnica precisa (UEFI, ESP, ext4, inodos, swapfile). | Respuestas correctas con redacción informal o vocabulario básico. | Respuestas incompletas o con errores conceptuales en sistemas de archivos. | No responde el cuestionario o presenta copias textuales sin comprensión. |
