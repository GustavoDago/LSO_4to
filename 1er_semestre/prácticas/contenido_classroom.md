# Contenido de Google Classroom: Laboratorio de Sistemas Operativos (4.º B - 2026)

* **Curso:** Laboratorio de Sistemas Operativos 4to B 2026
* **ID de la Clase:** 796587439990
* **Enlace de Classroom:** [Entrar a la clase](https://classroom.google.com/c/Nzk2NTg3NDM5OTkw)

---

## 📝 Registro Cronológico de Trabajos Prácticos y Clases (25 Actividades)

### 🗓️ Marzo 2026: Introducción, Fundamentos y Gestión Inicial de Procesos
1. **Tarea: Análisis del Entorno Digital** *(12/03/2026)*
   * **Contenidos:** Abstracción del SO respecto al hardware, identificación de dispositivos/SO/Kernel y definición del SO como Administrador de Recursos.
   * **Materiales:** Formulario *Blank Quiz*.

2. **Evaluación Clase 1: Fundamentos de Sistemas Operativos** *(17/03/2026)*
   * **Contenidos:** Evaluación sobre conceptos fundamentales de SO.
   * **Materiales:** [Formulario Google Quiz](https://docs.google.com/forms/d/e/1FAIpQLSdAm8pOBILzK7CWVhiuGXBHJs5HCOJ2Vi2lwELvBoyTsdHJ3Q/viewform?usp=publish-editor).

3. **Evolución de los Sistemas Operativos** *(19/03/2026)*
   * **Contenidos:** Evolución histórica y generaciones de los Sistemas Operativos.

4. **Actividad Práctica: Gestión de Procesos con PowerShell** *(24/03/2026)*
   * **Contenidos:** Estados del proceso (Nuevo, Listo, Ejecución, Terminado), PCB, PIDs.
   * **Comandos:** `Start-Process notepad`, `Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet`, `Sort-Object CPU -Descending`, `Stop-Process`.

5. **Administración de Procesos y Gestión de Recursos** *(26/03/2026)*
   * **Contenidos:** Rol del SO como gobierno del hardware, diferencia entre programa y proceso, cuestionario sobre asignación de PIDs y bloqueo por E/S.
   * **Materiales:** `Clase 5 - Guía de Laboratorio - Administración de Procesos y Gestión de Recursos.pdf`.

6. **Archivo script de comandos PowerShell** *(26/03/2026)*
   * **Contenidos:** Creación y ejecución de scripts `.ps1`, políticas de ejecución (`Set-ExecutionPolicy RemoteSigned`), ciclo de vida de procesos, memoria `WorkingSet`, `Threads`, *syscalls* y controladores `Win32_PnPSignedDriver`.
   * **Materiales:** `laboratorio_unidad2.txt`.

7. **Clase 5: Práctica Exploración del Kernel y Gestión de Recursos** *(26/03/2026)*
   * **Contenidos:** Prácticas directas en laboratorio sobre el Kernel y consumo de recursos.
   * **Materiales:** `Guía de Laboratorio - Exploración del Kernel y Gestión de Recursos en Windows.pdf`.

---

### 🗓️ Abril 2026: Bootstrapping, BIOS/UEFI y CLI de PowerShell
8. **Arranque y Carga (Bootstrapping)** *(16/04/2026)*
   * **Contenidos:** Diagnóstico del sistema ("Crisis en la Cocina"), Monitor de recursos (`resmon`), análisis de procesos rebeldes, secuencias de arranque y configuración con `bcdedit /enum`.

9. **Arranque y Carga - Finalización** *(22/04/2026)*
   * **Contenidos:** Inspección física y lógica de BIOS/UEFI, inspección del cargador de arranque con `bcdedit` y análisis de privilegios de administrador.
   * **Materiales:** `Guía Rápida de PowerShell.xlsx`, `Actividad 22-4.md`.

10. **El Mensaje Encriptado (Práctica CLI)** *(22/04/2026)*
    * **Contenidos:** Operaciones fundamentales en sistema de archivos desde terminal.
    * **Comandos:** `Set-Location ~`, `New-Item`, `Add-Content`, `Get-Content`, `Remove-Item`.

11. **Evaluación parcial 30/4/2026** *(30/04/2026)*
    * **Contenidos:** Instancia de evaluación integradora del mes de abril.

---

### 🗓️ Mayo 2026: Metadatos, Interfaz Gráfica (Overhead/DWM), Registro de Windows y UX
12. **Práctica de PowerShell - Metadatos** *(06/05/2026)*
    * **Contenidos:** Atributos de archivos, metadatos, filtros y permisos ACL.
    * **Comandos:** `Get-ChildItem -Filter`, `Get-ItemProperty`, `Get-ACL`, `Set-Content`, `Add-Content`, `Remove-Item`.

13. **Práctica de Explorador de Windows** *(06/05/2026)*
    * **Contenidos:** Filtrado, ordenamiento y organización visual de archivos en el Shell.

14. **Unidad 3 - Clase 1: Análisis del "Overhead" en Windows 11** *(07/05/2026)*
    * **Contenidos:** Costo en hardware de la GUI, IRQ, *syscalls*, comparación Estado A (Efectos visuales) vs Estado B (Rendimiento), investigación del proceso `dwm.exe` (Desktop Window Manager).
    * **Materiales:** `Unmasking_the_Interface.pptx`, `Clase 1: La Interfaz como Abstracción.docx`, `Info clase 1.png`.

15. **Tarea 1 - Diseño y Auditoría de Interfaz de Diagnóstico** *(14/05/2026)*
    * **Contenidos:** Wireframing, diseño de herramientas de diagnóstico, jerarquía visual, feedback, Ley de Fitts y fichas de auditoría entre pares.
    * **Materiales:** `Arquitectura_de_Interfaces.pptx`, `Wireframing y diseño de lógica.png`, `Guión clase 14/5/26`.

16. **Clase 3: Fuentes y Registro de Windows** *(20/05/2026)*
    * **Contenidos:** Intervención en el Registro (`HKEY_CURRENT_USER\Control Panel\Desktop`), modificación de `FontSmoothing` (suavizado anti-aliasing de fuentes), comando de restauración `reg delete` y fundamentación sobre ciclos de CPU/GPU.
    * **Materiales:** `Anatomía_de_la_Interfaz.pptx`, `Registro.png`.

17. **Clase 4: Accesibilidad e Infraestructura Semántica** *(21/05/2026)*
    * **Contenidos:** Infraestructura semántica del SO, accesibilidad y experiencia de usuario (UX).
    * **Materiales:** `Semantic_OS_Infrastructure.pptx`, `Infraestructura Semántica, Accesibilidad y UX.pdf`.

18. **Clase 5: Dark Patterns (Patrones Oscuros)** *(26/05/2026)*
    * **Contenidos:** Análisis crítico de patrones de diseño engañosos en interfaces de usuario.
    * **Materiales:** `presentacion_dark_patterns.html`, `dark patterns.pdf`, `ejemplos_reales_dark_patterns.md`.

---

### 🗓️ Junio 2026: Diagnóstico de Estrés, Registro Avanzado y Misión Gamificada
19. **Clase 6: Diagnóstico Técnico mediante Herramientas Avanzadas** *(04/06/2026)*
    * **Contenidos:** Estrés de CPU mediante concurrencia/paralelismo, inspección en Monitor de Recursos.
    * **Comandos:** `1..$env:NUMBER_OF_PROCESSORS | ForEach-Object { Start-Job -ScriptBlock { while($true) { [Math]::Sqrt([Random]::new().Next()) } } }`, `Get-Job | Stop-Job | Remove-Job`.
    * **Materiales:** `Clase 6: Diagnóstico Técnico mediante Herramientas Avanzadas.docx`, `Cuestionario Técnico.docx`.

20. **Registro de Windows (El ADN de Windows)** *(11/06/2026)*
    * **Contenidos:** Arquitectura profunda de la base de datos del Registro (HKEYs, tipos de datos, claves y valores).
    * **Materiales:** `El_ADN_de_Windows.pptx`, `Plan de Clase Registro de Windows.pdf`.

21. **Repaso CLI** *(18/06/2026)*
    * **Contenidos:** Práctica integradora de comandos de consola y evaluación mediante Kahoot.
    * **Materiales:** `activity_commands.pdf`, `kahoot_questions.pdf`.

22. **Operación "Limpieza LSO" (Práctica Gamificada)** *(25/06/2026)*
    * **Contenidos:** Misión de respuesta a incidentes: resolución de servicios alterados y claves en el registro en 9 terminales.
    * **Materiales:** `setup_practica1.ps1`, `Guia_Actividad_Gamificada.pdf`, `desbloquear.html`.

---

### 🗓️ Julio 2026: Cierre del 1.er Semestre y Evaluación Integradora
23. **Tareas de Repaso** *(01/07/2026)*
    * **Contenidos:** Repaso general previo a las evaluaciones finales.
    * **Materiales:** `actividad_repaso.pdf`, cuadernos de NotebookLM.

24. **Ensayo de Evaluación** *(02/07/2026)*
    * **Contenidos:** Simulacro de evaluación integradora teórica y práctica.
    * **Materiales:** `ensayo_evaluacion.pdf`.

25. **Evaluación Integradora del Primer Semestre** *(08/07/2026)*
    * **Contenidos:** Examen integrador final de 1er semestre (Temas A, B y C).
    * **Materiales:** `evaluacion_tema_a.pdf`, `evaluacion_tema_b.pdf`, `evaluacion_tema_c.pdf`.
