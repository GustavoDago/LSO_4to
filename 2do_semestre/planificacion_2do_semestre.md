# Planificación Pedagógica y Didáctica: 2.º Semestre (LSO 4.º Año)
## Tecnicatura en Informática Personal y Profesional

* **Asignatura:** Laboratorio de Sistemas Operativos (LSO)
* **Año:** 4.º Año
* **Carga Horaria Semanal:** 4 Horas Reloj / Cátedra
  * 🔹 **Miércoles:** 2 horas (Teoría Aplicada & Laboratorio 1)
  * 🔹 **Jueves:** 2 horas (Laboratorio 2 & Desafíos Prácticos)
* **Sistemas Operativos Objeto de Estudio:** Windows 11 (Administración Técnica Nativa, CLI y Herramientas Clínicas del Sistema)
* **Entorno de Laboratorio:** Computadoras con Windows 11 Home freezadas (Deep Freeze) sin credenciales de administración. Enfoque 100% Windows nativo sin dependencia de booteo externo.

---

## 🎯 Fundamentación y Estrategia de Entorno (Transición a 100% Windows Nativo)

Tras la experiencia de la Clase 1 de almacenamiento en Linux mediante Live USB con persistencia, se evidenciaron dificultades operativas severas inherentes a las restricciones del laboratorio escolar (equipos congelados con Deep Freeze, disparidad de interfaces UEFI/BIOS, bloqueos de booteo externo y latencia en unidades USB). Asimismo, dada la necesidad de consolidar competencias técnicas sin requerir formación en programación/scripting algorítmico prematuro, **se toma la decisión pedagógica y técnica de concentrar el 100% del segundo semestre en el ecosistema Windows 11**.

La estrategia operativa se redefine para garantizar máxima fluidez y tiempo efectivo de clase:

1. **Operación Nativa en Windows 11 Host:**
   * Prácticas ejecutadas directamente sobre el sistema anfitrión utilizando herramientas técnicas consolidadas: `diskpart`, VHDs dinámicos, arquitectura NTFS, listas de control de acceso (`icacls`, `Get-ACL`), Administrador de Tareas, Monitor de Recursos (`resmon.exe`) y `netsh`.
   * Se elimina la dependencia del arranque por Live USB y la complejidad de sintaxis de programación (Bash), priorizando el análisis arquitectónico del sistema operativo.
2. **Persistencia Híbrida (USB de Datos + Cloud):** Los alumnos utilizan sus pendrives exclusivamente como unidades de almacenamiento de datos y respaldos (Google Drive / Google Classroom) sin requerir particiones de booteo complejas.
3. **Scripts de Setup Inmediatos (< 1 Minuto):** Cada práctica cuenta con scripts Batch (`setup_claseX.bat`) o PowerShell ligeros que preparan y restauran los escenarios de laboratorio de forma instantánea sin romper la congelación del Deep Freeze.

---

## 🎮 Herramientas Pedagógicas e Infraestructura Flexible

* **Gamificación con Kahoot (10 Preguntas con 4 Opciones):** Cada clase desarrollada incluye una trivia de repaso lúdico al inicio o cierre con al menos 10 preguntas de opción múltiple (1 correcta y 3 distractores técnicos justificados) para fijar conceptos clave y diagnósticos técnicos.
* **Integración con NotebookLM:** Se proveen guías, podcasts/audios explicativos, infografías y cuestionarios integrables al cuaderno digital **"LSO 4to - 2do semestre"** en NotebookLM para facilitar el estudio interactivo y autónomo.
* **Flexibilidad de Hardware (Plan de Contingencia Netbooks):**
  * **Modo A (Laboratorio Principal Windows 11):** Prácticas completas con discos VHDX, monitoreo detallado de memoria con `resmon.exe`, inspección de pools del Kernel y seguridad local.
  * **Modo B (Contingencia Netbooks Escolares):** Prácticas optimizadas de baja huella de memoria con VHDs de tamaño reducido (128 MB) y comandos CLI directos.

---

## 📅 Cronograma Calendario Semanal (4 hs/semana: Miércoles y Jueves)

### 🗓️ Bloque I: Desarrollo de Contenidos (Agosto a Mediados de Octubre)

* **Semanas 1 y 2 (Agosto) — Almacenamiento y Seguridad Inicial en Windows:**
  * **Módulo 1 (Almacenamiento en Windows - 4 hs):**
    * *Clase 1 (2 hs):* Discos físicos y lógicos, MBR vs GPT, discos virtuales VHD/VHDX dinámicos con `diskpart`.
    * *Clase 2 (2 hs):* Sistemas de archivos, arquitectura NTFS, creación de volúmenes y formateo con `diskpart`.
  * **Módulo 2 (Seguridad y Permisos en Windows - 4 hs):**
    * *Clase 1 (2 hs):* Cuentas de usuario locales, grupos de seguridad, SIDs, base SAM y Control de Cuentas de Usuario (UAC).
    * *Clase 2 (2 hs):* Permisos NTFS, Listas de Control de Acceso (DACL/ACEs), herencia (`icacls`), toma de posesión (`takeown`) y precedencia Deny/Allow.

* **Semanas 3 y 4 (Agosto / Septiembre) — Transición y Cierre de Bloque Almacenamiento/Seguridad:**
  * Consolidación de prácticas de almacenamiento virtual (VHD) y listas de control de acceso NTFS sobre terminales del laboratorio.
  * Análisis comparativo conceptual de sistemas de archivos y modelos de seguridad (FAT32 vs NTFS vs POSIX en teoría).

* **Semanas 5 y 6 (Septiembre) — Módulo 3: Arquitectura y Administración de Memoria Real y Virtual en Windows:**
  * *Clase 1 (2 hs - Miércoles):* **Formación Teórica Magistral de Memoria en Windows:** Jerarquía de memoria, la ilusión de la memoria virtual, rol de la MMU, Espacio de Direcciones Virtuales (VAS de 32 y 64 bits, modo Usuario vs modo Kernel), Paginación (marcos y páginas de 4 KB, Page Tables), Fallos de Página (*Soft* vs *Hard Page Faults*), el archivo `pagefile.sys`, y Pools del Kernel (*Paged* vs *Non-Paged Pool*).
  * *Clase 2 (2 hs - Jueves):* **Diagnóstico Clínico y Monitoreo de Memoria:** Análisis de métricas en Administrador de Tareas y Monitor de Recursos (`resmon.exe`): memoria en uso, en espera (*Standby*), libre y modificada. Límite de compromiso (*Commit Limit*), detección de cuellos de botella por swapping y fugas de memoria (*memory leaks*).

* **Semanas 7 y 8 (Septiembre / Octubre) — Módulo 4: Redes Locales, Recursos Compartidos y Seguridad en Windows:**
  * *Clase 1 (2 hs - Miércoles):* Pila TCP/IP, direccionamiento IPv4, resolución de nombres (DNS/NetBIOS), diagnóstico de conectividad (`ipconfig`, `ping`, `tracert`, `Test-NetConnection`).
  * *Clase 2 (2 hs - Jueves):* Grupos de trabajo, recursos compartidos mediante SMB (`net share`, `net use`), combinación de permisos compartidos vs permisos NTFS, y filtrado con Windows Defender Firewall (`netsh advfirewall`).

* **Semana 9 (Mediados de Octubre) — Integración y Evaluación:**
  * *Clase 1 (2 hs - Miércoles):* Taller práctico de integración de almacenamiento, permisos, diagnóstico de memoria y conectividad.
  * *Clase 2 (2 hs - Jueves):* Evaluación teórica/práctica integradora de los Módulos 1 al 4.

---

### 🏆 Bloque II: Proyecto Integrador Final (Mediados de Octubre a Fin de Año)

* **Semanas 10 a 14 (Mediados de Octubre a Noviembre / Diciembre):** **Desafío de Auditoría, Diagnóstico y Ciberseguridad en Windows**
  * *Fase 1 (Semana 10):* Inyección del escenario de incidentes en Windows: diagnóstico de discos, particiones alteradas y permisos comprometidos.
  * *Fase 2 (Semana 11):* Remediación de almacenamiento (reconstrucción de VHDs y volúmenes NTFS) y reestructuración de ACLs con `icacls`.
  * *Fase 3 (Semana 12):* Detección y mitigación de procesos anomalos que saturan la memoria virtual, análisis con `resmon.exe` y optimización de paginación.
  * *Fase 4 (Semana 13):* Configuración de carpetas compartidas seguras en red local, auditoría de accesos y reglas de Windows Firewall con `netsh`.
  * *Fase 5 (Semana 14):* Pruebas de validación global, entrega de documentación técnica y **defensa práctica en vivo en la terminal del laboratorio**.

---

## 📋 Resumen por Módulo

### 📁 Módulo 1: Almacenamiento y Sistemas de Archivos en Windows 11
* **Contenidos:** Estructura de particiones (MBR vs GPT), sistemas de archivos (NTFS, FAT32, exFAT), volúmenes simples, montaje de unidades VHD/VHDX dinámicas, arquitectura de la tabla MFT.
* **Herramientas & Comandos:** `diskpart`, `Get-Disk`, `Get-Partition`, `Format-Volume`.

### 📁 Módulo 2: Seguridad, Permisos y Gestión de Usuarios en Windows
* **Contenidos:** Cuentas de usuario y grupos locales, identificadores de seguridad (SID), base SAM, elevación con UAC, arquitectura de permisos NTFS, DACL/ACEs, herencia y precedencia.
* **Herramientas & Comandos:** `icacls`, `Get-ACL`, `Set-ACL`, `takeown`, `net user`, `net localgroup`, `whoami /all`.

### 📁 Módulo 3: Arquitectura y Administración de Memoria Real y Virtual en Windows
* **Contenidos:** Jerarquía de almacenamiento, memoria física vs virtual, MMU, Espacio de Direcciones Virtuales (User vs Kernel Mode), paginación (4 KB), tablas de páginas, fallos de página suaves y duros, archivo `pagefile.sys`, Pools de Kernel (Paged y Non-Paged), métricas de rendimiento y diagnóstico en el Monitor de Recursos (`resmon.exe`).
* **Herramientas & Diagnóstico:** Administrador de Tareas (Pestaña Rendimiento/Memoria), Monitor de Recursos (`resmon.exe`), `systeminfo` (memoria virtual disponible/total).

### 📁 Módulo 4: Redes Locales, Recursos Compartidos y Seguridad en Windows
* **Contenidos:** Configuración de red IPv4, resolución de nombres, grupos de trabajo, recursos compartidos SMB, permisos compartidos vs NTFS, mapeo de unidades de red, firewall de Windows.
* **Herramientas & Comandos:** `ipconfig`, `ping`, `tracert`, `Test-NetConnection`, `net share`, `net use`, `netsh advfirewall`.

### 📁 Módulo 5: TP Integrador Final Gamificado
* **Título:** *"Desafío Integrador: Infraestructura y Ciberseguridad en Windows"*
* **Dinámica:** Simulación de un entorno de red de laboratorio Windows 11 desconfigurado tras una brecha de seguridad. Los alumnos deben diagnosticar el estado del almacenamiento, reconstruir permisos NTFS, resolver cuellos de botella de memoria y asegurar recursos compartidos en red.
