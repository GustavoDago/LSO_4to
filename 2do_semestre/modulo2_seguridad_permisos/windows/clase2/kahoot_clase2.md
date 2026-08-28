# Trivia Kahoot: Clase 2 - Permisos NTFS, ACLs, Herencia, Takeown y GUI
**Módulo 2 (Windows 11):** Seguridad, Permisos y Gestión de Usuarios  
**Destinatarios:** 4.º Año — Tecnicatura en Informática Personal y Profesional  
**Formato:** 12 Preguntas de Opción Múltiple (1 Correcta + 3 Distractores con Justificación Técnica)  
**Distribución de Claves Correctas:** Equitativa (3 A, 3 B, 3 C, 3 D)

---

### Pregunta 1
**En la seguridad NTFS, ¿qué elemento contiene las reglas que permiten o deniegan el acceso a un archivo?**
- A) La SACL (*System Access Control List*).
- B) La tabla FAT de asignación de clústeres.
- C) La DACL (*Discretionary Access Control List*). ✅ *(Correcta)*
- D) El MBR (*Master Boot Record*) del disco.

> **Justificación didáctica:**
> - **C (Correcta):** La DACL almacena las entradas ACE que conceden o deniegan acceso a los recursos.
> - **A:** La SACL se utiliza para registrar eventos de auditoría en el Visor de Eventos, no para conceder accesos.
> - **B:** La FAT es una tabla de asignación de archivos de un formato antiguo que no soporta listas ACL de seguridad.
> - **D:** El MBR es una estructura de particionamiento del disco físico.

---

### Pregunta 2
**¿Qué ocurre si un usuario tiene "Control Total" pero su grupo tiene "Denegar Lectura" explícito?**
- A) Puede leer porque el Control Total siempre prevalece.
- B) Se deniega la lectura: la regla Deny tiene máxima prioridad. ✅ *(Correcta)*
- C) Windows promedia los permisos y solo permite ejecución.
- D) Se solicita confirmación por UAC como administrador.

> **Justificación didáctica:**
> - **B (Correcta):** En el modelo de evaluación de seguridad de Windows, una regla Deny explícita cancela y supera cualquier regla Allow.
> - **A:** Error muy común: Control Total no anula una denegación explícita sobre el mismo recurso.
> - **C:** Los permisos no se promedian de forma aritmética.
> - **D:** UAC controla tokens de administración de procesos, no resolución de conflictos de ACLs NTFS.

---

### Pregunta 3
**En el comando `icacls`, ¿qué significan las banderas `(OI)(CI)` al asignar permisos a una carpeta?**
- A) *Only Input / Cancel Input* (solo entrada por teclado).
- B) *Owner Identity / Client Identity* (claves compartidas).
- C) *Online Index / Cached Index* (indexación en la nube).
- D) *Object Inherit / Container Inherit* (heredan archivos y carpetas). ✅ *(Correcta)*

> **Justificación didáctica:**
> - **D (Correcta):** (OI) propaga la regla a archivos (objetos) y (CI) a subcarpetas (contenedores). En la GUI equivale a la opción 'Esta carpeta, subcarpetas y archivos'.
> - **A, B, C:** Distractores conceptuales que no corresponden a la nomenclatura oficial de Microsoft ACLs.

---

### Pregunta 4
**¿Cuál es la diferencia entre `/inheritance:d` y `/inheritance:r` en el comando `icacls`?**
- A) `/inheritance:d` convierte herencia en explícita; `/inheritance:r` quita permisos heredados. ✅ *(Correcta)*
- B) `/inheritance:d` desactiva el disco y `/inheritance:r` lo repara automáticamente.
- C) `/inheritance:d` habilita la herencia y `/inheritance:r` la deshabilita por completo.
- D) No hay diferencia; ambos modificadores hacen exactamente lo mismo.

> **Justificación didáctica:**
> - **A (Correcta):** 'd' (disable & duplicate) convierte la herencia en permisos explícitos editables y 'r' (remove) elimina toda regla heredada.
> - **B:** Distractor absurdo sin relación con el sistema de archivos.
> - **C:** Para activar la herencia se utiliza el parámetro /inheritance:e.
> - **D:** Son dos modos de ruptura con comportamientos diametralmente opuestos sobre los permisos existentes.

---

### Pregunta 5
**En la GUI, ¿a qué comando equivale "Convertir los permisos heredados en permisos explícitos en este objeto"?**
- A) `icacls "carpeta" /inheritance:r`
- B) `takeown /F "carpeta"`
- C) `icacls "carpeta" /inheritance:d` ✅ *(Correcta)*
- D) `attrib +h "carpeta"`

> **Justificación didáctica:**
> - **C (Correcta):** /inheritance:d duplica los permisos heredados como explícitos locales, que es exactamente lo que hace esa opción gráfica.
> - **A:** /inheritance:r equivale a la opción gráfica 'Quitar todos los permisos heredados de este objeto'.
> - **B:** takeown cambia el propietario, no gestiona la herencia de ACLs.
> - **D:** attrib +h solo modifica atributos DOS para ocultar el archivo/carpeta.

---

### Pregunta 6
**En Configuración de seguridad avanzada, ¿qué pestaña calcula los permisos reales de un usuario?**
- A) La pestaña "Acceso efectivo" (*Effective Access*). ✅ *(Correcta)*
- B) La pestaña "Auditoría" de seguridad del sistema.
- C) La pestaña "Cuotas de disco" y almacenamiento.
- D) La pestaña "Propietario" y herencia de dominio.

> **Justificación didáctica:**
> - **A (Correcta):** La pestaña 'Acceso efectivo' ejecuta el algoritmo del SRM calculando en tiempo real si cada permiso resulta permitido o denegado para un usuario específico.
> - **B:** La pestaña de auditoría se utiliza para configurar eventos SACL en el registro de Windows.
> - **C:** Las cuotas de disco limitan el espacio en megabytes por usuario, no calculan permisos.
> - **D:** La pestaña de propietario solo muestra y transfiere la titularidad del objeto.

---

### Pregunta 7
**¿Qué comando nativo de Windows permite a un administrador tomar posesión (*Ownership*) de un archivo?**
- A) `chown root "archivo.txt"`
- B) `attrib -s -h "archivo.txt"`
- C) `format /q "archivo.txt"`
- D) `takeown /F "archivo.txt"` ✅ *(Correcta)*

> **Justificación didáctica:**
> - **D (Correcta):** takeown es la utilidad de línea de comandos de Windows para tomar posesión de archivos y carpetas. En la GUI equivale al enlace 'Cambiar' junto al Propietario.
> - **A:** chown es la utilidad de cambio de propietario en sistemas GNU/Linux.
> - **B:** attrib modifica atributos DOS de solo lectura, oculto y sistema.
> - **C:** format se utiliza para formatear volúmenes lógicos completos.

---

### Pregunta 8
**¿Qué derecho especial inalienable posee el Propietario (*Owner*) de un archivo NTFS?**
- A) Formatear la partición C: sin confirmación.
- B) Cambiar y reescribir los permisos del objeto (`WRITE_DAC`). ✅ *(Correcta)*
- C) Descifrar claves BitLocker sin contraseña.
- D) Navegar por internet sin restricciones de proxy.

> **Justificación didáctica:**
> - **B (Correcta):** El propietario siempre conserva el derecho WRITE_DAC, lo que le permite reescribir la DACL y volver a concederse permisos a sí mismo.
> - **A:** Formatear unidades requiere privilegios administrativos sobre el volumen de almacenamiento.
> - **C:** BitLocker es un cifrado de volumen a nivel de bloque y no se gestiona con la propiedad NTFS.
> - **D:** El acceso a la red y proxies es independiente del sistema de archivos local.

---

### Pregunta 9
**¿Cuál es la sintaxis correcta de `icacls` para conceder permiso de Modificar (`M`) con herencia en una carpeta?**
- A) `icacls "C:\Carpeta" /grant alumno_4to:(OI)(CI)M` ✅ *(Correcta)*
- B) `chmod -R 777 alumno_4to "C:\Carpeta"`
- C) `net user alumno_4to /permission:modify "C:\Carpeta"`
- D) `set-permission -User alumno_4to -Path "C:\Carpeta" -Level M`

> **Justificación didáctica:**
> - **A (Correcta):** La sintaxis oficial de icacls es /grant <Entidad>:(Banderas)Permiso, donde (OI)(CI) propaga a objetos y contenedores y M otorga Modificar.
> - **B:** chmod es el comando de permisos octales de sistemas POSIX / Linux.
> - **C:** net user gestiona cuentas de usuario en la base SAM local, no permisos de archivos.
> - **D:** Cmdlet ficticio con sintaxis inventada.

---

### Pregunta 10
**En la salida de `icacls`, si observas una entrada con el código `(I)`, ¿qué significa?**
- A) Que el archivo está **Infectado** y requiere revisión.
- B) Que la regla aplica únicamente a archivos de **Imagen**.
- C) Que la regla fue **Heredada** (*Inherited*) de la carpeta superior. ✅ *(Correcta)*
- D) Que el permiso es **Inválido** y debe ser eliminado.

> **Justificación didáctica:**
> - **C (Correcta):** (I) identifica visualmente que la ACE no fue creada en ese objeto específico, sino heredada del directorio contenedor superior (en la GUI figura en 'Heredado de').
> - **A, B, D:** Distractores técnicos falsos.

---

### Pregunta 11
**¿Qué cmdlet de PowerShell se utiliza para consultar la Lista de Control de Acceso y el Propietario de un archivo?**
- A) `Get-PermissionList`
- B) `Get-Acl` ✅ *(Correcta)*
- C) `Show-NTFSSecurity`
- D) `Test-FileAccess`

> **Justificación didáctica:**
> - **B (Correcta):** Get-Acl devuelve el objeto FileSecurity con el propietario, grupo de auditoría y lista de reglas de acceso del archivo.
> - **A, C, D:** Nombres de cmdlets inexistentes en PowerShell estándar.

---

### Pregunta 12
**Si deseas restablecer los permisos de una carpeta para volver a heredar de la carpeta padre, ¿qué parámetro de `icacls` usas?**
- A) `/format`
- B) `/delete`
- C) `/clean-all`
- D) `/reset` ✅ *(Correcta)*

> **Justificación didáctica:**
> - **D (Correcta):** El modificador /reset reemplaza las ACLs personalizadas por las ACLs heredadas de forma predeterminada (equivalente a presionar 'Habilitar herencia' en la GUI).
> - **A:** /format es para dar formato a volúmenes lógicos de disco.
> - **B, C:** Parámetros inválidos en la herramienta icacls.

---
