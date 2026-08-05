# Comparativa: Diseño Curricular Oficial vs. Contenidos Impartidos en Google Classroom (1.er Semestre - LSO 4.º Año)

---

## 📊 Matriz Comparativa de Cobertura

| Núcleo de Contenidos del Diseño Curricular (Res. 3828/09) | Estado en Google Classroom (1.er Semestre) | Evidencia de Trabajos Prácticos / Clases Impartidas |
| :--- | :---: | :--- |
| **Concepto de SO, Funciones y Abstracción del Hardware** | 🟢 **100% Cubierto** | Tarea *Análisis del Entorno Digital*, Evaluación Clase 1, Tarea *Evolución de los Sistemas Operativos*. |
| **Gestión de Procesos (PCB, PIDs, Estados del proceso)** | 🟢 **100% Cubierto** | *Gestión de Procesos con PowerShell* (`Start-Process`, `Get-Process`, `Stop-Process`), *Administración de Procesos y Gestión de Recursos*. |
| **Núcleo (Kernel), Hilos (*Threads*) y *Syscalls*** | 🟢 **100% Cubierto** | *Archivo script de comandos PowerShell* (`Threads`, `WorkingSet`, `syscalls`), *Clase 5: Exploración del Kernel*. |
| **Proceso de Arranque y Carga (*Bootstrapping* / BIOS / UEFI)** | 🟢 **100% Cubierto** | *Arranque y Carga (Bootstrapping)* ("Crisis en la cocina"), *Arranque y Carga - Finalización* (`bcdedit`, BIOS/UEFI, permisos admin). |
| **Sistema de Archivos y Metadatos en CLI** | 🟢 **100% Cubierto** | *El Mensaje Encriptado* (`New-Item`, `Add-Content`, `Get-Content`), *Práctica PowerShell - Metadatos* (`Get-ItemProperty`, `Get-ACL`, `Get-ChildItem`). |
| **Interfaz de Usuario (Overhead de GUI vs. CLI, DWM)** | 🟢 **100% Cubierto** | *Unidad 3 - Clase 1: Análisis del Overhead en Windows 11* (medición de CPU/RAM, `dwm.exe`), *Práctica de Explorador de Windows*. |
| **Diseño de Interfaces, Ergonomía y Accesibilidad** | 🟢 **100% Cubierto** | *Tarea 1: Wireframing y Ley de Fitts*, *Clase 4: Accesibilidad e Infraestructura Semántica*, *Clase 5: Dark Patterns*. |
| **Registro de Windows (`HKEYs`, configuración de Kernel)** | 🟢 **100% Cubierto** | *Clase 3: Fuentes y Registro* (modificación de `FontSmoothing` en `HKEY_CURRENT_USER\Control Panel\Desktop`), *Registro de Windows (El ADN de Windows)*. |
| **Diagnóstico Avanzado y Concurrencia (Trabajos en 2.º plano)** | 🟢 **100% Cubierto** | *Clase 6: Diagnóstico Técnico mediante Herramientas Avanzadas* (`Start-Job`, `Get-Job`, `Stop-Job`, bucles de estrés con `[Math]::Sqrt`). |
| **Auditoría, Respuesta a Incidentes y Seguridad Aplicada** | 🟢 **100% Cubierto** | *Operación "Limpieza LSO"* (actividad gamificada de respuesta a incidentes en 9 terminales, script `setup_practica1.ps1`, `desbloquear.html`). |
| **Evaluaciones e Integración de Saberes del 1.er Semestre** | 🟢 **100% Cubierto** | *Evaluación 30/4*, *Tareas de repaso*, *Ensayo de evaluación* y *Evaluación Integradora final de 1er semestre (Temas A, B y C)*. |

---

## 🔍 Hallazgos Principales

1. **Alineación 100% Rigurosa:**  
   El contenido publicado en Google Classroom cumple de manera exacta y completa con los contenidos mínimos de 4.º año prescritos por la Resolución 3828/09 para la Tecnicatura en Informática Personal y Profesional.

2. **Enfoque Clínico y Práctico con PowerShell:**  
   A diferencia de un abordaje puramente teórico, en el 1.er semestre se profundizó la manipulación directa del sistema mediante PowerShell (`Get-Process`, `Start-Job`, `Get-ACL`, `Get-ItemProperty`, `bcdedit`, `Set-ExecutionPolicy`).

3. **Innovación en Interfaces, UX y Análisis de Overhead:**  
   Se incluyeron aspectos de diseño de interfaces técnicas (Ley de Fitts, Wireframing, auditoría de UX), accesibilidad y el impacto en rendimiento (*Overhead*) del renderizado de ventanas (`dwm.exe`).

4. **Gamificación y Respuesta a Incidentes:**  
   La *Operación "Limpieza LSO"* integró todos los saberes de diagnóstico de servicios, modificación de Registro y automatización en un escenario simulado de brecha de seguridad.
