# Repaso Final: Ensayo de Evaluación - LSO 4to Año

**Instrucciones Generales:**
- Resuelve cada una de las siguientes actividades prácticas y teóricas.
- **IMPORTANTE:** Debes adjuntar **capturas de pantalla** que evidencien la realización de cada paso en las actividades prácticas, y documentar tus respuestas teóricas.
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
> 📸 **Captura de pantalla requerida:** Tu consola mostrando la ejecución exitosa de los comandos.

**Actividad 2: Monitoreo de Procesos desde la Terminal**
El servidor parece estar funcionando lento y necesitas identificar al "comensal glotón".
1. Desde la consola de PowerShell, ejecuta el comando necesario para listar los procesos activos y ordenarlos para ver **cuál es el proceso que más recursos de CPU está consumiendo** actualmente.
2. Identifica el nombre del proceso y su número de identificación (PID).
*Tip: Revisa los comandos `Get-Process`, `Sort-Object` y `Select-Object`.*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando la lista de procesos ordenados por consumo de CPU.

---

## 🛠️ Sección 2: Aplicaciones de Gestión del Sistema Operativo

**Actividad 3: Auditoría del Registro de Windows**
El intruso de la "Operación Limpieza LSO" modificó parámetros visuales del sistema para ralentizarlo.
1. Abre el **Editor del Registro de Windows** (`regedit`).
2. Navega hasta la ruta: `HKEY_CURRENT_USER\Control Panel\Desktop`.
3. Busca la clave encargada del retardo al mostrar los menús (`MenuShowDelay`) o del suavizado de fuentes (`FontSmoothing`).
4. Observa y anota el valor que tienen configurado actualmente en tu sistema.
> 📸 **Captura de pantalla requerida:** La ventana de `regedit` abierta en la ruta exacta, con la clave seleccionada visible.

**Actividad 4: Rastreo de Eventos Críticos**
Un servicio del sistema ha estado fallando de forma intermitente (similar a lo ocurrido con "Siberia.exe" en nuestra simulación).
1. Abre la herramienta **Visor de Eventos** (`eventvwr.msc`) o el **Monitor de Confiabilidad** (`perfmon /rel`).
2. En el Visor de Eventos, dirígete a *Registros de Windows -> Aplicación* o *Sistema*. Si usas el Monitor de Confiabilidad, busca en los últimos días reportados.
3. Filtra la vista o busca un evento de tipo "Error", "Advertencia" o evento crítico reciente.
> 📸 **Captura de pantalla requerida:** La herramienta de gestión mostrando el detalle de un evento crítico o de error del sistema.

---

## 🧠 Sección 3: Temas Teóricos

**Actividad 5: Ciclo de Vida de los Procesos**
Busca en el contenido de los documentos de NotebookLM cuál es la diferencia entre un **programa** y un **proceso**.
Luego, busca cuáles son los estados por los que viaja un proceso a lo largo de su ciclo de vida (desde que nace hasta que termina).
> 📸 **Captura de pantalla requerida:** Adjunta capturas de pantalla de la fuente de información.

**Actividad 6: Rendimiento vs. Estética en Servidores**
Busca en el contenido de los documentos de NotebookLM la razón por la que en entornos de servidores es una práctica común desactivar transparencias, animaciones y opciones como el suavizado de fuentes.
Luego, busca cómo se relaciona esta configuración con el proceso **Desktop Window Manager** (`dwm.exe`) y el concepto de *overhead* (costo extra) de recursos.
> 📸 **Captura de pantalla requerida:** Adjunta capturas de pantalla de la fuente de información.
