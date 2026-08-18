# Trivia Kahoot: Clase 1 - Usuarios, Grupos, SID, UAC y Herramientas Gráficas en Windows
**Módulo 2 (Windows 11):** Seguridad, Permisos y Gestión de Usuarios  
**Destinatarios:** 4.º Año — Tecnicatura en Informática Personal y Profesional  
**Formato:** 10 Preguntas de Opción Múltiple (1 Correcta + 3 Distractores con Justificación Técnica)

---

### Pregunta 1
**¿Qué es un SID (*Security Identifier*) en Windows?**
- A) El nombre de usuario que vemos en la pantalla de inicio.
- B) Un número único e inmutable que Windows le asigna a cada cuenta para identificarla ante el sistema de seguridad. ✅ *(Correcta)*
- C) La contraseña cifrada del usuario.
- D) La dirección IP asignada a la computadora.

> **Justificación didáctica:**
> - **B (Correcta):** El SID es el "DNI digital" que usa Windows para saber quién es cada usuario y qué permisos tiene.
> - **A:** El nombre visual puede cambiarse, pero el SID permanece igual.
> - **C:** Las contraseñas se guardan como hashes en la base SAM, no son el SID.
> - **D:** La IP es una dirección de red, no un identificador de usuario.

---

### Pregunta 2
**Si a un usuario llamado "Carlos" le cambiamos el nombre a "Juan", ¿qué ocurre con sus permisos sobre los archivos existentes?**
- A) Pierde todos sus permisos y no puede abrir ningún archivo.
- B) Conserva todos sus permisos intactos porque están vinculados a su número de SID y no a su nombre. ✅ *(Correcta)*
- C) Windows borra automáticamente todos sus archivos personales.
- D) Se debe formatear el disco para que Windows reconozca el cambio.

> **Justificación didáctica:**
> - **B (Correcta):** Como los permisos se asignan al SID y el SID no cambia al cambiar el nombre, el usuario conserva todos sus accesos.
> - **A, C, D:** Ideas erróneas comunes; renombrar una cuenta no rompe los permisos asignados.

---

### Pregunta 3
**¿Dónde guarda Windows de forma protegida las cuentas de usuario locales y sus contraseñas?**
- A) En un archivo de texto en el Escritorio.
- B) En la base de datos SAM (*Security Accounts Manager*). ✅ *(Correcta)*
- C) En la memoria caché del navegador de internet.
- D) En la papelera de reciclaje.

> **Justificación didáctica:**
> - **B (Correcta):** La base de datos SAM (`%SystemRoot%\System32\config\SAM`) almacena de manera cifrada las cuentas y claves del equipo.
> - **A, C, D:** Opciones incorrectas y sin relación con la seguridad del sistema operativo.

---

### Pregunta 4
**¿Qué comando de la consola CMD nos permite ver nuestro usuario, nuestro número de SID y los grupos a los que pertenecemos?**
- A) `whoami /all` ✅ *(Correcta)*
- B) `ping localhost`
- C) `time /now`
- D) `cls`

> **Justificación didáctica:**
> - **A (Correcta):** El comando `whoami /all` muestra toda la información de seguridad del usuario en la sesión actual.
> - **B:** `ping` es para probar conectividad de red.
> - **C, D:** `time` muestra la hora y `cls` limpia la pantalla.

---

### Pregunta 5
**¿Qué herramienta gráfica de Windows 11 permite ver los usuarios locales y cambiar su grupo (por ejemplo pasar de Estándar a Administrador)?**
- A) `netplwiz` (o `control userpasswords2`) ✅ *(Correcta)*
- B) `calc.exe` (Calculadora)
- C) `mspaint.exe` (Paint)
- D) `notepad.exe` (Bloc de notas)

> **Justificación didáctica:**
> - **A (Correcta):** `netplwiz` es el panel gráfico clásico de Windows para gestionar cuentas y grupos locales.
> - **B, C, D:** Son aplicaciones accesorias de Windows (cálculo, dibujo y edición de texto).

---

### Pregunta 6
**¿Cuál es la función principal del Control de Cuentas de Usuario (UAC) en Windows?**
- A) Aumentar la velocidad del procesador.
- B) Avisar al usuario y solicitar confirmación cada vez que un programa intenta hacer cambios importantes en el sistema. ✅ *(Correcta)*
- C) Apagar automáticamente la pantalla tras 5 minutos de inactividad.
- D) Cambiar el fondo de pantalla todos los días.

> **Justificación didáctica:**
> - **B (Correcta):** El UAC protege el equipo frenando instalaciones o modificaciones silenciosas de programas no autorizados.
> - **A, C, D:** No tienen ninguna relación con la seguridad de cuentas ni privilegios.

---

### Pregunta 7
**¿Qué comando de consola CMD es el correcto para crear un nuevo usuario llamado "tecnico" con contraseña "Pass2026!"?**
- A) `net user tecnico Pass2026! /add` ✅ *(Correcta)*
- B) `crear usuario tecnico Pass2026!`
- C) `new-user tecnico Pass2026!`
- D) `user /make:tecnico /pass:Pass2026!`

> **Justificación didáctica:**
> - **A (Correcta):** La sintaxis oficial en CMD es `net user <nombre> <contraseña> /add`.
> - **B, C, D:** Sintaxis inventadas no reconocidas por el Símbolo del Sistema.

---

### Pregunta 8
**¿Qué comando permite agregar al usuario "docente_lso" dentro del grupo local "Docentes"?**
- A) `net localgroup Docentes docente_lso /add` ✅ *(Correcta)*
- B) `net user docente_lso /meter:Docentes`
- C) `copiar docente_lso en Docentes`
- D) `group /add:Docentes docente_lso`

> **Justificación didáctica:**
> - **A (Correcta):** `net localgroup <Grupo> <Usuario> /add` es la orden para matricular a un usuario dentro de un grupo.
> - **B, C, D:** Sintaxis erróneas inexistentes en Windows.

---

### Pregunta 9
**¿Por qué es recomendable organizar los usuarios en "Grupos" en lugar de dar permisos de a uno por uno?**
- A) Porque si hay 30 alumnos, es más rápido y seguro darle permisos a la carpeta del grupo que configurar a los 30 usuarios por separado. ✅ *(Correcta)*
- B) Porque Windows no permite tener más de 2 usuarios si no están en un grupo.
- C) Porque los grupos hacen que la computadora use menos memoria RAM.
- D) Porque los grupos impiden que los usuarios usen internet.

> **Justificación didáctica:**
> - **A (Correcta):** La gestión por grupos simplifica enormemente la administración y previene errores al asignar permisos.
> - **B, C, D:** Conceptos falsos.

---

### Pregunta 10
**En un SID con formato `S-1-5-21-3623811015-3361044348-30300820-500`, ¿a quién pertenece el número especial final `500`?**
- A) Al usuario Administrador integrado de Windows. ✅ *(Correcta)*
- B) Al usuario Invitado.
- C) A una cuenta de alumno recién creada.
- D) A una impresora de red.

> **Justificación didáctica:**
> - **A (Correcta):** Por convención en Windows, el número RID `500` está reservado exclusivamente para la cuenta de Administrador principal del sistema.
> - **B:** El Invitado posee el número RID `501`.
> - **C:** Los usuarios nuevos creados por el administrador comienzan con números >= 1000.
> - **D:** Las impresoras no son cuentas de usuario con RID 500.
