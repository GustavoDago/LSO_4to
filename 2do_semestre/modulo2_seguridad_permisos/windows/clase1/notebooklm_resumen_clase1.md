# Ficha Didáctica NotebookLM: Cuentas, Grupos, SID, UAC y Herramientas Gráficas en Windows
**Cuaderno:** LSO 4to - 2do semestre  
**Módulo:** 2 - Seguridad, Permisos y Gestión de Usuarios (Clase 1 - Windows 11)  

---

## 🎙️ Podcast Prompt (Resumen de Audio para NotebookLM)
> "En este episodio explicamos cómo Windows identifica y protege a los usuarios y recursos. Descubrimos qué es un SID (Security Identifier) y por qué Windows utiliza este número único en lugar del nombre de usuario para gestionar permisos. Analizamos cómo la base de datos SAM y el proceso LSA custodian las contraseñas, y cómo el Control de Cuentas de Usuario (UAC) protege al sistema mediante el desdoblamiento de tokens. Además, repasamos las herramientas gráficas disponibles en Windows 11 como `netplwiz`, la pantalla de Configuración y el ajuste de UAC, y practicamos los comandos esenciales de consola `whoami`, `net user`, `net localgroup` y PowerShell para administrar identidades como un técnico profesional."

---

## 🧠 Conceptos Nucleares

### 1. El Identificador de Seguridad (SID)
* **Definición:** Es el "DNI digital" único e inmutable que Windows le asigna a cada cuenta o grupo cuando se crea.
* **Inmutabilidad:** Si cambias el nombre visual de un usuario, su SID sigue siendo el mismo y no pierde ningún permiso.
* **El RID (Número final del SID):** El RID `500` identifica al Administrador integrado, el `501` al Invitado, y los números a partir de `1000` son las cuentas creadas por nosotros.

### 2. Base de Datos SAM y Proceso LSA
* **SAM (*Security Accounts Manager*):** Base de datos donde se guardan de forma segura las contraseñas de las cuentas locales.
* **LSA (*Local Security Authority*):** Proceso encargado de autenticar al usuario y generarle su Token de Acceso con sus permisos.

### 3. Control de Cuentas de Usuario (UAC)
* Mecanismo de defensa que evita que los programas hagan cambios en el sistema sin autorización.
* Cuando un administrador inicia sesión, Windows le da un token estándar para el día a día y sólo activa los privilegios de administrador cuando el usuario confirma la ventana de UAC.

### 4. Herramientas Visuales y de Consola en Windows 11
* **`netplwiz`:** Herramienta gráfica para ver usuarios locales y cambiar su pertenencia a grupos (Estándar, Administrador u otros).
* **Configuración (`ms-settings:otherusers`):** Interfaz para agregar nuevos usuarios y cambiar roles.
* **`whoami`:** Comando para saber quién soy, mi SID y mis grupos.
* **`net user` y `net localgroup`:** Comandos para crear, modificar y eliminar usuarios y grupos rápidamente.

---

## ❓ Preguntas Frecuentes de Examen Técnico

**P: ¿Para qué sirve la herramienta `netplwiz` en Windows 11?**  
*R: Es una utilidad gráfica que permite listar las cuentas de usuario de la máquina, cambiar el grupo al que pertenecen (por ejemplo pasar de Usuario estándar a Administrador) y gestionar contraseñas.*

**P: ¿Qué sucede si eliminamos una cuenta de usuario y luego creamos otra con exactamente el mismo nombre?**  
*R: La nueva cuenta tendrá un nuevo SID (con un RID diferente). Por lo tanto, no tendrá acceso automático a los archivos protegidos ni a los permisos que tenía la cuenta anterior.*

**P: ¿Por qué es útil organizar a los usuarios en grupos?**  
*R: Porque permite asignar permisos de acceso a carpetas o recursos a muchas personas a la vez, en lugar de configurar cada cuenta una por una.*
