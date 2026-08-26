# Guía Práctica de Laboratorio: Clase 2 (Windows 11)
## Permisos NTFS, Listas de Control de Acceso (ACLs), Herencia y Propietario (CLI + GUI)

**Módulo 2:** Seguridad, Permisos y Gestión de Usuarios  
**Nivel:** 4.º Año — Tecnicatura en Informática Personal y Profesional  
**Entorno:** Windows 11 (CMD `icacls`, `takeown`, PowerShell `Get-Acl` y Explorador de Archivos GUI)  

---

## 🎯 Objetivos de la Práctica
1. Auditar la Lista de Control de Acceso Discrecional (**DACL**) mediante comandos de consola (`icacls`) y contrastarla visualmente en la **Configuración de Seguridad Avanzada** del Explorador de Windows.
2. Configurar permisos granulares con el comando `icacls` (Control Total, Modificar, Lectura/Escritura) y verificar la propagación en la GUI (*"Se aplica a"*).
3. Romper y restaurar la **herencia de permisos** aplicando `icacls /inheritance` y correlacionar las opciones de consola con los diálogos gráficos de herencia de Windows.
4. Resolver escenarios reales de conflicto de permisos (Allow vs. Deny) utilizando la herramienta nativa de **"Acceso efectivo"** (*Effective Access*).
5. Recuperar el control de recursos bloqueados mediante **toma de posesión** tanto por CLI (`takeown`) como a través del diálogo de seguridad del Explorador.

---

## ⚙️ Paso 0: Preparación del Escenario de Laboratorio

1. Abre una ventana de **Símbolo del Sistema (CMD)**.
2. Ejecuta el script de inicialización:
   ```cmd
   setup_clase2.bat
   ```
3. Comprueba que se haya generado la estructura de carpetas en `C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela`.

---

## 🧪 Actividad 1: Auditoría de ACLs (Consola `icacls` vs. GUI Avanzada)

### Tarea 1.1: Inspección por Consola
Ejecuta el siguiente comando para ver las ACEs de la carpeta `Publico_Lectura`:
```cmd
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Publico_Lectura"
```

**Análisis del Resultado:**
Observarás salidas similares a:
```text
Todos:(OI)(CI)(R)
NT AUTHORITY\SYSTEM:(I)(OI)(CI)(F)
BUILTIN\Administradores:(I)(OI)(CI)(F)
BUILTIN\Usuarios:(I)(OI)(CI)(RX)
```

### Tarea 1.2: Verificación Visual en la Interfaz Gráfica (GUI)
1. Abre el **Explorador de Archivos** (`Win + E`) y navega hasta `C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela`.
2. Haz clic derecho sobre la carpeta **`Publico_Lectura`** → **Propiedades** → pestaña **Seguridad**.
   - Observa la lista de *Nombres de grupos o usuarios* y el panel inferior de *Permisos*.
3. Haz clic en el botón **Opciones avanzadas**.
4. En la ventana **"Configuración de seguridad avanzada para Publico_Lectura"**, examina la tabla de **Entradas de permisos (DACL)**:
   - **Columna "Heredado de":** Identifica qué reglas provienen de `C:\` y compáralas con la bandera `(I)` de la consola.
   - **Columna "Se aplica a":** Observa el texto *"Esta carpeta, subcarpetas y archivos"* y compáralo con las banderas `(OI)(CI)` del comando `icacls`.

> 📝 **Preguntas de Análisis:**
> 1. ¿Qué relación directa existe entre la bandera `(I)` de `icacls` y la columna *"Heredado de"* en la ventana gráfica?
> 2. ¿Qué diferencia visual aprecias en la pestaña básica de Seguridad cuando seleccionas un usuario con permisos heredados (las casillas aparecen en gris deshabilitadas) versus permisos explícitos?

---

## 🧪 Actividad 2: Aislamiento Departamental y Ruptura de Herencia

En la carpeta `Secretaria`, los alumnos no deben tener acceso de lectura ni los usuarios generales deben poder ver los archivos de legajos.

### Tarea 2.1: Deshabilitar la Herencia de Permisos
Ejecuta en consola:
```cmd
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria" /inheritance:d
```
> Observa que ahora los permisos ya no tienen la marca `(I)`. Se han convertido en **permisos explícitos** en este objeto.

### Tarea 2.2: Remover Permisos a Usuarios Estándar
Elimina los permisos del grupo genérico `Usuarios`:
```cmd
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria" /remove:g "BUILTIN\Usuarios"
```

### Tarea 2.3: Asignar Permiso Específico
Concede permiso de **Modificar** (`M`) a tu usuario actual con propagación completa:
```cmd
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria" /grant:r %USERNAME%:(OI)(CI)M
```

### Tarea 2.4: Inspección y Validación Gráfica
1. En el Explorador de Windows, ve a las **Propiedades** de `Secretaria` → pestaña **Seguridad** → **Opciones avanzadas**.
2. Verifica que:
   - El botón inferior ahora dice **"Habilitar herencia"** (lo que confirma que la herencia fue deshabilitada).
   - En la columna *Heredado de* todas las entradas dicen **"Ninguno"** (son explícitas).
   - El grupo `Usuarios` ya no figura en la lista.
   - Tu usuario aparece con Acceso de **"Modificar"** y *Se aplica a* indica **"Esta carpeta, subcarpetas y archivos"**.

> 💡 **Equivalencia GUI:** Si hubieras querido hacer la Tarea 2.1 desde la interfaz gráfica, habrías presionado el botón **"Deshabilitar herencia"** y seleccionado la opción: *"Convertir los permisos heredados en permisos explícitos en este objeto"*.

---

## 🧪 Actividad 3: Configuración de un Buzón Ciego (*Drop Box*) para Alumnos

Configuraremos la carpeta `Alumnos_Buzon` para que los estudiantes puedan **crear y escribir archivos** de sus entregas, pero **no puedan modificar ni ver/borrar los trabajos de otros compañeros**.

### Tarea 3.1: Configuración con `icacls`
1. Rompe la herencia en `Alumnos_Buzon`:
   ```cmd
   icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Alumnos_Buzon" /inheritance:d
   ```
2. Asigna permiso de sólo creación/escritura (`(OI)(CI)(W)`):
   ```cmd
   icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Alumnos_Buzon" /grant "BUILTIN\Usuarios":(OI)(CI)(W)
   ```
3. Concede Control Total al grupo de profesores/administradores:
   ```cmd
   icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Alumnos_Buzon" /grant "BUILTIN\Administradores":(OI)(CI)(F)
   ```

### Tarea 3.2: Auditoría Gráfica de Permisos Avanzados
1. Haz clic derecho en `Alumnos_Buzon` → **Propiedades** → **Seguridad** → **Opciones avanzadas**.
2. Selecciona la entrada de `Usuarios` y haz clic en **Ver** (o *Editar*).
3. Haz clic en **Mostrar permisos avanzados**:
   - Observa qué casillas están marcadas: *Crear archivos / escribir datos*, *Crear carpetas / anexar datos*, *Escribir atributos*.
   - Comprueba que las casillas de *Lectura* y *Eliminar* se encuentren **desmarcadas**.

---

## 🧪 Actividad 4: Toma de Posesión (*Takeown*) y Recuperación de Archivos

En la carpeta `Archivos_Bloqueados` existe un archivo protegido con propietario huérfano.

### Tarea 4.1: Consultar el Propietario Actual (PowerShell)
```powershell
Get-Acl "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados\clave_secreta.txt" | Select-Object Path, Owner
```

### Tarea 4.2: Forzar la Propiedad por Consola con `takeown` (CMD Elevado)
```cmd
takeown /F "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados\clave_secreta.txt"
```
> El sistema responderá: *`CORRECTO: el archivo (o carpeta): "..." ahora pertenece al usuario "...".`*

### Tarea 4.3: Reasignar Permisos de Control Total al Nuevo Propietario
Una vez obtenida la propiedad, puedes asignarte permisos totales con `icacls`:
```cmd
icacls "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados\clave_secreta.txt" /grant %USERNAME%:F
```

### Tarea 4.4: Verificación Gráfica del Propietario (*Owner*)
1. Haz clic derecho sobre `clave_secreta.txt` → **Propiedades** → **Seguridad** → **Opciones avanzadas**.
2. En la parte superior verás: **Propietario:** (ahora figura tu cuenta de usuario).
3. *(Opcional)* Observa el vínculo azul **"Cambiar"** al lado del propietario: esta es la interfaz gráfica equivalente para transferir la propiedad sin usar `takeown`.

### Tarea 4.5: Verificar Lectura del Archivo
```cmd
type "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados\clave_secreta.txt"
```

---

## 🏆 Desafío de Ciberseguridad: "Conflicto Deny vs. Allow y Diagnóstico con Acceso Efectivo"

### Tarea D.1: Provocar el Conflicto por Consola
1. Concede a tu usuario permiso explícito de **Control Total** (`F`) sobre `normas_convivencia.txt`:
   ```cmd
   icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Publico_Lectura\normas_convivencia.txt" /grant %USERNAME%:F
   ```
2. Aplica una regla de **Denegación Explícita** (`/deny`) de Lectura (`R`) para el grupo `Todos` (*Everyone*):
   ```cmd
   icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Publico_Lectura\normas_convivencia.txt" /deny "Todos":(R)
   ```
3. Intenta leer el archivo en consola:
   ```cmd
   type "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Publico_Lectura\normas_convivencia.txt"
   ```
   > Mensaje recibido: **Acceso denegado.**

### Tarea D.2: Diagnóstico Profesional con la Pestaña "Acceso Efectivo" (GUI)
¿Cómo puede un sysadmin diagnosticar por qué un usuario no puede leer un archivo si en la lista general ve que tiene *Control Total*?
1. Haz clic derecho en `normas_convivencia.txt` → **Propiedades** → **Seguridad** → **Opciones avanzadas**.
2. Ve a la pestaña **Acceso efectivo** (*Effective Access*).
3. Haz clic en **Seleccionar un usuario** → escribe tu nombre de usuario → presiona *Comprobar nombres* y luego *Aceptar*.
4. Haz clic en el botón **Ver acceso efectivo**.
5. **Observa los resultados:**
   - Verás una lista de todos los derechos individuales con marcas de verificación verdes (✅) o cruces rojas (❌).
   - Localiza *Leer datos*: ¡aparece con una ❌ roja!
   - Al pasar el cursor o hacer clic sobre el detalle, Windows te informa que el permiso fue bloqueado por una regla de denegación explícita perteneciente al grupo `Todos`.

> ❓ **Pregunta de Cierre:** ¿Por qué la herramienta de *Acceso Efectivo* es fundamental en empresas donde los usuarios pertenecen a decenas de grupos de seguridad de Directorio Activo?

---

## 📋 Cuestionario de Fijación Conceptual
1. ¿Cuál es la diferencia técnica entre `/inheritance:d` y `/inheritance:r` en `icacls`, y qué opciones representan en la ventana de advertencia gráfica de Windows?
2. ¿Qué representan las banderas `(OI)` y `(CI)` al asignar una ACE y cómo se reflejan en el desplegable *"Se aplica a"* de la interfaz gráfica?
3. Si un archivo tiene revocados todos los permisos incluso para administradores, ¿qué dos pasos (CLI o GUI) se deben realizar para recuperar el acceso?
4. ¿Cómo ayuda la pestaña *"Acceso efectivo"* a resolver disputas de permisos cuando intervienen múltiples grupos?
