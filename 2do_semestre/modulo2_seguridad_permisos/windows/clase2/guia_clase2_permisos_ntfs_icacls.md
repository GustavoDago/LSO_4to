# Guía Práctica de Laboratorio: Clase 2 (Windows 11)
## Permisos NTFS, Listas de Control de Acceso (ACLs), Herencia y Propietario

**Módulo 2:** Seguridad, Permisos y Gestión de Usuarios  
**Nivel:** 4.º Año — Tecnicatura en Informática Personal y Profesional  
**Entorno:** Windows 11 (CMD `icacls`, `takeown` & PowerShell `Get-Acl`)  

---

## 🎯 Objetivos de la Práctica
1. Auditar la Lista de Control de Acceso Discrecional (**DACL**) en estructuras de directorios NTFS.
2. Configurar permisos granulares con el comando `icacls` (Control Total, Modificar, Lectura/Escritura).
3. Romper y restaurar la **herencia de permisos** aplicando las opciones de duplicación (`/inheritance:d`) y eliminación (`/inheritance:r`).
4. Resolver escenarios reales de conflicto de permisos (Allow vs. Deny) y recuperación de acceso forzado mediante **toma de posesión** (`takeown`).

---

## ⚙️ Paso 0: Preparación del Escenario de Laboratorio

1. Abre una ventana de **Símbolo del Sistema (CMD)**.
2. Ejecuta el script de inicialización:
   ```cmd
   setup_clase2.bat
   ```
3. Comprueba que se haya generado la estructura de carpetas en `C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela`.

---

## 🧪 Actividad 1: Auditoría de ACLs con `icacls`

### Tarea 1.1: Inspección de Permisos Iniciales
Ejecuta el siguiente comando para ver las ACEs de la carpeta `Publico_Lectura`:
```cmd
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Publico_Lectura"
```

### Análisis del Resultado:
Observarás salidas similares a:
```text
Todos:(OI)(CI)(R)
NT AUTHORITY\SYSTEM:(I)(OI)(CI)(F)
BUILTIN\Administradores:(I)(OI)(CI)(F)
BUILTIN\Usuarios:(I)(OI)(CI)(RX)
```

> 📝 **Preguntas de Análisis:**
> 1. ¿Qué significa la letra `(I)` en las entradas de `SYSTEM` y `Administradores`? *(Indica que provienen de la Herencia - Inherited).*
> 2. ¿Qué diferencia práctica genera la presencia de `(OI)(CI)` frente a una entrada sin estas banderas?

---

## 🧪 Actividad 2: Aislamiento Departamental y Ruptura de Herencia

En la carpeta `Secretaria`, los alumnos no deben tener acceso de lectura ni los usuarios generales deben poder ver los archivos de legajos.

### Tarea 2.1: Deshabilitar la Herencia de Permisos
Ejecuta:
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
Concede permiso de **Modificar** (`M`) al usuario o grupo de secretaría (o a tu usuario actual):
```cmd
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria" /grant:r %USERNAME%:(OI)(CI)M
```

### Tarea 2.4: Comprobar el Estado Final
```cmd
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria"
```

---

## 🧪 Actividad 3: Configuración de un Buzón Ciego (*Drop Box*) para Alumnos

Configuraremos la carpeta `Alumnos_Buzon` para que los estudiantes puedan **crear y escribir archivos** de sus entregas, pero **no puedan modificar ni borrar los trabajos de otros compañeros**.

### Tarea 3.1: Configuración de Permisos Especiales
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

---

## 🧪 Actividad 4: Toma de Posesión y Recuperación de Archivos con `takeown`

En la carpeta `Archivos_Bloqueados` existe un archivo protegido con propietario huérfano.

### Tarea 4.1: Consultar el Propietario Actual
Abre PowerShell y consulta el propietario del archivo:
```powershell
Get-Acl "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados\clave_secreta.txt" | Select-Object Path, Owner
```

### Tarea 4.2: Forzar la Propiedad con `takeown` (Consola CMD Elevada)
Ejecuta:
```cmd
takeown /F "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados\clave_secreta.txt"
```
> El sistema responderá: *`CORRECTO: el archivo (o carpeta): "..." ahora pertenece al usuario "...".`*

### Tarea 4.3: Reasignar Permisos de Control Total al Nuevo Propietario
Una vez obtenida la propiedad, puedes asignarte permisos totales con `icacls`:
```cmd
icacls "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados\clave_secreta.txt" /grant %USERNAME%:F
```

### Tarea 4.4: Verificar Lectura del Archivo
```cmd
type "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados\clave_secreta.txt"
```

---

## 🏆 Desafío de Ciberseguridad: "El Conflicto de Permisos Deny vs. Allow"

1. Concede a tu usuario permiso explícito de **Control Total** (`F`) sobre el archivo `normas_convivencia.txt`:
   ```cmd
   icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Publico_Lectura\normas_convivencia.txt" /grant %USERNAME%:F
   ```
2. Ahora, aplica una regla de **Denegación Explícita** (`/deny`) de Lectura (`R`) para el grupo `Todos` (*Everyone*):
   ```cmd
   icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Publico_Lectura\normas_convivencia.txt" /deny "Todos":(R)
   ```
3. Intenta leer el archivo con `type`:
   ```cmd
   type "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Publico_Lectura\normas_convivencia.txt"
   ```

> ❓ **Pregunta de Laboratorio:** ¿Qué mensaje devolvió el sistema operativo y por qué el permiso `Deny` se impuso sobre el permiso `Full Control` de tu usuario?

---

## 📋 Cuestionario de Fijación Conceptual
1. ¿Cuál es la diferencia técnica entre `/inheritance:d` y `/inheritance:r` en el comando `icacls`?
2. ¿Qué representan las banderas `(OI)` y `(CI)` al asignar una ACE en un directorio?
3. Si un archivo tiene revocados todos los permisos de acceso para todos los usuarios (incluso administradores), ¿cómo puede el Administrador recuperar el acceso al archivo?
4. ¿En qué orden evalúa el subsistema SRM de Windows los permisos explícitos y heredados?
