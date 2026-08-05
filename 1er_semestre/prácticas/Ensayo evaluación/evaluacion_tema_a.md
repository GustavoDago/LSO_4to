# Evaluación - LSO 4to Año (Tema A)

**Instrucciones Generales:**
- Resuelve cada una de las siguientes actividades prácticas y teóricas (8 actividades en total).
- **IMPORTANTE:** Debes adjuntar **capturas de pantalla** que evidencien la realización de cada paso en las actividades prácticas. Para las de teoría, **debes adjuntar capturas de pantalla de las diapositivas de la presentación o material PDF donde se explica el concepto**.
- Tienes a tu disposición todo el material del Google Classroom y los dos cuadernos de NotebookLM ("Planificación Anual Docente 2026: Informática Personal y Profesional" y "Unidad 3 LSO 4to año").
- **Se permite el uso de IA** para consultar la sintaxis de comandos de consola o para guiarte en el uso de las aplicaciones de gestión del Sistema Operativo.

---

## 💻 Sección 1: Uso de Consola (PowerShell / CMD)

**Actividad 1: Gestión de Archivos y Directorios**
Imagina que estás preparando el entorno para realizar una auditoría de seguridad.
1. Abre una consola de PowerShell.
2. Crea un nuevo directorio llamado `Auditoria_SO` en tu escritorio o en la carpeta Documentos.
3. Ingresa a ese nuevo directorio desde la consola.
4. Dentro del directorio, crea un archivo de texto vacío llamado `reporte_incidente.txt`.
*Tip: Puedes usar comandos como `New-Item` y `Set-Location`, o consultar con una IA sobre las alternativas (ej. `mkdir`, `cd`).*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando la ejecución exitosa de los comandos de creación y navegación.

**Actividad 2: Modificación e Inspección de Archivos**
Debes dejar asentado el inicio de la auditoría en el archivo que creaste.
1. Sin salir de la consola de PowerShell, agrega la frase "Inicio de Auditoría de Seguridad - LSO" al archivo `reporte_incidente.txt` sin sobreescribir lo que pudiera tener.
2. Ejecuta el comando para visualizar el contenido del archivo en la pantalla de la consola para comprobar que se guardó correctamente.
*Tip: Revisa los comandos `Add-Content` y `Get-Content` (o sus alias).*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando la inserción y la lectura del contenido del archivo.

**Actividad 3: Monitoreo de Procesos desde la Terminal**
El servidor parece estar funcionando lento y necesitas identificar al "comensal glotón".
1. Desde la consola de PowerShell, ejecuta el comando necesario para listar los procesos activos y ordenarlos para ver **cuál es el proceso que más recursos de CPU está consumiendo** actualmente.
2. Identifica el nombre del proceso y su número de identificación (PID).
*Tip: Revisa los comandos `Get-Process`, `Sort-Object` y `Select-Object`.*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando la lista de procesos ordenados por consumo de CPU.

---

## 🛠️ Sección 2: Aplicaciones de Gestión del Sistema Operativo

**Actividad 4: Auditoría del Registro de Windows**
El intruso de la "Operación Limpieza LSO" modificó parámetros visuales del sistema para ralentizarlo.
1. Abre el **Editor del Registro de Windows** (`regedit`).
2. Navega hasta la ruta: `HKEY_CURRENT_USER\Control Panel\Desktop`.
3. Busca la clave encargada del retardo al mostrar los menús (`MenuShowDelay`) o del suavizado de fuentes (`FontSmoothing`).
4. Observa y anota el valor que tienen configurado actualmente en tu sistema.
> 📸 **Captura de pantalla requerida:** La ventana de `regedit` abierta en la ruta exacta, con la clave seleccionada visible.

**Actividad 5: Rastreo de Eventos Críticos**
Un servicio del sistema ha estado fallando de forma intermitente (similar a lo ocurrido con "Siberia.exe" en nuestra simulación).
1. Abre la herramienta **Visor de Eventos** (`eventvwr.msc`) o el **Monitor de Confiabilidad** (`perfmon /rel`).
2. En el Visor de Eventos, dirígete a *Registros de Windows -> Aplicación* o *Sistema*. Si usas el Monitor de Confiabilidad, busca en los últimos días reportados.
3. Filtra la vista o busca un evento de tipo "Error", "Advertencia" o evento crítico reciente.
> 📸 **Captura de pantalla requerida:** La herramienta de gestión mostrando el detalle de un evento crítico o de error del sistema.

**Actividad 6: Análisis de Detalles de Procesos en el Administrador de Tareas**
Necesitas verificar las características de ejecución de la shell gráfica de Windows.
1. Abre el **Administrador de Tareas** (`taskmgr.msc`) y ve a la pestaña **Detalles**.
2. Localiza el proceso encargado de la interfaz gráfica del Explorador de Windows (`explorer.exe`).
3. Haz clic derecho sobre él, entra a *Propiedades* y anota su ubicación en el disco y su tamaño.
> 📸 **Captura de pantalla requerida:** La pestaña Detalles del Administrador de Tareas mostrando el proceso `explorer.exe` y su ventana de Propiedades abierta.

---

## 🧠 Sección 3: Temas Teóricos

**Actividad 7: Ciclo de Vida de los Procesos**
Busca en los documentos y presentaciones de la materia cuál es la diferencia entre un **programa** y un **proceso**.
Luego, identifica cuáles son los estados por los que viaja un proceso a lo largo de su ciclo de vida (desde que nace hasta que termina).
> 📸 **Captura de pantalla de diapositiva requerida:** Adjunta captura de pantalla de la diapositiva específica de la presentación o PDF de clase donde se detalla este concepto.

**Actividad 8: Rendimiento vs. Estética en Servidores**
Busca en el contenido de los documentos de la materia la razón por la que en entornos de servidores es una práctica común desactivar transparencias, animaciones y opciones como el suavizado de fuentes.
Luego, busca cómo se relaciona esta configuración con el proceso **Desktop Window Manager** (`dwm.exe`) y el concepto de *overhead* (costo extra) de recursos.
> 📸 **Captura de pantalla de diapositiva requerida:** Adjunta captura de pantalla de la diapositiva de la presentación o PDF de clase donde se explican estos conceptos y la relación con `dwm.exe`.
