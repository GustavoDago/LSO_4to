# Cuestionario Gamificado Kahoot: Paginación, Page Faults y Pools de Memoria
## Módulo 3 — Clase 2: Paginación, pagefile.sys y Pools del Kernel en Windows 11
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año

---

### 📋 Estructura y Reglas Pedagógicas
* **Total de Preguntas:** 10
* **Opciones por Pregunta:** 4 (1 Opción Correcta y 3 Distractores Técnicos Fundamentados)
* **Límites de Caracteres Kahoot:** Pregunta ≤ 120 caracteres | Cada respuesta ≤ 75 caracteres
* **Plantilla Excel:** Sincronizado con [`kahoot_clase2.xlsx`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo3_memoria/clase2/kahoot_clase2.xlsx) (listo para importar a Kahoot).
* **Objetivo Didáctico:** Fijar los conceptos de paginación de 4 KB, fallos de página suaves y duros, rol de la lista En Espera (*Standby*), funcionamiento real de `pagefile.sys`, límite de compromiso (*Commit Limit*) y la división crítica entre *Paged Pool* y *Non-Paged Pool*.

---

### ❓ Pregunta 1
**¿Cuál es el tamaño estándar de una página virtual en sistemas x86 y x64 en Windows?**

* **A)** 64 Kilobytes.
* **B)** 4 Kilobytes (4096 bytes). ✔️ *(Opción Correcta)*
* **C)** 1 Megabyte.
* **D)** 512 Bytes.

> **Fundamentación Pedagógica:**
> * **Opción B (Correcta):** En las arquitecturas x86 y x64 de Windows, la unidad mínima estándar de asignación de memoria virtual y física es la página de 4 KB (4096 bytes).
> * *Distractor A:* 64 KB es la alineación de granularidad de reserva en la API Win32 (`VirtualAlloc`), pero el tamaño de página atómica de hardware es de 4 KB.
> * *Distractor C:* Las "páginas grandes" (*Large Pages*) pueden medir 2 MB o 1 GB, pero no son el tamaño estándar del sistema.
> * *Distractor D:* 512 bytes es el tamaño típico de un sector físico de disco magnético clásico, no una página de memoria.

---

### ❓ Pregunta 2
**¿Qué sucede en el sistema durante un Fallo de Página Suave (Soft Page Fault)?**

* **A)** Se lee el archivo pagefile.sys desde el disco rígido.
* **B)** La página ya está en RAM y el Kernel solo actualiza la tabla. ✔️ *(Opción Correcta)*
* **C)** El microprocesador sufre un error de hardware irreparable.
* **D)** Se reinicia el servicio de Windows Update en segundo plano.

> **Fundamentación Pedagógica:**
> * **Opción B (Correcta):** En un *Soft Fault*, los datos ya se encuentran en la memoria RAM (en la lista *Standby* o compartidos por otro proceso); la MMU y el Kernel solo deben restablecer la correspondencia en la tabla de páginas sin demoras de I/O.
> * *Distractor A:* Leer del disco (`pagefile.sys`) corresponde a un *Hard Page Fault*, no a un *Soft Fault*.
> * *Distractor C:* Un fallo de página no es un fallo físico ni un cuelgue del hardware; es una excepción rutinaria de control.
> * *Distractor D:* Windows Update no interviene en la resolución de excepciones de traducción de memoria del procesador.

---

### ❓ Pregunta 3
**¿Por qué un Fallo de Página Duro (Hard Fault) genera lentitud perceptible en la PC?**

* **A)** Obliga a la CPU a suspender el hilo y leer datos desde el disco. ✔️ *(Opción Correcta)*
* **B)** Desconecta la placa madre de la fuente de alimentación.
* **C)** Borra la memoria caché L1 para enfriar el procesador.
* **D)** Fuerza al usuario a cerrar sesión en Windows de inmediato.

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** El procesador debe suspender la ejecución del hilo y esperar una operación de Entrada/Salida hacia el disco (milisegundos), que es órdenes de magnitud más lento que la memoria RAM (nanosegundos).
> * *Distractor B:* El hardware eléctrico de la fuente no se desactiva ante operaciones normales de memoria.
> * *Distractor C:* Las cachés de la CPU no se eliminan por refrigeración; operan automáticamente por hardware de coherencia.
> * *Distractor D:* Los fallos duros se resuelven de forma transparente para el usuario sin cerrar su sesión ni interrumpir el sistema.

---

### ❓ Pregunta 4
**En el Monitor de Recursos, ¿qué representa la memoria en estado "En espera" (Standby)?**

* **A)** Memoria dañada con errores físicos de hardware.
* **B)** Memoria no utilizable reservada por la BIOS del equipo.
* **C)** Caché de datos y código reutilizable lista para liberarse si hace falta. ✔️ *(Opción Correcta)*
* **D)** Memoria consumida por virus que no puede recuperarse.

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta / C):** La lista *Standby* contiene páginas con copias de archivos ejecutados recientemente. Acelera reaperturas y, si otro programa pide RAM urgente, el Administrador de Memoria la reutiliza de inmediato.
> * *Distractor A:* La memoria con fallas físicas es marcada por Windows como "Hardware dañado" o excluida a nivel de firmware, no clasificada como Standby.
> * *Distractor B:* La memoria reservada por BIOS/firmware figura bajo la etiqueta "Hardware reservado".
> * *Distractor D:* Es un mecanismo nativo de optimización de Windows NT, no un residuo de código malicioso.

---

### ❓ Pregunta 5
**¿Qué tipo de datos se transfieren principalmente al archivo de paginación pagefile.sys?**

* **A)** Archivos ejecutables .exe y librerías .dll inalteradas.
* **B)** Páginas de memoria privada modificada que no existen en disco. ✔️ *(Opción Correcta)*
* **C)** Videos y fotos personales guardados en la carpeta Documentos.
* **D)** El firmware UEFI de la placa madre del equipo.

> **Fundamentación Pedagógica:**
> * **Opción B (Correcta):** Solo la memoria anónima y modificada (variables y estructuras creadas en memoria que no tienen un archivo original en disco) va al `pagefile.sys`.
> * *Distractor A:* Los binarios ejecutables inalterados se descartan de la RAM y, si vuelven a requerirse, se leen directo de su archivo original sin duplicarse en `pagefile.sys`.
> * *Distractor C:* Los archivos de usuario residen permanentemente en el sistema de archivos del disco, no en el espacio de intercambio de memoria volátil.
> * *Distractor D:* El firmware UEFI reside en una memoria Flash ROM soldada en el motherboard, totalmente independiente de la memoria virtual del SO.

---

### ❓ Pregunta 6
**¿Por qué es un error técnico desactivar por completo el archivo pagefile.sys?**

* **A)** Windows no podrá comprometer memoria virtual y fallarán programas. ✔️ *(Opción Correcta)*
* **B)** La memoria RAM física se quemará por exceso de temperatura.
* **C)** La velocidad de internet descenderá a menos de 1 Mbps.
* **D)** El procesador dejará de reconocer la arquitectura de 64 bits.

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** Windows requiere respaldar el *Commit Limit*. Si se apaga el swap, las reservas virtuales no garantizadas causan cierres de emergencia por falta de memoria y se anula la creación de volcados de choque (*Crash Dumps*).
> * *Distractor B:* La temperatura de los módulos RAM está controlada por su disipador y voltaje JEDEC/XMP, no por la configuración del subsistema de paginación.
> * *Distractor C:* La velocidad de transferencia de la red (ancho de banda) es independiente de la existencia del archivo de intercambio.
> * *Distractor D:* El conjunto de instrucciones x86-64 es inherente al microprocesador y no depende de la configuración de archivos de Windows.

---

### ❓ Pregunta 7
**¿A qué equivale el Límite de Compromiso (Commit Limit) reportado por Windows?**

* **A)** Exclusivamente al tamaño de la memoria caché L3 de la CPU.
* **B)** A la suma de la RAM física más el tamaño del archivo de intercambio. ✔️ *(Opción Correcta)*
* **C)** A la capacidad total de almacenamiento del disco rígido C:.
* **D)** Al consumo de memoria de los programas de 32 bits activos.

> **Fundamentación Pedagógica:**
> * **Opción B (Correcta):** El *Commit Limit* representa la cantidad total de memoria virtual garantizada que el SO puede prometer simultáneamente, calculada como la RAM física disponible más el tamaño actual del archivo `pagefile.sys`.
> * *Distractor A:* La caché L3 mide apenas unos megabytes en la CPU y no fija los límites de asignación de memoria virtual global.
> * *Distractor C:* El espacio libre del disco no es usable directamente como memoria garantizada a menos que esté reservado por el archivo de paginación.
> * *Distractor D:* Los programas de 32 bits tienen un límite propio de 4 GB en su espacio individual, sin fijar el límite de compromiso global del sistema.

---

### ❓ Pregunta 8
**¿Qué característica distingue de forma absoluta al Grupo No Paginado (Non-Paged Pool)?**

* **A)** Puede ser comprimido y enviado a un pendrive USB.
* **B)** Reside permanentemente en RAM física y jamás se envía al disco. ✔️ *(Opción Correcta)*
* **C)** Se borra cada 5 minutos para ahorrar energía de la batería.
* **D)** Solo almacena datos de aplicaciones de usuario en Ring 3.

> **Fundamentación Pedagógica:**
> * **Opción B (Correcta):** El *Non-Paged Pool* está garantizado en memoria RAM física continua. Jamás puede ser paginado a disco para evitar interbloqueos catastróficos en rutinas del Kernel de alta prioridad.
> * *Distractor A:* Ninguna sección de la memoria del núcleo se envía a dispositivos extraíbles USB durante el funcionamiento normal.
> * *Distractor C:* Las estructuras del Kernel persisten durante toda la sesión del sistema operativo según las necesidades del hardware.
> * *Distractor D:* Pertenece al espacio de Modo Núcleo (Ring 0); los procesos de usuario en Ring 3 no tienen acceso ni asignación sobre este grupo.

---

### ❓ Pregunta 9
**¿Por qué las rutinas de interrupción de hardware (ISRs) deben usar memoria Non-Paged?**

* **A)** Para evitar que la CPU se bloquee esperando I/O de disco si paginara. ✔️ *(Opción Correcta)*
* **B)** Para que el mouse y el teclado se muevan con más resolución DPI.
* **C)** Porque los controladores de dispositivo no admiten código binario.
* **D)** Para impedir que Windows active la protección contra malware.

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** Si una rutina de atención de interrupciones (ISR) o DPC sufriera un fallo de página hacia el disco, el procesador entraría en interbloqueo (*deadlock*) al suspenderse a sí mismo, causando un colapso del sistema (BSOD).
> * *Distractor B:* La resolución DPI del sensor óptico es una configuración interna del mouse, no un aspecto de la arquitectura de paginación del Kernel.
> * *Distractor C:* Todos los controladores de dispositivos están compilados en código binario ejecutable nativo de la arquitectura de la CPU.
> * *Distractor D:* La seguridad del sistema se preserva justamente aislando estas rutinas en memoria privilegiada garantizada.

---

### ❓ Pregunta 10
**Si el Grupo No Paginado crece sin control hasta agotar la RAM física, ¿cuál es la causa?**

* **A)** Una fuga de memoria (leak) en un driver o estructura del Kernel. ✔️ *(Opción Correcta)*
* **B)** Un archivo de texto de Word demasiado grande en el escritorio.
* **C)** Que el monitor está configurado a una tasa de 144 Hz en Windows.
* **D)** Que la partición del disco rígido está formateada en FAT32.

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** Un crecimiento desmedido del *Non-Paged Pool* es el síntoma clásico de una fuga de memoria (*memory leak*) provocada por un controlador de dispositivo defectuoso en Ring 0 que solicita páginas y nunca las devuelve.
> * *Distractor B:* Un archivo de usuario consume memoria en el espacio de usuario (Ring 3) dentro del proceso de Word, nunca en los pools internos del Kernel.
> * *Distractor C:* La tasa de refresco del monitor influye en la GPU y el búfer de pantalla, sin saturar la memoria no paginada del procesador.
> * *Distractor D:* El sistema de archivos no influye en la fuga de memoria de controladores en ejecución.
