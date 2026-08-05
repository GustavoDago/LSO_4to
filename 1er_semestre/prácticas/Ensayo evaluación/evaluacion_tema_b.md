# Evaluación - LSO 4to Año (Tema B)

**Instrucciones Generales:**
- Resuelve cada una de las siguientes actividades prácticas y teóricas (8 actividades en total).
- **IMPORTANTE:** Debes adjuntar **capturas de pantalla** que evidencien la realización de cada paso en las actividades prácticas. Para las de teoría, **debes adjuntar capturas de pantalla de las diapositivas de la presentación o material PDF donde se explica el concepto**.
- Tienes a tu disposición todo el material del Google Classroom y los dos cuadernos de NotebookLM ("Planificación Anual Docente 2026: Informática Personal y Profesional" y "Unidad 3 LSO 4to año").
- **Se permite el uso de IA** para consultar la sintaxis de comandos de consola o para guiarte en el uso de las aplicaciones de gestión del Sistema Operativo.

---

## 💻 Sección 1: Uso de Consola (PowerShell / CMD)

**Actividad 1: Gestión de Archivos e Historial de Auditoría**
Imagina que estás preparando el entorno para almacenar los reportes de monitoreo de servicios del sistema.
1. Abre una consola de PowerShell.
2. Crea una nueva carpeta llamada `Monitoreo_Servicios` en tu escritorio o en la carpeta Documentos.
3. Ingresa a esa nueva carpeta desde la consola.
4. Crea un archivo llamado `servicios_criticos.txt` de manera que quede vacío o inicializado.
*Tip: Puedes usar comandos como `New-Item` y `Set-Location` (o sus alias correspondientes).*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando la creación y navegación dentro de la carpeta.

**Actividad 2: Modificación e Inspección de Archivos**
Debes dejar registrado un encabezado para documentar el monitoreo de los servicios.
1. Sin salir de la consola de PowerShell, agrega la línea de texto "Auditoría de Servicios LSO 2026" al archivo `servicios_criticos.txt` sin borrar nada de lo anterior.
2. Ejecuta el comando para visualizar el contenido del archivo en la pantalla de la consola para confirmar que los cambios se guardaron.
*Tip: Revisa los comandos `Add-Content` y `Get-Content` (o sus alias).*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando el comando para agregar texto y la lectura exitosa del contenido del archivo.

**Actividad 3: Monitoreo de Servicios desde la Terminal**
Necesitamos verificar el estado de los servicios del sistema para asegurarnos de que no haya servicios inactivos que deban estar funcionando.
1. Desde la consola de PowerShell, ejecuta el comando necesario para listar **todos los servicios que actualmente están en estado "Running" (Ejecutándose)**.
2. Ordena la lista alfabéticamente por el nombre del servicio.
*Tip: Revisa los comandos `Get-Service`, `Where-Object` y `Sort-Object`.*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando la lista de servicios activos ordenados alfabéticamente.

---

## 🛠️ Sección 2: Aplicaciones de Gestión del Sistema Operativo

**Actividad 4: Monitoreo de Hardware desde el Administrador de Tareas**
Para diagnosticar la lentitud o saturación de un equipo, el técnico debe saber medir el uso en tiempo real de los componentes principales.
1. Abre el **Administrador de Tareas** (`taskmgr.exe`).
2. Ve a la pestaña **Rendimiento** (Performance) y selecciona **CPU** o **Memoria**.
3. Observa y anota el porcentaje de uso actual, la velocidad (en GHz para CPU) o la cantidad de memoria RAM en uso/disponible.
4. Identifica cuántos núcleos lógicos tiene tu procesador o la velocidad de tu memoria RAM.
> 📸 **Captura de pantalla requerida:** La ventana del Administrador de Tareas en la pestaña de Rendimiento con los datos de CPU o Memoria visibles.
 
**Actividad 5: Auditoría de Programas de Inicio en el Registro de Windows**
Algunas aplicaciones configuran accesos en el registro para ejecutarse automáticamente en segundo plano al iniciar el sistema.
1. Abre el **Editor del Registro de Windows** (`regedit`).
2. Navega hasta la ruta: `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run`.
3. Observa los valores existentes en el panel derecho (que representan programas configurados para iniciarse con el usuario actual).
4. Anota al menos uno de los programas listados y la ruta a su archivo ejecutable que figura en la columna 'Datos'.
> 📸 **Captura de pantalla requerida:** La ventana de `regedit` abierta en la ruta exacta de la clave `Run`, mostrando los programas de inicio en el panel derecho.
 
**Actividad 6: Análisis de Controladores en el Administrador de Dispositivos**
Es fundamental revisar que todos los componentes físicos (hardware) tengan sus controladores funcionando correctamente.
1. Abre el **Administrador de Dispositivos** (`devmgmt.msc`).
2. Despliega la categoría **Adaptadores de red** o **Adaptadores de pantalla**.
3. Haz doble clic sobre tu adaptador principal para abrir sus Propiedades y verifica en la pestaña *General* si figura el mensaje "Este dispositivo funciona correctamente".
> 📸 **Captura de pantalla requerida:** La ventana del Administrador de Dispositivos con la pestaña de propiedades de tu adaptador visible.

---

## 🧠 Sección 3: Temas Teóricos

**Actividad 7: Concepto de Servicio vs. Proceso**
Busca en el material o investiga cuál es la diferencia fundamental entre un **proceso ordinario** de usuario (como abrir un bloc de notas o el navegador) y un **servicio en segundo plano** (background service / daemon).
¿Por qué los servicios no suelen tener una interfaz gráfica asociada?
> 📸 **Captura de pantalla de diapositiva requerida:** Adjunta captura de pantalla de la diapositiva específica de la presentación o PDF de clase donde se detalla este concepto.

**Actividad 8: El Registro de Windows y el Inicio de Aplicaciones**
Investiga y explica qué es el Registro de Windows.
¿Cómo afecta al rendimiento general del sistema que muchas aplicaciones se configuren para iniciarse automáticamente en segundo plano?
> 📸 **Captura de pantalla de diapositiva requerida:** Adjunta captura de pantalla de la diapositiva de la presentación o PDF de clase donde se hable sobre el Registro de Windows o el impacto del inicio automático de programas.
