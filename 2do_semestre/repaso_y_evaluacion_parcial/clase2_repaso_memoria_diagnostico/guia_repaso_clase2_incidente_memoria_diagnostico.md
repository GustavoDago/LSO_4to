# Guía de Laboratorio Clínico: Ticket #402
## Diagnóstico Clínico de Saturación de Memoria y Rendimiento del Kernel
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional

---

## 📋 Resumen del Incidente (Caso de Soporte N.º 402)
* **Cliente / Servidor:** Estación de Trabajo de Desarrollo `EST-DEV-04` (Windows 11 Host).
* **Prioridad:** Muy Alta / Crítica.
* **Descripción del Problema:**
  Los operadores del laboratorio reportan que tras abrir múltiples herramientas, el equipo entra en estado de latencia extrema (*thrashing*), el indicador de actividad del disco se dispara al 100% y Windows muestra alertas de *"Cierre programas para impedir la pérdida de información"*. El supervisor sospecha que una aplicación de desarrollo contiene una fuga de memoria (*memory leak*), saturó el **Límite de Compromiso (*Commit Limit*)** y obligó al Administrador de Memoria (*Memory Manager*) a volcar páginas al disco (`pagefile.sys`), generando una tormenta de fallos de página duros (*Hard Page Faults*).
* **Misión del Administrador de Sistemas (Alumno de 4.º Año):**
  1. Realizar una auditoría clínica en tiempo real con el **Administrador de Tareas** y el **Monitor de Recursos (`resmon.exe`)**, sin requerir herramientas externas de terceros.
  2. Interpretar con precisión quirúrgica los 4 estados de la memoria física en Windows 11: **En uso, Modificada, En espera (*Standby*) y Libre**.
  3. Diagnosticar la tasa de **Errores de hardware/s (Hard Page Faults)** y contrastarla con los **Fallos de página suaves (Soft Page Faults)**.
  4. Analizar la salud del Kernel auditando los Pools de Memoria (**Paged Pool** vs. **Non-Paged Pool**).
  5. Ejecutar el script clínico de pruebas controladas provisto por la cátedra, aislar el proceso causante del desbalance de memoria y redactar el dictamen técnico de remediación.

---

## ⚙️ Entorno y Herramientas Clínicas

Para esta práctica utilizaremos las dos herramientas clínicas nativas del sistema operativo:
1. **Administrador de Tareas** (`Ctrl + Shift + Esc` o `taskmgr.exe`).
2. **Monitor de Recursos** (`resmon.exe` o `Win + R` -> `resmon`).

---

## 🩺 Fase 1: Radiografía General en el Administrador de Tareas

Abre el **Administrador de Tareas**, haz clic en la pestaña lateral **Rendimiento** y selecciona la tarjeta **Memoria**.

### Paso 1.1: Registro de la Línea Base (Basal del Sistema)
Registra en tu informe los siguientes valores numéricos del equipo en estado de reposo:
* **Memoria física total instalada:** `_____ GB`
* **Memoria en uso actual:** `_____ GB`
* **Memoria disponible:** `_____ GB`
* **Confirmada (Commit Charge / Commit Limit):** `_____ / _____ GB`
* **En caché:** `_____ GB`
* **Grupo paginado (Paged Pool):** `_____ MB`
* **Grupo no paginado (Non-Paged Pool):** `_____ MB`

> [!IMPORTANT]
> **Pregunta de Análisis 1:** ¿Por qué la cifra de *Memoria Confirmada* puede ser **mayor** que la memoria RAM física total instalada en el equipo? ¿Qué componente del disco secundario aporta ese espacio virtual adicional?

---

## 🔬 Fase 2: Exploración Microscópica con el Monitor de Recursos (`resmon.exe`)

Abre la consola de ejecución (`Win + R`), escribe `resmon` y presiona Enter. Dirígete a la pestaña **Memoria**.

### Paso 2.1: Anatomía de la Barra de Memoria Física
Observa la barra horizontal multicolor ubicada en la parte inferior de la ventana:

```
┌─────────────────┬──────────────┬─────────────────────────┬──────────────┐
│  En uso (Verde) │Modificada(N) │    En espera (Azul)     │ Libre (Cel)  │
└─────────────────┴──────────────┴─────────────────────────┴──────────────┘
```

Analiza el rol de cada segmento:
1. **En uso (Verde):** Memoria actualmente asignada a procesos, controladores y al Kernel. No puede ser reutilizada inmediatamente por otros procesos sin liberar o paginar.
2. **Modificada (Naranja):** Páginas cuyos contenidos fueron alterados por una aplicación y deben ser escritas en el disco (`pagefile.sys` o archivos mapeados) antes de poder asignarse a otro proceso.
3. **En espera (*Standby* - Azul):** Páginas de memoria que contienen datos y código que ya no están en uso activo pero que el SO conserva en RAM por si se vuelven a requerir (evitando lecturas lentas a disco). Si otro programa necesita RAM de emergencia, Windows convierte estas páginas a *Libre* instantáneamente.
4. **Libre (Celeste):** Bloques de RAM completamente vacíos, que no contienen ningún dato.

> [!NOTE]
> **Desmitificación Técnica:** Si ves que tu equipo tiene poca memoria *"Libre"* pero mucha memoria *"En espera"*, **no significa que falte RAM**. Significa que Windows 11 está aprovechando la velocidad de la RAM para acelerar el sistema inteligente mediante *SuperFetch / SysMain*.

---

## ⚡ Fase 3: Detección de Fallos de Página (*Page Faults*)

En la tabla superior de la pestaña **Memoria** de `resmon.exe`, localiza las columnas:
* **Confirmada (KB) (*Commit*):** Memoria virtual privada reservada por el proceso.
* **Espacio de trabajo (KB) (*Working Set*):** Cantidad de memoria que el proceso tiene físicamente residente en la RAM en este instante.
* **Compartible (KB) / Privada (KB).**
* **Errores de hardware/seg (*Hard Page Faults*):** Fallos de página que obligaron al Kernel a leer el dato desde el disco.

### Paso 3.1: Identificación de Fallos Duros
1. Haz un clic sobre la cabecera de la columna **Errores de hardware/seg** para ordenar los procesos de mayor a menor.
2. Abre una aplicación pesada (por ejemplo, Google Chrome, Visual Studio Code o Edge) y observa qué ocurre con esa columna en los primeros 3 segundos.
3. **Diferenciación conceptual:**
   * **Fallo de página suave (*Soft Page Fault*):** La página requerida estaba en RAM (por ejemplo, en la lista *Standby* o compartida con otra DLL), por lo que la MMU la vincula a la tabla de páginas en nanosegundos.
   * **Fallo de página duro (*Hard Page Fault*):** La página no estaba en RAM física y el procesador debió detener la ejecución para traer el bloque desde el disco mecánico o SSD. Es el principal causante de los cuelgues temporales del sistema.

---

## 🧪 Fase 4: Inyección Controlada del Escenario de Incidente

Para reproducir el incidente reportado en el ticket sin poner en riesgo la estabilidad del equipo, ejecutaremos el script preparado por la cátedra:

```cmd
cd /d "f:\Mochila\Antigravity\LSO_4to\2do_semestre\repaso_y_evaluacion_parcial\clase2_repaso_memoria_diagnostico"
setup_repaso_clase2.bat
```

### Paso 4.1: Observación de Métricas en Vivo
Con `resmon.exe` abierto al lado de la consola, ejecuta el script y observa:
1. ¿Aparece un proceso llamado `powershell.exe` o la tarea de diagnóstico reservando memoria?
2. ¿Qué ocurre con la columna **Confirmada (KB)** en comparación con su **Espacio de trabajo (KB)**?
3. ¿Cómo reacciona la barra de memoria física en el gráfico inferior (aumento de *En uso* o de *Modificada*)?
4. Observa el valor de **Memoria confirmada** en el Administrador de Tareas: ¿a qué porcentaje llegó respecto al *Commit Limit*?

### Paso 4.2: Mitigación del Incidente
Presiona una tecla en la consola del script para finalizar la simulación o cierra el proceso desde el Monitor de Recursos (`Clic derecho sobre el proceso -> Finalizar proceso`).
Observa cómo el Administrador de Memoria de Windows recupera los marcos de página y los envía a la lista *En espera* o *Libre*.

---

## 🛡️ Fase 5: Análisis del Kernel: Paged Pool vs. Non-Paged Pool

Regresa a la pestaña Memoria del Administrador de Tareas y examina los dos valores de la parte inferior derecha:
1. **Grupo paginado (*Paged Pool*):**
   * Es el espacio de memoria que el Kernel y los controladores utilizan para estructuras de datos que **sí pueden ser enviadas al disco (`pagefile.sys`)** si la RAM física escasea.
2. **Grupo no paginado (*Non-Paged Pool*):**
   * Es la memoria crítica del Kernel que **bajo ninguna circunstancia puede ser paginada al disco**. Debe residir permanentemente en la RAM física (código de interrupciones IRQ, planificador de hilos, tablas de páginas primarias).
   * **Alerta Técnica:** Si el *Non-Paged Pool* supera los 500 MB o 1 GB en una máquina de escritorio, es indicio directo de un controlador (*driver*) defectuoso con fuga de memoria.

---

## 📝 Dictamen Técnico de Cierre del Ticket #402

Completa las siguientes preguntas de conclusión técnica:
1. ¿Cuál es la diferencia entre el **Working Set** de un proceso y su **Commit Charge**?
2. ¿Por qué una tasa sostenida de cientos de **Errores de hardware/seg** degrada severamente el rendimiento de una computadora con disco rígido convencional?
3. Si un equipo tiene 8 GB de RAM y el archivo `pagefile.sys` está configurado en 4 GB, ¿cuál es el **Commit Limit** total del sistema? ¿Qué ocurre si la suma de memoria solicitada por todos los programas supera ese límite?
4. Si un controlador de tarjeta de red presenta una fuga de memoria en el **Non-Paged Pool**, ¿puede Windows salvar la situación volcando esos datos al `pagefile.sys`? Justifica técnicamente.
