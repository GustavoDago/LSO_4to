# Cuestionario Gamificado Kahoot: Clase 1 de Repaso
## Módulo 1 (Almacenamiento) y Módulo 2 (Seguridad y Permisos) en Windows 11
### Laboratorio de Sistemas Operativos — 4.º Año

---

### Pregunta 1
* **Pregunta:** ¿Cuál es el límite máximo de almacenamiento soportado por el esquema de particiones MBR?
* **Opciones:**
  * A) 512 Gigabytes.
  * B) 2 Terabytes. *(Correcta)*
  * C) 128 Terabytes.
  * D) 9.4 Zettabytes.
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* MBR utiliza direcciones de bloque lógico (LBA) de 32 bits con sectores estándar de 512 bytes, lo que limita matemáticamente el disco a 2^32 * 512 bytes = 2.19 TB (2 TB prácticos).
  * *Opción A (Distractor):* 512 bytes es el tamaño del sector físico clásico, no la capacidad total del esquema.
  * *Opción C (Distractor):* 128 es el límite de particiones primarias en Windows bajo GPT, no un tamaño de almacenamiento.
  * *Opción D (Distractor):* 9.4 Zettabytes (ZB) es el límite teórico máximo del estándar GPT moderno.

---

### Pregunta 2
* **Pregunta:** ¿Qué mecanismo de redundancia implementa la tabla GPT para protegerse ante corrupción de datos?
* **Opciones:**
  * A) Doble encabezado con copia de respaldo al final del disco (Secondary GPT). *(Correcta)*
  * B) Almacenamiento de copias de seguridad de particiones en la base SAM.
  * C) Duplicación automática de los archivos del usuario en el archivo $LogFile.
  * D) Cifrado de sectores mediante sumas de verificación en el sector 0 (MBR).
* **Respuesta Correcta:** A
* **Fundamentación Técnica:**
  * *Opción A (Correcta):* GPT escribe un encabezado primario (Primary GPT) al inicio del disco y una copia de respaldo completa (Secondary GPT) en los últimos sectores, respaldados por sumas de verificación CRC32.
  * *Opción B (Distractor):* La base SAM almacena identidades y credenciales de usuario locales, no estructuras de particionado.
  * *Opción C (Distractor):* `$LogFile` es el registro transaccional de NTFS para journaling, no una copia de particiones GPT.
  * *Opción D (Distractor):* MBR reside en el sector 0 y carece de cualquier mecanismo de respaldo y de sumas de verificación.

---

### Pregunta 3
* **Pregunta:** En Diskpart, ¿qué comando conecta y monta un disco virtual VHDX en el subsistema del Kernel?
* **Opciones:**
  * A) detach vdisk
  * B) create vdisk
  * C) attach vdisk *(Correcta)*
  * D) convert gpt
* **Respuesta Correcta:** C
* **Fundamentación Técnica:**
  * *Opción C (Correcta):* Tras seleccionar el archivo con `select vdisk`, el comando `attach vdisk` conecta el contenedor al Administrador de Discos del Kernel para que sea reconocido como una unidad física.
  * *Opción A (Distractor):* `detach vdisk` realiza la operación inversa: desconecta y desmonta el disco virtual de manera segura.
  * *Opción B (Distractor):* `create vdisk` genera el archivo contenedor en el disco host pero no lo monta.
  * *Opción D (Distractor):* `convert gpt` inicializa la tabla de particiones del disco una vez que ya fue conectado.

---

### Pregunta 4
* **Pregunta:** ¿Cuál es la principal ventaja de un disco virtual dinámico (expandable) frente a uno fijo?
* **Opciones:**
  * A) Reserva la totalidad del espacio físico declarado desde el primer segundo.
  * B) Permite saltarse la elevación de privilegios del Control de Cuentas (UAC).
  * C) No requiere inicializarse con particiones ni formatearse con NTFS.
  * D) Inicia pesando pocos MB y crece en el disco físico al escribir datos. *(Correcta)*
* **Respuesta Correcta:** D
* **Fundamentación Técnica:**
  * *Opción D (Correcta):* Un VHD/VHDX dinámico (*expandable*) comienza con un archivo contenedor diminuto y consume espacio real en el host únicamente a medida que se escriben datos, ideal para entornos educativos.
  * *Opción A (Distractor):* Reservar la totalidad del espacio físico desde el inicio es la propiedad del disco de asignación fija (*Fixed*).
  * *Opción B (Distractor):* UAC regula la elevación de privilegios de procesos de seguridad, no la arquitectura del archivo contenedor.
  * *Opción C (Distractor):* Todo disco virtual, sea fijo o dinámico, requiere particionamiento y formateo con un sistema de archivos.

---

### Pregunta 5
* **Pregunta:** ¿Qué estructura de NTFS almacena un registro de 1024 bytes con los atributos de cada archivo?
* **Opciones:**
  * A) MFT (Master File Table). *(Correcta)*
  * B) Registro transaccional de diario ($LogFile).
  * C) Base de datos SAM (Security Accounts Manager).
  * D) Encabezado secundario de respaldo GPT.
* **Respuesta Correcta:** A
* **Fundamentación Técnica:**
  * *Opción A (Correcta):* La MFT es la base de datos relacional indexada de NTFS; cada archivo o carpeta del volumen posee al menos un registro de 1024 bytes donde se describen sus atributos, marcas de tiempo y punteros a clusters.
  * *Opción B (Distractor):* `$LogFile` almacena el registro transaccional de operaciones para recuperación ante fallos (journaling).
  * *Opción C (Distractor):* La SAM almacena hashes de contraseñas e identidades de cuentas locales de Windows.
  * *Opción D (Distractor):* El encabezado secundario GPT reside al final del disco para recuperar particiones ante daño del sector inicial.

---

### Pregunta 6
* **Pregunta:** ¿Por qué NTFS es superior a FAT32 para almacenamiento corporativo ante cortes de energía?
* **Opciones:**
  * A) NTFS almacena copias de seguridad de los archivos en la memoria RAM.
  * B) Posee journaling transaccional ($LogFile) y no tiene el límite de 4 GB. *(Correcta)*
  * C) FAT32 no permite crear particiones primarias en discos virtuales VHDX.
  * D) FAT32 exige obligatoriamente esquemas de partición GPT con sumas CRC32.
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* NTFS implementa *journaling* mediante `$LogFile` para registrar transacciones y evitar la corrupción de metadatos ante apagones inesperados, además de soportar archivos mayores a 4 GB y permisos DACL (a diferencia de FAT32 que no tiene seguridad y tiene el límite de 4 GB).
  * *Opción A (Distractor):* La RAM es almacenamiento volátil y se borra al apagarse el equipo; NTFS guarda su registro transaccional en almacenamiento secundario.
  * *Opción C (Distractor):* FAT32 sí puede formatearse en particiones dentro de discos virtuales.
  * *Opción D (Distractor):* FAT32 se utilizó históricamente sobre MBR y no exige tablas GPT ni sumas CRC32.

---

### Pregunta 7
* **Pregunta:** ¿Dónde almacena Windows 11 las credenciales locales y qué comando audita el SID en sesión?
* **Opciones:**
  * A) Registro MFT del volumen y el comando icacls /inheritance:d.
  * B) Archivo $LogFile de NTFS y el comando diskpart list.
  * C) Base SAM (System32\config\SAM) y el comando whoami /all. *(Correcta)*
  * D) Encabezado Secondary GPT y el comando format fs=ntfs.
* **Respuesta Correcta:** C
* **Fundamentación Técnica:**
  * *Opción C (Correcta):* La base de datos SAM (`System32\config\SAM`) almacena los hashes de contraseñas y cuentas locales, mientras que `whoami /all` devuelve en consola el SID del usuario, grupos y privilegios activos.
  * *Opción A (Distractor):* La MFT almacena metadatos de archivos e `icacls` administra listas de control de acceso DACL.
  * *Opción B (Distractor):* `$LogFile` es el diario transaccional de NTFS y `diskpart` gestiona almacenamiento a bajo nivel.
  * *Opción D (Distractor):* GPT gestiona particiones del disco y `format` aplica el sistema de archivos al volumen.

---

### Pregunta 8
* **Pregunta:** En Windows 11, ¿qué tipo de token otorga UAC a un administrador al iniciar su sesión habitual?
* **Opciones:**
  * A) Token Filtrado (permisos estándar), requiriendo elevación para el Kernel. *(Correcta)*
  * B) Token Elevado permanente con control total irrestricto sobre el Kernel.
  * C) Token de Invitado que desactiva automáticamente la lectura en la MFT.
  * D) Token de Auditoría SACL que solo permite ejecutar el comando diskpart.
* **Respuesta Correcta:** A
* **Fundamentación Técnica:**
  * *Opción A (Correcta):* Por diseño de UAC (Control de Cuentas de Usuario), un administrador inicia con un **Token Filtrado** que tiene privilegios de usuario estándar. Solo cuando una acción requiere privilegios administrativos (como ejecutar `diskpart` o modificar el registro), el UAC solicita confirmación para activar el **Token Elevado**.
  * *Opción B (Distractor):* El token elevado no se otorga por defecto de forma permanente para proteger al Kernel de ejecuciones maliciosas o accidentales.
  * *Opción C (Distractor):* El token filtrado no corresponde a una cuenta de invitado y permite la operatoria de usuario regular.
  * *Opción D (Distractor):* La SACL define reglas de auditoría de eventos en NTFS, no es un tipo de credencial o token de usuario.

---

### Pregunta 9
* **Pregunta:** En icacls, ¿qué conmutador rompe la herencia copiando los permisos como reglas explícitas?
* **Opciones:**
  * A) /inheritance:r
  * B) /inheritance:d *(Correcta)*
  * C) /grant:r
  * D) /deny
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* `/inheritance:d` desvincula el objeto de su contenedor padre copiando los permisos que tenía como permisos explícitos editables sin borrar accesos previos.
  * *Opción A (Distractor):* `/inheritance:r` rompe la herencia eliminando todas las reglas heredadas, dejando la lista DACL completamente vacía.
  * *Opción C (Distractor):* `/grant:r` asigna permisos reemplazando reglas previas sobre un usuario o grupo específico.
  * *Opción D (Distractor):* `/deny` añade una regla de bloqueo explícito a la DACL.

---

### Pregunta 10
* **Pregunta:** Si un usuario tiene Control Total (Allow) por su grupo, pero Deny explícito de Escritura, ¿qué ocurre?
* **Opciones:**
  * A) Prevalece el Allow del grupo porque los grupos tienen mayor jerarquía.
  * B) Prevalece el Deny explícito y Windows le bloquea la escritura. *(Correcta)*
  * C) El sistema operativo solicita elevación UAC para autorizar el acceso.
  * D) Las reglas se cancelan entre sí y el archivo se marca como corrupto.
* **Respuesta Correcta:** B
* **Fundamentación Técnica:**
  * *Opción B (Correcta):* En la matriz de precedencia de Windows, la Denegación Explícita ocupa el nivel 1 de máxima prioridad. Por lo tanto, un Deny explícito anula automáticamente cualquier permiso Allow concedido por pertenencia a grupos.
  * *Opción A (Distractor):* Las reglas de grupo o heredadas tienen menor prioridad que una regla explícita asignada directamente al objeto, y Deny siempre supera a Allow.
  * *Opción C (Distractor):* UAC eleva privilegios de token de proceso en el Kernel, no anula las denegaciones NTFS de la DACL.
  * *Opción D (Distractor):* Las reglas de seguridad no corrompen ni eliminan archivos; simplemente devuelven el error "Acceso denegado".
