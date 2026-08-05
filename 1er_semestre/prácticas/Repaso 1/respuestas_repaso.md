# Clave de Respuestas - Actividad de Repaso General

Este documento contiene las respuestas esperadas y explicaciones técnicas para la actividad de repaso de Laboratorio de Sistemas Operativos.

## Sección 1: Fundamentos y Arquitectura

1. **Abstracción y Rol del SO:**
   * **Administrador de recursos:** El Sistema Operativo se encarga de repartir el tiempo de CPU, asignar espacio en la memoria RAM y coordinar los periféricos de forma justa, segura y eficiente entre todas las aplicaciones.
   * **Máquina Extendida (Abstracción):** Oculta la extrema complejidad física del hardware (interrupciones, sectores de disco, direcciones de memoria) y le presenta al usuario y a los programas un entorno lógico limpio, fácil de usar (ventanas, archivos, carpetas).

2. **Ciclo de Vida de los Procesos:**
   * Un **programa** es una entidad pasiva (código guardado en el disco). Un **proceso** es una entidad activa: un programa en ejecución que fue cargado en la memoria RAM y al que se le asignó un identificador (PID) y un PCB.
   * **El Viaje:** Nace en estado **Nuevo**. Al ser admitido, pasa a **Listo** esperando su turno. El planificador (*Scheduler*) le asigna CPU y pasa a **Ejecución**. Puede alternar entre Listo y Ejecución, o pasar a **Bloqueado** si debe esperar un evento (como la lectura de un disco lento). Finalmente, cuando termina, pasa al estado **Terminado** y libera sus recursos.

3. **El Chef y la Cocina:**
   * **Kernel:** Es el Chef principal que organiza, da las órdenes y decide qué pedido tiene prioridad.
   * **CPU:** Es la cocina en sí, donde se procesa y ejecuta todo el trabajo duro.
   * **RAM:** Es la mesada de trabajo; donde los ingredientes (datos) se ponen a mano para cocinar rápidamente.
   * **CPU-bound:** Si un comensal/proceso consume todos los recursos, acapara el tiempo del Chef y la cocina, bloqueando al resto de los procesos y causando que la computadora se perciba "lenta" o congelada.

## Sección 2: La Consola (CLI) y PowerShell

1. **Navegación y Gestión:**
   ```powershell
   New-Item -Path "Auditoria_SO" -ItemType Directory
   Set-Location -Path "Auditoria_SO"
   New-Item -Path "reporte.txt" -ItemType File
   ```
   *(También es válido: `mkdir Auditoria_SO; cd Auditoria_SO; ni reporte.txt`)*

2. **Metadatos:**
   ```powershell
   Get-ItemProperty -Path "reporte.txt"
   ```

3. **Gestión de Procesos:**
   * Encontrar el proceso: `Get-Process | Sort-Object CPU -Descending | Select-Object -First 1`
   * Forzar cierre: `Stop-Process -Id <PID>` o `Stop-Process -Name <NombreProceso>`

4. **Seguridad y Permisos:**
   ```powershell
   Get-Acl -Path "reporte.txt"
   ```

## Sección 3: Arranque, Carga (Bootstrapping) y Diagnóstico

1. **Secuencia de Inicio:**
   El orden correcto es: **1) BIOS/UEFI** (Revisión de hardware POST), **2) Boot Manager** (Gestor de arranque), **3) Carga del SO**, **4) Ejecución del Kernel**.

2. **Herramienta BCD:**
   * `bcdedit` sirve para visualizar y modificar la base de datos de la configuración de arranque (Boot Configuration Data). 
   * Requiere permisos de administrador porque modificar el arranque toca las raíces del Sistema Operativo; un error aquí puede dejar al sistema completamente inoperable.

3. **Diagnóstico de Estrés:**
   * **Monitor de Recursos:** En la pestaña CPU, se detecta visualmente cuando la gráfica general y las individuales de cada núcleo alcanzan el techo (100%) sostenido, dibujando una línea plana superior en verde.
   * **Comando para detener:** `Get-Job | Stop-Job | Remove-Job`

## Sección 4: Estética, "Overhead" y el Registro de Windows

1. **El Costo del "Brillo":**
   * El proceso `dwm.exe` (Desktop Window Manager) es el encargado de renderizar (dibujar) las ventanas en pantalla. Al usar transparencias, su consumo de RAM y GPU se dispara porque requiere componer múltiples capas visuales (lo que hay de fondo y el efecto translúcido) antes de enviarlo a la pantalla, generando un costo extra (*overhead*).

2. **Modificación del Registro:**
   * **Ruta:** `HKEY_CURRENT_USER\Control Panel\Desktop`
   * **Valor:** La cadena `FontSmoothing`, modificando su dato de `2` (activado) a `0` (desactivado).

3. **Intervención vs Rendimiento:**
   * Sí, en un servidor es mandatorio sacrificar la estética visual. Los servidores están diseñados para brindar servicios (bases de datos, webs) y procesar información en segundo plano, no para que un usuario interactúe gráficamente con ellos de forma frecuente. Desactivar el suavizado de fuentes, las animaciones y temas visuales libera RAM y ciclos de CPU vitales.

## Sección 5: Experiencia de Usuario (UX) y Dark Patterns

1. **Dark Patterns (Patrones Oscuros):**
   * Son interfaces de usuario diseñadas estratégicamente para engañar, confundir o manipular al usuario para que realice acciones que no pretendía hacer.
   * **Impacto en Rendimiento:** Si el usuario es engañado e instala bloatware u otro proceso secundario indeseado, estos programas corren en segundo plano consumiendo RAM y ciclos de CPU innecesariamente (como los "comensales glotones" vistos en clase), degradando el rendimiento general de la máquina.

2. **Arquitectura de Interfaces:**
   * **Jerarquía:** Garantiza que los elementos más críticos del diagnóstico (ej. "RAM al 99%") sean lo primero que resalte a la vista.
   * **Ley de Fitts:** Aplicada en UX, sugiere que los botones para acciones urgentes o de emergencia (como "Matar Proceso Rebelde") deben ser lo suficientemente grandes y fáciles de alcanzar con el cursor, minimizando el tiempo de respuesta del técnico ante una falla.
