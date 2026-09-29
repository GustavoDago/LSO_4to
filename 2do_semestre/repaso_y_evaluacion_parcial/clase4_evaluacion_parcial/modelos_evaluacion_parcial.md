# Evaluaciones Parciales — Modelos de Examen (Tema A, Tema B y Tema C)
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
### Eje de Evaluación: Almacenamiento, Seguridad/Permisos y Arquitectura de Memoria

> **Documento de Referencia Exclusivo:** compendio_completo_modulos_1_2_3.md  
> **Criterio de Evaluación:** Rigor técnico, precisión conceptual, justificación arquitectónica y ejecución correcta en laboratorio.  
> **Escala de Calificación y Modalidad (Total: 10 Puntos):**  
> * 📝 **Parte 1 (Teoría Conceptual - 4 Puntos):** Las 3 preguntas deben ser **respondidas en papel, de forma manuscrita/por escrito**, con vocabulario técnico y debida justificación (1.33 puntos c/u).  
> * 💻 **Parte 2 (Práctica en Laboratorio - 6 Puntos):** 3 tareas prácticas (2 puntos c/u), acreditadas mediante sus respectivas **capturas de pantalla subidas a Google Classroom**.

---

# 📝 TEMA A

### Ponderación del Tema A:
* **Parte 1: Teoría (4 Puntos):** Preguntas 1, 2 y 3 (1.33 pts c/u).
* **Parte 2: Práctica en Laboratorio (6 Puntos):** Práctica 1 (CMD - Almacenamiento), Práctica 2 (PowerShell - Memoria) y Práctica 3 (Aplicaciones - Seguridad) (2 pts c/u).

---

## 📌 PARTE 1: Preguntas Conceptuales de Examen (4 Puntos)
> ✍️ *Nota obligatoria:* Estas preguntas deben responderse **en papel, por escrito**, utilizando letra clara y vocabulario técnico riguroso.

1. **Arquitectura de Particionado y el Límite de los 2 TB (1.33 Puntos):**  
   Un técnico informático debe instalar una unidad de disco rígido de **4 TB** en una estación de trabajo con Windows 11.
   * Explica detalladamente por qué es técnicamente imposible aprovechar la totalidad del disco si se inicializa bajo el esquema **MBR**, justificando matemáticamente la relación entre el direccionamiento LBA de 32 bits y el tamaño estándar de sector.
   * Justifica dos razones arquitectónicas por las cuales el estándar **GPT** supera esta limitación y ofrece mayor tolerancia a fallos ante la corrupción de datos.

2. **Seguridad Local, Identidades y Resolución de Conflictos NTFS (1.33 Puntos):**  
   En un servidor con Windows 11, un usuario llamado `Carlos` pertenece simultáneamente al grupo local `Tecnicos` y al grupo `Pasantes`. Sobre una carpeta compartida confidencial (`D:\Auditoria`), la Lista de Control de Acceso Discrecional (**DACL**) posee las siguientes dos reglas (*ACEs*):
   * `Tecnicos`: **Permitir (Allow)** — Control Total (F).
   * `Pasantes`: **Denegar (Deny)** — Lectura y Ejecución (RX).
   
   *Responde y justifica:*
   * ¿Podrá `Carlos` ingresar a la carpeta y leer su contenido? Explica qué regla jerárquica estricta aplica el Administrador de Referencia de Seguridad (**SRM**) del kernel para resolver este conflicto.
   * Si el administrador del sistema cambia el nombre de la cuenta de usuario de `Carlos` a `Carlos_Jefe`, ¿pierde sus accesos o se deben reconfigurar las reglas de la carpeta? Justifica tu respuesta utilizando el concepto de **SID (*Security Identifier*)**.

3. **Arquitectura de Memoria: Aislamiento del VAS y Anillos de CPU (1.33 Puntos):**  
   En una computadora con Windows 11 de 64 bits, se están ejecutando al mismo tiempo el navegador web (`chrome.exe`) y un editor de texto (`notepad.exe`).
   * Explica en qué consiste el concepto de **"La Ilusión Contigua"** que brinda la Memoria Virtual y cómo la **MMU (*Memory Management Unit*)** garantiza que dos procesos puedan utilizar exactamente la misma dirección lógica (ej. `0x00400000`) sin interferir entre sí.
   * Si un proceso que corre en Modo Usuario (**Ring 3**) intenta forzar una lectura directa a una dirección del núcleo del sistema operativo (**Ring 0**), ¿qué componente detecta la infracción, qué excepción se dispara y qué acción inmediata toma Windows con dicho proceso?

---

## 💻 PARTE 2: Práctica en Laboratorio (6 Puntos)

### 🔲 Práctica 1: CMD — Aprovisionamiento de Unidad Virtual VHDX en `diskpart` (2 Puntos)
1. Abre una ventana de **Símbolo del sistema (CMD)** como Administrador.
2. Inicia el intérprete `diskpart` y ejecuta la siguiente secuencia de comandos:
   ```cmd
   diskpart
   create vdisk file="C:\Temp\TemaA.vhdx" maximum=128 type=expandable
   select vdisk file="C:\Temp\TemaA.vhdx"
   attach vdisk
   convert gpt
   create partition primary
   format fs=ntfs quick label="TEMA_A"
   assign letter=V
   list volume
   ```
3. 📸 **Captura Obligatoria 1:** Toma una captura de pantalla de la ventana de CMD donde se observe la ejecución de los comandos y la tabla de `list volume` mostrando la unidad `V:` montada con formato NTFS y etiqueta `TEMA_A`.

---

### 🔲 Práctica 2: PowerShell — Auditoría de Procesos por RAM Física (Working Set) (2 Puntos)
1. Abre una consola de **PowerShell**.
2. Ejecuta la siguiente instrucción para consultar los procesos activos, ordenarlos de mayor a menor consumo de memoria RAM física real (`WorkingSet64`), calcular el valor en Megabytes y mostrar los 5 procesos principales:
   ```powershell
   Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 Id, ProcessName, @{Name="RAM_Fisica_MB"; Expression={[math]::round($_.WorkingSet64 / 1MB, 2)}} | Format-Table -AutoSize
   ```
3. 📸 **Captura Obligatoria 2:** Toma una captura de pantalla de la consola PowerShell mostrando la tabla resultante con los 5 procesos y sus consumos en Megabytes.

---

### 🔲 Práctica 3: Aplicaciones (GUI) — Auditoría de Permisos Efectivos en el Explorador (2 Puntos)
1. Abre el **Explorador de Archivos** (`Win + E`) y dirígete a `C:\Temp`. Crea una nueva carpeta llamada `Seguridad_TemaA`.
2. Haz clic derecho sobre `Seguridad_TemaA` → selecciona **Propiedades** → ve a la pestaña **Seguridad** → haz clic en el botón **Opciones avanzadas**.
3. En la ventana de configuración avanzada, haz clic en la pestaña superior **Acceso efectivo**.
4. Haz clic en **Seleccionar un usuario**, escribe el nombre de tu usuario local (o `Usuarios`) y pulsa **Aceptar**.
5. Haz clic en el botón **Ver acceso efectivo** para que el sistema calcule los permisos reales.
6. 📸 **Captura Obligatoria 3:** Toma una captura de pantalla donde se observe la ventana "Configuración de seguridad avanzada para Seguridad_TemaA" con la lista de derechos evaluados y sus respectivos tildes de estado.

---
---

# 📝 TEMA B

### Ponderación del Tema B:
* **Parte 1: Teoría (4 Puntos):** Preguntas 1, 2 y 3 (1.33 pts c/u).
* **Parte 2: Práctica en Laboratorio (6 Puntos):** Práctica 1 (CMD - Seguridad), Práctica 2 (PowerShell - Almacenamiento) y Práctica 3 (Aplicaciones - Memoria) (2 pts c/u).

---

## 📌 PARTE 1: Preguntas Conceptuales de Examen (4 Puntos)
> ✍️ *Nota obligatoria:* Estas preguntas deben responderse **en papel, por escrito**, utilizando letra clara y vocabulario técnico riguroso.

1. **Estructura Interna de NTFS y Asignación por Clusters (1.33 Puntos):**  
   Al particionar y preparar un volumen con `diskpart` se ejecuta la instrucción: `format fs=ntfs quick label="DATOS"`.
   * Explica qué funciones críticas cumplen la **MFT (*Master File Table*)** y el diario de transacciones (**Journaling / `$LogFile`**) en la integridad de los datos ante cortes repentinos de energía.
   * Si en dicho volumen con clusters estándar de **4 KB (4096 bytes)** se almacena un archivo de texto liviano que pesa **600 bytes**, calcula cuánto espacio exacto se desperdicia, explica cómo se denomina técnicamente este fenómeno (*Slack Space*) y por qué se produce.

2. **Control de Accesos, Herencia NTFS y Recuperación de Recursos (1.33 Puntos):**  
   Un administrador debe configurar un directorio protegido en `C:\Empresa\Balances`.
   * Explica la diferencia entre los modificadores de ruptura de herencia `/inheritance:d` y `/inheritance:r` del comando `icacls`, detallando en qué estado queda la lista de permisos (DACL) en cada caso.
   * Si el único administrador que tenía acceso a una carpeta bloqueada es dado de baja y la carpeta queda sin permisos accesibles para nadie, ¿qué comando de consola permite recuperar el control de dicho recurso (`takeown`) y qué derecho inalienable de bajo nivel adquiere quien se convierte en su **Owner (Propietario)**?

3. **Gestión de Paginación y Diagnóstico de Rendimiento (1.33 Puntos):**  
   Durante una jornada de trabajo, una estación de trabajo comienza a responder con extrema lentitud: el puntero del mouse se congela periódicamente y el Administrador de Tareas reporta que la actividad del disco de sistema está permanentemente al **100%**, aun cuando el procesador tiene baja carga de cálculo.
   * Explica la diferencia técnica y de impacto en el rendimiento entre un **Soft Page Fault (Fallo de Página Suave)** y un **Hard Page Fault (Fallo de Página Duro)**.
   * Justifica con precisión cómo se denomina este cuadro de degradación patológica (**Hiperpaginación / *Thrashing***) y describe la secuencia de eventos que ocurre entre la memoria RAM física saturada, el archivo `pagefile.sys` y la suspensión de hilos del procesador.

---

## 💻 PARTE 2: Práctica en Laboratorio (6 Puntos)

### 🔲 Práctica 1: CMD — Ruptura de Herencia y Restricción con `icacls` (2 Puntos)
1. Abre una ventana de **Símbolo del sistema (CMD)** como Administrador.
2. Crea el directorio de prueba y configura la seguridad mediante comandos de consola:
   ```cmd
   mkdir C:\Temp\Seguridad_TemaB
   icacls "C:\Temp\Seguridad_TemaB" /inheritance:d
   icacls "C:\Temp\Seguridad_TemaB" /remove "Usuarios"
   icacls "C:\Temp\Seguridad_TemaB"
   ```
3. 📸 **Captura Obligatoria 1:** Toma una captura de pantalla de la ventana de CMD donde se aprecie la salida del comando final `icacls`, verificando que la herencia fue deshabilitada y que el grupo `Usuarios` ya no forma parte de la DACL.

---

### 🔲 Práctica 2: PowerShell — Auditoría de Volúmenes y Espacio NTFS (2 Puntos)
1. Abre una consola de **PowerShell**.
2. Ejecuta la siguiente instrucción para consultar los volúmenes del sistema con letra asignada formateados en NTFS, mostrando su letra de unidad, etiqueta de volumen, tamaño total en GB y espacio disponible en GB:
   ```powershell
   Get-Volume | Where-Object { $_.DriveLetter -ne $null -and $_.FileSystem -eq "NTFS" } | Select-Object DriveLetter, FileSystemLabel, FileSystem, @{Name="Total_GB"; Expression={[math]::round($_.Size / 1GB, 2)}}, @{Name="Libre_GB"; Expression={[math]::round($_.SizeRemaining / 1GB, 2)}} | Format-Table -AutoSize
   ```
3. 📸 **Captura Obligatoria 2:** Toma una captura de pantalla de la consola PowerShell mostrando la tabla estructurada con los volúmenes NTFS, sus capacidades y el espacio libre.

---

### 🔲 Práctica 3: Aplicaciones (GUI) — Distribución de Memoria en el Monitor de Recursos (2 Puntos)
1. Presiona las teclas **`Win + R`**, escribe **`resmon`** y presiona **Enter** para iniciar el **Monitor de Recursos**.
2. Haz clic en la pestaña superior **Memoria**.
3. Localiza el panel central inferior titulado **Memoria física** donde figura la barra horizontal cromática que detalla los estados de la RAM (Hardware reservado, En uso, Modificada, En espera y Libre).
4. 📸 **Captura Obligatoria 3:** Toma una captura de pantalla de la ventana del Monitor de Recursos enfocando claramente la barra de memoria física con sus segmentos de colores y los valores en MB de cada estado.

---
---

# 📝 TEMA C

### Ponderación del Tema C:
* **Parte 1: Teoría (4 Puntos):** Preguntas 1, 2 y 3 (1.33 pts c/u).
* **Parte 2: Práctica en Laboratorio (6 Puntos):** Práctica 1 (CMD - Identidades), Práctica 2 (PowerShell - Seguridad) y Práctica 3 (Aplicaciones - Memoria/Hardware) (2 pts c/u).

---

## 📌 PARTE 1: Preguntas Conceptuales de Examen (4 Puntos)
> ✍️ *Nota obligatoria:* Estas preguntas deben responderse **en papel, por escrito**, utilizando letra clara y vocabulario técnico riguroso.

1. **Discos Virtuales en Windows (VHD/VHDX) y Gestión CLI con `diskpart` (1.33 Puntos):**  
   En el laboratorio de la escuela se requiere implementar entornos de práctica aislados para los alumnos sin modificar el congelador de disco (*Deep Freeze*) ni reconfigurar particiones físicas.
   * Explica dos ventajas arquitectónicas del formato **VHDX** sobre el formato heredado **VHD**, prestando especial atención a la capacidad máxima y a la resiliencia ante cortes imprevistos de energía eléctrica.
   * Diferencia técnicamente entre un disco virtual de **tamaño fijo (*fixed*)** y uno **dinámico / expandible (*expandable*)**. ¿Por qué para una netbook escolar con almacenamiento reducido se recomienda configurar el tipo dinámico?
   * Escribe la secuencia de comandos exacta en `diskpart` para:
     1. Desconectar (*desmontar*) un disco virtual ubicado en `C:\Temp\DiscoLSO.vhdx`.
     2. Volver a conectarlo (*montarlo*) posteriormente sin reiniciar el equipo.

2. **Control de Cuentas de Usuario (UAC) y Permisos POSIX (1.33 Puntos):**  
   * **Parte A (Windows):** Describe cómo funciona la arquitectura de **Token Dividido** del Control de Cuentas de Usuario (**UAC**) cuando un usuario administrador inicia sesión cotidiana, y explica por qué se utiliza el **Escritorio Seguro (*Secure Desktop*)** cuando aparece la ventana de consentimiento.
   * **Parte B (Linux):** Un alumno ejecuta el comando `chmod 644 /laboratorio` sobre un directorio. Al intentar ingresar con el comando `cd /laboratorio`, la terminal le arroja el error: `Permiso denegado`. Explica qué permiso esencial le falta al usuario sobre el directorio (Lectura `r`, Escritura `w` o Ejecución `x`) y justifica técnicamente qué significa tener permiso de ejecución (`x`) sobre una carpeta en Linux.

3. **Diagnóstico Clínico de Memoria y Pools del Kernel (1.33 Puntos):**  
   Un técnico en soporte analiza el consumo de recursos de un servidor mediante el Administrador de Tareas y PowerShell.
   * Explica con claridad la diferencia entre el **Working Set (Espacio de Trabajo / RAM Física)** de un proceso y su **Commit Size (Memoria Confirmada / Privada)**. ¿Por qué el *Commit Size* puede ser significativamente mayor que la memoria física que el proceso tiene cargada en ese momento?
   * En el espacio de Modo Núcleo de Windows existen el **Paged Pool (Grupo Paginado)** y el **Non-Paged Pool (Grupo No Paginado)**. Explica por qué es críticamente peligroso que ocurra una fuga de memoria (*memory leak*) en un controlador dentro del **Non-Paged Pool** y por qué el sistema operativo no puede mitigar esa falla enviando páginas al `pagefile.sys`.

---

## 💻 PARTE 2: Práctica en Laboratorio (6 Puntos)

### 🔲 Práctica 1: CMD — Inspección de Identidades (SID y Cuentas Locales) (2 Puntos)
1. Abre una ventana de **Símbolo del sistema (CMD)**.
2. Ejecuta los comandos de inspección de identidades y usuarios locales:
   ```cmd
   whoami /user
   net user
   ```
3. 📸 **Captura Obligatoria 1:** Toma una captura de pantalla de la ventana de CMD donde se observen la salida completa de `whoami /user` (mostrando el nombre de usuario y su código SID con el RID final) y la tabla de cuentas locales arrojada por `net user`.

---

### 🔲 Práctica 2: PowerShell — Auditoría Estructurada de Reglas DACL con `Get-Acl` (2 Puntos)
1. Abre una consola de **PowerShell**.
2. Ejecuta la siguiente instrucción para auditar las entradas de control de acceso (ACEs) configuradas en la carpeta `C:\Temp` (o `C:\Windows`), extrayendo de forma tabular la identidad, el derecho específico y el tipo de regla:
   ```powershell
   (Get-Acl "C:\Temp").Access | Select-Object IdentityReference, FileSystemRights, AccessControlType, IsInherited | Format-Table -AutoSize
   ```
3. 📸 **Captura Obligatoria 2:** Toma una captura de pantalla de la consola PowerShell mostrando la tabla resultante con las columnas `IdentityReference`, `FileSystemRights`, `AccessControlType` e `IsInherited`.

---

### 🔲 Práctica 3: Aplicaciones (GUI) — Auditoría de CPU y Memoria en el Administrador de Tareas (2 Puntos)
1. Presiona las teclas **`Ctrl + Shift + Esc`** para abrir el **Administrador de Tareas**.
2. Dirígete a la pestaña lateral **Rendimiento** y haz clic en **CPU**.
3. Observa en la zona inferior derecha las métricas de hardware: **Caché L1, Caché L2 y Caché L3**, además de los procesadores lógicos y núcleos.
4. 📸 **Captura Obligatoria 3:** Toma una captura de pantalla de la ventana del Administrador de Tareas en la sección de Rendimiento donde se aprecien con claridad los tamaños de memoria Caché de la CPU y los datos de arquitectura del equipo.
