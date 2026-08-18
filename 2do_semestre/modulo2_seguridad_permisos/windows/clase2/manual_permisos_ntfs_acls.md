# 📖 Manual de Permisos NTFS y Listas de Control de Acceso (ACL)
> *Laboratorio de Sistemas Operativos (LSO) — 4.º Año*  
> *Tecnicatura en Informática Personal y Profesional*

---

## 1. 📂 El Descriptor de Seguridad en Sistemas de Archivos NTFS

A diferencia de sistemas de archivos antiguos o planos (como FAT32 o exFAT), el sistema de archivos **NTFS** (*New Technology File System*) incorpora en cada archivo y carpeta una estructura binaria denominada **Descriptor de Seguridad** (*Security Descriptor*):

```text
┌────────────────────────────────────────────────────────────────────────┐
│             DESCRIPTOR DE SEGURIDAD (Security Descriptor)              │
├────────────────────────────────────────────────────────────────────────┤
│ • Owner SID: Propietario del archivo (posee el derecho WRITE_DAC)     │
│ • Primary Group SID: Grupo principal (compatibilidad POSIX)           │
├────────────────────────────────────────────────────────────────────────┤
│ • SACL (System ACL): Reglas de auditoría para el Visor de Eventos      │
├────────────────────────────────────────────────────────────────────────┤
│ • DACL (Discretionary ACL): Lista de Reglas de Acceso a Usuarios/Grupos│
│   ├── ACE 1: [Tipo: ALLOW/DENY] [SID: Usuario/Grupo] [Permiso: R/W/M/F]│
│   ├── ACE 2: [Tipo: ALLOW/DENY] [SID: Usuario/Grupo] [Herencia: (OI)(CI)]
│   └── ACE n: ...                                                       │
└────────────────────────────────────────────────────────────────────────┘
```

### Componentes del Descriptor:
1. **Owner SID (*Propietario*):** Cuenta que posee el derecho inalienable de modificar los permisos del objeto (derecho `WRITE_DAC`), incluso si se le revocan todos los permisos de lectura o escritura.
2. **DACL (*Discretionary ACL*):** Lista que especifica **quién** tiene permiso o prohibición para acceder al recurso y **qué** operaciones específicas puede realizar.
3. **SACL (*System ACL*):** Lista utilizada para generar eventos de auditoría en el Visor de Sucesos (*Event Viewer*) cuando un usuario accede o intenta acceder a un recurso.
4. **ACE (*Access Control Entry*):** Cada una de las entradas individuales dentro de una DACL o SACL.

---

## 2. 🔐 Permisos Estándar de NTFS

NTFS ofrece un conjunto de permisos estándar que agrupan combinaciones de permisos avanzados (*granular permissions*):

| Permiso Estándar | Código `icacls` | Descripción Técnica |
| :--- | :---: | :--- |
| **Control Total (*Full Control*)** | `F` | Control absoluto: lectura, escritura, modificación, eliminación, cambio de permisos (`WRITE_DAC`) y cambio de propietario (`WRITE_OWNER`). |
| **Modificar (*Modify*)** | `M` | Permite leer, ejecutar, crear archivos/carpetas y **eliminar** el archivo o subcarpeta. No permite cambiar permisos ni propietario. |
| **Lectura y Ejecución (*Read & Execute*)** | `RX` | Permite ver el contenido, atributos y ejecutar programas/scripts. |
| **Lectura (*Read*)** | `R` | Permite abrir el archivo y ver sus atributos/permisos (no permite ejecución si se separa). |
| **Escritura (*Write*)** | `W` | Permite sobrescribir el archivo o crear nuevos archivos/carpetas dentro del directorio. |

---

## 3. 🧬 Herencia de Permisos (*Inheritance*)

Por defecto en NTFS, los archivos y subcarpetas creados dentro de un directorio **heredan automáticamente** las entradas de control de acceso (ACEs) de la carpeta contenedora superior (*Parent Folder*).

### Banderas de Propagación de Herencia en `icacls`:
* **`(OI)` — *Object Inherit*:** Las subcarpetas y archivos heredarán esta entrada de control de acceso.
* **`(CI)` — *Container Inherit*:** Las subcarpetas heredarán esta entrada de control de acceso.
* **`(IO)` — *Inherit Only*:** La regla no se aplica a la carpeta actual, solo a los objetos que estén dentro de ella.
* **`(NP)` — *No Propagate*:** La regla se hereda solo un nivel hacia abajo, no se propaga a subniveles posteriores.

> **Combinación común:** `(OI)(CI)` significa que la regla se aplica al contenedor actual y a todos los archivos y subcarpetas descendientes recursivamente.

### Modos de Ruptura de Herencia:
1. **`/inheritance:d` (*Disable & Duplicate*):** Deshabilita la herencia pero **convierte los permisos heredados en permisos explícitos**, copiándolos en el objeto para poder editarlos individualmente.
2. **`/inheritance:r` (*Disable & Remove*):** Deshabilita la herencia y **elimina todos los permisos heredados**, dejando el recurso completamente aislado (solo accesible por el propietario o administradores).
3. **`/inheritance:e` (*Enable*):** Reactiva la herencia desde el contenedor superior.

---

## 4. ⚖️ Matriz de Precedencia y Resolución de Conflictos

Cuando un usuario pertenece a múltiples grupos con diferentes reglas sobre una misma carpeta, Windows SRM aplica el siguiente orden estricto de evaluación:

```text
┌───────────────────────────────────────────────────────────┐
│  1. ¿Existe un DENY Explícito directo en el objeto?       │
└─────────────────────────────┬─────────────────────────────┘
                              │
               ├── SÍ ────────┴────────► ⛔ ACCESO DENEGADO
               └── NO
                   ▼
┌───────────────────────────────────────────────────────────┐
│  2. ¿Existe un ALLOW Explícito directo en el objeto?      │
└─────────────────────────────┬─────────────────────────────┘
                              │
               ├── SÍ ────────┴────────► ✅ ACCESO PERMITIDO
               └── NO
                   ▼
┌───────────────────────────────────────────────────────────┐
│  3. ¿Existe un DENY Heredado de la carpeta padre?         │
└─────────────────────────────┬─────────────────────────────┘
                              │
               ├── SÍ ────────┴────────► ⛔ ACCESO DENEGADO
               └── NO
                   ▼
┌───────────────────────────────────────────────────────────┐
│  4. ¿Existe un ALLOW Heredado de la carpeta padre?        │
└─────────────────────────────┬─────────────────────────────┘
                              │
               ├── SÍ ────────┴────────► ✅ ACCESO PERMITIDO
               └── NO ─────────────────► ⛔ ACCESO DENEGADO (Implícito)
```

> 🔒 **Regla de Oro:** Un **Deny Explícito** anula cualquier **Allow** concedido individualmente o a través de cualquier grupo.

---

## 5. 🛠️ Comandos Esenciales: `icacls`, `takeown` y PowerShell

### Comando `icacls` (Integrity & Control ACLs):
```cmd
:: 1. Ver los permisos actuales de un archivo o carpeta
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria"

:: 2. Conceder permiso explícito de Modificar a un usuario
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria" /grant:r alumno_4to:(OI)(CI)M

:: 3. Denegar explícitamente escritura a un grupo
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria" /deny GRP_Alumnos:(OI)(CI)W

:: 4. Quitar un usuario de la lista de permisos (remover ACE)
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria" /remove alumno_4to

:: 5. Deshabilitar herencia copiando permisos existentes
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria" /inheritance:d

:: 6. Restablecer permisos heredados originales recursivamente
icacls "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria" /reset /T /C
```

### Toma de Posesión (*Ownership*) con `takeown`:
Si un usuario queda bloqueado o un archivo pertenece a una cuenta eliminada sin permisos de acceso, un administrador puede forzar la propiedad:
```cmd
:: Tomar propiedad del archivo actual
takeown /F "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados\clave_secreta.txt"

:: Tomar propiedad de una carpeta y todo su contenido recursivamente
takeown /F "C:\Temp\LSO_Modulo2\Clase2\Archivos_Bloqueados" /R /D S
```

### Equivalentes en PowerShell (`Get-Acl` y `Set-Acl`):
```powershell
# Obtener descriptor de seguridad y mostrar reglas de acceso
(Get-Acl "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria").Access | Format-Table IdentityReference, FileSystemRights, AccessControlType, IsInherited -AutoSize

# Clonar permisos de una carpeta a otra
$acl = Get-Acl "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Secretaria"
Set-Acl -Path "C:\Temp\LSO_Modulo2\Clase2\Empresa_Escuela\Docentes_Examenes" -AclObject $acl
```
