# Trivia Kahoot: Clase 1 - Principios y Arquitectura de Almacenamiento en Linux (10 Preguntas - 4 Opciones)

---

## ❓ Pregunta 1
**¿Por qué Linux no utiliza letras de unidad (como `C:` o `D:`) para identificar discos o particiones como hace Windows?**
* A) Porque el firmware BIOS/UEFI no permite letras en sistemas operativos basados en UNIX. (Distractor - El firmware no tiene injerencia en las convenciones lógicas de nombres del sistema operativo).
* B) **Porque implementa un árbol de directorios unificado (`/`) donde cualquier partición debe montarse como una rama dentro de dicho árbol.** (Correcto - Linux abstrae todo el almacenamiento a través del Virtual File System en una única jerarquía que parte de la raíz `/`).
* C) Porque las letras de unidad están patentadas comercialmente por Microsoft y no pueden usarse en software libre. (Distractor - Es un mito; se trata de una diferencia fundamental de arquitectura UNIX vs CP/M-DOS).
* D) Porque los discos en Linux solo pueden contener una única partición por limitación del Kernel. (Distractor - Linux soporta múltiples particiones en esquemas MBR y GPT).

---

## ❓ Pregunta 2
**¿Qué comportamiento operativo distingue a un dispositivo de bloque (como un disco `/dev/sda`) de un flujo de caracteres (como el teclado o `/dev/tty`)?**
* A) Los dispositivos de bloque transmiten información únicamente en formato gráfico y los de caracteres solo en texto plano. (Distractor - Ambos tipos de dispositivos manejan bytes binarios a bajo nivel de abstracción).
* B) Los dispositivos de caracteres permiten almacenar sistemas de archivos complejos pero no admiten lectura secuencial. (Distractor - Los dispositivos de caracteres no pueden alojar sistemas de archivos porque no poseen direccionamiento de bloques).
* C) **Los dispositivos de bloque permiten leer o escribir sectores específicos en cualquier posición arbitraria (acceso aleatorio/directo).** (Correcto - Las unidades de disco permiten saltar a cualquier bloque o sector lógico LBA sin necesidad de recorrer secuencialmente los datos anteriores).
* D) Los dispositivos de bloque solo funcionan si están conectados a través de la red local. (Distractor - Discos SATA, NVMe, USB o dispositivos virtuales son locales).

---

## ❓ Pregunta 3
**Si conectamos un disco rígido moderno de 4 TB e intentamos particionarlo utilizando el esquema tradicional MBR, ¿qué sucederá en el sistema operativo?**
* A) El disco funcionará con normalidad porque el Kernel de Linux amplía el MBR a 64 bits de forma automática. (Distractor - El estándar MBR es fijo y ninguna capa de software puede ampliar sus campos de 32 bits).
* B) El disco se bloqueará por hardware y la placa madre emitirá una señal sonora de cortocircuito. (Distractor - No se produce ningún fallo físico o de hardware; es una limitación meramente lógica de direccionamiento).
* C) **El sistema operativo solo podrá reconocer y particionar hasta 2 TB, quedando el resto de la capacidad completamente inaccesible.** (Correcto - Debido a que la tabla MBR utiliza registros de 32 bits para contabilizar sectores de 512 bytes, el límite máximo direccionable es de aproximadamente 2.19 TB).
* D) El disco se formateará automáticamente en formato FAT16 para reducir el tamaño de los archivos. (Distractor - El formato y el particionado son etapas independientes; el esquema de partición no formatea el medio automáticamente).

---

## ❓ Pregunta 4
**¿Por qué en el esquema MBR clásico solo es posible definir un máximo de 4 particiones primarias en el sector de arranque?**
* A) Porque el procesador solo puede gestionar 4 interrupciones de hardware dedicadas al controlador de disco. (Distractor - Las interrupciones IRQ no limitan la cantidad de particiones lógicas).
* B) **Porque la tabla de particiones dentro del MBR dispone únicamente de 64 bytes, y cada descriptor de partición ocupa 16 bytes ($64 / 16 = 4$).** (Correcto - El sector 0 de 512 bytes asigna 446 bytes al cargador de arranque, 64 bytes a la tabla [4 entradas de 16 bytes] y 2 bytes a la firma mágica `0x55AA`).
* C) Porque el estándar POSIX prohíbe tener más de cuatro dispositivos de bloque por disco físico. (Distractor - POSIX no establece límites sobre la cantidad de particiones primarias en hardware).
* D) Porque la memoria caché del disco rígido solo puede almacenar 4 descriptores de arranque en su ROM. (Distractor - Los descriptores se leen del medio magnético/flash, no de la ROM del disco).

---

## ❓ Pregunta 5
**¿Qué ventaja de redundancia y tolerancia a fallos estructurales ofrece GPT frente a MBR ante daños físicos o corrupción de sectores?**
* A) Realiza una copia de seguridad en tiempo real de todos los archivos del usuario en la partición swap. (Distractor - La partición swap se utiliza para paginación de memoria virtual, no para respaldar metadatos).
* B) Duplica automáticamente la tabla de particiones en la nube mediante un servicio del Kernel. (Distractor - El particionado es una estructura local sin dependencia de red).
* C) **Mantiene una cabecera de respaldo (*Backup GPT*) al final físico del disco y valida la integridad de sus datos mediante sumas CRC32.** (Correcto - GPT almacena la tabla primaria en LBA 1 y una réplica idéntica en los últimos sectores del disco, con checksums CRC32 para detectar inconsistencias).
* D) Utiliza compresión con pérdida para que la tabla quepa en los registros internos del microprocesador. (Distractor - Las tablas de partición no usan compresión con pérdida ni residen permanentemente en los registros del CPU).

---

## ❓ Pregunta 6
**A diferencia de MBR que identifica particiones con simples números correlativos, ¿por qué el esquema GPT asigna un UUID/GUID único a cada partición y disco?**
* A) Para obligar al usuario a escribir una contraseña criptográfica de 32 caracteres cada vez que inicia sesión. (Distractor - El UUID es un metadato de identificación de hardware, no una clave de autenticación de usuario).
* B) **Para permitir que el sistema operativo identifique y monte la partición correcta sin importar si cambia el puerto USB, cable SATA o el orden de detección.** (Correcto - El UUID garantiza que `/dev/disk/by-uuid/` apunte siempre al volumen exacto aunque cambie su designación de nodo como `sda1` a `sdb1`).
* C) Para limitar el uso del disco a una única computadora registrada mediante la dirección MAC de la placa de red. (Distractor - Los identificadores de partición GPT son portables entre cualquier equipo compatible con UEFI/GPT).
* D) Para comprimir los datos del disco mediante un algoritmo hash irreversible. (Distractor - Un identificador unívoco no comprime ni altera los datos de los archivos).

---

## ❓ Pregunta 7
**En el esquema MBR clásico, ¿qué recurso arquitectónico se ideó para superar la limitación histórica de tener únicamente hasta 4 particiones primarias?**
* A) Fusionar dos discos rígidos físicos mediante un cable puente IDE/SATA. (Distractor - Es una limitación lógica de la tabla de particiones del disco, no de la interconexión de buses).
* B) Crear una memoria caché en la memoria RAM que simula particiones fantasma no persistentes. (Distractor - Las particiones deben ser persistentes en el medio de almacenamiento).
* C) **Definir una partición extendida que funciona como un contenedor especial dentro del cual se alojan múltiples particiones lógicas.** (Correcto - MBR permite definir hasta 3 particiones primarias y 1 extendida, y dentro de la extendida encadenar particiones lógicas adicionales como `sda5`, `sda6`, etc.).
* D) Reemplazar el sector MBR por un archivo ejecutable `.bat` en el directorio raíz. (Distractor - El MBR reside en el sector físico 0 y es leído por el firmware antes de que exista cualquier sistema de archivos).

---

## ❓ Pregunta 8
**En la arquitectura del almacenamiento en Linux, ¿qué es conceptualmente un dispositivo Loopback (`/dev/loopX`)?**
* A) Un cable físico especial que conecta dos puertos SATA entre sí para duplicar la velocidad de transferencia. (Distractor - Loopback de almacenamiento es una abstracción 100% de software en el Kernel).
* B) Una partición volátil en memoria RAM idéntica a un sistema de archivos `tmpfs`. (Distractor - Un dispositivo de bloque en RAM es `ramdisk` o `zram`, no loopback).
* C) **Un mecanismo del Kernel que permite tratar un archivo binario regular como si fuera un dispositivo de bloque físico real.** (Correcto - Permite asociar una imagen `.img` o `.iso` a `/dev/loopX` para particionarla, formatearla y montarla como un disco físico).
* D) Un protocolo de red que redirige las peticiones de disco a través de la interfaz de red local `127.0.0.1`. (Distractor - Confunde el almacenamiento loopback con la interfaz de red de retorno).

---

## ❓ Pregunta 9
**¿Cuál es la función primordial de configurar una partición de tipo *Linux Swap* (espacio de intercambio) en un sistema de almacenamiento?**
* A) Aumentar la velocidad de rotación física del disco duro cuando se ejecutan programas pesados. (Distractor - La velocidad mecánica de los discos magnéticos es fija e independiente del software).
* B) Servir como directorio de cuarentena donde el antivirus del sistema aísla archivos sospechosos. (Distractor - Swap no es un sistema de archivos accesible por el usuario ni funciona como cuarentena).
* C) Reemplazar por completo a la memoria RAM para abaratar los costos de hardware del equipo. (Distractor - El almacenamiento secundario es órdenes de magnitud más lento que la RAM; Swap es un complemento de apoyo).
* D) **Proveer almacenamiento secundario para que el Kernel pueda descargar páginas de memoria inactivas y liberar RAM física o permitir hibernación.** (Correcto - Facilita el subsistema de memoria virtual paginando hacia el disco los bloques anónimos con menor demanda de uso).

---

## ❓ Pregunta 10
**¿Cómo administra el Kernel de Linux la detección de particiones en un disco y su exposición al espacio de usuario?**
* A) Lee el archivo de texto `/etc/fstab` al arrancar y no reconoce ningún dispositivo que no esté listado allí. (Distractor - `/etc/fstab` contiene directivas de montaje del usuario, pero el Kernel detecta el hardware independientemente).
* B) **Analiza la tabla de particiones del disco, crea las estructuras de datos de bloque correspondientes y las expone en `/proc/partitions` y `/sys/block/`.** (Correcto - El subsistema de bloques del Kernel analiza la tabla física y publica la topología dinámicamente en los pseudo-sistemas de archivos del sistema).
* C) Obliga al usuario a reiniciar el equipo cada vez que se crea o modifica una partición para poder detectarla. (Distractor - Comandos como `partx` o el soporte del Kernel actualizan la tabla en memoria sin reiniciar el sistema).
* D) Delega la detección en el servidor gráfico X11, por lo que una terminal en modo texto no reconoce particiones. (Distractor - La gestión de almacenamiento ocurre estrictamente en el espacio de Kernel, muy por debajo de cualquier entorno gráfico).

---
