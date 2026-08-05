# Contexto y Directivas del Proyecto: LSO 4to

## Nivel Educativo y Especialidad
- **Carrera:** Tecnicatura en Informática Personal y Profesional (Educación Técnico-Profesional).
- **Año:** 4to Año.
- **Materia Principal:** Laboratorio de Sistemas Operativos (LSO).

## Carga Horaria y Cronograma de Clases
- **Frecuencia Semanal:** 4 horas semanales de clase.
  - **Miércoles:** 2 horas.
  - **Jueves:** 2 horas.
- **Distribución del 2.º Semestre:**
  - **Agosto a Mediados de Octubre:** Desarrollo de contenidos teóricos-prácticos (Módulos 1 a 4: Almacenamiento, Permisos/Seguridad, Virtualización WSL2 + Bash Scripting, Redes/SSH).
  - **Mediados de Octubre a Fin de Año:** Desarrollo, implementación, pruebas y defensa en laboratorio del **TP Integrador Final** (*Desafío Híbrido y Ciberseguridad*).

## Pilares Didácticos y Tecnológicos Requeridos
1. **Repasos Gamificados con Kahoot (Mínimo 10 Preguntas con 4 Opciones):** 
   - Cada clase desarrollada contará con su cuestionario Kahoot de cierre.
   - **Regla estricta de Kahoot:** Debe tener **siempre al menos 10 preguntas**, cada una con **4 opciones de respuesta** (1 opción correcta y 3 distractores técnicos con fundamentación).
2. **Cuadernos Pedagógicos con NotebookLM:** Se utilizará el cuaderno **"LSO 4to - 2do semestre"** en NotebookLM para cargar y estructurar resúmenes, podcasts/audios explicativos, guías, infografías y materiales compatibles como soporte de aprendizaje interactivo para los alumnos.
3. **Doble Escenario de Hardware (Nodo Tecnológico vs. Netbooks Limitadas):**
   - **Escenario A (Nodo Tecnológico):** Máquinas potentes freezadas -> Entorno Windows 11 + Linux WSL2 + scripts automatizados de setup (`.ps1` / `.sh`).
   - **Escenario B (Contingencia Netbooks Escolares):** En días sin laboratorio potente, las actividades deben tener variantes livianas (PowerShell ligero, scripts Bash ejecutables directamente o simulación de comandos) que funcionen fluido en hardware de bajos recursos.
4. **Organización de Carpetas por Clase:**
   - Cada clase desarrollada de forma individual dentro de un módulo contará con su propia subcarpeta (ejemplo: `2do_semestre/modulo1_almacenamiento/clase1/`, `clase2/`, etc.).
   - Cada carpeta de clase incluirá su guía práctica, script de setup/restauración, materiales para NotebookLM y trivia Kahoot de cierre de 10 preguntas.

## Enfoque y Metodología de Trabajo
1. **Rigor Técnico y Didáctico:** Todos los ejemplos, guías, scripts (PowerShell, Bash, CMD) y explicaciones deben estar alineados con el nivel técnico de 4to año de la tecnicatura (conceptos de Kernel, procesos, recursos, registro, CLI, permisos, virtualización y automatización).
2. **Estructura del Proyecto:**
   - `1er_semestre/`: Fundamentos de SO, CLI, PowerShell básico, Registro de Windows, administración de procesos y recursos.
   - `2do_semestre/`: Almacenamiento, seguridad y permisos, virtualización (WSL2), scripting en Bash, redes/SSH y TP Integrador Final.
   - `contenido_classroom.md`: Planificación y consignas de trabajos prácticos de la materia en Google Classroom.
3. **Estrategia de Entorno (Persistencia):**
   - Persistencia vía Google Drive / Google Classroom o pendrive.
   - Scripts automatizados de Setup (`setup_env.ps1` / `setup_env.sh`) para preparar escenarios en menos de 1 minuto.
