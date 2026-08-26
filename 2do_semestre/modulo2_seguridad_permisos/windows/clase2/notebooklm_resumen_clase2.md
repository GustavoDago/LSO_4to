# Ficha Didáctica NotebookLM: Permisos NTFS, ACLs, Herencia, Takeown y GUI
**Cuaderno:** LSO 4to - 2do semestre  
**Módulo:** 2 - Seguridad, Permisos y Gestión de Usuarios (Clase 2 - Windows 11)  

---

## 🎙️ Podcast Prompt (Resumen de Audio para NotebookLM)
> "En esta sesión nos sumergimos en las entrañas del sistema de archivos NTFS para entender cómo protege la información tanto desde la línea de comandos como a través de la interfaz gráfica avanzada de Windows. Descubrimos la estructura de un Descriptor de Seguridad, compuesto por el SID del Propietario, la DACL y las ACEs. Explicamos cómo funciona la herencia de permisos, qué significan las banderas (OI) y (CI) del comando `icacls` y cómo se visualizan en el menú 'Se aplica a' del Explorador de Archivos. Analizamos qué ocurre cuando hay conflicto entre un permiso de permitir (Allow) y uno de denegar (Deny), y cómo auditarlo profesionalmente con la herramienta de 'Acceso efectivo'. Por último, examinamos el poder de `takeown` y el vínculo gráfico de cambio de propietario para recuperar el control de archivos huérfanos o bloqueados."

---

## 🧠 Conceptos Nucleares

### 1. Arquitectura del Descriptor de Seguridad NTFS
* **Owner SID (*Propietario*):** La cuenta que posee el derecho especial inalienable `WRITE_DAC` sobre el objeto. En la GUI se visualiza en la cabecera de la ventana *Seguridad avanzada*.
* **DACL (*Discretionary Access Control List*):** Conjunto de reglas (ACEs) que conceden o deniegan acceso a usuarios y grupos concretos.
* **SACL (*System Access Control List*):** Conjunto de reglas para auditar accesos exitosos o fallidos en los registros de eventos de Windows.

### 2. Banderas de Herencia y Propagación: CLI vs. GUI
* **`(OI)` — Object Inherit:** Se propaga a archivos hijos (GUI: *"Esta carpeta y archivos"*).
* **`(CI)` — Container Inherit:** Se propaga a subcarpetas hijas (GUI: *"Esta carpeta y subcarpetas"*).
* **`(OI)(CI)`:** Propagación recursiva total (GUI: *"Esta carpeta, subcarpetas y archivos"*).
* **`(I)` — Inherited:** Indica que la regla proviene del padre (GUI: Columna *"Heredado de"*).

### 3. Ruptura y Gestión de Herencia
* **`icacls /inheritance:d`:** GUI → Botón *Deshabilitar herencia* → *"Convertir los permisos heredados en permisos explícitos en este objeto"*.
* **`icacls /inheritance:r`:** GUI → Botón *Deshabilitar herencia* → *"Quitar todos los permisos heredados de este objeto"*.
* **`icacls /reset`:** GUI → Botón *Habilitar herencia*.

### 4. Jerarquía de Evaluación y Diagnóstico con "Acceso Efectivo"
1. **Deny Explícito** (Máxima prioridad; cancela cualquier Allow).
2. **Allow Explícito**.
3. **Deny Heredado**.
4. **Allow Heredado**.
5. **Denegación Implícita** (Acceso denegado por defecto si no hay ACE coincidente).
* **Herramienta "Acceso efectivo" (Pestaña GUI):** Permite ingresar el nombre de cualquier usuario y evaluar el resultado exacto de sus 14 permisos NTFS calculados en tiempo real por el subsistema SRM.

### 5. Toma de Posesión (*Ownership*) con `takeown` / GUI
* Permite a un administrador reclamar la propiedad de un archivo cuando los permisos están corruptos o el dueño fue eliminado.
* CLI: `takeown /F "ruta\archivo.ext"`.
* GUI: *Propiedades → Seguridad → Opciones avanzadas → Propietario: Cambiar*.

---

## ❓ Preguntas Frecuentes de Examen Técnico

**P: Si un alumno pertenece al grupo `Alumnos` con permiso de Lectura en una carpeta, pero se agrega una regla de Denegar Escritura a `Todos`, ¿puede crear archivos en esa carpeta?**  
*R: No. El permiso `Deny` (Denegar) tiene precedencia absoluta sobre cualquier permiso de permitir concedido por pertenencia a grupos.*

**P: ¿Qué opción de la ventana gráfica de Windows equivale al comando `icacls /inheritance:d`?**  
*R: La opción "Convertir los permisos heredados en permisos explícitos en este objeto" dentro del cuadro de diálogo al hacer clic en "Deshabilitar herencia".*

**P: ¿Para qué sirve la pestaña "Acceso efectivo" en la ventana de Seguridad Avanzada?**  
*R: Para simular el token de un usuario y auditar de forma visual qué operaciones exactas puede o no puede realizar sobre un archivo, mostrando si un bloqueo proviene de una regla Deny o de falta de permisos.*
