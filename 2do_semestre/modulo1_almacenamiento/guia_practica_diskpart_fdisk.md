# Guía Práctica de Laboratorio: Administración de Almacenamiento y Particionamiento (Windows 11 & Linux)

## 🎯 Objetivo Práctico
Crear, formatear y montar particiones virtuales utilizando herramientas nativas de consola en Windows 11 (`diskpart` en CMD / PowerShell) y Linux (`fdisk` / `mkfs.ext4` en Live USB), garantizando la integridad de las computadoras del laboratorio sin requerir permisos de Hyper-V ni alterar Deep Freeze.

---

## 🛠️ Parte A: Almacenamiento en Windows 11 (VHD & Diskpart)

### Paso 1: Crear y Adjuntar el Disco Virtual (VHD) con `diskpart`
Abre una ventana de **Símbolo del sistema (CMD)** como Administrador y ejecuta:

```cmd
diskpart
```

Dentro del intérprete interactivo de `diskpart`:

```cmd
REM 1. Crear un disco virtual dinámico de 1024 MB (o 128 MB en netbooks)
create vdisk file="C:\Temp\DiscoPrueba.vhdx" maximum=1024 type=expandable

REM 2. Seleccionar y adjuntar el disco virtual al sistema operativo
select vdisk file="C:\Temp\DiscoPrueba.vhdx"
attach vdisk
```

### Paso 2: Particionar y Formatear con NTFS en formato GPT
Continuando dentro de `diskpart`:

```cmd
REM 3. Inicializar la tabla de particiones en formato moderno GPT
convert gpt

REM 4. Crear la partición primaria
create partition primary

REM 5. Formatear rápidamente con sistema de archivos NTFS
format fs=ntfs quick label="Datos_LSO"

REM 6. Asignar la letra de unidad Z:
assign letter=Z

REM 7. Salir de diskpart
exit
```

### Paso 3: Inspección y Diagnóstico desde PowerShell
Abre **PowerShell** y verifica la nueva unidad montada:

```powershell
# Comprobar particiones y volúmenes montados
Get-Partition -DriveLetter Z
Get-Volume -DriveLetter Z
```

---

## 🐧 Parte B: Almacenamiento en Linux (Live USB Lubuntu / Mint)

### Paso 1: Inspección de Bloques de Almacenamiento
Inicia la PC con tu pendrive mediante el **Boot Menu (F12/F11/Esc)**, abre la terminal de Linux y ejecuta:

```bash
# Listar todos los dispositivos de bloques, UUIDs y puntos de montaje
lsblk -f

# Inspeccionar el espacio en disco en formato legible para humanos
df -h
```

### Paso 2: Crear un Archivo de Imagen de Disco y Montarlo en Loopback
Para practicar particionamiento y formateo en Linux con total seguridad:

```bash
# 1. Crear un archivo contenedor de ceros de 512 MB (o 64 MB en netbooks)
dd if=/dev/zero of=~/disco_virtual.img bs=1M count=512

# 2. Particionar la imagen con fdisk
fdisk ~/disco_virtual.img
# Dentro del menú interactivo de fdisk:
# - Presiona 'n' (para crear nueva partición)
# - Presiona 'p' o 'Enter' para aceptar valores por defecto
# - Presiona 'w' (para escribir la tabla de particiones y salir)

# 3. Formatear el contenedor como EXT4
sudo mkfs.ext4 ~/disco_virtual.img

# 4. Crear un directorio como punto de montaje y asociarlo en modo loopback
sudo mkdir -p /mnt/disco_lso
sudo mount -o loop ~/disco_virtual.img /mnt/disco_lso

# 5. Verificar el montaje activo y sus inodos
df -h /mnt/disco_lso
df -i /mnt/disco_lso
```

---

## 📋 Consignas de Entrega
1. Adjuntar captura de pantalla de la ejecución de `diskpart` con el VHD formateado en GPT como NTFS en la letra `Z:`.
2. Adjuntar captura de la terminal de Linux con el archivo loopback formateado como `EXT4`, montado en `/mnt/disco_lso` y mostrando la tabla de inodos con `df -i`.
3. Responder con justificación técnica: ¿Qué diferencia existe entre el concepto de inodo en EXT4 y la tabla maestra de archivos (MFT) en NTFS?
