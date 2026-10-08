# Evaluación Parcial — Modelo de Examen (Tema A)
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
