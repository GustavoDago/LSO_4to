# Cuestionario Digital: Paginación, Fallos de Página y Pools de Memoria en Windows 11
## Módulo 3 — Clase 2: Paginación, pagefile.sys y Pools del Kernel
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año

---

> **📋 Formato Optimizado para Google Forms / Google Classroom**  
> *Este documento contiene las 10 preguntas con el orden de preguntas y de opciones (A, B, C, D) **completamente aleatorizado** respecto a la trivia de clase para evitar la memorización mecánica y facilitar su carga directa en Formularios de Google o su asignación como examen individual autocalificable.*  
> **Puntaje total recomendado:** 100 puntos (10 puntos por pregunta).

---

### ⚙️ Metadatos y Configuración para Google Forms

* **Título del Formulario:** LSO 4.º Año — Evaluación Formativa: Paginación, Hard Faults y Pools de Kernel en Windows 11
* **Descripción sugerida:** Evaluación técnica sobre el mecanismo de paginación (páginas de 4 KB), fallos de página (Soft vs Hard Faults), el rol del archivo pagefile.sys, la memoria confirmada (Commit Charge) y la división entre Paged Pool y Non-Paged Pool.
* **Ajustes de Google Forms recomendados:**
  1. Activar **"Convertir en cuestionario"**.
  2. En *Calificaciones*, seleccionar **"Publicar calificaciones más tarde (después de la revisión manual)"** o **"Inmediatamente después de cada entrega"**.
  3. Marcar todas las preguntas como **Obligatorias** con un valor de **10 puntos**.

---

## 📝 Preguntas del Cuestionario (Copiar y Pegar en Google Forms)

---

### Pregunta 1 (10 puntos)
**¿Qué sucede en el sistema operativo durante un Fallo de Página Suave (*Soft Page Fault*)?**

* [ ] **A)** El microprocesador sufre un error de hardware irreparable y reinicia la PC.
* [ ] **B)** Se reinicia el servicio de Windows Update en segundo plano.
* [ ] **C)** La página ya está en la memoria RAM (en caché/Standby) y el Kernel solo actualiza la tabla de páginas.
* [ ] **D)** Se lee el archivo `pagefile.sys` desde el almacenamiento secundario.

---

### Pregunta 2 (10 puntos)
**¿Cuál es el tamaño estándar de una página virtual y de un marco físico en sistemas x86 y x64 de Windows?**

* [ ] **A)** 4 Kilobytes (4096 bytes).
* [ ] **B)** 64 Kilobytes.
* [ ] **C)** 1 Megabyte.
* [ ] **D)** 512 Bytes.

---

### Pregunta 3 (10 puntos)
**¿Por qué es un grave error técnico desactivar por completo el archivo de paginación (`pagefile.sys`) aunque la máquina tenga mucha RAM?**

* [ ] **A)** La velocidad de descarga de la conexión de red se limitará a 1 Mbps.
* [ ] **B)** El microprocesador pierde la capacidad de ejecutar instrucciones de 64 bits.
* [ ] **C)** La memoria RAM física aumentará su temperatura hasta quemar los circuitos.
* [ ] **D)** Windows no podrá garantizar el límite de memoria confirmada (*Commit Charge*), causando cierres inesperados de aplicaciones y bloqueando los volcados de memoria (*Crash Dumps*).

---

### Pregunta 4 (10 puntos)
**¿Por qué un Fallo de Página Duro (*Hard Page Fault*) provoca congelamientos o lentitud perceptible para el usuario?**

* [ ] **A)** Porque el procesador debe suspender el hilo y realizar una operación lenta de lectura al disco para traer los 4 KB a RAM.
* [ ] **B)** Porque el monitor reduce automáticamente su tasa de refresco a 30 Hz.
* [ ] **C)** Porque borra la memoria caché L1 para permitir que el disipador se enfríe.
* [ ] **D)** Porque desconecta la placa madre de la fuente de poder por microsegundos.

---

### Pregunta 5 (10 puntos)
**En el Monitor de Recursos (`resmon.exe`), ¿qué función cumple la memoria física en estado "En espera" (*Standby*)?**

* [ ] **A)** Es memoria defectuosa que Windows aisló para que ningún programa la utilice.
* [ ] **B)** Es memoria asignada de forma exclusiva a la BIOS/UEFI de la placa madre.
* [ ] **C)** Es una caché activa de datos y programas usados recientemente que aceleran el sistema y están disponibles de inmediato si otra app los necesita.
* [ ] **D)** Es memoria que ha sido consumida por software espía y no puede ser recuperada.

---

### Pregunta 6 (10 puntos)
**¿Qué tipo de información traslada el Administrador de Memoria de Windows hacia el archivo `pagefile.sys`?**

* [ ] **A)** Archivos ejecutables `.exe` y librerías `.dll` inalterados.
* [ ] **B)** Exclusivamente páginas de memoria privada y modificada (anónima) creadas por procesos en ejecución que no tienen un archivo original en disco.
* [ ] **C)** Las fotos, videos y documentos personales de la carpeta del usuario.
* [ ] **D)** El código de inicio rápido de la BIOS/UEFI guardado en el motherboard.

---

### Pregunta 7 (10 puntos)
**¿A qué equivale el Límite de Compromiso (*Commit Limit*) que reporta Windows en el Administrador de Tareas?**

* [ ] **A)** Al tamaño de almacenamiento total disponible en la unidad `C:`.
* [ ] **B)** Al tamaño de la memoria caché de tercer nivel (L3) del procesador.
* [ ] **C)** A la cantidad de memoria consumida exclusivamente por los programas de 32 bits.
* [ ] **D)** A la suma de la memoria RAM física instalada más el tamaño actual del archivo de intercambio `pagefile.sys`.

---

### Pregunta 8 (10 puntos)
**¿Cuál es la regla operativa fundamental del Grupo No Paginado (*Non-Paged Pool*) del Kernel?**

* [ ] **A)** Reside de forma garantizada y permanente en la memoria RAM física; jamás puede ser trasladado al disco.
* [ ] **B)** Se comprime y se transfiere automáticamente a una memoria USB si la RAM se llena.
* [ ] **C)** Se vacía y resetea automáticamente cada 10 minutos para ahorrar batería.
* [ ] **D)** Es un área compartida accesible libremente por cualquier ejecutable en Modo Usuario (Ring 3).

---

### Pregunta 9 (10 puntos)
**¿Por qué las rutinas de atención de interrupciones del hardware (ISRs) deben residir obligatoriamente en memoria Non-Paged?**

* [ ] **A)** Porque los controladores de red y teclado no están escritos en código binario.
* [ ] **B)** Para evitar que la CPU sufra un fallo de página hacia el disco en medio de una interrupción crítica, lo que causaría un interbloqueo (*deadlock*) y colapso del sistema.
* [ ] **C)** Para aumentar la sensibilidad y aceleración del puntero del mouse.
* [ ] **D)** Para permitir que el Firewall de Windows filtre paquetes sin consumir ciclos de CPU.

---

### Pregunta 10 (10 puntos)
**Si en el Administrador de Tareas observás que el Grupo No Paginado creció hasta 6 GB en una PC de 8 GB de RAM causando lentitud extrema, ¿cuál es el diagnóstico técnico?**

* [ ] **A)** Hay un archivo de texto de Word demasiado grande abierto en el escritorio.
* [ ] **B)** Una fuga de memoria (*memory leak*) en un controlador de dispositivo (driver) en Modo Kernel (Ring 0) que reserva páginas y nunca las libera.
* [ ] **C)** El disco rígido fue formateado incorrectamente con el sistema FAT32.
* [ ] **D)** La resolución de la pantalla fue configurada en una escala superior al 100%.

---

## 🔑 Clave de Respuestas y Justificación Pedagógica (Uso del Docente)

1. **Pregunta 1: C** — En un *Soft Page Fault*, los datos ya están en RAM física; solo se requiere mapear la entrada en la tabla de páginas sin demoras de I/O.
2. **Pregunta 2: A** — En sistemas Windows x86/x64, las páginas virtuales y los marcos físicos de RAM son de 4 KB (4096 bytes).
3. **Pregunta 3: D** — Sin `pagefile.sys`, el SO no puede respaldar el *Commit Limit*, lo que causa cierres forzados de aplicaciones y bloquea la creación de volcados *Crash Dump*.
4. **Pregunta 4: A** — Un *Hard Fault* suspende el hilo para esperar la lectura de disco (milisegundos vs. nanosegundos de RAM).
5. **Pregunta 5: C** — La lista *Standby* almacena datos de caché reutilizables; tenerla llena es señal de máximo aprovechamiento de la RAM.
6. **Pregunta 6: B** — A `pagefile.sys` solo viaja memoria privada anónima modificada; el código `.exe` o `.dll` puro se descarta y se recarga desde su archivo original.
7. **Pregunta 7: D** — El Límite de Compromiso (*Commit Limit*) es la suma de la RAM física más el tamaño actual del archivo de intercambio.
8. **Pregunta 8: A** — El *Non-Paged Pool* reside siempre en RAM física y tiene prohibida la paginación a disco.
9. **Pregunta 9: B** — Si una ISR sufriera un fallo de página, la CPU entraría en interbloqueo irreversible esperando al controlador de disco.
10. **Pregunta 10: B** — Un desborde en el *Non-Paged Pool* indica una fuga (*leak*) en un driver del Kernel en Ring 0.
