# 📖 Manual de Seguridad en Windows: Cuentas, Grupos, SID y UAC
> *Laboratorio de Sistemas Operativos (LSO) — 4.º Año*  
> *Tecnicatura en Informática Personal y Profesional*

---

## 1. 🛡️ ¿Cómo Protege Windows a los Usuarios y Archivos?

Cuando encendemos una computadora con Windows, el sistema operativo necesita saber **quién está usando el equipo** y **qué acciones tiene permitido realizar** (abrir un archivo, instalar un programa o cambiar la configuración del sistema).

Para lograr esto, Windows cuenta con tres componentes internos clave que trabajan en equipo:

```text
┌─────────────────────────┐
│  Usuario en el Equipo   │
└────────────┬────────────┘
             │ Inicia sesión con contraseña
             ▼
┌─────────────────────────┐       Consulta cuentas       ┌────────────────────────┐
│ LSA / LSASS             ├─────────────────────────────►│ Base de Datos SAM      │
│ (Autoridad de Seguridad)│◄─────────────────────────────┤ (Almacén de Claves)    │
└────────────┬────────────┘       Valida credenciales    └────────────────────────┘
             │ 
             │ Genera y entrega credencial digital
             ▼
┌─────────────────────────┐
│ Token de Seguridad      │ (Contiene el SID del usuario y sus grupos)
└────────────┬────────────┘
             │ Presenta el Token al intentar acceder a un archivo
             ▼
┌─────────────────────────┐
│ SRM (Security Reference │
│ Monitor en el Kernel)   │◄─── Compara Token vs Lista de Permisos (ACL)
└────────────┬────────────┘
             │
             ▼
┌────────────────────────────────────────────────────────┐
│  ¿Tiene Permiso?                                       │
│  ├── SÍ  ──► Acceso concedido al archivo o carpeta     │
│  └── NO  ──► Acceso denegado (Error de permisos)       │
└────────────────────────────────────────────────────────┘
```

### Conceptos Clave Explicados Fácil:
1. **Base de Datos SAM (*Security Accounts Manager*):** Es el "fichero seguro" de Windows (almacenado en `C:\Windows\System32\config\SAM`) donde se guardan los nombres de los usuarios y sus contraseñas protegidas.
2. **LSA / LSASS (*Local Security Authority*):** Es el "guardia de seguridad" del sistema (`lsass.exe`). Revisa que tu contraseña sea correcta y te entrega una credencial digital llamada **Token de Acceso**.
3. **SRM (*Security Reference Monitor*):** Es el verificador en el núcleo (*Kernel*) de Windows. Cada vez que intentas abrir, modificar o borrar un archivo, revisa tu Token para comprobar si tienes permiso.

---

## 2. 🆔 El SID (*Security Identifier*): El DNI de tu Usuario

En la vida real, las personas nos identificamos legalmente por nuestro número de DNI y no solo por nuestro nombre, porque puede haber otras personas con el mismo nombre o podemos cambiarlo legalmente.

En Windows ocurre exactamente lo mismo: **Windows no utiliza tu nombre para darte permisos, utiliza un código numérico único e inmutable llamado SID.**

### Estructura de un SID:

```text
  S - 1 - 5 - 21 - 3623811015 - 3361044348 - 30300820 - 1001
  │   │   │   │                                          │
  │   │   │   └─► Identificador del Equipo Local        └─► RID (Usuario creado)
  │   │   └─────► Autoridad Emisora (NT Authority)
  │   └─────────► Nivel de Revisión (Siempre 1)
  └─────────────► Indica que es una cadena SID
```

* **RID (*Relative Identifier* - Número final tras el último guion):**
  - **RID 500:** Usuario **Administrador integrado** del sistema.
  - **RID 501:** Usuario **Invitado** (*Guest*).
  - **RID 1000 en adelante (1001, 1002, etc.):** Cuentas de usuario creadas por nosotros.

> 💡 **¿Por qué es fundamental el SID?**  
> Si a un usuario llamado `Carlos` le cambias el nombre a `Carlos_Admin`, **todos sus permisos siguen funcionando exactamente igual**, porque las carpetas le dan permiso a su **SID** y el SID nunca cambia.

---

## 3. 👥 Tipos de Cuentas y Grupos de Usuarios

Para mantener el orden y la seguridad, Windows divide las cuentas en diferentes categorías:

### Tipos de Cuentas:
1. **Cuentas de Administrador:** Tienen control total sobre el equipo. Pueden instalar software, modificar configuraciones críticas del sistema y gestionar a los demás usuarios.
2. **Cuentas Estándar:** Son para el uso diario seguro. Pueden usar programas, navegar por internet y guardar archivos personales, pero no pueden alterar archivos de otros usuarios ni desconfigurar el sistema.

### ¿Qué es un Grupo?
Un **Grupo** es un conjunto de usuarios. En lugar de darle permisos a cada persona de a una, creamos un grupo (por ejemplo `Docentes` o `Alumnos`) y le asignamos los permisos al grupo completo.

---

## 4. 🖥️ Herramientas Gráficas de Administración en Windows 11

En Windows 11 disponemos de varias herramientas visuales muy útiles para consultar y configurar cuentas:

| Herramienta | ¿Cómo se abre? | ¿Para qué sirve? |
| :--- | :--- | :--- |
| **Cuentas Avanzadas (`netplwiz`)** | `Win + R` → escribir `netplwiz` | Muestra la lista completa de usuarios y permite cambiar de grupo a una cuenta (Estándar, Administrador u otros). |
| **Configuración de Cuentas** | `Win + R` → `ms-settings:otherusers` | Pantalla moderna para agregar nuevos usuarios y cambiar su tipo de cuenta. |
| **Ajuste de UAC** | `Win + R` → `UserAccountControlSettings.exe` | Permite ajustar con una barra deslizante qué tan seguido Windows nos avisa ante cambios en el equipo. |

---

## 5. 🛡️ Control de Cuentas de Usuario (UAC): El Escudo de Windows

¿Alguna vez viste que la pantalla se oscurece y aparece una ventana preguntando: *"¿Quieres permitir que esta aplicación haga cambios en el dispositivo?"*?

Esa protección se llama **UAC (*User Account Control*)**.

```text
┌───────────────────────────────────────────────────────────┐
│     Inicio de Sesión de una Cuenta Administrador         │
└─────────────────────────────┬─────────────────────────────┘
                              │ Windows genera 2 Tokens
                              ▼
        ┌───────────────────────────────────────────┐
        │  Token Estándar (Uso Cotidiano)           │
        │  • Navegar por internet                   │
        │  • Usar procesador de texto, juegos       │
        │  • Abrir carpetas personales              │
        └─────────────────────┬─────────────────────┘
                              │
                              │ ¿Un programa intenta instalar software
                              │  o modificar archivos del sistema?
                              ▼
        ┌───────────────────────────────────────────┐
        │        VENTANA DE ALERTA DE UAC           │
        │  "¿Desea permitir que esta aplicación     │
        │   haga cambios en el dispositivo?"        │
        └─────────────────────┬─────────────────────┘
                              │
               ┌──────────────┴──────────────┐
               │ Clic en "SÍ"                │ Clic en "NO"
               ▼                             ▼
┌─────────────────────────────┐ ┌───────────────────────────┐
│ Se activa temporalmente el  │ │ Se cancela la operación.  │
│ Token Elevado con permisos  │ │ El sistema queda a salvo  │
│ de Administrador.           │ │ de cambios no deseados.   │
└─────────────────────────────┘ └───────────────────────────┘
```

### ¿Por qué existe el UAC?
Incluso si tu usuario es Administrador, Windows hace que tus programas cotidianos funcionen con privilegios de **usuario estándar**. Si un virus o malware intentara ejecutarse silenciosamente en segundo plano, el UAC lo detiene de inmediato pidiéndote autorización en pantalla.

---

## 6. 🛠️ Comandos Esenciales de Consola (CMD y PowerShell)

Los técnicos informáticos utilizan la consola de comandos porque es más rápida, potente y permite automatizar tareas mediante scripts:

```cmd
:: 1. Ver qué usuario soy y cuál es mi SID
whoami /user

:: 2. Ver todos los grupos a los que pertenezco
whoami /groups

:: 3. Listar todos los usuarios del equipo
net user

:: 4. Ver los detalles de una cuenta específica
net user alumno_4to

:: 5. Crear un nuevo usuario con contraseña
net user Juan Perez2026! /add

:: 6. Listar todos los grupos del equipo
net localgroup

:: 7. Crear un grupo y agregar un usuario adentro
net localgroup Alumnos_LSO /add
net localgroup Alumnos_LSO Juan /add
```
