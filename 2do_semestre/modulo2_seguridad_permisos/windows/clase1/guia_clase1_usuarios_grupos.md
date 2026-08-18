# Guía Práctica de Laboratorio: Clase 1 (Windows 11)
## Gestión de Usuarios, Grupos Locales, SID, UAC y Herramientas Gráficas (GUI)

**Módulo 2:** Seguridad, Permisos y Gestión de Usuarios  
**Nivel:** 4.º Año — Tecnicatura en Informática Personal y Profesional  
**Entorno:** Windows 11 (CMD, PowerShell y Herramientas Gráficas)  

---

## 🎯 Objetivos de la Práctica
1. Descubrir cómo Windows identifica a los usuarios en el sistema a través de **SIDs**, **Tokens de Acceso** y **Privilegios**.
2. Administrar cuentas y grupos locales usando herramientas gráficas (`netplwiz`, Configuración) y comandos de consola (`net user`, `net localgroup`, PowerShell).
3. Entender cómo funciona la protección de Windows con el **Control de Cuentas de Usuario (UAC)**.
4. Resolver un desafío práctico de configuración de usuarios para una escuela técnica.

---

## 🧪 Actividad 1: Inspección de Identidades con `whoami`

Cada vez que inicias sesión, Windows te asigna un identificador numérico único llamado **SID** y un **Token de Seguridad** con tus permisos.

### Tarea 1.1: Identificar Usuario y SID
Ejecuta en CMD:
```cmd
whoami /user
```
> 📝 **Pregunta de Análisis 1:** Observa el código que aparece debajo de SID (empieza con `S-1-5-21...`). El último número tras el guion final es tu **RID**. Si es mayor o igual a 1000, indica que es una cuenta creada en el equipo. ¿Cuál es el tuyo?

### Tarea 1.2: Ver a qué Grupos perteneces
Ejecuta:
```cmd
whoami /groups
```
> Observa si tu usuario pertenece al grupo `Usuarios` (estándar) o `Administradores`.

### Tarea 1.3: Ver los Privilegios de tu Sesión
Ejecuta:
```cmd
whoami /priv
```
> Aquí puedes ver qué acciones especiales tiene permitidas tu usuario en el sistema (por ejemplo, `SeShutdownPrivilege` para apagar el equipo).

---

## 🖥️ Actividad 2: Herramientas Gráficas de Windows 11 para Administrar Cuentas

Windows 11 incluye aplicaciones visuales que nos permiten ver y configurar cuentas de manera intuitiva.

```text
┌─────────────────────────────────────────────────────────────┐
│          Herramientas Gráficas en Windows 11                │
├──────────────────────────────┬──────────────────────────────┤
│ • netplwiz                   │ Cuentas de usuario avanzadas │
│ • ms-settings:otherusers     │ Configuración moderna        │
│ • UserAccountControlSettings │ Ajuste visual del UAC        │
└──────────────────────────────┴──────────────────────────────┘
```

### Tarea 2.1: Explorar el Administrador Avanzado de Cuentas (`netplwiz`)
1. Presiona en tu teclado las teclas **`Win + R`**, escribe **`netplwiz`** y presiona **Enter**.
2. En la ventana que se abre:
   - Verás la lista de todos los usuarios registrados en la computadora.
   - Haz clic sobre tu usuario y luego presiona el botón **Propiedades**.
   - Abre la pestaña **Pertenencia a grupos**: Observa cómo Windows permite cambiar el nivel de un usuario entre *Usuario estándar*, *Administrador* u *Otro grupo*.
3. Haz clic en **Cancelar** para no realizar cambios accidentales.

### Tarea 2.2: Configuración Moderna de Cuentas
1. Presiona **`Win + R`**, escribe **`ms-settings:otherusers`** y presiona **Enter**.
2. Observa la ventana moderna de Configuración de Windows 11:
   - Aquí se pueden agregar otros usuarios al equipo.
   - Permite alternar fácilmente el rol de una cuenta entre Estándar y Administrador.

### Tarea 2.3: Visualizar el Control de Cuentas de Usuario (UAC)
1. Presiona **`Win + R`**, escribe **`UserAccountControlSettings.exe`** y presiona **Enter**.
2. Observa el **deslizador vertical con 4 niveles de seguridad**:
   - **Nivel Superior (Notificarme siempre):** Máxima seguridad. Pide confirmación cada vez que un programa o el usuario intente hacer cambios en el sistema.
   - **Nivel Predeterminado (Recomendado):** Te avisa cuando los programas intentan instalar algo o hacer cambios, pero no cuando tú mismo cambias configuraciones de Windows.
   - **Nivel Inferior (No notificar nunca):** Desactiva la protección (no recomendado).
3. Haz clic en **Cancelar** para mantener la configuración segura del equipo.

---

## 🧪 Actividad 3: Explorar Cuentas desde la Consola con `net user`

Aunque las herramientas visuales son cómodas, la consola de comandos permite a los técnicos obtener detalles completos y trabajar mucho más rápido.

### Tarea 3.1: Listar todas las Cuentas
Ejecuta en CMD:
```cmd
net user
```

### Tarea 3.2: Ver la Ficha Técnica de tu Usuario
Ejecuta:
```cmd
net user %USERNAME%
```
Revisa los siguientes datos en la pantalla:
- **Cuenta activa:** Indica si el usuario puede iniciar sesión.
- **La contraseña caduca:** Muestra si tiene fecha de vencimiento.
- **Pertenencia a grupos locales:** Grupos a los que pertenece.

---

## 🧪 Actividad 4: Creación de Usuarios y Grupos por Comandos (Consola de Administrador)

> [!NOTE]
> Para crear usuarios en el sistema se requiere abrir CMD con **"Ejecutar como Administrador"**. Si estás en una computadora con permisos restringidos, puedes practicar y anotar los comandos tal como se muestran a continuación.

### Tarea 4.1: Crear Usuarios de Prueba para un Colegio
```cmd
net user alumno_4to P@ssw0rd2026! /add /comment:"Cuenta de prueba Alumno LSO"
net user docente_lso ProfeSecure#2026 /add /comment:"Cuenta de prueba Docente LSO"
net user directivo_tec DirTics$2026 /add /comment:"Cuenta de prueba Directivo"
```

### Tarea 4.2: Crear Grupos de Trabajo
Los grupos nos permiten organizar los permisos de varias personas juntas:
```cmd
net localgroup GRP_Docentes /add /comment:"Grupo de profesores de Informatica"
net localgroup GRP_Alumnos /add /comment:"Grupo de estudiantes de 4to anio"
net localgroup GRP_Directivos /add /comment:"Grupo de directivos de la institucion"
```

### Tarea 4.3: Asignar Usuarios a sus Grupos
```cmd
net localgroup GRP_Docentes docente_lso /add
net localgroup GRP_Alumnos alumno_4to /add
net localgroup GRP_Directivos directivo_tec /add
```

### Tarea 4.4: Verificar los Miembros de un Grupo
```cmd
net localgroup GRP_Docentes
```

---

## ⚡ Actividad 5: Consultar Cuentas con PowerShell

PowerShell es la consola avanzada de Windows que muestra la información en tablas organizadas:

```powershell
# 1. Ver los usuarios con su SID en una tabla limpia
Get-LocalUser | Format-Table Name, Enabled, SID, Description -AutoSize

# 2. Ver todos los grupos locales
Get-LocalGroup | Format-Table Name, SID, Description -AutoSize

# 3. Ver quiénes están dentro del grupo GRP_Alumnos
Get-LocalGroupMember -Group "GRP_Alumnos"
```

---

## 🏆 Desafío Práctico: Configurar Políticas de una Cuenta

Aplica los siguientes ajustes de seguridad sobre la cuenta `alumno_4to`:
1. Evitar que el alumno cambie su contraseña (`/passwordchg:no`).
2. Establecer una fecha de vencimiento (`/expires:31/12/2026`).

```cmd
net user alumno_4to /passwordchg:no /expires:31/12/2026
```

### 🧹 Limpieza del Laboratorio (Opcional):
Para borrar las cuentas de prueba creadas:
```cmd
net user alumno_4to /delete
net user docente_lso /delete
net user directivo_tec /delete
net localgroup GRP_Docentes /delete
net localgroup GRP_Alumnos /delete
net localgroup GRP_Directivos /delete
```

---

## 📋 Cuestionario de Repaso
1. ¿Para qué sirve la herramienta gráfica `netplwiz` en Windows 11?
2. ¿Por qué cambiar el nombre a un usuario no borra sus permisos sobre los archivos existentes?
3. ¿Qué función cumple el Control de Cuentas de Usuario (UAC) cuando intentamos instalar un programa?
4. ¿Qué comando de CMD usamos para ver qué grupos existen en la computadora?
