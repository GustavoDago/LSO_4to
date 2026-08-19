# 🎮 Trivia Kahoot: Clase 1 - Usuarios, Grupos, SID, SAM, UAC y Herramientas en Windows 11
**Módulo 2:** Seguridad, Permisos y Gestión de Usuarios  
**Destinatarios:** 4.º Año — Tecnicatura en Informática Personal y Profesional (Educación Técnico-Profesional)  
**Carga Horaria:** 4 Horas Semanales (Laboratorio de Sistemas Operativos)  
**Estructura:** 10 Preguntas de Opción Múltiple (Opciones correctas distribuidas aleatoriamente entre A, B, C y D)

---

### Pregunta 1: Identificador de Seguridad (SID) e Inmutabilidad
**Si en Windows 11 le cambiamos el nombre de usuario a una cuenta de "Carlos" a "Juan_Admin", ¿qué ocurre con sus permisos de acceso sobre las carpetas y archivos del sistema?**
- A) Pierde todos sus permisos anteriores porque las Listas de Control de Acceso (ACL) buscan el nombre de usuario textual.
- B) Windows duplica la cuenta en la base SAM para mantener una copia de respaldo con los permisos anteriores.
- C) Conserva todos sus permisos intactos porque Windows asigna los permisos al SID (*Security Identifier*), el cual es inmutable y no cambia al renombrar la cuenta. ✅ *(Correcta)*
- D) Se produce una denegación de acceso general hasta que el usuario cierre sesión y vuelva a escribir su contraseña en `netplwiz`.

> **Justificación didáctica y técnica:**
> - **C (Correcta):** En la arquitectura NT, los permisos de seguridad se vinculan exclusivamente al SID numérico de la cuenta. El nombre es solo una etiqueta visual; por tanto, renombrar el usuario no altera en absoluto su SID ni sus permisos.
> - **A:** Es un error conceptual frecuente: el sistema de seguridad de Windows no evalúa cadenas de texto con nombres de usuario, sino tokens con SIDs.
> - **B:** La base SAM no duplica cuentas al renombrarlas; actualiza el atributo de nombre sobre el mismo registro de usuario.
> - **D:** No existe bloqueo ni denegación de acceso tras un cambio de nombre en caliente en el equipo local.

---

### Pregunta 2: Almacenamiento Seguro de Credenciales Locales (Base SAM)
**¿En qué ubicación del sistema y base de datos almacena Windows de manera cifrada las cuentas de usuario locales y sus hashes de contraseña?**
- A) En el archivo `%SystemRoot%\System32\config\SAM` gestionado por el subsistema de seguridad local. ✅ *(Correcta)*
- B) En el archivo plano `%ProgramFiles%\Windows NT\users.txt`.
- C) En la base de datos de Directorio Activo `C:\Windows\NTDS\ntds.dit`.
- D) En el archivo de paginación de memoria `C:\pagefile.sys`.

> **Justificación didáctica y técnica:**
> - **A (Correcta):** La base de datos SAM (*Security Accounts Manager*) reside en el registro del sistema (`config\SAM`), bloqueada en tiempo de ejecución por el kernel para proteger las credenciales locales.
> - **B:** Windows nunca almacena credenciales ni cuentas en archivos de texto plano.
> - **C:** `ntds.dit` es exclusivo de Controladores de Dominio (Active Directory en Windows Server), no de equipos locales independientes con Windows 11.
> - **D:** `pagefile.sys` es memoria virtual de intercambio (*paging*), no un almacén de cuentas de seguridad.

---

### Pregunta 3: Estructura del SID y Roles Numéricos (RIDs)
**En un SID con formato `S-1-5-21-3623811015-3361044348-30300820-500`, ¿qué elemento identifica al usuario específico dentro del equipo y a quién corresponde el valor `500`?**
- A) El prefijo `S-1-5` identifica al usuario y el `500` indica que es una cuenta de Invitado (*Guest*).
- B) El número `500` representa el identificador de grupo global asignado a todos los alumnos del colegio.
- C) El número `500` es el puerto TCP utilizado por el subsistema LSASS para validar el inicio de sesión.
- D) El último bloque numérico es el **RID** (*Relative Identifier*) y el valor `500` está reservado exclusivamente para la cuenta de **Administrador integrado** de Windows. ✅ *(Correcta)*

> **Justificación didáctica y técnica:**
> - **D (Correcta):** El último segmento es el RID. Los valores conocidos fijos son `500` para Administrador local integrado, `501` para Invitado (*Guest*) y `1000+` para usuarios creados manualmente.
> - **A:** `S-1-5` corresponde a la autoridad emisora (NT Authority), no al usuario, y el `500` no es Invitado (Invitado es `501`).
> - **B:** Los identificadores de grupo poseen su propia estructura de SID y no utilizan el RID 500 de usuario raíz.
> - **C:** El RID es un número de seguridad en la estructura del SID, no un puerto de red de comunicación.

---

### Pregunta 4: Ciclo de Vida del SID al Eliminar y Recrear Cuentas
**Si un técnico elimina la cuenta local `alumno_4to` y luego crea inmediatamente una nueva cuenta llamada exactamente igual (`alumno_4to`), ¿qué ocurrirá con el acceso a las carpetas privadas que tenía la cuenta original?**
- A) La nueva cuenta tendrá acceso inmediato porque Windows reconoce que tiene el mismo nombre de usuario.
- B) La nueva cuenta recibirá un **nuevo SID único con un RID diferente**, perdiendo el acceso a las carpetas anteriores (apareciendo como un "SID huérfano" en los permisos). ✅ *(Correcta)*
- C) Windows bloqueará la creación del usuario hasta reiniciar el equipo para evitar conflictos de nombres en la base SAM.
- D) Se fusionan automáticamente los Tokens de Seguridad de ambas cuentas para preservar la configuración del usuario.

> **Justificación didáctica y técnica:**
> - **B (Correcta):** Los SIDs son irrepetibles en el tiempo. Al borrar un usuario su SID muere con él. Si se crea una cuenta homónima, recibirá un RID nuevo (ej. 1004 en vez de 1001) y no tendrá acceso a las ACL previas (donde figurará el SID viejo no resuelto).
> - **A:** Confunde la coincidencia de nombre textual con la identidad criptográfica del SID.
> - **C:** Windows permite reutilizar nombres de usuario borrados sin reiniciar el equipo, asignándoles un nuevo RID.
> - **D:** No existe la fusión de tokens ni herencia automática entre cuentas eliminadas y nuevas.

---

### Pregunta 5: Inspección de Identidad y Privilegios en CLI (`whoami`)
**¿Qué comando de consola debemos ejecutar para obtener un reporte completo de nuestro nombre de usuario, número de SID, grupos locales a los que pertenecemos y privilegios activos de la sesión actual?**
- A) `net user /view`
- B) `Get-Process -Name lsass`
- C) `systeminfo /security`
- D) `whoami /all` ✅ *(Correcta)*

> **Justificación didáctica y técnica:**
> - **D (Correcta):** `whoami /all` vuelca la información exhaustiva de la sesión: identidad de usuario, SID, membresía de grupos (con sus SIDs) y la tabla de privilegios (ej. `SeShutdownPrivilege`, `SeChangeNotifyPrivilege`).
> - **A:** `net user /view` es una sintaxis inexistente (`net user` lista cuentas, pero no muestra privilegios ni el token actual).
> - **B:** `Get-Process -Name lsass` únicamente muestra el uso de CPU y memoria del proceso LSASS, no los datos del usuario.
> - **C:** `systeminfo` muestra datos del hardware, versión de Windows y parches instalados, no los tokens de seguridad del usuario.

---

### Pregunta 6: Arquitectura Interna del Control de Cuentas de Usuario (UAC)
**¿Cómo funciona internamente el Control de Cuentas de Usuario (UAC) cuando un usuario perteneciente al grupo Administradores inicia sesión en Windows 11?**
- A) Le asigna permisos de Administrador a todos los programas de forma permanente para evitar interrupciones.
- B) Cifra el disco completo con BitLocker cada vez que se abre la consola de comandos.
- C) Genera **dos Tokens de Acceso**: un Token Estándar (filtrado) para las tareas comunes y un Token Elevado que solo se activa temporalmente cuando el usuario confirma la advertencia del UAC. ✅ *(Correcta)*
- D) Deshabilita el firewall y el antivirus mientras se ejecutan tareas administrativas en segundo plano.

> **Justificación didáctica y técnica:**
> - **C (Correcta):** UAC implementa el principio de mínimo privilegio generando una sesión desdoblada (Split Token). Las aplicaciones corren por defecto con el token limitado; la elevación a permisos de administrador requiere el consentimiento explícito en el escritorio seguro.
> - **A:** Otorgar permisos totales permanentes anularía el propósito de seguridad del UAC, dejando al equipo vulnerable a malware.
> - **B:** BitLocker es un mecanismo de cifrado de volumen en reposo, independiente del control de elevación de privilegios de procesos.
> - **D:** UAC no interactúa desactivando los escudos de seguridad del firewall o antivirus.

---

### Pregunta 7: Herramientas Gráficas de Gestión de Cuentas en Windows 11
**¿Qué herramienta gráfica clásica de Windows se abre ejecutando `netplwiz` (o `control userpasswords2`) desde el cuadro "Ejecutar" (`Win + R`)?**
- A) El panel avanzado de **Cuentas de usuario**, que permite listar usuarios locales y cambiar su nivel de grupo (Estándar o Administrador). ✅ *(Correcta)*
- B) El Administrador de Dispositivos para actualizar controladores de hardware.
- C) El Editor de Directivas de Grupo Local (`gpedit.msc`).
- D) El Visor de Eventos de Seguridad (`eventvwr.msc`).

> **Justificación didáctica y técnica:**
> - **A (Correcta):** `netplwiz` abre la interfaz rápida para administrar credenciales locales, pertenencia a grupos (Estándar vs Administradores) y el inicio de sesión automático.
> - **B:** El Administrador de Dispositivos se ejecuta mediante `devmgmt.msc`.
> - **C:** Las directivas de grupo se abren con `gpedit.msc`.
> - **D:** Los registros de auditoría de eventos se visualizan en `eventvwr.msc`.

---

### Pregunta 8: Creación y Configuración Segura de Usuarios por Línea de Comandos
**¿Cuál es la sintaxis correcta en CMD (con permisos de Administrador) para crear un usuario llamado `alumno_4to`, con contraseña `SecurePass2026!` y configurado para que NO pueda cambiar su contraseña?**
- A) `net account add alumno_4to SecurePass2026! /lockpassword`
- B) `useradd alumno_4to -p SecurePass2026! --no-change-pass`
- C) `net user alumno_4to SecurePass2026! /add /passwordchg:no` ✅ *(Correcta)*
- D) `create user alumno_4to /pass:SecurePass2026! /readonly`

> **Justificación didáctica y técnica:**
> - **C (Correcta):** En Windows CMD, el comando oficial es `net user <nombre> <clave> /add` junto con el modificador `/passwordchg:no` para restringir la modificación de credenciales por parte del usuario.
> - **A:** `net accounts` gestiona políticas globales de contraseñas (longitud mínima, bloqueo de cuenta), no crea usuarios individuales.
> - **B:** `useradd` es la utilidad estándar de sistemas GNU/Linux, no de Windows.
> - **D:** Sintaxis inventada no reconocida por el intérprete de comandos `cmd.exe`.

---

### Pregunta 9: Gestión de Grupos Locales (`net localgroup`)
**¿Qué comando de consola se debe utilizar para incorporar al usuario existente `docente_lso` dentro del grupo local `GRP_Docentes`?**
- A) `net group GRP_Docentes /member:docente_lso`
- B) `net localgroup GRP_Docentes docente_lso /add` ✅ *(Correcta)*
- C) `net user docente_lso /group:GRP_Docentes`
- D) `Add-UserToGroup -User docente_lso -Group GRP_Docentes`

> **Justificación didáctica y técnica:**
> - **B (Correcta):** La sintaxis canónica de Windows para agregar miembros a un grupo local es `net localgroup <NombreGrupo> <NombreUsuario> /add`.
> - **A:** `net group` se utiliza en entornos de dominio de Active Directory, no para grupos locales de una estación de trabajo.
> - **C:** El comando `net user` no cuenta con el parámetro `/group:` para asignar membresía.
> - **D:** En PowerShell el cmdlet oficial es `Add-LocalGroupMember -Group ... -Member ...`, no `Add-UserToGroup`.

---

### Pregunta 10: Ventajas de la Administración Basada en Grupos
**En la administración de laboratorios e infraestructura de servidores, ¿por qué es una buena práctica asignar permisos a Grupos Locales en lugar de asignarlos a usuarios individuales?**
- A) Porque Windows no permite almacenar más de 3 usuarios individuales en las Listas de Control de Acceso (ACL).
- B) Porque los grupos comprimen los archivos de las carpetas ahorrando espacio en disco.
- C) Porque los usuarios que pertenecen a un grupo no necesitan contraseña para iniciar sesión.
- D) Porque simplifica la administración: al modificar miembros del grupo se heredan o revocan permisos automáticamente, evitando errores y garantizando escalabilidad y cumplimiento del principio de mínimo privilegio. ✅ *(Correcta)*

> **Justificación didáctica y técnica:**
> - **D (Correcta):** La gestión basada en grupos (principio AGDLP / RBAC) permite centralizar el control: basta con agregar o quitar un usuario del grupo para que gane o pierda acceso a decenas de carpetas y recursos sin tocar las ACL de los archivos.
> - **A:** Las ACLs de NTFS admiten cientos de entradas de control de acceso (ACE), no hay un límite arbitrario de 3 usuarios.
> - **C:** Los grupos son objetos de seguridad lógicos, no realizan compresión de datos de almacenamiento.
> - **D:** La membresía en grupos no exime a los usuarios del proceso de autenticación segura con contraseña o credencial.

---
