# Análisis de Modernización Curricular: Diseño Oficial (Res. 3828/09) vs. Enfoque Actual (Windows 11 / Linux)

> **Objetivo Pedagógico:** Respetar los fundamentos conceptuales de la arquitectura de Sistemas Operativos prescritos en el diseño provincial (2009), pero **transponerlos y actualizarlos a las tecnologías, herramientas y entornos de producción modernos de 4.º año** (Windows 11, PowerShell, Linux, seguridad aplicada y UX).

---

## 🔄 Comparativa Detallada: Prescripción Tradicional vs. Enfoque Modernizado Impartido

| Eje Temático Curricular | 📜 Diseño Curricular Oficial (Res. 3828/09) | 🚀 Modernización Aplicada en Classroom (Windows 11 / CLI Actual) | Impacto Didáctico y Técnico |
| :--- | :--- | :--- | :--- |
| **Proceso de Arranque (*Bootstrapping*)** | Concepto general de arranque, sectores de inicio tradicionales (MBR). | **BIOS/UEFI + Boot Configuration Data (`bcdedit`)**<br>- Inspección de almacenes BCD en Windows 11.<br>- Análisis de firmware UEFI y gestión de privilegios elevados (UAC). | Transición de conceptos heredados de MBR a la arquitectura UEFI y BCD actual. |
| **Monitoreo de Recursos y Proceso `dwm.exe`** | Descripción elemental de interfaz de usuario y herramientas gráficas de diagnóstico. | **Análisis del *Overhead* en Windows 11**<br>- Medición del consumo de CPU/RAM/GPU del **Desktop Window Manager (`dwm.exe`)**.<br>- Comparación cuantitativa: Estado A (Efectos visuales/Transparencias) vs. Estado B (Rendimiento). | Comprensión del costo computacional de la aceleración gráfica en sistemas modernos. |
| **Gestión de Procesos y Concurrencia** | Concepto estático de procesos, PCB y prioridades. | **PowerShell & Trabajo Multihilo / Estrés**<br>- Métodos `Start-Process`, `Get-Process`, `Stop-Process`.<br>- Práctica de estrés multinúcleo con `Start-Job` y `[Math]::Sqrt` sobre `$env:NUMBER_OF_PROCESSORS`. | Manipulación en tiempo real de hilos de ejecución (*Threads*) y planificador del Kernel. |
| **Administración por Consola (CLI)** | Comandos genéricos de operación o entorno DOS heredado. | **PowerShell 7 / Windows Terminal (`wt`)**<br>- Manejo de tuberías (*pipelines*), objetos, alias (`ls`, `cd`, `cat`, `ni`, `rm`).<br>- Políticas de ejecución de scripts (`Set-ExecutionPolicy RemoteSigned`). | Capacitación en herramientas de administración y automatización de nivel profesional. |
| **Registro del Sistema (*Registry*)** | Conceptos teóricos de Panel de Control y configuración de núcleo. | **Intervención en el Registro de Windows**<br>- Modificación directa de la clave `FontSmoothing` (anti-aliasing) en `HKEY_CURRENT_USER\Control Panel\Desktop`.<br>- Comando de restauración mediante `reg delete` con modificadores `/va` y `/f`. | Acceso a la "raíz" de la configuración de Windows sin depender únicamente de la GUI. |
| **Metadatos y Seguridad del Sistema de Archivos** | Manejo básico de archivos y directorios. | **Metadatos y Listas de Control de Acceso (ACL)**<br>- Inspección de metadatos con `Get-ItemProperty`.<br>- Gestión de permisos de seguridad mediante `Get-ACL`. | Vinculación del sistema de archivos con los modelos de seguridad NTFS/Linux. |
| **Arquitectura de Interfaces, UX y Ética Digital** | Principios generales de claridad y personalización de pantalla. | **Diseño de Interfaces, Accesibilidad y *Dark Patterns***<br>- Wireframing de herramientas de diagnóstico y Ley de Fitts.<br>- Infraestructura semántica y accesibilidad.<br>- Análisis crítico de *Dark Patterns* (patrones oscuros engañosos). | Formación integral del técnico en diseño, usabilidad y ética tecnológica. |
| **Integración de Saberes y Respuesta a Incidentes** | Evaluaciones escritas tradicionales o monografías. | **Práctica Gamificada: *"Operación Limpieza LSO"***<br>- Simulación de brecha de seguridad y restauración de 9 terminales.<br>- Ejecución de scripts `.ps1`, manipulación de registro y clave maestra en consola web. | Evaluación por resolución de problemas reales y trabajo colaborativo en equipo. |

---

## 🎯 Síntesis del Valor Agregado de la Modernización

1. **Reemplazo de Tecnologías Obsoletas:** Se eliminan referencias a tecnologías en desuso (disquetes, puertos paralelos, impresoras matriciales locales) y se reemplazan por **PowerShell, entornos multihilo, UEFI, registro avanzado y monitoreo de recursos en Windows 11 y Linux**.
2. **Abordaje del Sistema como Objeto de Estudio e Intervención:** Los alumnos no usan el sistema operativo como "usuarios finales", sino como **analistas técnicos de sistemas**, capaces de medir el impacto en hardware (*Overhead*), automatizar tareas por CLI y responder ante incidentes de seguridad.
3. **Formación Profesional Alineada con el Perfil Técnico:** Prepara a los estudiantes de 4.º año de la Tecnicatura para los módulos avanzados de 5.º, 6.º y 7.º año (redes, administración de servidores, virtualización WSL2 y scripting).
