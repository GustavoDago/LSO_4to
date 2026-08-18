# Módulo 1: Almacenamiento en Linux (Lubuntu Live USB Persistente)

## 📌 Próximas Clases (Semana de Implementación de Pendrives)
Una vez que los alumnos dispongan de sus unidades USB configuradas con **Lubuntu / Linux Mint XFCE Persistente**, se desarrollarán las prácticas de almacenamiento en entorno Linux nativo.

### 📅 Contenidos Previstos:
- **Dispositivos de Bloque:** Reconocimiento de unidades y discos (`lsblk`, `fdisk -l`, `/dev/sdX`, `/dev/nvmeXn1`).
- **Particionamiento:** Creación de tablas de particiones MBR y GPT con `fdisk` y `parted`.
- **Sistemas de Archivos Linux:** Formateo en `ext4`, `vfat` y `btrfs` (`mkfs.ext4`, `mkfs.vfat`).
- **Puntos de Montaje y Persistencia:** Montaje manual y automático (`mount`, `umount`, `/etc/fstab`, imágenes loop con `losetup`).
- **Mantenimiento y Diagnóstico:** Chequeo del sistema de archivos (`fsck`) y monitoreo de espacio e inodos (`df -h`, `df -i`, `du -sh`).
