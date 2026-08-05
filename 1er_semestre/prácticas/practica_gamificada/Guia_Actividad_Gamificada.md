# Guía de Actividad: Operación "Limpieza LSO" (Desafío Cooperativo)

**Materia:** Laboratorio de Sistemas Operativos (LSO)  
**Destinatarios:** 4to Año - Escuela Técnica  
**Dinámica:** Gamificación Cooperativa (9 Analistas de Sistemas)  
**Duración Estimada:** 45-60 minutos  
**Permisos requeridos para los Alumnos:** Permisos de Usuario estándar (Sin Administrador)

---

## 📖 La Historia (Lore)
El servidor central de la escuela técnica ha sufrido una brecha de seguridad. Un intruso digital ha alterado parámetros del sistema, levantado servicios ocultos y manipulado el registro del sistema operativo para bloquear la consola de administración. 

Para recuperar el control, el equipo de **Analistas de Incidentes de 4to B** (máximo 9 integrantes) debe trabajar cooperativamente. Cada analista tiene asignado un terminal de diagnóstico con un problema exclusivo. Al resolverlo utilizando herramientas clínicas del sistema operativo, cada uno descubrirá un **Fragmento de Código** (una letra o número). 

Una vez recuperados los 9 fragmentos, deberán ordenarlos secuencialmente (desde el Analista 1 al Analista 9) para formar la **Clave Maestra** e ingresarla en la consola central para restablecer los servidores.

> [!IMPORTANT]
> Si un solo analista falla en su diagnóstico u obtiene un código incorrecto, la clave maestra fallará y el servidor no se restablecerá. ¡Toda la misión depende de la precisión de cada integrante!

---

## 🛠️ Guía para el Docente: Configuración del Laboratorio

Para garantizar la seguridad de los equipos del laboratorio, **todas las misiones de los alumnos corren con permisos normales de usuario (sin privilegios de Administrador)**. Sin embargo, para configurar los servicios y logs iniciales de la simulación, el script debe ser ejecutado en cada máquina por el docente o con credenciales de administrador una única vez antes del taller.

### Paso 1: Ubicar los archivos de la actividad
Ubica los archivos de la práctica en los equipos:
* [setup_practica1.ps1](file:///F:/Mochila/Antigravity/NotebookLm/prácticas/practica_gamificada/setup_practica1.ps1) (Script de configuración)
* [desbloquear.html](file:///F:/Mochila/Antigravity/NotebookLm/prácticas/practica_gamificada/desbloquear.html) (Consola de validación final)

### Paso 2: Ejecutar el script en cada puesto de trabajo (Docente)
1. Abre **PowerShell** como **Administrador** en la computadora de cada alumno.
2. Navega al directorio donde guardaste los archivos.
3. Asigna un número de analista (del 1 al 9) a cada alumno y ejecuta el script pasando ese número como parámetro:
   ```powershell
   # Ejemplo para el Estudiante 3:
   Set-ExecutionPolicy Bypass -Scope Process -Force
   .\setup_practica1.ps1 -StudentNumber 3
   ```
4. El script configurará el entorno silenciosamente y le indicará al alumno su misión inicial en la pantalla.

---

## 🕵️‍♂️ Misiones Individuales (Hojas de Ruta de los Analistas)

| Analista | Especialidad | Herramienta Principal | Anomalía a Investigar |
| :---: | :--- | :--- | :--- |
| **1** | Gestión de CPU | Monitor de Recursos / PowerShell | Proceso oculto que sobrecarga el procesador |
| **2** | Registro del Sistema (Visual) | Editor del Registro (`regedit`) | Alteración de tiempos de la interfaz |
| **3** | Registro del Sistema (Tipografía)| Editor del Registro (`regedit`) | Alteración de renderizado de tipografías |
| **4** | Telemetría y Redes | Consola (`netstat`) / Monitor de Recursos | Puerto sospechoso abierto en el sistema |
| **5** | Variables de Entorno | Consola (`cmd.exe` o PowerShell) | Variables de usuario inyectadas por el intruso |
| **6** | Historial de Estabilidad | Monitor de Confiabilidad (`perfmon /rel`) | Registro de fallos de la aplicación *Siberia.exe* |
| **7** | Auditoría Forense de Logs | Visor de Eventos (`eventvwr.msc`) | Registro de auditoría con ID 1337 en Aplicación |
| **8** | Servicios del Sistema | Consola de Servicios (`services.msc`) | Servicio creado con metadatos ocultos |
| **9** | Sistemas de Archivos | Bloc de Notas (`notepad.exe`) | Lectura de archivos de volcado y evidencia |

---

### 📋 Misión Detallada por Estudiante

#### 1. Analista 1: El Proceso Infiltrado (CPU)
* **Objetivo:** Encontrar qué proceso en segundo plano está consumiendo ciclos de procesamiento en exceso y mapear su ID de proceso (PID) al archivo de claves.
* **Instrucciones:**
  1. Abre el **Monitor de Recursos** (`resmon.exe`) y ve a la pestaña **CPU** (o abre el Administrador de Tareas).
  2. Identifica un proceso sospechoso llamado `Apolo_13.exe` que esté consumiendo ciclos de CPU de forma continua.
  3. Toma nota de su **PID** (número identificador de proceso).
  4. Dirígete a la carpeta `C:\LSO` y busca el archivo que coincida con ese PID (ej. `apolo_<PID>.txt`).
  5. Abre el archivo y lee tu clave (letra `K`).

#### 2. Analista 2: El Registro Lento (Registro de Windows)
* **Objetivo:** Auditar el Registro de Windows para descubrir qué tiempo de retardo visual ha configurado el intruso para los menús.
* **Instrucciones:**
  1. Abre el **Editor del Registro** (`regedit`).
  2. Navega a la ruta: `HKEY_CURRENT_USER\Control Panel\Desktop`.
  3. Busca la clave de tipo cadena llamada `MenuShowDelay`.
  4. Tu código secreto es el **primer dígito** de ese número de 3 cifras (ej. si el valor es 270, tu código es `2`).

#### 3. Analista 3: Suavizado de Fuentes (Registro de Windows)
* **Objetivo:** Detectar si se ha forzado un renderizado tipográfico no optimizado en el ADN de configuración del usuario.
* **Instrucciones:**
  1. Abre el **Editor del Registro** (`regedit`).
  2. Navega a la ruta: `HKEY_CURRENT_USER\Control Panel\Desktop`.
  3. Busca la clave de tipo cadena llamada `FontSmoothing`.
  4. Tu código secreto es el valor asignado a esta clave (un solo dígito).

#### 4. Analista 4: El Puerto Sospechoso (Monitoreo de Red)
* **Objetivo:** Buscar conexiones activas y rastrear el archivo que contiene la clave secreta vinculada a ese ID de proceso (PID).
* **Instrucciones:**
  1. Abre una consola y ejecuta el comando de diagnóstico de red:
     ```cmd
     netstat -ano | findstr 4444
     ```
  2. Identifica el **PID** (número al final de la línea) que está escuchando en el puerto local `4444`.
  3. Una vez que tengas ese PID, ve a la carpeta `C:\LSO` en tu Explorador de Archivos.
  4. Busca el archivo que lleva ese PID en el nombre (ej. `net_<PID>.txt`) y ábrelo para leer tu clave.

#### 5. Analista 5: Variables de Entorno (Diagnóstico del Shell)
* **Objetivo:** Leer los datos de variables inyectadas por el software intruso en el entorno de usuario.
* **Instrucciones:**
  1. Abre una consola clásica de comandos (**CMD**) o **PowerShell**.
  2. Si estás en CMD, escribe: `echo %LSO_KEY%` y presiona Enter. Si estás en PowerShell, escribe: `$env:LSO_KEY` y presiona Enter.
  3. Tu código secreto es la letra que devuelve la consola en pantalla (letra `O`).

#### 6. Analista 6: La Caída de Siberia (Monitor de Confiabilidad)
* **Objetivo:** Utilizar la línea de tiempo del sistema operativo para auditar el último colapso crítico de software.
* **Instrucciones:**
  1. Abre la herramienta de búsqueda de Windows, escribe **Monitor de Confiabilidad** (o ejecuta `perfmon /rel`).
  2. Busca en el día de hoy (marcado con una cruz roja en un círculo) el evento crítico que informa un fallo de la aplicación `Siberia.exe`.
  3. Haz doble clic sobre él para abrir los "Detalles técnicos".
  4. Lee la descripción del error y copia la letra del **Código de error** final (ej. si el código es "H", tu fragmento es `H`).

#### 7. Analista 7: La Alarma Digital (Visor de Eventos)
* **Objetivo:** Filtrar los miles de logs del sistema para encontrar una alerta específica generada por el intruso.
* **Instrucciones:**
  1. Abre el **Visor de Eventos** (`eventvwr.msc`).
  2. Despliega **Registros de Windows** y selecciona **Aplicación**.
  3. Utiliza la opción **Filtrar registro actual...** en el panel lateral derecho e ingresa el ID del evento: `1337`.
  4. Selecciona la entrada encontrada y lee el cuerpo del mensaje. Tu código es la letra indicada como `Código fragmentado`.

#### 8. Analista 8: El Servicio Fantasma (Servicios)
* **Objetivo:** Buscar el nombre descriptivo de servicios creados de forma externa en el sistema.
* **Instrucciones:**
  1. Abre la consola de administración de **Servicios** (`services.msc`) o usa PowerShell (`Get-Service`).
  2. Busca un servicio cuyo nombre de sistema sea `LSO_Service`.
  3. Revisa su **Nombre para mostrar** (Display Name) en la lista.
  4. Tu código secreto es la letra que aparece al final de la leyenda `Key: ...` (ej. si dice "LSO Service Key: Y", tu código es `Y`).

#### 9. Analista 9: Archivo de Evidencia (Notepad y Rutas)
* **Objetivo:** Buscar en el almacenamiento local el reporte final de evidencia del intruso.
* **Instrucciones:**
  1. Abre el Explorador de Archivos y dirígete a la carpeta `C:\LSO`.
  2. Abre el archivo llamado `evidencia.txt` haciendo doble clic, lo que iniciará el **Bloc de Notas** (`notepad.exe`).
  3. Lee la línea que indica "El fragmento de código secreto es: ...".
  4. Ese número es tu código.

---

## 🔒 Desbloqueo y Victoria

Una vez que los 9 analistas tengan su carácter, deben dirigirse a la computadora central (o abrir el archivo [desbloquear.html](file:///F:/Mochila/Antigravity/NotebookLm/prácticas/practica_gamificada/desbloquear.html) en su navegador).

Deberán ingresar los caracteres en orden:
`[C1][C2][C3][C4][C5][C6][C7][C8][C9]` (La clave maestra de desbloqueo es: `K23SOHTY5`).

Si todos los diagnósticos fueron correctos, se desbloqueará la consola del servidor de manera animada y se habrá completado la práctica de revisión de sistemas operativos.



