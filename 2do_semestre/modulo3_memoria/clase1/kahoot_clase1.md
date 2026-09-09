# Cuestionario Gamificado Kahoot: Arquitectura de Memoria y Aislamiento en Windows 11
## Módulo 3 — Clase 1: Jerarquía, MMU y Espacio de Direcciones Virtuales
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año

---

### 📋 Estructura y Reglas Pedagógicas
* **Total de Preguntas:** 10
* **Opciones por Pregunta:** 4 (1 Opción Correcta y 3 Distractores Técnicos Fundamentados)
* **Límites de Caracteres Kahoot:** Pregunta ≤ 120 caracteres | Cada respuesta ≤ 75 caracteres
* **Plantilla Excel:** Sincronizado con [`kahoot_clase1.xlsx`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo3_memoria/clase1/kahoot_clase1.xlsx) (listo para importar a Kahoot).
* **Objetivo Didáctico:** Fijar los conceptos de bajo nivel sobre la jerarquía de memorias, traducción acelerada por la MMU, espacio de direcciones virtuales (VAS), aislamiento de procesos y anillos de privilegio (Ring 3 vs Ring 0).

---

### ❓ Pregunta 1
**¿Cuál es la función principal de la Unidad de Manejo de Memoria (MMU) integrada en el microprocesador?**

* **A)** Aumentar la velocidad del cooler si la RAM se calienta.
* **B)** Traducir direcciones virtuales a direcciones físicas de RAM en tiempo real. ✔️ *(Opción Correcta)*
* **C)** Desfragmentar discos mecánicos en segundo plano.
* **D)** Generar claves de cifrado BitLocker del disco del sistema.

> **Fundamentación Pedagógica:**
> * **Opción B (Correcta):** La MMU es el componente de hardware del CPU encargado de la traducción acelerada de direcciones lógicas/virtuales a direcciones físicas reales en la memoria DRAM.
> * *Distractor A:* El control de ventiladores lo gestiona el controlador embebido (EC) de la placa madre y la telemetría térmica, no la MMU.
> * *Distractor C:* La desfragmentación de disco es una tarea de software del sistema de archivos, no una función de hardware de la CPU.
> * *Distractor D:* El cifrado BitLocker depende del chip TPM (Trusted Platform Module) y de algoritmos criptográficos, no de la MMU.

---

### ❓ Pregunta 2
**¿Cuál componente de la jerarquía de memoria tiene el menor tiempo de acceso (menor latencia)?**

* **A)** Memoria RAM DDR4 o DDR5.
* **B)** Unidad de estado sólido SSD NVMe.
* **C)** Memoria Caché de tercer nivel (L3).
* **D)** Registros internos del procesador (CPU). ✔️ *(Opción Correcta)*

> **Fundamentación Pedagógica:**
> * **Opción D (Correcta):** Los registros del CPU operan a la misma frecuencia interna del núcleo del procesador con tiempos de acceso inferiores a 1 nanosegundo (< 1 ns).
> * *Distractor A:* La memoria RAM física tiene una latencia de entre 50 y 100 nanosegundos, cientos de veces más lenta que los registros.
> * *Distractor B:* Un SSD NVMe opera en el orden de los microsegundos (milisegundos a escala macro), miles de veces más lento que la memoria interna del silicio.
> * *Distractor C:* La caché L3 es sumamente veloz (10 a 20 ns), pero se sitúa por debajo de los registros de CPU y de las cachés L1/L2 en velocidad.

---

### ❓ Pregunta 3
**Si dos programas usan la misma dirección virtual 0x00400000, ¿por qué no colisionan sus datos?**

* **A)** Tienen VAS privado y la MMU asigna marcos de RAM física distintos. ✔️ *(Opción Correcta)*
* **B)** Windows solo permite un programa abierto en RAM a la vez.
* **C)** El CPU mezcla los datos y los separa por contraseñas.
* **D)** Un programa va al disco rígido y el otro a la caché L1.

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** La memoria virtual desacopla la memoria lógica de la física; la MMU traduce la misma dirección lógica a marcos físicos completamente aislados en la memoria RAM.
> * *Distractor B:* Windows es un sistema operativo multiproceso apropiativo; decenas de procesos residen de forma simultánea en la RAM.
> * *Distractor C:* El aislamiento de procesos se basa en hardware (MMU y tablas de páginas del Kernel), no en contraseñas de software ni encriptación de datos.
> * *Distractor D:* El sistema operativo no divide aplicaciones enteras fijándolas rígidamente a disco o caché; ambas residen en RAM física según sus hilos activos.

---

### ❓ Pregunta 4
**¿Cuál es el límite máximo de memoria que puede direccionar un proceso de 32 bits en su VAS?**

* **A)** 640 Kilobytes.
* **B)** 128 Terabytes.
* **C)** 4 Gigabytes (2^32 bytes). ✔️ *(Opción Correcta)*
* **D)** No tiene límite, depende de la RAM física instalada.

> **Fundamentación Pedagógica:**
> * **Opción C (Correcta):** Con un puntero de 32 bits existen $2^{32}$ combinaciones posibles, lo que arroja un límite matemático estricto de 4.294.967.296 bytes (exactamente 4 GB).
> * *Distractor A:* 640 KB era el límite convencional de la memoria base de las computadoras IBM PC con MS-DOS en la década de 1980.
> * *Distractor B:* 128 TB es el límite del espacio virtual asignado a procesos en arquitecturas de 64 bits en Windows 11.
> * *Distractor D:* Por más memoria física que tenga la computadora, la arquitectura matemática de un ejecutable de 32 bits no puede superar los 4 GB de direccionamiento lógico.

---

### ❓ Pregunta 5
**En Windows 11 (64 bits), ¿cuánto espacio de memoria virtual privada tiene cada proceso de usuario?**

* **A)** 2 Gigabytes.
* **B)** 128 Terabytes. ✔️ *(Opción Correcta)*
* **C)** 16 Megabytes.
* **D)** Exactamente la cantidad de RAM física instalada.

> **Fundamentación Pedagógica:**
> * **Opción B (Correcta):** En Windows x64 moderno, la arquitectura asigna un rango virtual masivo de 128 TB para el espacio de usuario (*User Mode*) y otros 128 TB para el espacio del Kernel.
> * *Distractor A:* 2 GB era el espacio reservado para modo usuario en la arquitectura heredada de Windows de 32 bits.
> * *Distractor C:* 16 MB era el límite de direccionamiento físico de las computadoras con procesadores Intel 80286 en la década de 1980.
> * *Distractor D:* El espacio virtual no depende de la cantidad física de RAM; la memoria virtual es un espacio lógico provisto por el sistema operativo y la CPU.

---

### ❓ Pregunta 6
**¿En qué nivel de privilegio del CPU se ejecutan las aplicaciones de usuario como Chrome o Word?**

* **A)** Ring 0 (Modo Núcleo / Kernel Mode).
* **B)** Ring -1 (Modo BIOS).
* **C)** Ring 7 (Modo Gráfico).
* **D)** Ring 3 (Modo Usuario / User Mode). ✔️ *(Opción Correcta)*

> **Fundamentación Pedagógica:**
> * **Opción D (Correcta):** Las aplicaciones de usuario corren en Ring 3 (el nivel con privilegios más bajos), lo que les impide acceder directamente al hardware o a la memoria del sistema.
> * *Distractor A:* Ring 0 es el nivel de máxima autoridad reservado exclusivamente para el núcleo del sistema operativo (`ntoskrnl.exe`) y los controladores de dispositivos.
> * *Distractor B:* Aunque modernamente existen capas de hipervisor (Ring -1), no es donde corren las aplicaciones de usuario estándar.
> * *Distractor C:* La arquitectura de protección x86 implementa únicamente cuatro anillos (del Ring 0 al Ring 3); no existe un "Ring 7".

---

### ❓ Pregunta 7
**¿Qué ocurre si un programa en Ring 3 intenta escribir en una dirección del Kernel (Ring 0)?**

* **A)** El CPU dispara una Violación de Acceso y Windows cierra el proceso. ✔️ *(Opción Correcta)*
* **B)** Windows se congela y formatea el disco rígido.
* **C)** Se permite si el usuario tiene sesión de Administrador.
* **D)** La memoria RAM duplica su voltaje automáticamente.

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** El hardware del microprocesador verifica los bits de privilegio en cada acceso a memoria. Si un hilo en Ring 3 apunta a memoria de Ring 0, la CPU lanza una excepción por falla de protección y el Kernel cierra el proceso para mantener la estabilidad del equipo.
> * *Distractor B:* El mecanismo de protección de memoria existe precisamente para evitar daños al sistema operativo y al disco cuando un programa falla.
> * *Distractor C:* La seguridad de los anillos del procesador es a nivel de instrucciones de hardware; ningún privilegio de cuenta de usuario en Windows permite violar Ring 3 sin una llamada al sistema (*syscall*) controlada.
> * *Distractor D:* El voltaje de la memoria RAM es regulado electrónicamente por la placa madre (VRMs) y no varía por excepciones de software.

---

### ❓ Pregunta 8
**¿Por qué las PCs no usan solo Caché L1 si es miles de veces más rápida que la RAM?**

* **A)** Porque la memoria caché es incompatible con Windows 11.
* **B)** Porque la caché solo almacena letras, no binarios.
* **C)** Los chips SRAM son muy costosos de fabricar y disipan mucho calor. ✔️ *(Opción Correcta)*
* **D)** Porque el bus al disco no soporta más de 128 MB.

> **Fundamentación Pedagógica:**
> * **Opción C (Correcta):** La memoria caché utiliza celdas SRAM integradas directamente en el silicio de la CPU. Su costo por bit es altísimo y su consumo térmico elevado, por lo que se reserva para pequeñas capacidades (KB/MB).
> * *Distractor A:* Todos los sistemas operativos modernos utilizan intensivamente la memoria caché del procesador de forma nativa y transparente.
> * *Distractor B:* Toda la información digital en la memoria caché se compone estrictamente de bits binarios (ceros y unos), sin distinción de tipo de dato.
> * *Distractor D:* La memoria caché reside físicamente dentro del propio encapsulado del procesador, no se conecta por cables al disco.

---

### ❓ Pregunta 9
**En el Administrador de Tareas, ¿dónde se ve si un proceso es de 32 bits o de 64 bits?**

* **A)** En Historial de aplicaciones, ordenando por consumo de red.
* **B)** En la pestaña Detalles, habilitando la columna Plataforma. ✔️ *(Opción Correcta)*
* **C)** En la pestaña Inicio, clic derecho en el antivirus.
* **D)** En el panel de configuración de pantalla de Windows.

> **Fundamentación Pedagógica:**
> * **Opción B (Correcta):** En la pestaña "Detalles" del Administrador de Tareas, el usuario puede personalizar las columnas activando "Plataforma", donde Windows indica explícitamente "32 bits" o "64 bits" para cada ejecutable.
> * *Distractor A:* El "Historial de aplicaciones" registra el uso de recursos acumulado a lo largo del tiempo de apps UWP/Store, no su plataforma de compilación de bajo nivel.
> * *Distractor C:* La pestaña "Inicio" gestiona los programas que arrancan automáticamente con el sistema y su impacto en el inicio, sin detallar la arquitectura del proceso.
> * *Distractor D:* La configuración de pantalla gestiona resoluciones, tasas de refresco y perfiles de color, sin vinculación con el monitoreo de procesos.

---

### ❓ Pregunta 10
**¿Cuál era el gran defecto del direccionamiento de Memoria Real en sistemas como MS-DOS?**

* **A)** Los programas tardaban días en encender el monitor.
* **B)** No se podían usar teclados ni ratones.
* **C)** Windows borraba archivos si se abrían dos ventanas.
* **D)** Un error de puntero podía sobrescribir el Kernel por falta de protección. ✔️ *(Opción Correcta)*

> **Fundamentación Pedagógica:**
> * **Opción D (Correcta):** En la memoria real no existía aislamiento ni anillos de protección; los programas compartían el mismo espacio físico contiguo, por lo que un error de programación en una aplicación corrompía la memoria del Kernel o de otros programas.
> * *Distractor A:* Los tiempos de inicio en sistemas de modo real eran casi instantáneos debido a la ausencia de controladores complejos y servicios de fondo.
> * *Distractor B:* Los periféricos de entrada como teclados y ratones operaban perfectamente mediante interrupciones de hardware (IRQ / BIOS INT 10h/16h).
> * *Distractor C:* MS-DOS ni siquiera soportaba ventanas nativas multiproceso concurrentes; ejecutaba un programa por vez de forma secuencial.
