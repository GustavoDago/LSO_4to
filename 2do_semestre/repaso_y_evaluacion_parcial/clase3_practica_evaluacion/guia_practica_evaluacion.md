# Guía de Práctica y Simulacro de Evaluación Parcial (Clase 3)
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional
### Ciclo Lectivo 2026 — 2.º Semestre

---

## 📋 Información General e Instrucciones de la Evaluación

* **Institución:** Escuela de Educación Secundaria Técnica (EEST).
* **Asignatura:** Laboratorio de Sistemas Operativos (LSO).
* **Nivel:** 4.º Año — Tecnicatura en Informática Personal y Profesional.
* **Módulos Evaluados:** Módulo 1 (Almacenamiento y Sistemas de Archivos), Módulo 2 (Seguridad, Identidades y Permisos NTFS) y Módulo 3 (Arquitectura y Administración de Memoria en Windows).
* **Tiempo Estimado:** 2 horas reloj (1 bloque de clase de laboratorio).
* **Escala de Calificación:** 10 Puntos en total.
  * 📝 **Parte 1 (Teórica en Papel):** 3 Puntos (1 punto por pregunta). Se responde de puño y letra en la hoja física entregada por el docente.
  * 💻 **Parte 2 (Práctica en Consola CLI):** 7 Puntos (3.5 pts Bloque CMD + 3.5 pts Bloque PowerShell). Se documenta con capturas de pantalla en un documento de Google Docs entregado mediante Google Classroom.
* **Condición de Aprobación:** Calificación mínima de 7 (siete) puntos, con resolución obligatoria de ambas partes (teórica y práctica).

> [!IMPORTANT]
> **Normas de Trabajo en el Laboratorio:**
> 1. En la **Parte 1 (Papel)**, las respuestas deben ser redactadas con vocabulario técnico formal, concisión y claridad conceptual.
> 2. En la **Parte 2 (Consola CLI)**, cada captura de pantalla debe ser nítida y mostrar obligatoriamente:
>    * El *prompt* del sistema con la ruta de ejecución.
>    * El comando completo ingresado por el estudiante.
>    * La salida en texto devuelta por el sistema operativo que acredite el resultado exitoso.
> 3. Al finalizar, debes completar la plantilla provista al final de esta guía dentro de tu documento de Google Docs y entregar la tarea en el enlace correspondiente de Google Classroom.

---

## 📝 PARTE 1: Evaluación Teórica Escrita en Papel (3 Puntos)

*Instrucción:* Responde de forma manuscrita las siguientes tres preguntas en la hoja de examen entregada por el docente. Justifica tus respuestas utilizando los conceptos de arquitectura estudiados durante el semestre.

---

### Pregunta 1: Arquitectura de Almacenamiento y Sistemas de Archivos (1 Punto)

Un técnico debe configurar una estación de trabajo con un disco de 4 TB para almacenamiento de máquinas virtuales y bases de datos. 
1. **Esquema de Particionado:** ¿Por qué es mandatorio inicializar el disco bajo el esquema **GPT (GUID Partition Table)** en lugar del antiguo esquema **MBR (Master Boot Record)**? Explica al menos dos diferencias arquitectónicas críticas (capacidad máxima direccionable, cantidad de particiones primarias o mecanismos de redundancia de cabeceras).
2. **Sistema de Archivos:** Explica por qué se debe formatear el volumen con **NTFS** en lugar de **FAT32** o **exFAT** en un entorno corporativo. Detalla qué rol cumple la **Tabla Maestra de Archivos (MFT - Master File Table)** y qué ventajas de seguridad y tolerancia a fallos aporta NTFS (metadatos, permisos DACL y journaling/registro transaccional).

---

### Pregunta 2: Seguridad Local, Identidades y Permisos NTFS (1 Punto)

Durante una auditoría de seguridad en un servidor Windows, se detecta que un usuario llamado `Operador01` pertenece al grupo local `Tecnicos` y al grupo `Auditores`.
1. **Identificadores de Seguridad (SID) y Tokens:** Explica qué es un **SID (Security Identifier)**, por qué no se altera aunque se cambie el nombre del usuario y cómo se genera el **Token de Acceso** durante el inicio de sesión.
2. **Listas de Control de Acceso (DACL) y Precedencia:** En la carpeta `D:\Confidencial`, la lista DACL tiene asignados los siguientes permisos:
   * Grupo `Tecnicos`: **Permitir (Allow)** Lectura y Escritura.
   * Grupo `Auditores`: **Denegar (Deny)** Acceso de Escritura.
   * Herencia de permisos desactivada (`inheritance:d`).
   
   ¿Podrá el usuario `Operador01` modificar o crear archivos dentro de `D:\Confidencial`? **Fundamenta técnicamente** tu respuesta aplicando la regla de precedencia estricta de Windows (*Deny explícito sobre Allow* y herencia vs. asignación directa).

---

### Pregunta 3: Arquitectura y Administración de Memoria en Windows (1 Punto)

Un operador de laboratorio nota que la computadora se congela temporalmente (*thrashing*), el indicador de uso de disco se mantiene al 100% y Windows muestra una advertencia de memoria insuficiente.
1. **Memoria Virtual y Paginación:** Explica la diferencia entre la **Memoria Física (RAM)** y el **Espacio de Direcciones Virtuales (VAS)**. ¿Cuál es el tamaño de bloque estándar de paginación que gestiona la MMU (Memory Management Unit) en arquitecturas x86/x64?
2. **Fallos de Página y Archivo de Paginación:** 
   * ¿Cuál es la diferencia fundamental entre un **Fallo de página suave (*Soft Page Fault*)** y un **Fallo de página duro (*Hard Page Fault*)**?
   * ¿Qué función cumple el archivo `pagefile.sys` en el disco secundario y por qué una tormenta de fallos duros degrada dramáticamente el rendimiento del procesador?

---

## 💻 PARTE 2: Práctica de Laboratorio en Consola CLI (7 Puntos)

*Instrucción:* Abre una ventana de **Símbolo del sistema (CMD)** como Administrador y una consola de **PowerShell** como Administrador. Ejecuta las siguientes actividades prácticas y toma las capturas de pantalla solicitadas para adjuntar a tu informe de Google Docs.

---

### 🔲 Bloque A: Administración y Seguridad en Símbolo del Sistema (CMD - 3.5 Puntos)

#### Tarea 1: Creación, Particionamiento y Formateo de Unidad Virtual con `diskpart` (2.0 Puntos)
En entornos de laboratorio o soporte técnico, es fundamental saber aprovisionar unidades de almacenamiento mediante la línea de comandos sin depender de asistentes gráficos.

1. Abre una consola de **CMD** con privilegios elevados de Administrador.
2. Inicia la utilidad interactiva de particionamiento:
   ```cmd
   diskpart
   ```
3. Crea un disco virtual dinámico de prueba de **256 MB** en la ruta de trabajo local (o selecciona uno existente provisto por el docente):
   ```cmd
   create vdisk file="C:\disco_examen.vhdx" maximum=256 type=expandable
   ```
4. Selecciona y adjunta el disco al subsistema del Kernel:
   ```cmd
   select vdisk file="C:\disco_examen.vhdx"
   attach vdisk
   ```
5. Inicializa el disco con tabla de particiones **GPT**:
   ```cmd
   convert gpt
   ```
6. Crea una partición primaria, formatéala en formato **NTFS** con la etiqueta `EVALUACION` y móntala en la letra de unidad `V:`:
   ```cmd
   create partition primary
   format fs=ntfs label="EVALUACION" quick
   assign letter=V
   detail volume
   exit
   ```

> 📸 **CAPTURA REQUERIDA N.º 1:**  
> Captura de pantalla de la consola CMD mostrando la salida del comando `detail volume` o la secuencia final de `diskpart` donde se observe el disco en formato GPT, el sistema de archivos NTFS montado y la letra `V:` asignada exitosamente.

---

#### Tarea 2: Auditoría de Identidades (`whoami`) y Control de Acceso (`icacls`) (1.5 Puntos)
Debes asegurar un directorio confidencial en la nueva unidad aplicando el principio de privilegios mínimos.

1. En la consola de CMD ordinaria (fuera de diskpart), crea un directorio llamado `Confidencial` dentro de la unidad `V:`:
   ```cmd
   mkdir V:\Confidencial
   ```
2. Inspecciona tu identidad actual, tu SID y los privilegios de tu token de acceso:
   ```cmd
   whoami /user /fo table
   ```
3. Inspecciona la lista de control de acceso (DACL) actual heredada por la carpeta:
   ```cmd
   icacls V:\Confidencial
   ```
4. Rompe la herencia de permisos convirtiendo los permisos heredados en explícitos y elimina el acceso al grupo general de `Usuarios`:
   ```cmd
   icacls V:\Confidencial /inheritance:d
   icacls V:\Confidencial /remove "Usuarios"
   ```
5. Vuelve a listar los permisos de la carpeta para verificar la nueva DACL:
   ```cmd
   icacls V:\Confidencial
   ```

> 📸 **CAPTURA REQUERIDA N.º 2:**  
> Captura de pantalla de la consola CMD mostrando la salida de `whoami /user` (con tu SID visible) seguida del comando `icacls V:\Confidencial` final, donde se compruebe que la herencia fue desactivada y que la DACL refleja los cambios aplicados.

---

### 🟦 Bloque B: Auditoría de Almacenamiento y Diagnóstico Clínico de Memoria en PowerShell (3.5 Puntos)

#### Tarea 3: Auditoría y Verificación de Almacenamiento con Cmdlets (1.5 Puntos)
En PowerShell, la administración de almacenamiento se realiza mediante objetos estructurados en lugar de texto plano.

1. Abre una ventana de **PowerShell** como Administrador.
2. Consulta el estado de todos los discos conectados al sistema para auditar el estilo de partición del disco virtual recién creado:
   ```powershell
   Get-Disk | Select-Object Number, FriendlyName, PartitionStyle, OperationalStatus, TotalSize
   ```
3. Consulta los detalles de los volúmenes del sistema, filtrando específicamente la unidad `V`:
   ```powershell
   Get-Volume -DriveLetter V | Select-Object DriveLetter, FileSystemLabel, FileSystem, DriveType, SizeRemaining, Size
   ```

> 📸 **CAPTURA REQUERIDA N.º 3:**  
> Captura de pantalla de la consola de PowerShell mostrando la ejecución y los resultados de `Get-Disk` (con la columna `PartitionStyle` indicando **GPT**) y de `Get-Volume` (con `FileSystem` en **NTFS** y letra `V`).

---

#### Tarea 4: Diagnóstico Clínico de Procesos y Memoria Física/Virtual (2.0 Puntos)
Como administrador de sistemas, debes auditar qué procesos ocupan mayor cantidad de memoria física residente (*Working Set*) y memoria virtual comprometida (*Paged Memory*).

1. En la consola de PowerShell, ejecuta una consulta que obtenga todos los procesos activos, ordene los 10 principales consumidores de memoria RAM física en orden descendente y formatee el consumo en Megabytes (MB) legibles:
   ```powershell
   Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 10 Id, ProcessName, @{Name="RAM_Fisica_MB"; Expression={[math]::Round($_.WorkingSet64 / 1MB, 2)}}, @{Name="Memoria_Virtual_MB"; Expression={[math]::Round($_.PM / 1MB, 2)}} | Format-Table -AutoSize
   ```
2. Analiza el proceso que encabeza la lista: identifica su **PID**, su nombre y explica brevemente en tu informe si el consumo de memoria corresponde a una aplicación de usuario o a un servicio del sistema operativo.

> 📸 **CAPTURA REQUERIDA N.º 4:**  
> Captura de pantalla de la consola de PowerShell mostrando la tabla completa de los 10 procesos con mayor consumo de memoria física y virtual debidamente formateada en MB.

---

## 📊 Rúbrica de Evaluación y Criterios de Corrección

| Componente | Criterio de Logro Técnico | Puntaje Máximo |
| :--- | :--- | :---: |
| **Parte 1 — Pregunta 1 (Papel)** | Justifica técnicamente las ventajas de GPT sobre MBR (>2TB, redundancia) y la arquitectura NTFS (MFT, transacciones, seguridad). | **1.0 pto** |
| **Parte 1 — Pregunta 2 (Papel)** | Explica con precisión el rol del SID, Token de Acceso y la precedencia estricta *Deny > Allow* en la DACL. | **1.0 pto** |
| **Parte 1 — Pregunta 3 (Papel)** | Distingue memoria física de virtual (páginas de 4 KB), diferencia Soft vs. Hard Page Faults y rol del `pagefile.sys`. | **1.0 pto** |
| **Parte 2 — Captura 1 (CMD)** | Creación, adjuntado de VHD, inicialización GPT, particionado y formateo NTFS montado en `V:` con `diskpart`. | **2.0 pts** |
| **Parte 2 — Captura 2 (CMD)** | Auditoría de SID con `whoami /user` y corte de herencia/reestructuración de permisos en `icacls`. | **1.5 pts** |
| **Parte 2 — Captura 3 (PowerShell)** | Uso correcto de `Get-Disk` y `Get-Volume` mostrando propiedades clave (GPT, NTFS, letra V:). | **1.5 pts** |
| **Parte 2 — Captura 4 (PowerShell)** | Script/comando de PowerShell que filtra y calcula en MB el WorkingSet de los 10 procesos más pesados. | **2.0 pts** |
| **TOTAL** | **Dominio Integral Teórico y Práctico (Nota Final)** | **10.0 PUNTOS** |

---

## 📋 Plantilla para el Documento de Entrega en Google Classroom

*Copiar y pegar la siguiente estructura en un nuevo documento de Google Docs, completar los datos, insertar las 4 capturas en sus secciones respectivas y entregar el archivo en la tarea correspondiente de Google Classroom.*

```markdown
# Informe de Evaluación Parcial de Laboratorio (LSO 4.º Año)
## Evaluación Práctica en Consola CLI — 2.º Semestre

### Datos del Estudiante
* **Apellido y Nombre:** [Completar aquí]
* **Curso y División:** 4.º Año — Tecnicatura en Informática Personal y Profesional
* **Fecha de Realización:** _____ / _____ / 2026
* **Número de Computadora / Puesto de Laboratorio:** PC N.º _____

---

### ✅ Checklist de Entregas Requeridas
- [ ] Hoja física con las 3 preguntas teóricas entregada en mano al docente.
- [ ] Captura 1: Creación y montaje de volumen VHDX con GPT y NTFS (`diskpart`).
- [ ] Captura 2: Identificación de SID (`whoami`) y control de accesos (`icacls`).
- [ ] Captura 3: Auditoría de almacenamiento con cmdlets de PowerShell (`Get-Disk` y `Get-Volume`).
- [ ] Captura 4: Monitoreo de memoria WorkingSet de procesos en PowerShell (`Get-Process`).

---

### 💻 Bloque A: Comandos en Símbolo del Sistema (CMD)

#### Captura N.º 1: Particionamiento y Montaje con `diskpart`
*(Pegar aquí la captura de pantalla mostrando la salida final de diskpart con la letra V: y volumen NTFS)*

* **Explicación técnica de lo realizado:** 
[Explicar brevemente qué parámetros se utilizaron en diskpart y por qué se eligió el esquema GPT]

---

#### Captura N.º 2: Auditoría de SIDs y Permisos con `icacls`
*(Pegar aquí la captura de pantalla con whoami /user y la salida de icacls mostrando el corte de herencia)*

* **SID de la cuenta auditada:** `S-1-5-...`
* **Explicación técnica del cambio de permisos:** 
[Explicar qué efecto tuvo el modificador /inheritance:d y por qué se restringió el acceso]

---

### 🟦 Bloque B: Auditoría y Diagnóstico en PowerShell

#### Captura N.º 3: Auditoría de Discos y Volúmenes (`Get-Disk` / `Get-Volume`)
*(Pegar aquí la captura de pantalla de PowerShell con los cmdlets de almacenamiento ejecutados)*

* **Estilo de partición reportado por Get-Disk:** [MBR / GPT]
* **Sistema de archivos y espacio reportado por Get-Volume:** [NTFS / Capacidad]

---

#### Captura N.º 4: Diagnóstico de Memoria y WorkingSet (`Get-Process`)
*(Pegar aquí la captura de pantalla con la tabla de los 10 procesos ordenados por consumo de RAM en MB)*

* **Proceso con mayor consumo de memoria física:** [Nombre del proceso y PID]
* **Cantidad de memoria física (WorkingSet) consumida:** [Valor en MB]
* **Análisis técnico:** [¿Es un proceso del sistema o de usuario? ¿Por qué es importante medir el WorkingSet vs la memoria virtual confirmada?]

---
```

