# Evaluación Parcial — Modelo de Examen (Tema C)
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
### Eje de Evaluación: Almacenamiento, Seguridad/Permisos y Arquitectura de Memoria

> **Documento de Referencia Exclusivo:** compendio_completo_modulos_1_2_3.md  
> **Criterio de Evaluación:** Rigor técnico, precisión conceptual, justificación arquitectónica y ejecución correcta en laboratorio.  
> **Escala de Calificación y Modalidad (Total: 10 Puntos):**  
> * 📝 **Parte 1 (Teoría Conceptual - 4 Puntos):** Las 3 preguntas deben ser **respondidas en papel, de forma manuscrita/por escrito**, con vocabulario técnico y debida justificación (1.33 puntos c/u).  
> * 💻 **Parte 2 (Práctica en Laboratorio - 6 Puntos):** 3 tareas prácticas (2 puntos c/u), acreditadas mediante sus respectivas **capturas de pantalla subidas a Google Classroom**.

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
