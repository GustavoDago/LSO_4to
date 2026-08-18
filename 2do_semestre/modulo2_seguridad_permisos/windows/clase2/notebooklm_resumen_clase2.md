# Ficha Didáctica NotebookLM: Permisos NTFS, ACLs, Herencia y Takeown
**Cuaderno:** LSO 4to - 2do semestre  
**Módulo:** 2 - Seguridad, Permisos y Gestión de Usuarios (Clase 2 - Windows 11)  

---

## 🎙️ Podcast Prompt (Resumen de Audio para NotebookLM)
> "En esta sesión nos sumergimos en las entrañas del sistema de archivos NTFS para entender cómo protege la información. Descubrimos la estructura de un Descriptor de Seguridad, compuesto por el SID del Propietario, la DACL (Lista de Control de Acceso Discrecional) y las ACEs (Entradas de Control de Acceso). Explicamos cómo funciona la herencia de permisos de carpetas superiores, qué significan las banderas (OI) y (CI) del comando `icacls`, y qué ocurre cuando hay conflicto entre un permiso de permitir (Allow) y uno de denegar (Deny). Por último, analizamos el poder del comando `takeown` para recuperar el control de archivos huérfanos o bloqueados mediante la toma de posesión del objeto."

---

## 🧠 Conceptos Nucleares

### 1. Arquitectura del Descriptor de Seguridad NTFS
* **Owner SID (*Propietario*):** La cuenta que posee el derecho especial `WRITE_DAC` sobre el objeto.
* **DACL (*Discretionary Access Control List*):** Conjunto de reglas (ACEs) que conceden o deniegan acceso a usuarios y grupos concretos.
* **SACL (*System Access Control List*):** Conjunto de reglas para auditar accesos exitosos o fallidos en los registros de eventos de Windows.

### 2. Banderas de Herencia y Propagación en `icacls`
* **`(OI)` — Object Inherit:** Se propaga a los archivos que se creen dentro del directorio.
* **`(CI)` — Container Inherit:** Se propaga a las subcarpetas que se creen dentro del directorio.
* **`(IO)` — Inherit Only:** Aplica únicamente a los objetos hijos, sin afectar a la carpeta contenedora en sí misma.
* **`(I)` — Inherited:** Indica que la regla fue heredada desde la carpeta superior.

### 3. Ruptura de Herencia
* **`/inheritance:d`:** Convierte los permisos heredados en permisos explícitos editables (copia local).
* **`/inheritance:r`:** Elimina todos los permisos heredados, dejando el directorio completamente cerrado.
* **`/reset`:** Elimina reglas explícitas y restablece la herencia desde el padre.

### 4. Jerarquía de Evaluación de Permisos (SRM)
1. **Deny Explícito** (Máxima prioridad; siempre se impone).
2. **Allow Explícito**.
3. **Deny Heredado**.
4. **Allow Heredado**.
5. **Denegación Implícita** (Si el usuario no está en ninguna ACE, el acceso es denegado automáticamente).

### 5. Toma de Posesión (*Ownership*) con `takeown`
* Permite a un administrador del sistema reclamar la propiedad de un archivo o carpeta cuando los permisos están corruptos o el usuario original fue borrado.
* Sintaxis: `takeown /F "ruta\archivo.ext"` o `takeown /F "ruta\carpeta" /R /D S` (recursivo).

---

## ❓ Preguntas Frecuentes de Examen Técnico

**P: Si un alumno pertenece al grupo `Alumnos` con permiso de Lectura en una carpeta, pero se agrega una regla de Denegar Escritura a `Todos`, ¿puede crear archivos en esa carpeta?**  
*R: No. El permiso `Deny` (Denegar) tiene precedencia absoluta sobre cualquier permiso de permitir concedido por pertenencia a grupos.*

**P: ¿Por qué es fundamental usar `/inheritance:d` antes de intentar quitar el grupo `Usuarios` con `icacls /remove`?**  
*R: Porque si la herencia sigue activa, los permisos de `Usuarios` provienen del volumen raíz `C:\` y no pueden ser eliminados en un subdirectorio sin romper primero la herencia.*
