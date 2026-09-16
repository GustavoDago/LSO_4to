# Ficha Pedagógica de Repaso: Almacenamiento y Seguridad NTFS en Windows 11
## Cuaderno Digital NotebookLM: "LSO 4to - 2do semestre"
### Laboratorio de Sistemas Operativos — Tecnicatura en Informática Personal y Profesional

---

## 🎧 Introducción para el Generador de Audio / Podcast de NotebookLM
En esta sesión de repaso intensivo pre-evaluación consolidamos dos pilares críticos del Administrador de Sistemas en Windows 11:
1. **Cómo organiza el Kernel el almacenamiento secundario:** Desde el esquema de particionado físico y virtual hasta los sistemas de archivos transaccionales.
2. **Cómo protege el Sistema Operativo los datos:** Identidades digitales únicas (SIDs), base de datos SAM y la ingeniería detrás de las Listas de Control de Acceso (DACL) con herencia y precedencia estricta.

---

## 1. Arquitectura de Almacenamiento: MBR vs. GPT

| Característica | MBR (*Master Boot Record*) | GPT (*GUID Partition Table*) |
| :--- | :--- | :--- |
| **Año de Introducción** | 1983 (IBM PC DOS 2.0) | Finales de los 90 (Estándar UEFI) |
| **Capacidad Máxima de Disco** | **2 Terabytes (2 TB)** (sectores de 512 bytes) | **9.4 Zettabytes (ZB)** |
| **Límite de Particiones Primarias** | **4 particiones primarias** (o 3 primarias + 1 extendida) | **128 particiones primarias** en Windows |
| **Mecanismo de Respaldo / Redundancia** | **Ninguno.** Si el sector 0 se corrompe, la tabla es irrecuperable. | **Doble encabezado:** Primary GPT (inicio del disco) y Secondary GPT (final del disco). |
| **Verificación de Integridad** | No posee sumas de verificación nativas. | Sumas **CRC32** que detectan corrupción de datos en la tabla. |
| **Compatibilidad con Windows 11** | No compatible para booteo oficial (exige UEFI/GPT). | Obligatorio para instalación y arranque en Windows 11. |

---

## 2. Discos Virtuales en Windows: VHD y VHDX

Un disco virtual es una abstracción de software que encapsula un disco rígido completo dentro de un único archivo en el sistema de archivos host.

* **Tipos de Asignación de Espacio:**
  * **Fijo (*Fixed*):** Reserva en el almacenamiento físico la totalidad del espacio declarado desde el primer segundo. Ofrece mayor velocidad pero desperdicia espacio no utilizado.
  * **Dinámico / Expandible (*Dynamically Expanding*):** El archivo contenedor inicia pesando unos pocos Megabytes y crece en el disco real a medida que el usuario escribe información en él. Es la opción predilecta en entornos educativos y de laboratorio.
* **Comandos Clave en `diskpart`:**
  * `create vdisk file="C:\ruta\disco.vhdx" maximum=1024 type=expandable`: Genera el archivo contenedor.
  * `attach vdisk`: Conecta el disco virtual al Administrador de Discos del Kernel.
  * `detach vdisk`: Desconecta y desmonta el disco virtual de manera segura.

---

## 3. Sistemas de Archivos: ¿Por qué NTFS es el Estándar Empresarial?

* **FAT32:**
  * Limitación severa: **No admite archivos individuales mayores a 4 Gigabytes (4 GB)**.
  * Cero soporte para permisos de usuario locales o auditoría.
* **NTFS (New Technology File System):**
  * **MFT (Master File Table):** Base de datos indexada donde cada archivo y carpeta tiene al menos un registro de 1024 bytes con sus atributos (nombre, marcas temporales, permisos y datos o punteros a clusters).
  * **Journaling (Transaccionalidad):** Mantiene un registro de diario (`$LogFile`) que previene la corrupción del sistema de archivos ante apagones inesperados.
  * **Compresión nativa y cuotas de disco.**
  * **Seguridad granular:** Almacena descriptores de seguridad y Listas de Control de Acceso (ACL).

---

## 4. Identidades y Modelo de Seguridad en Windows: SAM y SIDs

1. **Base SAM (*Security Accounts Manager*):**
   Archivo protegido ubicado en `C:\Windows\System32\config\SAM` que almacena las contraseñas cifradas y los identificadores de usuarios y grupos locales.
2. **SID (*Security Identifier*):**
   Cadena alfanumérica única e irrepetible asignada por el sistema operativo a cada usuario o grupo al momento de su creación.
   * *Estructura típica:* `S-1-5-21-2959828458-3729372911-3829102938-1001`
   * El número final (`1001`) es el **RID (Relative Identifier)**: los usuarios estándar inician a partir del 1000, mientras que el Administrador integrado reservado es el `500`.
3. **UAC (Control de Cuentas de Usuario):**
   Separa la sesión ordinaria de la sesión administrativa. Cuando un administrador inicia sesión, Windows le otorga un **Token Filtrado** (privilegios estándar). Solo cuando una herramienta requiere acceso al Kernel (como `diskpart` o modificar el registro), el UAC solicita elevación para activar el **Token Elevado**.

---

## 5. Permisos NTFS: DACL, Herencia y Matriz de Precedencia

### A. DACL vs. SACL
* **DACL (*Discretionary Access Control List*):** Lista que define **quién** tiene acceso a un recurso y qué operaciones específicas puede realizar (Lectura, Escritura, Modificación, Control Total).
* **SACL (*System Access Control List*):** Lista que define las reglas de **auditoría** (registrar en el Visor de Eventos cuándo un usuario intenta acceder a un archivo).

### B. Herencia de Permisos
Por defecto, todo archivo o subcarpeta nueva hereda las reglas DACL de su carpeta contenedora padre.
* Conmutador `icacls /inheritance:d`: Rompe la herencia copiando los permisos actuales como permisos explícitos para poder personalizarlos sin borrar accesos previos.
* Conmutador `icacls /inheritance:r`: Rompe la herencia eliminando todas las reglas heredadas (deja la DACL completamente vacía).

### C. La Regla de Oro: Matriz de Precedencia de Accesos en Windows
Cuando Windows evalúa si un usuario puede abrir o alterar un archivo, procesa las ACEs en este orden de prioridad estricto:

```
┌─────────────────────────────────────────────────────────────┐
│ 1.º DENEGACIÓN EXPLÍCITA (Deny explícito en el archivo)     │  ▲ MÁXIMA PRIORIDAD
├─────────────────────────────────────────────────────────────┤  │
│ 2.º CONCESIÓN EXPLÍCITA (Allow explícito en el archivo)     │  │
├─────────────────────────────────────────────────────────────┤  │
│ 3.º DENEGACIÓN HEREDADA (Deny heredado de la carpeta padre) │  │
├─────────────────────────────────────────────────────────────┤  │
│ 4.º CONCESIÓN HEREDADA (Allow heredado de la carpeta padre) │  │
├─────────────────────────────────────────────────────────────┤  │
│ 5.º DENEGACIÓN IMPLÍCITA (Si no está en la lista, NO entra) │  ▼ MENOR PRIORIDAD
└─────────────────────────────────────────────────────────────┘
```

> [!CAUTION]
> **REGLA TÉCNICA CLAVE:** Si un usuario tiene **Control Total (Allow)** a través del grupo *Administradores*, pero se le aplica una regla individual de **Denegación de Escritura (Deny)**, la denegación **anula automáticamente** la concesión. ¡El bloqueo siempre gana!

---

## 💡 Glosario Rápido de Supervivencia para la Terminal
* `diskpart`: Consola de administración de almacenamiento a bajo nivel.
* `convert gpt`: Inicializa el disco con tabla GPT.
* `format fs=ntfs quick`: Da formato NTFS inicializando la MFT.
* `whoami /all`: Lista el usuario actual, su SID, grupos a los que pertenece y privilegios.
* `icacls "carpeta" /inheritance:d`: Desvincula la herencia preservando las entradas.
* `icacls "archivo" /grant:r "Usuarios":(RX)`: Asigna permisos de Lectura y Ejecución reemplazando reglas previas.
* `icacls "archivo" /deny "Usuario":(W)`: Bloquea explícitamente la escritura.
