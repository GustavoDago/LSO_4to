# Guía de Actividades de Laboratorio N.º 2: Paginación, Fallos de Página y Pools de Memoria en Windows 11
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
### Módulo 3: Arquitectura y Administración de Memoria — Clase 2

---

* **Estudiante(s):** __________________________________________________
* **Fecha:** ___ / ___ / 2026
* **Terminal / Equipo N.º:** ________
* **Sistema Operativo:** Windows 11
* **Tiempo Estimado de Laboratorio:** 2 horas de clase práctica (individual o en parejas).

---

## 🎯 Objetivos de Aprendizaje
1. Auditar en tiempo real la **Memoria Confirmada (*Commit Charge*)** y dimensionar el tamaño del archivo de paginación (`pagefile.sys`) respecto a la memoria física instalada.
2. Identificar y contrastar la asignación de memoria del núcleo entre el **Grupo Paginado (*Paged Pool*)** y el **Grupo No Paginado (*Non-Paged Pool*)** usando el Administrador de Tareas.
3. Desglosar mediante el **Monitor de Recursos (`resmon.exe`)** el estado real de la memoria RAM: *Hardware reservado*, *En uso*, *Modificada*, *En espera (Standby)* y *Libre*, desterrando el mito de la "RAM desperdiciada".
4. Experimentar y medir la ocurrencia de **Fallos de Página Suaves (*Soft Page Faults*)** vs. **Fallos de Página Duros (*Hard Page Faults*)** al interactuar con aplicaciones en vivo.
5. Analizar y diagnosticar problemáticas reales del administrador de sistemas: colapso por desactivación del archivo de intercambio y detección forense de fugas de memoria (*memory leaks*) en el Ring 0.

---

## 🧭 Requisitos Previos e Instrumental de Trabajo
* Computadora del laboratorio con Windows 11 (no requiere descongelar Deep Freeze ni privilegios de administrador de red).
* Instrumental de software nativo:
  * **Administrador de Tareas de Windows** (`taskmgr.exe`).
  * **Monitor de Recursos de Windows** (`resmon.exe`).
* Conceptos previos leídos del [Manual Teórico Parte 2](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo3_memoria/clase2/manual_teorico_memoria_windows_parte2.md): Páginas de 4 KB, Page Faults, pagefile.sys, Non-Paged Pool.

---

## 🔬 Parte 1: Auditoría de Memoria Confirmada (*Commit Charge*) y Pools del Kernel

1. Abrí el Administrador de Tareas presionando el atajo de teclado:  
   `Ctrl` + `Shift` + `Esc`  
   *(Asegurate de que esté en vista completa haciendo clic en "Más detalles" si se abre minimizado).*
2. En el menú de navegación lateral, seleccioná el ícono de **Rendimiento** (gráfico de pulsos) y luego hacé clic en **Memoria**.
3. En la parte inferior del panel de Memoria, registrá con exactitud los siguientes valores del sistema operativo:

| Parámetro del Administrador de Tareas | Valor Registrado en la Terminal | Significado Técnico |
| :--- | :--- | :--- |
| **En uso (Comprimida):** | | Memoria RAM física activa asignada a procesos, drivers y kernel. |
| **Disponible:** | | Suma de memoria libre y memoria en lista de espera (Standby). |
| **Confirmada (*Commit Charge*):** | _____ / _____ GB | Memoria virtual asignada / Límite máximo de compromiso del SO. |
| **Caché en disco (En caché):** | | Datos y código retenidos en RAM para acelerar lecturas futuras. |
| **Grupo paginado (*Paged Pool*):** | | Memoria del Kernel que puede enviarse a `pagefile.sys`. |
| **Grupo no paginado (*Non-Paged Pool*):**| | Memoria del Kernel fijada en RAM física que nunca puede paginarse. |

---

### 📝 Ejercicio de Cálculo Técnico:
El **Límite de Compromiso (*Commit Limit*)** es el segundo número que figura en el renglón **Confirmada** (por ejemplo: `4,2 / 11,8 GB`).  
Matemáticamente responde a la fórmula:  
$$\text{Límite de Compromiso} \approx \text{Memoria RAM Física} + \text{Tamaño Actual de pagefile.sys}$$

1. Anotá la memoria RAM total de tu equipo: ________ GB.
2. Anotá el Límite de Compromiso reportado: ________ GB.
3. Calculá la diferencia para estimar el tamaño que Windows le asignó dinámicamente al archivo `pagefile.sys`:
$$\text{Tamaño Estimado de pagefile.sys} = \text{Límite de Compromiso} - \text{Memoria RAM Física} = \text{\underline{\hspace{2cm}}\,GB}$$

### 📝 Pregunta de Análisis 1:
Compará los tamaños registrados entre el **Grupo paginado** y el **Grupo no paginado**.  
¿Cuál de los dos es menor? Si un controlador de placa de red defectuoso comenzara a consumir memoria sin liberarla (*fuga de memoria* o *leak*) dentro del **Grupo no paginado**, ¿por qué el sistema operativo no puede solucionar el problema enviando esa memoria al disco `pagefile.sys`? Justificá con los conceptos del Ring 0.

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  

---

## 🔬 Parte 2: Análisis Forense de la RAM con el Monitor de Recursos (`resmon.exe`)

El Administrador de Tareas resume la memoria, pero el **Monitor de Recursos** permite visualizar la asignación física a bajo nivel que gestiona el Administrador de Memoria de Windows NT.

1. En el Administrador de Tareas, hacé clic en los tres puntos superiores `...` (o en la parte inferior de la pestaña Rendimiento) y seleccioná **Abrir el Monitor de Recursos**.  
   *(Alternativa rápida: presioná `Win` + `R`, escribí `resmon.exe` y presioná Enter).*
2. En la ventana del Monitor de Recursos, seleccioná la pestaña **Memoria**.
3. Prestá especial atención a la barra horizontal multicolor ubicada en la parte inferior, titulada **Memoria física**:

```
[ Hardware reservado | En uso (Verde) | Modificada (Naranja) | En espera (Azul oscuro) | Libre (Celeste) ]
```

4. Anotá los valores en Megabytes (MB) de cada bloque de la barra:

| Estado de la Memoria Física | Valor en MB | Rol en la Arquitectura del Sistema Operativo |
| :--- | :--- | :--- |
| **Hardware reservado:** | | Memoria asignada a BIOS/UEFI y periféricos integrados (ej: placa de video integrada). |
| **En uso:** | | Páginas activas utilizadas por programas, servicios del SO y el Kernel. |
| **Modificada:** | | Páginas con datos alterados que deben guardarse en disco antes de reutilizarse. |
| **En espera (*Standby List*):** | | Páginas con copias de archivos y código ya cargados; listas para reuso instantáneo. |
| **Libre:** | | Páginas sin contenido; solo contienen ceros o están disponibles de inmediato. |

---

### 📝 Pregunta de Análisis 2:
Es muy común escuchar a usuarios quejarse: *"¡Windows me consume casi toda la memoria, me queda solo 500 MB libres de 8 GB!"*.  
Observá la suma entre la memoria **En espera (*Standby*)** y la memoria **Libre**.  
¿Por qué en los sistemas operativos modernos (Windows, Linux, macOS) tener mucha memoria "En espera" y poca memoria "Libre" es un síntoma de **alta eficiencia** y no un problema? ¿Qué sucede con la memoria "En espera" si de pronto abrís un videojuego o programa pesado que solicita mucha RAM de golpe?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  

---

## 🔬 Parte 3: Experimento de Fallos de Página (*Page Faults*) en Vivo

Un **Page Fault (Fallo de Página)** no es un error de software, sino una interrupción estándar de la CPU cuando una dirección de memoria solicitada no está mapeada directamente en la tabla de páginas del proceso.

1. En el **Monitor de Recursos**, dentro de la pestaña **Memoria**, observá la tabla superior de **Procesos**.
2. Hacé clic en la cabecera de la columna **Errores de página graves/s** (en inglés: *Hard Faults/sec*) para ordenar los procesos de mayor a menor consumo de fallos de disco.
3. Observá el valor general con el equipo en reposo (sin abrir nada nuevo). Generalmente oscilará entre `0` y `5` fallos/s.
4. **Experimento A (Disparo de Hard Faults):**  
   * Abrí una aplicación pesada que no hayas usado hoy (por ejemplo: Google Chrome, Microsoft Edge con varias pestañas, LibreOffice o Visual Studio Code).  
   * Mirá fijamente el Monitor de Recursos mientras el programa se abre.
   * ¿Qué ocurre con la columna **Errores de página graves/s** durante los primeros segundos? ¿A qué valor pico llegó y en qué proceso?  
   *Proceso:* _________________________ | *Pico de Hard Faults/s:* _________
5. **Experimento B (Diferenciación con Soft Faults):**  
   * Minimizá la ventana del navegador. Abrí el Bloc de Notas (`notepad.exe`). Maximizá nuevamente el navegador y navegá entre pestañas ya abiertas.
   * En el Administrador de Tareas (`taskmgr.exe`), andá a **Detalles**, hacé clic derecho en las cabeceras de columnas, elegí **Elegir columnas** y tildá **Fallos de página**.
   * Observá cómo el contador acumulado de "Fallos de página" (que incluye Soft Faults) aumenta de a miles de unidades por segundo, mientras que la columna "Errores de página graves/s" del Monitor de Recursos permanece prácticamente en `0`.

---

### 📝 Pregunta de Análisis 3:
Explicá con tus palabras la diferencia técnica observada en el experimento entre un **Soft Page Fault** y un **Hard Page Fault**:
* ¿Por qué el Soft Page Fault no congela la máquina ni produce demoras perceptibles al usuario?
* ¿Por qué una ráfaga intensa de Hard Page Faults causa el típico congelamiento o lentitud extrema en una máquina con disco mecánico (HDD)?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  

---

## 🔬 Parte 4: Casos Clínicos del Administrador de Sistemas

Analizá las siguientes dos situaciones reales que enfrenta un técnico en informática o administrador de infraestructura y fundamentá tus respuestas con rigor técnico:

### Caso Clínico 1: El Mito de "Optimizar" desactivando el Paginado
Un usuario gamer con una computadora de 16 GB de RAM vio un video en redes sociales que recomendaba:  
*"Para duplicar los FPS y cuidar la vida útil de tu SSD, desactivá por completo el archivo de paginación (`pagefile.sys` = 0 MB)"*.  
El usuario aplicó el cambio y reinició. A las dos horas, mientras jugaba y tenía Discord abierto de fondo, el juego se cerró abruptamente sin aviso de error y Windows arrojó una notificación:  
`"El equipo no tiene suficiente memoria. Guarde sus archivos y cierre estos programas."`  
Al mirar el Administrador de Tareas, el usuario observó que la memoria RAM física marcaba solo un **75% de uso (12 GB de 16 GB ocupados)**.

1. Si todavía quedaban 4 GB de RAM física libres, ¿por qué Windows cerró el juego por falta de memoria? Relacioná tu respuesta con el concepto de **Memoria Confirmada (*Commit Charge*)** y la imposibilidad del SO de prometer memoria virtual sin respaldo.
2. Si ocurriera un fallo crítico de hardware en el sistema con el archivo de paginación desactivado, ¿podrá Windows escribir el archivo de volcado de depuración (`MEMORY.DMP` / Crash Dump)? ¿Por qué?

> **Diagnóstico Técnico 1:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  

---

### Caso Clínico 2: La Fuga Silenciosa en el Modo Núcleo (*Pool Leak*)
En el laboratorio de la escuela, una computadora con 8 GB de RAM comienza a funcionar cada vez más lenta a medida que pasan las horas. El usuario solo tiene abierto Word, pero la memoria RAM física marca **95% de uso**.  
Al revisar la lista de procesos en el Administrador de Tareas, la suma de memoria de todos los programas visibles de usuario apenas llega a **1,5 GB**.  
Sin embargo, en la pestaña **Rendimiento > Memoria**, el técnico observa el siguiente parámetro anómalo:  
* **Grupo no paginado (*Non-Paged Pool*): 5,8 GB** (cuando el valor habitual suele ser de 200 a 400 MB).

1. ¿Qué está ocurriendo en el sistema? ¿El causante es un programa de usuario en Ring 3 o un controlador/driver en Ring 0?
2. ¿Por qué el Administrador de Tareas no muestra este consumo en la pestaña habitual de "Procesos"?
3. ¿Por qué este problema no puede resolverse cerrando aplicaciones y obliga a actualizar o desinstalar el controlador responsable?

> **Diagnóstico Técnico 2:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  

---

## 🏆 Cuestionario de Cierre y Autoevaluación
Al finalizar esta guía práctica, participá del cuestionario gamificado **Kahoot de la Clase 2** y completá el formulario digital evaluativo en Google Classroom para registrar tu calificación.
