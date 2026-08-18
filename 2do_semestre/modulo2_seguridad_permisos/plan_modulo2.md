# Módulo 2: Seguridad, Permisos y Gestión de Usuarios

## 📌 Objetivos del Módulo
1. Comparar los modelos de seguridad NTFS (Windows 11) y POSIX (Linux).
2. Comprender la herencia de permisos, Listas de Control de Acceso (ACL), propietarios y permisos octales/simbólicos.
3. Administrar cuentas de usuario, grupos y asignación de privilegios desde CLI.
4. Experimentar con mecanismos de elevación de privilegios (UAC vs `sudo`) y auditoría de accesos.

---

## 🗂️ Estructura del Módulo por Entorno Operativo

### 🪟 Bloque 1: Windows 11 (Host Nativo)
* **[Clase 1 (Miércoles)](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo2_seguridad_permisos/windows/clase1):** Cuentas de usuario locales, grupos de seguridad, identificadores SID, base SAM y Control de Cuentas de Usuario (UAC / Token Filtrado vs Elevado).
  - Herramientas: `whoami`, `net user`, `net localgroup`, `Get-LocalUser`, `New-LocalUser`.
* **[Clase 2 (Jueves)](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo2_seguridad_permisos/windows/clase2):** Permisos NTFS, Listas de Control de Acceso (DACL/SACL), reglas ACE, herencia (`/inheritance:d|r`), toma de posesión y matriz de precedencia (Deny > Allow).
  - Herramientas: `icacls`, `takeown`, `Get-Acl`, `Set-Acl`.

### 🐧 Bloque 2: Linux (Lubuntu Live USB Persistente)
* **[Clases Linux](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo2_seguridad_permisos/linux):** Modelo de seguridad POSIX, permisos octales/simbólicos (`chmod`), propietarios (`chown`, `chgrp`), máscara `umask`, permisos especiales (SUID, SGID, Sticky Bit), administración de cuentas (`/etc/passwd`, `/etc/shadow`, `useradd`) y elevación con `sudo` (`/etc/sudoers`).
