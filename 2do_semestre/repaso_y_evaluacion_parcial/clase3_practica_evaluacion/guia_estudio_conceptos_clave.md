# Documento Guía de Estudio y Fundamentos Conceptuales
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional — Ciclo Lectivo 2026
### Eje Integrador: Almacenamiento, Seguridad NTFS y Gestión de Memoria

---

## 🎯 Propósito del Documento
Este documento sintetiza los conceptos teóricos y arquitectónicos esenciales abordados en los tres primeros módulos del semestre. Su lectura comprensiva proporciona los fundamentos técnicos y las justificaciones exactas necesarias para responder con solvencia las preguntas conceptuales de la **Parte 1** de la [Guía de Práctica y Evaluación Parcial (Clase 3)](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/repaso_y_evaluacion_parcial/clase3_practica_evaluacion/guia_practica_evaluacion.md).

---

## 1. Arquitectura de Almacenamiento y Esquemas de Particionado

### 1.1 El Límite de MBR (*Master Boot Record*)
El esquema **MBR**, concebido a principios de la década de 1980 para PC-DOS, almacena la tabla de particiones en los primeros 512 bytes del disco (sector 0 / LBA 0).
* **Limitación de Direccionamiento de 32 bits:** MBR utiliza campos de **32 bits** para registrar los números de sector lógicos (LBA). Dado que el tamaño estándar de sector es de 512 bytes:
  $$\text{Capacidad Máxima MBR} = 2^{32} \times 512 \text{ bytes} = 4.294.967.296 \times 512 \text{ bytes} \approx 2,19 \text{ TB (2 TiB)}$$
  Cualquier espacio por encima de los 2 TB en un disco inicializado con MBR queda inaccesible e inútil (*espacio no asignable*).
* **Límite de Particiones:** MBR solo admite un máximo de **4 particiones primarias** (o 3 primarias y 1 extendida que contenga unidades lógicas).
* **Sin Tolerancia a Fallos:** Posee un único sector de cabecera. Si el sector 0 sufre daño físico o corrupción lógica, toda la tabla de particiones se pierde.

### 1.2 La Solución Moderna: GPT (*GUID Partition Table*)
El estándar **GPT**, parte de la especificación UEFI moderna:
* **Direccionamiento de 64 bits:** Permite direccionar hasta $2^{64}$ sectores, habilitando volúmenes de hasta **9,4 Zettabytes (ZB)**. Por ello, **en cualquier disco de más de 2 TB es técnicamente obligatorio utilizar el esquema GPT**.
* **Particiones Ilimitadas:** Windows soporta nativamente hasta **128 particiones primarias** en GPT sin requerir particiones extendidas ni unidades lógicas.
* **Redundancia y Verificación:** Posee un encabezado primario al inicio del disco y un **encabezado secundario de respaldo (Backup GPT)** al final físico del disco. Además, calcula sumas de comprobación **CRC32** para validar la integridad de las tablas en cada arranque.

---

## 2. Seguridad Local, Permisos NTFS y Reglas de Precedencia

### 2.1 Identidades Digitales: SID y Tokens de Acceso
En los sistemas Windows NT, la seguridad no se basa en el nombre de usuario (que es solo una etiqueta visual para humanos), sino en identificadores criptográficos únicos:
* **SID (*Security Identifier*):** Es un identificador alfanumérico único generado por el Kernel/SAM (ejemplo: `S-1-5-21-...-1001`). Si un usuario cambia su nombre de cuenta, su SID permanece inalterable y conserva exactamente los mismos accesos.
* **Token de Acceso (*Access Token*):** Objeto generado durante el inicio de sesión exitoso por el subsistema LSASS. Contiene el SID del usuario, los SIDs de todos los grupos a los que pertenece y sus privilegios especiales (como apagar el equipo o cargar controladores).

### 2.2 Listas de Control de Acceso (DACL)
El sistema de archivos **NTFS** almacena en los metadatos de cada archivo y carpeta una lista de control de acceso discrecional (**DACL** - *Discretionary Access Control List*). Cada entrada dentro de esta lista se denomina **ACE** (*Access Control Entry*) y puede ser de dos tipos:
1. **ACE de Permitir (*Allow*):** Otorga un derecho específico (lectura, escritura, ejecución, control total).
2. **ACE de Denegar (*Deny*):** Prohíbe explícitamente una acción.

### 2.3 Regla Estricta de Precedencia en Windows
Cuando un usuario intenta acceder a un recurso, el subsistema **SRM (*Security Reference Monitor*)** analiza secuencialmente las ACEs en el siguiente orden jerárquico estricto:

$$\text{1. Denegar Explícito} \ > \ \text{2. Permitir Explícito} \ > \ \text{3. Denegar Heredado} \ > \ \text{4. Permitir Heredado}$$

* **Regla de Denegación Absoluta:** Si coincide un permiso de **Denegar (Deny)** explícito (aplicado directamente a la cuenta del usuario o a cualquiera de los grupos a los que pertenece), el SRM **bloquea el acceso de inmediato** y detiene la evaluación, sin importar cuántos grupos otorguen permisos de "Permitir (Allow)".

---

## 3. Arquitectura de Memoria en Windows: Física vs. Virtual

### 3.1 Memoria RAM Física (*Working Set*)
* **Memoria Física:** Son los módulos de hardware RAM instalados en la placa madre donde el procesador ejecuta código en tiempo real.
* **Working Set (Conjunto de Trabajo):** Es la cantidad exacta de memoria RAM física que un proceso tiene cargada y residente en un instante determinado. Cuando consultamos la propiedad `WorkingSet64` en PowerShell (o memoria en el Administrador de Tareas), estamos auditando las páginas de memoria que residen directamente en los chips de silicio.

### 3.2 Espacio de Direcciones Virtuales y Memoria Comprometida
* **VAS (*Virtual Address Space*):** Cada proceso en Windows de 64 bits cree tener para sí mismo un rango gigantesco y continuo de memoria privada (hasta 128 TB), aislado de los demás procesos.
* **Memoria Comprometida (*Commit Size* / *Paged Memory*):** Es el total de memoria virtual que un proceso ha reservado y que el sistema operativo ha garantizado respaldar, ya sea en la RAM física o en el archivo de intercambio secundario (**`pagefile.sys`**).
* **Tamaño de Página:** La Unidad de Administración de Memoria (**MMU**) del procesador y el Kernel gestionan la memoria en bloques discretos de **4 Kilobytes (4 KB)**.

---

## 4. Gestión de Paginación y Diagnóstico de Fallos de Página

### 4.1 ¿Qué es un Fallo de Página (*Page Fault*)?
Cuando un hilo de ejecución intenta acceder a una dirección de memoria virtual cuya página de 4 KB no se encuentra actualmente presente en la tabla de páginas del proceso en RAM física, la MMU interrumpe al procesador y genera una excepción llamada **Page Fault**.

Existen dos tipos de fallos de página:

| Tipo de Fallo | ¿Dónde está la página? | Impacto en Rendimiento |
| :--- | :--- | :--- |
| **Soft Page Fault** *(Fallo Suave)* | La página ya está en la memoria RAM, pero en otra lista (como la lista en espera/*Standby List*, compartida con otro proceso o pendiente de reasignación). | **Mínimo.** Se resuelve reasociando punteros de memoria en nanosegundos sin tocar el almacenamiento secundario. |
| **Hard Page Fault** *(Fallo Duro)* | La página **no está en la RAM física**. Fue enviada al disco de almacenamiento dentro de **`pagefile.sys`** o se encuentra en un archivo ejecutable en disco. | **Severo.** El hilo debe suspenderse mientras el subsistema de E/S lee la página desde el disco mecánico o SSD. |

### 4.2 El Fenómeno de Degradación: *Thrashing*
* **Latencia de Silicio vs. Latencia de Disco:** Acceder a la RAM física toma aproximadamente **50 a 100 nanosegundos**. Leer desde un disco secundario puede tomar desde decenas de microsegundos (en un SSD NVMe) hasta **10 milisegundos** (en un HDD mecánico), lo cual es entre **10.000 y 100.000 veces más lento**.
* **Tormenta de Fallos Duros y Cuello de Botella:** Cuando la memoria RAM se satura, el Kernel desaloja páginas constantemente a `pagefile.sys`. Si los procesos las vuelven a necesitar de inmediato, se produce una avalancha de *Hard Page Faults*. El procesador pasa la mayor parte de su tiempo esperando que el disco termine las operaciones de lectura/escritura en lugar de ejecutar instrucciones útiles, provocando que el uso de disco salte al 100% y el sistema se congele (*hiperpaginación* o *thrashing*).

---

## 📚 Compendio Integral y Extendido de Cátedra
Para profundizar en cada uno de estos temas con los laboratorios completos de Linux (`fdisk`, inodos, `/etc/fstab`), banderas detalladas de `icacls`, permisos POSIX, y arquitectura avanzada de pools de memoria, consultar el:
* 📖 **[Compendio Integral de Cátedra — Módulos 1, 2 y 3](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/compendio_completo_modulos_1_2_3.md)**
