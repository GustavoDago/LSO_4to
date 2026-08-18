# Módulo 2: Seguridad y Permisos en Linux (Lubuntu Live USB Persistente)

## 📌 Próximas Clases (Semana de Implementación de Pendrives)
Prácticas de seguridad, permisos POSIX y administración de identidades en Linux ejecutadas desde el pendrive persistente.

### 📅 Contenidos Previstos:
- **Modelo de Seguridad POSIX:** Propietario (*user/owner*), Grupo (*group*) y Otros (*others*).
- **Gestión de Permisos:** Lectura (`r`), Escritura (`w`), Ejecución (`x`). Notación octal (ej. `755`, `640`) y simbólica (`u+rwx`, `g-w`, `o=r`). Comandos `chmod`, `chown`, `chgrp`.
- **Máscara de Creación:** Cálculo de permisos por defecto con `umask`.
- **Permisos Especiales:** SUID (`4xxx`), SGID (`2xxx`) y Sticky Bit (`1xxx` en `/tmp`).
- **Administración de Usuarios y Grupos:** `/etc/passwd`, `/etc/shadow`, `/etc/group`. Comandos `useradd`, `usermod`, `userdel`, `groupadd`, `passwd`.
- **Elevación de Privilegios:** Configuración de `/etc/sudoers` (`visudo`), diferencias entre `su`, `sudo -i` y UAC de Windows.
