# Guía de Laboratorio Práctico: Ticket #401
## Incidente de Infraestructura de Almacenamiento y Fuga de Datos
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional

---

## 📋 Resumen del Incidente (Caso de Soporte N.º 401)
* **Cliente / Servidor:** Servidor Local de Archivos `SRV-DATOS-01` (Windows 11 Host).
* **Prioridad:** Alta.
* **Descripción del Problema:**
  Tras un corte de energía y reinicio inesperado del equipo, el departamento contable reporta que la unidad virtual de almacenamiento `V:` (donde residen los proyectos y balances) no aparece en el Explorador de Archivos. Paralelamente, el área de Seguridad de la Información detectó una alerta crítica: la carpeta de auditoría interna `Auditoria_RRHH` heredó permisos permisivos de la raíz del disco, permitiendo que cualquier usuario estándar de la red local pueda leer y modificar documentos confidenciales de sueldos.
* **Misión del Administrador de Sistemas (Alumno de 4.º Año):**
  1. Recomponer la infraestructura de almacenamiento utilizando la herramienta clínica de consola `diskpart`: adjuntar el disco virtual dinámico (VHDX), inicializarlo bajo esquema **GPT**, crear la partición primaria con sistema de archivos **NTFS** y montarlo en la letra `V:`.
  2. Auditar identidades locales y privilegios del sistema mediante `whoami /all`, identificando **SIDs** y tokens de elevación (**UAC**).
  3. Remediación de seguridad con `icacls`: romper la herencia de permisos NTFS, expulsar cuentas no autorizadas, conceder permisos mínimos necesarios y aplicar una regla de denegación explícita para comprobar la matriz de precedencia de accesos (**Deny > Allow**).

---

## ⚙️ Entorno y Preparación del Laboratorio (< 1 Minuto)

Antes de comenzar, ejecuta en una consola de comandos (**CMD con privilegios de Administrador**) el script de automatización provisto por la cátedra:

```cmd
setup_repaso_clase1.bat
```

> [!NOTE]
> El script prepara el entorno en `C:\LaboratorioLSO\Incidente401` generando los archivos de prueba y verificando que el entorno quede limpio en computadoras con Deep Freeze o netbooks escolares.

---

## 🛠️ Fase 1: Diagnóstico y Montaje de Almacenamiento con `diskpart`

El disco virtual dinámico fue ubicado en `C:\LaboratorioLSO\Incidente401\disco_proyectos.vhdx` (o `.vhd` en netbooks). Debe ser adjuntado y preparado sin entorno gráfico.

### Paso 1.1: Ingresar a la consola de particionamiento
Abre la consola de `diskpart` desde tu terminal:
```cmd
diskpart
```

### Paso 1.2: Seleccionar y adjuntar el disco virtual
Ejecuta la secuencia de comandos para seleccionar el contenedor y montarlo en el subsistema de almacenamiento del Kernel:
```cmd
select vdisk file="C:\LaboratorioLSO\Incidente401\disco_proyectos.vhdx"
attach vdisk
list disk
```

> [!IMPORTANT]
> Observa la salida de `list disk`. Identifica el **Número de Disco** asignado a tu unidad virtual (por lo general, Disco 1 o Disco 2, con un tamaño aproximado de 256 MB o 128 MB). Notarás que no posee asterisco `*` en la columna **Gpt** si está sin inicializar.

### Paso 1.3: Inicialización bajo esquema moderno GPT
Selecciona el disco recién adjuntado y convierte su tabla de particiones al estándar **GPT** (GUID Partition Table), superando las limitaciones del antiguo MBR:
```cmd
select disk X
convert gpt
list disk
```
*(Reemplaza `X` por el número de disco correspondiente a tu VHD).*

Verifica que ahora el disco muestre el asterisco `*` en la columna **Gpt**.

---

## 🗄️ Fase 2: Particionamiento, Formateo NTFS y Asignación de Letra

### Paso 2.1: Creación de la partición primaria
Dentro de `diskpart`, con el disco `X` seleccionado, crea una partición primaria que ocupe todo el espacio disponible:
```cmd
create partition primary
list partition
```

### Paso 2.2: Formateo con arquitectura NTFS y asignación de letra
Formatea la partición utilizando el sistema de archivos **NTFS** (vital para soportar Listas de Control de Acceso DACL y metadatos MFT) con la etiqueta `DATOS_PROYECTOS` y asígnale la letra `V`:
```cmd
format fs=ntfs label="DATOS_PROYECTOS" quick
assign letter=V
detail volume
```

### Paso 2.3: Salir de Diskpart
```cmd
exit
```

Comprueba desde la línea de comandos ordinaria que la unidad `V:` esté operativa:
```cmd
dir V:\
```

---

## 👤 Fase 3: Auditoría de Identidades, Grupos y SIDs

Para resolver el problema de permisos, primero debemos auditar con qué credenciales e identificadores únicos opera el sistema operativo.

### Paso 3.1: Inspección de Token y SIDs
Ejecuta en CMD:
```cmd
whoami /all
```

Registra en tu informe técnico de resolución:
1. **SID de Usuario:** ¿Cuál es el Identificador de Seguridad único (inicia con `S-1-5-21-...`) de tu usuario actual?
2. **Grupos y Privilegios:** Localiza el grupo `BUILTIN\Administradores` o `Usuarios`. ¿Cuál es su estado en la columna de atributos?
3. **Nivel de Integridad:** ¿El token está marcado como *Nivel de integridad alto* (ejecutado como Administrador con UAC elevado) o *Nivel de integridad medio*?

### Paso 3.2: Creación de carpetas de simulación en `V:\`
Crea la estructura de carpetas corporativas en el nuevo disco:
```cmd
mkdir "V:\ProyectosPublicos"
mkdir "V:\Auditoria_RRHH"
echo Archivo Confidencial de Sueldos > "V:\Auditoria_RRHH\balance_privado.txt"
```

---

## 🔒 Fase 4: Reestructuración de Permisos NTFS con `icacls`

El directorio `V:\Auditoria_RRHH` debe cumplir las siguientes directivas de ciberseguridad estrictas:
* **Directiva 1:** Ningún usuario no autorizado debe heredar permisos de la raíz `V:\`.
* **Directiva 2:** El grupo `Administradores` debe tener **Control Total (F)**.
* **Directiva 3:** El grupo local `Usuarios` (`BUILTIN\Usuarios`) solo debe tener permisos de **Lectura y Ejecución (RX)** sobre `V:\ProyectosPublicos`.
* **Directiva 4:** En `V:\Auditoria_RRHH`, el grupo `Usuarios` debe ser expulsado completamente de la DACL.
* **Directiva 5 (Prueba de Precedencia):** Para probar el principio de seguridad de Windows, se aplicará una regla de denegación explícita (`/deny`) sobre un usuario de pruebas y se comprobará que **Deny prevalece sobre Allow**.

### Paso 4.1: Inspeccionar los permisos heredados actuales
```cmd
icacls "V:\Auditoria_RRHH"
```
Notarás que las entradas indican `(I)` de **Heredado** (*Inherited*).

### Paso 4.2: Desactivar la herencia (Romper el enlace con la raíz)
Copia los permisos heredados como permisos explícitos para poder editarlos:
```cmd
icacls "V:\Auditoria_RRHH" /inheritance:d
```

### Paso 4.3: Expulsar a los usuarios estándar de la carpeta confidencial
Remueve al grupo `Usuarios` de la DACL de `V:\Auditoria_RRHH`:
```cmd
icacls "V:\Auditoria_RRHH" /remove "Usuarios"
```

### Paso 4.4: Conceder Control Total exclusivo a Administradores
Asegura que solo los administradores gestionen la carpeta:
```cmd
icacls "V:\Auditoria_RRHH" /grant:r "Administradores":(OI)(CI)(F)
```
*(Donde `(OI)` significa Object Inherit para archivos y `(CI)` Container Inherit para subcarpetas).*

### Paso 4.5: Prueba de Fuego de Precedencia (Deny explícito)
Aplica una regla de denegación sobre el archivo confidencial:
```cmd
icacls "V:\Auditoria_RRHH\balance_privado.txt" /deny %USERNAME%:(W)
```
Intenta ahora modificar el archivo:
```cmd
echo Intento de alteracion >> "V:\Auditoria_RRHH\balance_privado.txt"
```
> **Resultado Esperado:** La terminal responderá con `Acceso denegado`. A pesar de pertenecer al grupo Administradores con Control Total (Allow), la regla de **Denegación Explícita (Deny)** es procesada primero por el subsistema de seguridad de Windows (LSA/Kernel) y bloquea la operación.

---

## 🧪 Fase 5: Verificación Final y Cuestionario de Cierre

Ejecuta el comando final de comprobación y copia la salida:
```cmd
icacls "V:\Auditoria_RRHH"
icacls "V:\Auditoria_RRHH\balance_privado.txt"
```

### 📝 Preguntas de Diagnóstico Técnico (Autoevaluación)
1. ¿Qué comando de `diskpart` permite que el archivo `.vhdx` sea reconocido por el sistema como una unidad de disco física?
2. ¿Por qué es obligatorio utilizar el sistema de archivos **NTFS** en lugar de **FAT32** para cumplir con las directivas de seguridad solicitadas en el ticket?
3. ¿Qué función cumple el conmutador `/inheritance:d` en `icacls` y en qué se diferencia de `/inheritance:r`?
4. Si un usuario tiene asignado permiso explícito de **Lectura (R)** a través de su cuenta individual, pero pertenece a un grupo con permiso de **Escritura (W)**, ¿qué permisos efectivos tendrá? ¿Y qué sucedería si a su grupo se le asigna **Deny (D)** a la lectura?

---

## 🧹 Limpieza del Laboratorio (Post-Práctica)
Al finalizar la clase, para dejar el equipo disponible para la siguiente comisión:
```cmd
diskpart
select vdisk file="C:\LaboratorioLSO\Incidente401\disco_proyectos.vhdx"
detach vdisk
exit
```
