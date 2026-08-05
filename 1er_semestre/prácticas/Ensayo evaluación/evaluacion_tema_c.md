# Evaluación - LSO 4to Año (Tema C)

**Instrucciones Generales:**
- Resuelve cada una de las siguientes actividades prácticas y teóricas (8 actividades en total).
- **IMPORTANTE:** Debes adjuntar **capturas de pantalla** que evidencien la realización de cada paso en las actividades prácticas. Para las de teoría, **debes adjuntar capturas de pantalla de las diapositivas de la presentación o material PDF donde se explica el concepto**.
- Tienes a tu disposición todo el material del Google Classroom y los dos cuadernos de NotebookLM ("Planificación Anual Docente 2026: Informática Personal y Profesional" y "Unidad 3 LSO 4to año").
- **Se permite el uso de IA** para consultar la sintaxis de comandos de consola o para guiarte en el uso de las aplicaciones de gestión del Sistema Operativo.

---

## 💻 Sección 1: Uso de Consola (PowerShell / CMD)

**Actividad 1: Gestión de Scripts y Directorios**
Imagina que vas a almacenar scripts de automatización de mantenimiento preventivo.
1. Abre una consola de PowerShell.
2. Crea una carpeta llamada `Tareas_Programadas` en tu escritorio o en la carpeta Documentos.
3. Ingresa a esa nueva carpeta desde la consola.
4. Crea un archivo llamado `script_alerta.ps1` que quede vacío o inicializado.
*Tip: Puedes usar comandos como `New-Item` y `Set-Location` (o sus alias correspondientes).*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando la creación y navegación dentro de la carpeta.

**Actividad 2: Modificación de Scripts y Escritura**
Debes registrar una instrucción en tu script para que imprima un mensaje por pantalla.
1. Sin salir de la consola de PowerShell, agrega la frase `Write-Host "Iniciando mantenimiento preventivo"` al archivo `script_alerta.ps1`.
2. Ejecuta el comando necesario para leer el contenido del archivo en la consola y verificar que se guardó correctamente.
*Tip: Revisa los comandos `Add-Content` y `Get-Content` (o sus alias).*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando el comando para agregar la línea de script y la visualización final del archivo.

**Actividad 3: Inspección de Metadatos y Atributos de Archivos desde la Terminal**
Los archivos en un sistema de archivos contienen metadatos técnicos (como fecha de creación, tamaño y atributos de lectura/escritura) que un técnico puede auditar desde la consola.
1. Desde la consola de PowerShell, ejecuta el comando necesario para consultar las propiedades y metadatos detallados del archivo `script_alerta.ps1` que creaste.
2. Identifica y anota la fecha de creación (`CreationTime`) y el tamaño en bytes del archivo a partir de los datos que muestra la consola.
*Tip: Revisa los comandos `Get-ItemProperty` o `Get-Item`.*
> 📸 **Captura de pantalla requerida:** Tu consola mostrando las propiedades del archivo en pantalla (incluyendo la fecha de creación y tamaño).

---

## 🛠️ Sección 2: Aplicaciones de Gestión del Sistema Operativo

**Actividad 4: Monitoreo de Recursos en Tiempo Real (GUI)**
Cuando un equipo experimenta tirones o lentitud al leer/escribir archivos o al navegar, no basta con ver el Administrador de Tareas.
1. Abre la herramienta gráfica **Monitor de Recursos** (`resmon.exe`).
2. Ve a la pestaña **Disco** o **Red**.
3. Identifica cuál es el proceso que actualmente está realizando más operaciones de lectura/escritura en disco (B/seg) o transmitiendo más datos por la red.
4. Anota el nombre del proceso y su PID.
> 📸 **Captura de pantalla requerida:** La ventana del Monitor de Recursos abierta en la pestaña seleccionada, ordenando los procesos por mayor actividad de disco o red.

**Actividad 5: Auditoría de Estabilidad en el Monitor de Confiabilidad**
Cuando un sistema experimenta fallas repetitivas o bloqueos, el Monitor de Confiabilidad ayuda a auditar de manera cronológica la estabilidad del equipo.
1. Presiona `Win + R`, escribe `perfmon /rel` y presiona Enter para abrir el **Monitor de Confiabilidad**.
2. Observa el gráfico del índice de estabilidad general del sistema (una escala de 1 a 10).
3. Busca un día reciente que muestre un círculo rojo con una cruz (error crítico de software o hardware).
4. Selecciona dicho día y, en el panel inferior, haz doble clic sobre el evento crítico para ver los detalles técnicos de la falla. Anota el nombre del ejecutable que falló.
> 📸 **Captura de pantalla requerida:** La ventana del Monitor de Confiabilidad mostrando la gráfica temporal y el detalle del error crítico seleccionado en pantalla.
 
**Actividad 6: Análisis de Logs de Error en el Visor de Eventos**
El sistema operativo registra en tiempo real todos los eventos importantes y errores en registros de auditoría (logs).
1. Abre el **Visor de Eventos** (`eventvwr.msc`).
2. En el panel izquierdo, navega hasta *Registros de Windows -> Sistema*.
3. En el panel derecho de acciones, haz clic en **Filtrar registro actual...**.
4. En la ventana de filtro, marca únicamente la casilla de **Error** y **Crítico**, y presiona Aceptar.
5. Selecciona un error reciente en la lista central, observa la pestaña *General* y anota su **Origen** (Source) y su **Id. del evento** (Event ID).
> 📸 **Captura de pantalla requerida:** La ventana del Visor de Eventos con el filtro aplicado mostrando los errores/eventos críticos de sistema en pantalla.

---

## 🧠 Sección 3: Temas Teóricos

**Actividad 7: El Rol de los Metadatos en el Sistema de Archivos**
Investiga y explica qué son los **metadatos** de un archivo y menciona al menos 3 ejemplos de metadatos comunes que el sistema operativo almacena (además del nombre del archivo).
¿Por qué es útil para un técnico o administrador de sistemas poder consultar y filtrar estos metadatos en tareas de auditoría de un equipo?
> 📸 **Captura de pantalla de diapositiva requerida:** Adjunta captura de pantalla de la diapositiva específica de la presentación o PDF de clase donde se hable sobre metadatos de archivos, atributos o propiedades del sistema de archivos.

**Actividad 8: Entrada/Salida (E/S) y el Estado Bloqueado**
En el diagnóstico de sistemas, a veces observamos procesos que parecen congelados o lentos cuando realizan tareas intensivas de lectura/escritura en disco o red.
1. Investiga y explica qué sucede con un proceso en el diagrama de estados cuando solicita realizar una operación de **Entrada/Salida (E/S)** (como leer un archivo del disco o enviar datos por la red).
2. ¿Por qué el planificador (Scheduler) del sistema operativo lo retira del estado de Ejecución y a qué estado lo mueve mientras se completa la operación física?
> 📸 **Captura de pantalla de diapositiva requerida:** Adjunta captura de pantalla de la presentación o PDF de clase donde se explique el estado de Bloqueado / Espera y su relación con la Entrada/Salida (E/S).
