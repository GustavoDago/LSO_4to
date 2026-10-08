# Evaluación Parcial — Modelo de Examen (Tema B)
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
### Eje de Evaluación: Almacenamiento, Seguridad/Permisos y Arquitectura de Memoria

> **Documento de Referencia Exclusivo:** compendio_completo_modulos_1_2_3.md  
> **Criterio de Evaluación:** Rigor técnico, precisión conceptual, justificación arquitectónica y ejecución correcta en laboratorio.  
> **Escala de Calificación y Modalidad (Total: 10 Puntos):**  
> * 📝 **Parte 1 (Teoría Conceptual - 4 Puntos):** Las 3 preguntas deben ser **respondidas en papel, de forma manuscrita/por escrito**, con vocabulario técnico y debida justificación (1.33 puntos c/u).  
> * 💻 **Parte 2 (Práctica en Laboratorio - 6 Puntos):** 3 tareas prácticas (2 puntos c/u), acreditadas mediante sus respectivas **capturas de pantalla subidas a Google Classroom**.

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
