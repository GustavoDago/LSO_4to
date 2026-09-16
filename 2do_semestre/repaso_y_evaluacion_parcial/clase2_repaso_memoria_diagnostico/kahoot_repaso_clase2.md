# Cuestionario Gamificado Kahoot: Clase 2 de Repaso
## Módulo 3: Arquitectura y Diagnóstico Clínico de Memoria en Windows 11
### Laboratorio de Sistemas Operativos — 4.º Año

---

### Pregunta 1
* **Pregunta:** ¿Qué componente del hardware se encarga de traducir direcciones de memoria virtual a física?
* **Opciones:**
  * A) BIOS / UEFI.
  * B) MMU (Memory Management Unit). *(Correcta)*
  * C) Controlador DMA.
  * D) Unidad de Punto Flotante (FPU).
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* La MMU es la unidad de hardware dentro del microprocesador que consulta las tablas de páginas (y el buffer TLB) para transformar las direcciones lógicas vistas por el software en marcos físicos de RAM.
  * *Opción A (Distractor):* BIOS/UEFI es el firmware de inicialización de la placa madre y arranque del sistema.
  * *Opción C (Distractor):* El DMA permite transferencias entre periféricos y RAM sin intervención del CPU, pero no gestiona memoria virtual.
  * *Opción D (Distractor):* La FPU realiza cálculos matemáticos de punto flotante.

---

### Pregunta 2
* **Pregunta:** ¿Cuál es el tamaño estándar de una página de memoria en arquitecturas x86 y x64 de Windows?
* **Opciones:**
  * A) 512 Bytes.
  * B) 4 Kilobytes (4096 bytes). *(Correcta)*
  * C) 64 Kilobytes.
  * D) 1 Megabyte.
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* Tanto en procesadores Intel como AMD de 32 y 64 bits bajo Windows, el tamaño de granularidad estándar de página de memoria virtual y marco físico es de exactamente 4096 bytes (4 KB).
  * *Opción A (Distractor):* 512 bytes es el tamaño del sector clásico en discos magnéticos.
  * *Opción C (Distractor):* 64 KB es la granularidad de asignación de regiones de memoria en Windows (`VirtualAlloc`), pero no el tamaño de la página individual.
  * *Opción D (Distractor):* 1 MB es una unidad de partición o tamaño de buffer grande.

---

### Pregunta 3
* **Pregunta:** ¿Qué ocurre durante un fallo de página suave (Soft Page Fault)?
* **Opciones:**
  * A) El procesador debe leer obligatoriamente la página desde el disco rígido.
  * B) El sistema operativo arroja una pantalla azul de la muerte (BSOD).
  * C) La página ya está en la RAM física y la MMU la vincula en nanosegundos. *(Correcta)*
  * D) El proceso se cierra inmediatamente por violación de acceso a memoria.
* **Respuesta Correcta:** C
* **Fundamentación Técnica:**
  * *Opción C (Correcta):* En un *Soft Page Fault*, el bloque solicitado reside en la memoria RAM (en la lista en espera, modificada o compartida), por lo que el Kernel simplemente actualiza la tabla de páginas sin esperar al almacenamiento secundario.
  * *Opción A (Distractor):* La lectura desde disco corresponde a un fallo de página duro (*Hard Page Fault*).
  * *Opción B (Distractor):* Los fallos de página son eventos operacionales normales, no provocan BSOD salvo que ocurran en el Non-Paged Pool.
  * *Opción D (Distractor):* Solo un intento de acceso a memoria no asignada o protegida dispara una excepción `STATUS_ACCESS_VIOLATION`.

---

### Pregunta 4
* **Pregunta:** ¿Qué consecuencia produce una tasa elevada y sostenida de fallos de página duros (Hard Faults)?
* **Opciones:**
  * A) Congelamiento del sistema (thrashing) por lectura masiva desde pagefile.sys. *(Correcta)*
  * B) Duplicación de la memoria RAM disponible en el Administrador de Tareas.
  * C) Desactivación automática del firewall de Windows y del antivirus.
  * D) Pérdida definitiva de las tablas de particiones GPT de los discos.
* **Respuesta Correcta:** A
* **Fundamentación Técnica:**
  * *Opción A (Correcta):* Los *Hard Page Faults* obligan al procesador a esperar operaciones de lectura a disco (milisegundos); cuando son masivos, el equipo entra en hiperpaginación (*thrashing*) y el disco se satura al 100%.
  * *Opción B (Distractor):* La memoria física no se duplica.
  * *Opción C y D (Distractores):* No guardan relación alguna con la gestión de memoria virtual del Kernel.

---

### Pregunta 5
* **Pregunta:** En la barra de memoria de resmon.exe, ¿qué representa la memoria en estado "En espera" (Standby)?
* **Opciones:**
  * A) Memoria dañada físicamente que el sistema operativo no puede utilizar.
  * B) Datos en caché conservados en RAM que se ceden al instante si se requiere. *(Correcta)*
  * C) Memoria reservada exclusivamente para el arranque en frío de Windows.
  * D) Memoria ocupada por virus y procesos maliciosos que no se pueden cerrar.
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* La lista *Standby* actúa como una memoria caché inteligente que guarda páginas de archivos y aplicaciones cerradas recientemente; si otro proceso requiere memoria de urgencia, Windows descarta o reasigna estas páginas en microsegundos.
  * *Opción A (Distractor):* La memoria dañada es marcada por el BIOS/Kernel como *Bad Memory* y se descarta del mapa físico.
  * *Opción C y D (Distractores):* Conceptos erróneos habituales de usuarios novatos.

---

### Pregunta 6
* **Pregunta:** ¿Cómo se calcula matemáticamente el Límite de Compromiso (Commit Limit) en Windows?
* **Opciones:**
  * A) Capacidad total del disco rígido C: dividido la velocidad del procesador.
  * B) Memoria RAM física instalada + Tamaño del archivo pagefile.sys. *(Correcta)*
  * C) Memoria de la tarjeta gráfica + Caché L3 del procesador.
  * D) Cantidad de procesos en ejecución multiplicado por 4 Kilobytes.
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* El *Commit Limit* es el techo absoluto de memoria virtual respaldable que el subsistema de memoria puede garantizar: la RAM física más el tamaño actual del archivo de intercambio `pagefile.sys`.
  * *Opción A, C y D (Distractores):* Fórmulas ficticias sin fundamento en la arquitectura del Kernel de Windows NT.

---

### Pregunta 7
* **Pregunta:** ¿Qué es una fuga de memoria (Memory Leak) en una aplicación?
* **Opciones:**
  * A) Un programa solicita memoria continuamente y no la libera al terminar de usarla. *(Correcta)*
  * B) Un cortocircuito en los zócalos DIMM de la placa madre que pierde datos.
  * C) La eliminación accidental del archivo pagefile.sys de la raíz de C:.
  * D) El envío no autorizado de contraseñas de la base SAM a través de la red.
* **Respuesta Correcta:** A
* **Fundamentación Técnica:**
  * *Opción A (Correcta):* Un *memory leak* es un defecto de software donde el programa reserva bloques en el Heap (*malloc / new*) y pierde las referencias a ellos sin destruirlos, incrementando su memoria privada hasta agotar los recursos.
  * *Opción B (Distractor):* Falla de hardware físico, no una fuga lógica de software.
  * *Opción C (Distractor):* `pagefile.sys` está bloqueado en uso exclusivo por el Kernel y no se borra por accidente.
  * *Opción D (Distractor):* Describe una brecha de seguridad o malware de robo de credenciales.

---

### Pregunta 8
* **Pregunta:** ¿Por qué la memoria del Non-Paged Pool (Grupo no paginado) jamás se envía al disco?
* **Opciones:**
  * A) Porque es memoria que reside dentro de los registros internos del procesador.
  * B) Contiene rutinas críticas del Kernel e interrupciones que deben estar siempre en RAM. *(Correcta)*
  * C) Porque el sistema de archivos NTFS no permite almacenar datos del Kernel.
  * D) Para evitar que los usuarios estándar puedan leer las contraseñas de Windows.
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* Si el código que atiende una interrupción de hardware de disco o del planificador fuera paginado a disco y sufriera un *Page Fault*, el sistema entraría en un callejón sin salida (deadlock) y provocaría un pantallazo azul inmediato.
  * *Opción A (Distractor):* Los registros del CPU son apenas unos cientos de bytes de almacenamiento interno del chip.
  * *Opción C (Distractor):* NTFS aloja perfectamente el `pagefile.sys` del Kernel.
  * *Opción D (Distractor):* La protección de contraseñas corre por cuenta de la base SAM y la LSA, no del pool de memoria.

---

### Pregunta 9
* **Pregunta:** En el Monitor de Recursos, ¿qué diferencia al "Working Set" del "Commit Size" de un proceso?
* **Opciones:**
  * A) El Working Set está en el disco rígido y Commit está en la memoria caché L1.
  * B) El Working Set es la RAM física real y Commit es la memoria virtual reservada. *(Correcta)*
  * C) No hay diferencia, son dos nombres distintos para el mismo valor de RAM.
  * D) El Working Set mide el uso de CPU y Commit mide la velocidad de lectura.
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* El *Working Set* es el conjunto de páginas del proceso que residen físicamente en marcos de RAM en este instante. El *Commit Size* es la memoria virtual privada total que el proceso ha solicitado respaldar al SO.
  * *Opción A, C y D (Distractores):* Afirmaciones técnicamente erróneas.

---

### Pregunta 10
* **Pregunta:** ¿Qué sucede si el Commit Charge de todos los programas activos alcanza el Commit Limit?
* **Opciones:**
  * A) Windows muestra la advertencia de memoria insuficiente y rechaza nuevas reservas. *(Correcta)*
  * B) El sistema operativo formatea la unidad secundaria para crear más espacio.
  * C) La memoria RAM física se expande automáticamente mediante el bus PCIe.
  * D) Todos los usuarios pierden sus privilegios de administrador de inmediato.
* **Respuesta Correcta:** A
* **Fundamentación Técnica:**
  * *Opción A (Correcta):* Al alcanzar el límite, el Administrador de Memoria no puede otorgar más compromisos; Windows advierte al usuario con *"Cierre programas para impedir la pérdida de datos"* y las aplicaciones que intenten reservar más memoria fallan con excepciones de memoria insuficiente.
  * *Opción B, C y D (Distractores):* Comportamientos ficticios.
