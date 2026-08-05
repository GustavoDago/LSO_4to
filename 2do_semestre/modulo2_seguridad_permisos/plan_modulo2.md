# Módulo 2: Seguridad, Permisos y Gestión de Usuarios

## 📌 Objetivos del Módulo
1. Comparar los modelos de seguridad NTFS (Windows 11) y POSIX (Linux).
2. Comprender la herencia de permisos, Listas de Control de Acceso (ACL), propietarios y permisos octales/simbólicos.
3. Administrar cuentas de usuario, grupos y asignación de privilegios desde CLI.
4. Experimentar con mecanismos de elevación de privilegios (UAC vs `sudo`) y auditoría de accesos.

---

## 📅 Contenidos Específicos
* **Permisos en Windows 11 (NTFS / ACL):** Lectura, Escritura, Modificación, Control Total, permisos especiales. Comandos `icacls`, `Get-ACL`, `Set-ACL`.
* **Permisos en Linux (POSIX):** Usuario (*owner*), Grupo (*group*), Otros (*others*). Permisos de lectura (`r`), escritura (`w`), ejecución (`x`). Comandos `chmod`, `chown`, `chgrp`, `umask`.
* **Usuarios y Grupos:** Cuentas locales, grupos del sistema, creación y modificación (`net user` / `useradd`, `usermod`).
* **Elevación e Identidad:** Control de cuentas de usuario (UAC) en Windows 11 vs. `sudo` / `su` en Linux.
