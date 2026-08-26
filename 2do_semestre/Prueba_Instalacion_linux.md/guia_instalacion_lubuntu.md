# Guía de Laboratorio: Instalación de Lubuntu en Dual-Boot (Windows 11 / Linux)

* **Materia:** Laboratorio de Sistemas Operativos (LSO) - 4.º Año
* **Especialidad:** Tecnicatura en Informática Personal y Profesional
* **Destinatarios:** Alumnos y Docentes de LSO
* **Propósito:** Implementar una configuración de **Arranque Dual (Dual-Boot)** en almacenamiento físico o entornos de prueba, cubriendo de forma secuencial la **reducción de volumen en Windows**, la **evaluación en modo Live ("Probar Lubuntu")** y el **proceso técnico de particionamiento e instalación definitiva con Calamares**, preservando la integridad del sistema operativo anfitrión.

---

## 🧭 1. Arquitectura Conceptual: ¿Cómo funciona el Dual-Boot en UEFI/GPT?

En computadoras modernas con arquitectura **UEFI** y tabla de particiones **GPT** (*GUID Partition Table*), dos o más sistemas operativos pueden convivir en el mismo disco rígido o SSD sin destruirse mutuamente:

```
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                             DISCO FÍSICO (SSD / NVMe / HDD)                              │
├───────────────┬──────────────────────────┬─────────────────────────────┬─────────────────┤
│ Partición EFI │ Partición NTFS           │ Partición EXT4              │ Swap / Libre    │
│ (/boot/efi)   │ (Windows 11 / C:)        │ (Lubuntu - Raíz "/")        │ (Mem. Virtual)  │
│ FAT32 (~100MB)│ Archivos de Windows      │ Sistema de archivos Linux   │ 2 GB - 4 GB     │
├───────────────┴──────────────────────────┴─────────────────────────────┴─────────────────┤
│ Gestor de Arranque UEFI: GRUB2 detecta Windows Boot Manager y Lubuntu al encender la PC. │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

* **Partición del Sistema EFI (ESP):** Partición formateada en FAT32 que aloja los ejecutables de arranque (`.efi`). Linux (`grubx64.efi`) y Windows (`bootmgfw.efi`) comparten esta partición sin sobreescribirse.
* **Sistemas de Archivos Coexistentes:** Windows opera en **NTFS** y Lubuntu en **EXT4**. Linux puede leer y escribir particiones NTFS; Windows ignora EXT4 de forma nativa.
* **Aislamiento de Kernel:** Cada sistema operativo posee su propio Kernel, controladores y subsistema de archivos en particiones separadas.

---

## 🧰 Requisitos Previos y Medidas de Seguridad

1. **Pendrive Booteable de Lubuntu:** Creado previamente con Rufus (modo GPT/UEFI) o Ventoy.
2. **Espacio Libre Mínimo en Disco:** Al menos **20 GB a 30 GB** de espacio no asignado (en netbooks escolares se puede trabajar con un mínimo de **15 GB**).
3. **Respaldo de Datos Críticos:** Todo procedimiento que manipule tablas de particiones debe realizarse con precaución y copias de seguridad de datos importantes.

> [!CAUTION]
> **Paso Crítico de Seguridad en Windows: Desactivar "Inicio Rápido" (Fast Startup)**
> Windows 11 no se apaga completamente por defecto; hiberna el Kernel en un archivo (`hiberfil.sys`) y bloquea la partición NTFS en modo solo-lectura. Si Linux intenta montar un disco NTFS hibernado, se corre riesgo de corrupción de datos.
>
> **Cómo desactivarlo desde CMD o PowerShell como Administrador:**
> ```cmd
> powercfg /h off
> ```
> *(Este comando desactiva la hibernación y el inicio rápido, garantizando que el disco quede liberado para operaciones de particionado seguro).*

---

## 🪟 FASE 1: Creación de Espacio Libre en Disco (Desde Windows)

Antes de iniciar el instalador de Linux, debemos achicar la partición de Windows para generar un bloque de **Espacio No Asignado** (*Unallocated Space*).

### Método 1: Mediante la Interfaz Gráfica (Administración de Discos)

1. Presiona la combinación de teclas `Win + X` y selecciona **Administración de discos** (o presiona `Win + R`, escribe `diskmgmt.msc` y presiona **Enter**).
2. Localiza el disco principal (generalmente `Disco 0`) y la partición del sistema `(C:)`.
3. Haz clic derecho sobre el volumen `(C:)` y selecciona **Reducir volumen...** (*Shrink Volume*).
4. El sistema calculará el espacio disponible para reducción.
5. En el campo **"Tamaño del espacio que desea reducir en MB"**, ingresa la cantidad adecuada:
   * Para liberar **20 GB:** Ingresa `20480`
   * Para liberar **30 GB:** Ingresa `30720`
   * Para liberar **50 GB:** Ingresa `51200`
   * En netbooks con disco chico (ej. 128 GB SSD): Ingresa entre `15360` (15 GB) y `20480` (20 GB).
6. Haz clic en **Reducir**.
7. **Verificación:** Observarás un nuevo bloque de color negro etiquetado como **"No asignado"** (*Unallocated*).
   > [!IMPORTANT]
   > **NO crees una nueva partición NTFS ni le asignes letra de unidad.** Déjalo exactamente como "No asignado". El instalador de Lubuntu utilizará este espacio libre directamente.

```
┌───────────────────────────────┬───────────────────────────────┐
│ Partición (C:) Reducida       │ ESPACIO NO ASIGNADO (NEGRO)   │
│ Formato: NTFS (Activo)        │ 20 GB - 30 GB Libres          │
│ Sistema Windows 11            │ 👉 DESTINADO A LUBUNTU        │
└───────────────────────────────┴───────────────────────────────┘
```

### Método 2: Mediante Línea de Comandos (`diskpart`)

Para administradores de sistemas y alumnos de 4.º año que operan desde terminal de consola:

```cmd
REM 1. Abrir CMD como Administrador e iniciar diskpart
diskpart

REM 2. Listar discos y seleccionar el disco principal
list disk
select disk 0

REM 3. Listar particiones y seleccionar la partición C:
list partition
select partition 3    (Nota: Seleccionar el número correspondiente al volumen C: del sistema)

REM 4. Reducir el volumen en 25 GB (25600 MB)
shrink desired=25600

REM 5. Verificar que se haya liberado el espacio
detail disk
exit
```

---

## 🐧 FASE 2: Arranque y Prueba del Sistema Operativo ("Probar Lubuntu")

Nunca instalamos un sistema operativo a ciegas. La modalidad **Live Session** permite comprobar compatibilidad de hardware, conectividad, audio, gráficos y discos sin escribir un solo byte en el almacenamiento interno.

### Paso 1: Iniciar desde el Pendrive mediante el Boot Menu

1. Conecta el pendrive booteable en un puerto USB (preferentemente USB 3.0).
2. Enciende el equipo y pulsa repetidamente la tecla de acceso al **Menú de Arranque temporal**:
   * **HP / Compaq:** `F9` o `Esc`
   * **Lenovo / ThinkPad:** `F12` (o botón Novo / `Fn + F12`)
   * **Dell:** `F12`
   * **Asus:** `F8` o `Esc`
   * **Acer:** `F12`
   * **Exomate / Netbooks Escolares (BGH, Juana Manso):** `F11` o `F12`
3. Selecciona la entrada UEFI de tu pendrive USB (ej. *UEFI: Kingston DataTraveler*) y presiona **Enter**.
4. En el menú GRUB de bienvenida, selecciona **"Try or Install Lubuntu"** y presiona **Enter**.

---

### Paso 2: Entorno de Escritorio Live (LXQt) y Verificación Técnica

El sistema cargará completamente en la memoria RAM. Verás el escritorio minimalista de Lubuntu (LXQt).

```
┌────────────────────────────────────────────────────────────────────────┐
│ [ Escritorio Lubuntu Live - LXQt ]                                     │
│                                                                        │
│   💽 Install Lubuntu 24.04 LTS (Acceso directo para instalar)          │
│                                                                        │
│   Terminal: Ctrl + Alt + T                                             │
│                                                                        │
├────────────────────────────────────────────────────────────────────────┤
│ [Menú Inicio]  [Terminal]  [Navegador]         [ES] [📶 100%] [🔊] 19:30│
└────────────────────────────────────────────────────────────────────────┘
```

### Protocolo de Pruebas de Hardware en Laboratorio:

Abre una terminal (`Ctrl + Alt + T`) y ejecuta las siguientes verificaciones:

1. **Prueba de Conectividad de Red y Wi-Fi:**
   * Haz clic en el icono de red en la bandeja del sistema (esquina inferior derecha) y conéctate a la red Wi-Fi del laboratorio, o conecta el cable Ethernet.
   * Ejecuta en terminal:
     ```bash
     ping -c 3 google.com
     ```
2. **Inspección de Dispositivos de Bloque y Espacio Libre:**
   * Ejecuta:
     ```bash
     lsblk -f
     ```
   * **Qué buscar:** Identifica el disco local (`/dev/sda` o `/dev/nvme0n1`). Debes distinguir las particiones NTFS de Windows y confirmar que existe un segmento sin particionar correspondiente al espacio no asignado que creamos en la Fase 1.
3. **Prueba de Pantalla, Teclado y Audio:**
   * Verifica que la resolución de pantalla sea la nativa (en *Menú > Preferencias > Configuración de monitor LXQt*).
   * Comprueba la distribución del teclado escribiendo caracteres especiales en terminal: `|`, `@`, `#`, `~`, `/`, `\`.
   * Abre un reproductor de sonido o prueba un video en el navegador web para validar el chip de audio.

---

## 💿 FASE 3: Instalación Paso a Paso de Lubuntu (Calamares Installer)

Una vez validado que todo el hardware funciona de manera fluida, procedemos con la instalación definitiva en el disco.

### Paso 1: Lanzar el Instalador
Haz doble clic sobre el icono del escritorio **"Install Lubuntu XX.XX LTS"**. Se abrirá el asistente gráfico de instalación **Calamares**.

---

### Paso 2: Configuración Regional e Idioma
1. **Bienvenido:** Selecciona **Español (Spanish)** en el menú desplegable lateral izquierdo y haz clic en **Siguiente**.
2. **Ubicación:** 
   * Región: **América**
   * Zona horaria: **Argentina / Buenos Aires** (o haz clic sobre el mapa en Buenos Aires).
   * Configuración regional: `es_AR.UTF-8`. Haz clic en **Siguiente**.
3. **Teclado:**
   * Modelo de teclado: **Genérico de 105 teclas (PC)**.
   * Distribución: **Español** o **Español (Latinoamericano)**.
   * *Prueba obligatoria:* Haz clic en la caja de texto inferior y escribe `@` (`AltGr + Q` o `AltGr + 2`), `\`, `/` y tildes (`á`, `é`). Cuando coincida exactamente con tu teclado físico, haz clic en **Siguiente**.

---

### Paso 3: Particionado del Disco (Punto Crítico)

Calamares presentará la pantalla de selección de almacenamiento. Asegúrate de tener seleccionado el disco de almacenamiento interno correcto en el menú desplegable superior (ej. `Disco /dev/nvme0n1` o `/dev/sda`, **¡NO selecciones tu pendrive USB `/dev/sdb`!**).

Se presentan dos alternativas de particionado:

```
┌──────────────────────────────────────────────────────────────────────────┐
│ SELECCIÓN DE MÉTODO DE PARTICIONADO EN CALAMARES                         │
├──────────────────────────────────────────────────────────────────────────┤
│ ( ) Instalar junto a Windows Boot Manager (Modo Automático)              │
│ ( ) Reemplazar una partición                                             │
│ ( ) Borrar disco (⚠️ ¡ELIMINA WINDOWS Y TODOS LOS DATOS!)                │
│ (•) Particionado manual (Recomendado para 4.º Año - Control Total)      │
└──────────────────────────────────────────────────────────────────────────┘
```

---

#### 🛠️ Opción A: Particionado Manual (Recomendada para Nivel Técnico)

El particionado manual brinda comprensión exacta de la estructura de archivos en sistemas UNIX/Linux:

1. Selecciona **Particionado manual** y haz clic en **Siguiente**.
2. Verás la tabla gráfica de particiones del disco:
   * Identifica la partición EFI existente (Formato: `fat32`, Etiqueta: `ESP` o `System`, Tamaño: `~100 MB - 512 MB`, Bandera: `boot, esp`).
   * Localiza el bloque de **Espacio Libre** (*Free Space*) de 20 GB a 30 GB que dejamos en la Fase 1.

3. **Configurar la Partición EFI existente:**
   * Haz clic sobre la partición EFI (`/dev/sda1` o `/dev/nvme0n1p1`).
   * Haz clic en **Editar**.
   * Punto de montaje: Selecciona `/boot/efi`.
   * Sistema de archivos: Mantener `fat32`.
   * Banderas: Marcar `boot` / `esp`.
   > [!CAUTION]
   > **¡NO MARQUES LA CASILLA "FORMATEAR"!** Si formateas la partición EFI, borrarás el cargador de arranque de Windows (`bootmgfw.efi`) y Windows no podrá iniciar. Solo debes montarla.

4. **Crear la Partición Raíz (`/`) de Lubuntu:**
   * Haz clic sobre el **Espacio Libre** (*Free Space*).
   * Haz clic en **Crear**.
   * Tamaño: Si vas a usar archivo de intercambio (*swapfile*), asigna todo el espacio disponible (ej. `25000 MB`). Si prefieres partición swap dedicada, reserva `2048 MB` a `4096 MB` y asigna el resto a la raíz.
   * Tipo de partición: **Primaria**.
   * Sistema de archivos: **`ext4`**.
   * Punto de montaje: Selecciona **`/`** (barra diagonal = raíz del sistema).
   * Banderas: Marcar `root`.
   * Haz clic en **Aceptar**.

5. *(Opcional)* **Crear Partición Swap (Área de Intercambio):**
   * *Nota técnica:* Las versiones modernas de Lubuntu / Ubuntu configuran automáticamente un archivo `swapfile` dinámico dentro de la raíz `/`. No obstante, si el docente solicita partición física dedicada:
   * Haz clic en el espacio libre restante, selecciona **Crear**, Sistema de archivos: **`linuxswap`**, Banderas: `swap`.

6. **Ubicación del Cargador de Arranque (GRUB):**
   * En la parte inferior, verifica que el campo *"Instalar cargador de arranque en:"* apunte a la partición del sistema EFI (`/boot/efi`) o al disco principal (`/dev/sda` / `/dev/nvme0n1`).

---

#### ⚡ Opción B: Modo Asistido ("Instalar junto a...")

Si prefieres la modalidad automatizada:
1. Selecciona la opción **"Instalar junto a Windows Boot Manager"**.
2. Calamares detectará el espacio no asignado y preconfigurará la partición EXT4 y la vinculación a la partición EFI de forma automática.
3. Haz clic en **Siguiente**.

---

### Paso 4: Creación de la Cuenta de Usuario
Completa los datos de la cuenta administradora local:
* **¿Cuál es su nombre?:** Nombre del alumno / grupo (ej. `Alumno LSO`).
* **¿Cuál es el nombre de usuario que desea usar para iniciar sesión?:** `alumno` (en minúsculas, sin espacios ni caracteres especiales).
* **¿Cuál es el nombre de este equipo?:** `pc-lso-01` (nombre de host / *hostname* para identificar la máquina en la red local).
* **Elija una contraseña:** Contraseña segura (ej. `Tecnica2026!` o la designada por el docente).
* Marca la opción **"Pedir una contraseña para iniciar sesión"** (por seguridad de auditoría).
* *(Opcional)* Marca *"Usar la misma contraseña para la cuenta de administrador (root)"*.
* Haz clic en **Siguiente**.

---

### Paso 5: Pantalla de Resumen y Confirmación de Escritura
Calamares mostrará un informe exhaustivo con:
* Ubicación y teclado seleccionados.
* Cambios en la tabla de particiones (Particiones que se crean, formatean o preservan).
* Ubicación de instalación de GRUB.

> [!WARNING]
> Revisa detenidamente que las particiones de Windows (formato `ntfs` o `bitlocker`) figuren como **"Preservar"** y **NUNCA** como "Borrar" o "Formatear".

Haz clic en el botón **Instalar** y luego confirma en el cuadro de diálogo: **"Instalar ahora"**.

---

### Paso 6: Proceso de Instalación y Finalización
1. Calamares desempaquetará la imagen del sistema, creará el sistema de archivos EXT4, configurará los usuarios, compilará el `initramfs` e instalará el menú de arranque GRUB2.
2. Una vez completado al 100%, verás el mensaje: **"¡Todo listo! Lubuntu ha sido instalado en su equipo."**
3. Marca la casilla **"Reiniciar ahora"** y haz clic en **Hecho**.
4. La pantalla se pondrá en negro y aparecerá el aviso:
   ```text
   Please remove the installation medium, then press ENTER:
   ```
5. **Retira el pendrive USB del puerto y presiona la tecla Enter.**

---

## 🚀 FASE 4: Verificación Post-Instalación y Diagnóstico del Arranque Dual

### 1. El Menú de Arranque GRUB
Al encender o reiniciar la computadora, se desplegará el menú del cargador de arranque **GRUB2**:

```
                   GNU GRUB version 2.12
 ┌────────────────────────────────────────────────────────────┐
 │ *Lubuntu                                                   │
 │  Opciones avanzadas para Lubuntu                           │
 │  Memory test (memtest86+x64.efi)                           │
 │  Windows Boot Manager (on /dev/nvme0n1p1)                  │
 │  UEFI Firmware Settings                                    │
 └────────────────────────────────────────────────────────────┘
    Use the ↑ and ↓ keys to select which entry is highlighted.
    Press enter to boot the selected OS.
```

* **Prueba 1:** Selecciona **Windows Boot Manager** y presiona Enter. Comprueba que Windows 11 inicie con todas sus aplicaciones y archivos intactos.
* **Prueba 2:** Reinicia el equipo, selecciona **Lubuntu** en el menú GRUB e inicia sesión con tu usuario y contraseña.

---

### 2. Primeros Comandos de Puesta a Punto en Lubuntu
Abre una terminal (`Ctrl + Alt + T`) en tu nuevo Lubuntu y ejecuta:

```bash
# 1. Actualizar el índice de repositorios y paquetes instalados
sudo apt update && sudo apt upgrade -y

# 2. Instalar herramientas esenciales de diagnóstico y laboratorio
sudo apt install -y htop neofetch tree curl git net-tools

# 3. Comprobar la información del sistema y el Kernel
neofetch
uname -r

# 4. Inspeccionar las particiones montadas y el UUID del sistema
lsblk -f
```

---

### 3. Resolución de Problemas Comunes (Troubleshooting)

| Síntoma / Problema | Causa Raíz | Solución Técnica |
| :--- | :--- | :--- |
| **La PC arranca directo en Windows sin mostrar el menú GRUB.** | El gestor de arranque de Windows quedó configurado con mayor prioridad en el firmware NVRAM de UEFI. | Entra al BIOS/UEFI (`F2`, `F10` o `Del`) > pestaña *Boot Priority* > Coloca **"ubuntu" / "Lubuntu"** como primera opción de arranque sobre "Windows Boot Manager". |
| **GRUB no muestra la opción de Windows Boot Manager.** | `os-prober` viene desactivado por defecto en algunas versiones de GRUB por seguridad. | En terminal de Lubuntu ejecuta:<br>`sudo nano /etc/default/grub`<br>Agrega o descomenta la línea: `GRUB_DISABLE_OS_PROBER=false`<br>Guarda (`Ctrl+O`, `Enter`, `Ctrl+X`) y corre: `sudo update-grub`. |
| **Las particiones de Windows se montan en Linux en Modo Solo-Lectura.** | Windows tiene activo el *Fast Startup* o no se apagó de forma limpia. | Inicia en Windows y ejecuta en CMD como Administrador: `powercfg /h off`. Luego reinicia el equipo con normalidad. |

---

## 🎮 Repaso Gamificado: Kahoot de Evaluación Técnica (10 Preguntas)

Cuestionario para afianzar los conceptos técnicos de la práctica. Cada pregunta cuenta con 4 opciones estructuradas y su fundamentación pedagógica.

### Pregunta 1
**¿Por qué es indispensable desactivar el "Inicio Rápido" (Fast Startup) en Windows antes de instalar Linux en Dual-Boot?**
* A) Porque acelera la velocidad del procesador al instalar paquetes en Linux.
* B) *(Correcta)* Porque hiberna el Kernel de Windows bloqueando la partición NTFS, lo que puede provocar corrupción de datos si Linux accede a ella.
* C) Porque de lo contrario el BIOS bloquea los puertos USB e impide bootear el pendrive.
* D) Porque Linux no puede leer tablas de particiones si Windows está en modo suspensión.
> **Fundamentación:** El Fast Startup de Windows deja las particiones NTFS marcadas como "en uso/hibernadas", lo que fuerza a Linux a montarlas en solo lectura o arriesgar inconsistencias en el sistema de archivos.

---

### Pregunta 2
**Al reducir el volumen de Windows en `diskmgmt.msc`, ¿cómo debe quedar el espacio liberado para que el instalador de Linux lo utilice?**
* A) Formateado en NTFS y con una letra de unidad asignada (ej. `Z:`).
* B) Formateado en FAT32 con etiqueta "LINUX".
* C) *(Correcta)* Como "Espacio No Asignado" (*Unallocated Space*), sin partición ni formato previo.
* D) Como una partición extendida con formato RAW.
> **Fundamentación:** El espacio sin asignar permite que el instalador de Linux (Calamares) cree libremente las particiones nativas necesarias (`ext4`, `swap`, etc.) con sus propios esquemas y metadatos.

---

### Pregunta 3
**¿Cuál es la función principal de la partición EFI System Partition (ESP) en un arranque dual moderno con UEFI?**
* A) Servir de memoria virtual de intercambio cuando la RAM se satura.
* B) Guardar los archivos de usuario personales del directorio `/home`.
* C) *(Correcta)* Alojar los ejecutables binarios de arranque (`.efi`) de ambos sistemas operativos en formato FAT32 para que el firmware UEFI los cargue.
* D) Almacenar las copias de seguridad del Registro de Windows.
> **Fundamentación:** La ESP es la partición estandarizada por el consorcio UEFI donde conviven los cargadores de arranque de múltiples sistemas operativos (`/EFI/Microsoft/` y `/EFI/ubuntu/`).

---

### Pregunta 4
**Durante el particionado manual en Calamares, ¿qué acción NUNCA se debe realizar sobre la partición EFI existente de Windows?**
* A) Asignarle el punto de montaje `/boot/efi`.
* B) *(Correcta)* Marcar la casilla "Formatear".
* C) Marcar la bandera de arranque `boot` o `esp`.
* D) Seleccionarla para comprobar su tamaño en megabytes.
> **Fundamentación:** Si se formatea la partición EFI, se destruyen los binarios de arranque de Windows (`bootmgfw.efi`) y el sistema Windows quedará imposibilitado para iniciar.

---

### Pregunta 5
**¿Qué ventaja técnica ofrece la modalidad Live ("Probar Lubuntu") antes de proceder con la instalación definitiva?**
* A) Instala de forma permanente los controladores de video en el disco duro.
* B) Formatea automáticamente los discos defectuosos.
* C) *(Correcta)* Ejecuta el sistema operativo en memoria RAM para validar la compatibilidad de hardware (Wi-Fi, audio, video) sin alterar el disco.
* D) Duplica la memoria swap del almacenamiento secundario.
> **Fundamentación:** La sesión Live carga una imagen de solo lectura en RAM que permite diagnosticar periféricos y componentes antes de realizar modificaciones en el almacenamiento físico.

---

### Pregunta 6
**¿Cuál es el sistema de archivos nativo recomendado para la partición raíz (`/`) de Lubuntu?**
* A) NTFS
* B) FAT32
* C) *(Correcta)* EXT4 (Fourth Extended Filesystem)
* D) exFAT
> **Fundamentación:** `ext4` es el sistema de archivos estándar de Linux, compatible con journaling transaccional, permisos POSIX nativos, inodos y enlaces simbólicos/duros.

---

### Pregunta 7
**¿Qué componente de software se encarga de mostrar la pantalla de selección para elegir entre Lubuntu y Windows al encender la computadora?**
* A) `systemd-sysv`
* B) *(Correcta)* GRUB2 (*Grand Unified Bootloader*)
* C) Disk Management
* D) LXQt Desktop Session
> **Fundamentación:** GRUB2 es el gestor de arranque multietapa que lee la tabla de particiones y los cargadores EFI registrados para ofrecer el menú interactivo de inicio.

---

### Pregunta 8
**¿Qué comando de terminal en Linux permite listar los discos físicos, particiones, tipos de sistemas de archivos y puntos de montaje activos?**
* A) `format /s`
* B) `tasklist /v`
* C) *(Correcta)* `lsblk -f`
* D) `netstat -ano`
> **Fundamentación:** `lsblk -f` (*list block devices*) imprime en árbol los dispositivos de almacenamiento, sus UUIDs, tipos de sistemas de archivos (NTFS, EXT4, FAT32) y sus directorios de montaje.

---

### Pregunta 9
**Si al instalar Lubuntu la computadora arranca directamente en Windows 11 sin mostrar el menú de GRUB, ¿cuál es la solución adecuada?**
* A) Reinstalar Windows desde cero.
* B) Formatear el pendrive en modo MBR.
* C) *(Correcta)* Ingresar a la configuración del BIOS/UEFI y cambiar la prioridad de booteo para colocar a "Lubuntu / ubuntu" en primer lugar.
* D) Borrar la partición del sistema C:.
> **Fundamentación:** En sistemas UEFI, cada sistema registra su entrada en la NVRAM del firmware. Modificar la prioridad de arranque en UEFI restaura a GRUB como el gestor principal.

---

### Pregunta 10
**¿Qué herramienta ejecuta Lubuntu en segundo plano para detectar automáticamente la instalación de Windows y agregarla al menú de GRUB?**
* A) `chkdsk`
* B) *(Correcta)* `os-prober` (mediante `update-grub`)
* C) `calamares-daemon`
* D) `regedit.exe`
> **Fundamentación:** `os-prober` escanea todas las particiones del equipo buscando otros núcleos y cargadores de arranque reconocibles para incorporarlos al archivo `/boot/grub/grub.cfg`.

---

## 📚 Ficha de Estudio y Material Pedagógico (NotebookLM)

> **Cuaderno de Destino:** *LSO 4to - 2do semestre*  
> **Tema:** Implementación de Dual-Boot Seguro (Windows 11 + Lubuntu LXQt).

### 📝 Resumen Ejecutivo
La coexistencia armónica de Windows y Linux en un mismo equipo se fundamenta en la arquitectura **UEFI/GPT**. La reducción de la partición principal de Windows genera un bloque de **espacio no asignado** que el instalador de Linux (**Calamares**) utiliza para crear la partición raíz (**EXT4**). Ambos sistemas conviven utilizando la misma **Partición de Sistema EFI (ESP)** en formato FAT32, orquestados por el gestor de arranque **GRUB2**.

### 🔑 Glosario Técnico Esencial
* **UEFI (Unified Extensible Firmware Interface):** Firmware moderno que reemplaza al BIOS tradicional, soportando discos de más de 2 TB (GPT) y múltiples cargadores de arranque seguros.
* **ESP (EFI System Partition):** Partición FAT32 reservada donde se almacenan los binarios `.efi` de arranque de los sistemas operativos instalados.
* **Calamares:** Instalador gráfico universal de distribuciones Linux independientes y derivadas (Lubuntu, Manjaro, Neon), diseñado para ser modular y seguro en el particionado.
* **GRUB2:** Cargador de arranque universal de Linux capaz de encadenar (*chainload*) el arranque de Windows Boot Manager.
* **EXT4:** Sistema de archivos transaccional con journaling e indexación por árboles HTree, utilizado para el directorio raíz `/` de Linux.
* **Fast Startup:** Característica de Windows que hiberna el núcleo para acelerar el inicio; debe desactivarse en entornos duales para prevenir bloqueos en volúmenes NTFS.

### ❓ Preguntas Guía para el Debate en Laboratorio
1. *¿Por qué un sistema operativo instalado en modo Live corre más rápido en ciertas tareas de I/O pero pierde sus cambios al reiniciar si no se configura persistencia o instalación en disco?*
2. *¿Qué sucedería si asignamos el punto de montaje `/boot/efi` a la partición de Windows `C:` en lugar de la partición FAT32 de ~100 MB?*
3. *¿De qué manera el archivo de intercambio dinámico (`/swapfile`) reemplaza la necesidad de crear particiones físicas `linux-swap` dedicadas en discos SSD modernos?*
