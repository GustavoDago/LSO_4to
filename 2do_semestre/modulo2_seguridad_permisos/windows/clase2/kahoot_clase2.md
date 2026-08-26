# Trivia Kahoot: Clase 2 - Permisos NTFS, ACLs, Herencia, Takeown y GUI
**Módulo 2 (Windows 11):** Seguridad, Permisos y Gestión de Usuarios  
**Destinatarios:** 4.º Año — Tecnicatura en Informática Personal y Profesional  
**Formato:** 12 Preguntas de Opción Múltiple (1 Correcta + 3 Distractores con Justificación Técnica)

---

### Pregunta 1
**En la arquitectura de seguridad NTFS de Windows, ¿qué elemento contiene las reglas que determinan qué usuarios pueden leer o modificar un archivo?**
- A) La DACL (*Discretionary Access Control List*). ✅ *(Correcta)*
- B) La SACL (*System Access Control List*).
- C) La tabla FAT de asignación de clústeres.
- D) El MBR (*Master Boot Record*).

> **Justificación didáctica:**
> - **A (Correcta):** La DACL almacena las entradas ACE que conceden o deniegan acceso a los recursos.
> - **B:** La SACL se utiliza para registrar eventos de auditoría en el Visor de Eventos, no para conceder accesos.
> - **C:** La FAT es una tabla de asignación de archivos de un formato antiguo que no soporta listas ACL de seguridad.
> - **D:** El MBR es una estructura de particionamiento del disco físico.

---

### Pregunta 2
**¿Qué ocurre cuando un usuario tiene permiso explícito de "Control Total" sobre un archivo, pero pertenece a un grupo que tiene asignado un permiso explícito de "Denegar Lectura"?**
- A) El usuario puede leer el archivo porque el Control Total siempre prevalece.
- B) El acceso de lectura es denegado porque el permiso "Deny" tiene precedencia absoluta. ✅ *(Correcta)*
- C) Windows promedia ambos permisos y sólo permite ejecución.
- D) Se abre una ventana de UAC solicitando una segunda contraseña.

> **Justificación didáctica:**
> - **B (Correcta):** En el modelo de evaluación de seguridad de Windows, una regla *Deny* explícita cancela y supera cualquier regla *Allow*.
> - **A:** Error muy común; Control Total no anula una denegación explícita sobre el mismo recurso.
> - **C:** Los permisos no se promedian de forma aritmética.
> - **D:** UAC controla tokens de administración de procesos, no conflictos de ACLs NTFS.

---

### Pregunta 3
**Al ejecutar el comando `icacls`, ¿qué significan las banderas `(OI)(CI)` al asignar permisos sobre una carpeta?**
- A) *Only Input / Cancel Input* (Solo lectura por teclado).
- B) *Object Inherit / Container Inherit* (Los permisos se propagan tanto a archivos como a subcarpetas hijas). ✅ *(Correcta)*
- C) *Owner Identity / Client Identity* (El propietario y el cliente comparten la misma clave).
- D) *Online Index / Cached Index* (Indexación en la nube).

> **Justificación didáctica:**
> - **B (Correcta):** `(OI)` propaga la regla a archivos (objetos) y `(CI)` a subcarpetas (contenedores) que se creen dentro del directorio. En la GUI equivale a la opción *"Esta carpeta, subcarpetas y archivos"*.
> - **A, C, D:** Distractores conceptuales que no corresponden a la nomenclatura oficial de Microsoft ACLs.

---

### Pregunta 4
**¿Cuál es la diferencia entre los modificadores `/inheritance:d` y `/inheritance:r` en el comando `icacls`?**
- A) `/inheritance:d` copia los permisos heredados como explícitos, mientras que `/inheritance:r` borra todos los permisos heredados. ✅ *(Correcta)*
- B) `/inheritance:d` borra el disco duro y `/inheritance:r` lo recupera.
- C) `/inheritance:d` activa la herencia y `/inheritance:r` la deshabilita.
- D) No hay diferencia; ambos comandos realizan exactamente la misma acción.

> **Justificación didáctica:**
> - **A (Correcta):** `d` significa *disable & duplicate* (convierte la herencia en permisos explícitos editables) y `r` significa *disable & remove* (aísla la carpeta eliminando toda regla heredada).
> - **B:** Distractor absurdo.
> - **C:** Para activar la herencia se utiliza `/inheritance:e`.
> - **D:** Son dos modos de ruptura con comportamientos diametralmente opuestos sobre los permisos existentes.

---

### Pregunta 5
**En la interfaz gráfica del Explorador de Windows, ¿a qué comando de consola equivale presionar "Deshabilitar herencia" y elegir "Convertir los permisos heredados en permisos explícitos en este objeto"?**
- A) `icacls "carpeta" /inheritance:d` ✅ *(Correcta)*
- B) `icacls "carpeta" /inheritance:r`
- C) `takeown /F "carpeta"`
- D) `attrib +h "carpeta"`

> **Justificación didáctica:**
> - **A (Correcta):** `/inheritance:d` duplica los permisos heredados como explícitos locales, que es exactamente lo que hace esa opción gráfica.
> - **B:** `/inheritance:r` equivale a la opción gráfica *"Quitar todos los permisos heredados de este objeto"*.
> - **C:** `takeown` cambia el propietario, no gestiona la herencia de ACLs.
> - **D:** `attrib +h` oculta la carpeta en DOS.

---

### Pregunta 6
**¿Qué herramienta nativa dentro de "Configuración de seguridad avanzada" permite diagnosticar si un usuario puede o no realizar una acción simulando todos sus grupos y reglas de conflicto?**
- A) La pestaña "Acceso efectivo" (*Effective Access*). ✅ *(Correcta)*
- B) El Administrador de Tareas.
- C) El Desfragmentador de Disco.
- D) El panel de Control Parental.

> **Justificación didáctica:**
> - **A (Correcta):** La pestaña "Acceso efectivo" ejecuta el algoritmo del SRM calculando en tiempo real si cada uno de los 14 permisos NTFS resulta permitido o denegado para un usuario específico.
> - **B, C, D:** Herramientas del sistema no vinculadas a la resolución de conflictos de DACLs.

---

### Pregunta 7
**¿Qué comando de consola nativo permite a un administrador tomar la propiedad (*Ownership*) de un archivo cuyo acceso está bloqueado?**
- A) `takeown /F "archivo.txt"` ✅ *(Correcta)*
- B) `chown root "archivo.txt"`
- C) `attrib -s -h "archivo.txt"`
- D) `format /q "archivo.txt"`

> **Justificación didáctica:**
> - **A (Correcta):** `takeown` es la utilidad de línea de comandos de Windows para tomar posesión de archivos y directorios. En la GUI equivale al enlace *"Cambiar"* junto al nombre del Propietario.
> - **B:** `chown` es la utilidad estándar de sistemas GNU/Linux.
> - **C:** `attrib` modifica atributos DOS de solo lectura, oculto y sistema.
> - **D:** `format` se utiliza para formatear unidades lógicas.

---

### Pregunta 8
**¿Qué permiso especial posee de manera inalienable el Propietario (*Owner*) de un archivo en NTFS, incluso si carece de permisos de lectura y escritura?**
- A) El derecho a cambiar los permisos del objeto (`WRITE_DAC`). ✅ *(Correcta)*
- B) El derecho a formatear la partición C:.
- C) La capacidad de descifrar claves BitLocker sin contraseña.
- D) Acceso ilimitado a internet sin proxy.

> **Justificación didáctica:**
> - **A (Correcta):** El propietario siempre conserva el derecho `WRITE_DAC`, lo que le permite reescribir la DACL y volver a concederse permisos a sí mismo.
> - **B, C, D:** Privilegios no relacionados con la propiedad de un objeto en el sistema de archivos.

---

### Pregunta 9
**¿Cuál es la sintaxis correcta de `icacls` para conceder permiso de Modificar (`M`) al usuario "alumno_4to" de forma recursiva con herencia completa en una carpeta?**
- A) `icacls "C:\Carpeta" /grant alumno_4to:(OI)(CI)M` ✅ *(Correcta)*
- B) `chmod -R 777 alumno_4to "C:\Carpeta"`
- C) `net user alumno_4to /permission:modify "C:\Carpeta"`
- D) `set-permission -User alumno_4to -Path "C:\Carpeta" -Level M`

> **Justificación didáctica:**
> - **A (Correcta):** La sintaxis oficial de `icacls` es `/grant <Entidad>:(Banderas)Permiso`.
> - **B:** `chmod` es la herramienta de sistemas Linux/POSIX.
> - **C:** `net user` gestiona cuentas en la base SAM local, no permisos de archivos.
> - **D:** Cmdlet ficticio con sintaxis inventada.

---

### Pregunta 10
**En la salida del comando `icacls`, si observas una entrada con el código `(I)`, ¿qué significa y cómo se refleja en la ventana gráfica?**
- A) Indica que la regla fue **Heredada** (*Inherited*) y en la GUI figura el nombre de la carpeta padre en la columna *"Heredado de"*. ✅ *(Correcta)*
- B) Que el archivo está **Infectado** y la GUI lo marca en color rojo.
- C) Que la regla aplica solo a archivos de **Imagen**.
- D) Que el permiso es **Invalido** y la GUI deshabilita el Explorador.

> **Justificación didáctica:**
> - **A (Correcta):** `(I)` identifica visualmente que la ACE no fue creada en ese objeto específico, sino heredada del directorio contenedor superior.
> - **B, C, D:** Distractores técnicos falsos.

---

### Pregunta 11
**¿Qué cmdlet de PowerShell se utiliza para consultar la Lista de Control de Acceso y el Propietario de un archivo en NTFS?**
- A) `Get-Acl` ✅ *(Correcta)*
- B) `Get-PermissionList`
- C) `Show-NTFSSecurity`
- D) `Test-FileAccess`

> **Justificación didáctica:**
> - **A (Correcta):** `Get-Acl` devuelve el objeto `FileSecurity` con el propietario, grupo y lista de reglas de acceso del archivo.
> - **B, C, D:** Nombres de cmdlets inexistentes en PowerShell estándar.

---

### Pregunta 12
**Si un técnico desea restablecer todos los permisos de una carpeta para que vuelva a heredar limpiamente los permisos de su carpeta padre, ¿qué parámetro de `icacls` debe ejecutar?**
- A) `/reset` ✅ *(Correcta)*
- B) `/format`
- C) `/delete`
- D) `/clean-all`

> **Justificación didáctica:**
> - **A (Correcta):** El modificador `/reset` reemplaza las ACLs personalizadas por las ACLs heredadas de forma predeterminada (equivalente a presionar *"Habilitar herencia"* en la GUI).
> - **B:** `/format` es para dar formato a volúmenes lógicos de disco.
> - **C, D:** Parámetros inválidos en la herramienta `icacls`.
