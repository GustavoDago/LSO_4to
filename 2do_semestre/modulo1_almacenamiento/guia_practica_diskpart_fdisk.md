# Guía Práctica de Laboratorio: Administración de Almacenamiento y Particionamiento (Windows 11 & Linux)

## 🎯 Objetivo Práctico
Crear, formatear y montar particiones virtuales utilizando herramientas de consola en Windows 11 (`diskpart` / PowerShell) y Linux (`fdisk` / `mkfs` en WSL2), sin modificar el disco físico congelado.

---

## 🛠️ Parte A: Almacenamiento en Windows 11 (VHD & Diskpart)

### Paso 1: Crear un Disco Virtual (VHD) para la Práctica
Abre PowerShell como Administrador y ejecuta:

```powershell
# Crear un disco virtual de 1 GB en la carpeta temporal
New-VHD -Path "C:\Temp\DiscoPrueba.vhd" -SizeBytes 1GB -Dynamic

# Montar el VHD en el sistema
Mount-VHD -Path "C:\Temp\DiscoPrueba.vhd"
```

### Paso 2: Administrar con `diskpart`
Abre una ventana de comandos de Windows (`cmd`) o ejecútalo dentro de PowerShell:

```cmd
diskpart
list disk
select disk <Número_de_disco_VHD>
clean
convert gpt
create partition primary size=500
format fs=ntfs quick label="Datos_LSO"
assign letter=Z
exit
```

### Paso 3: Inspección desde PowerShell
```powershell
Get-Disk | Where-Object IsVirtual -eq $true
Get-Partition -DriveLetter Z
Get-Volume -DriveLetter Z
```

---

## 🐧 Parte B: Almacenamiento en Linux (WSL2 / Ubuntu)

### Paso 1: Inspección de Bloques de Almacenamiento
Abre la consola de WSL2 (Ubuntu) y ejecuta:

```bash
# Listar todos los dispositivos de bloques y puntos de montaje
lsblk -f

# Inspeccionar el espacio en disco en formato legible
df -h
```

### Paso 2: Crear un Archivo de Imagen de Disco y Montarlo en Loopback
Para practicar particionamiento y formateo en Linux sin arriesgar el disco del sistema:

```bash
# 1. Crear un archivo vacío de 512 MB
dd if=/dev/zero of=~/disco_virtual.img bs=1M count=512

# 2. Particionar con fdisk
fdisk ~/disco_virtual.img
# Dentro de fdisk: presiona 'n' (nueva partición), Enter (acepta defaults), 'w' (guardar y salir).

# 3. Formatear como EXT4
sudo mkfs.ext4 ~/disco_virtual.img

# 4. Crear un punto de montaje y montar
sudo mkdir -p /mnt/disco_lso
sudo mount -o loop ~/disco_virtual.img /mnt/disco_lso

# 5. Verificar montaje
df -h /mnt/disco_lso
```

---

## 📋 Consignas de Entrega
1. Adjuntar captura de pantalla de la ejecución de `diskpart` con el VHD formateado como NTFS en la letra `Z:`.
2. Adjuntar captura de la terminal de Linux con el archivo loopback formateado como `EXT4` y montado en `/mnt/disco_lso`.
3. Responder brevemente: ¿Qué diferencia existe entre un inodo en EXT4 y la MFT (*Master File Table*) en NTFS?
