# Actividad de Repaso General - Laboratorio de Sistemas Operativos

Esta actividad de repaso está diseñada para integrar y afianzar todos los conceptos vistos hasta el momento (julio 2026). Resuelvan los siguientes desafíos aplicando la teoría y las herramientas prácticas utilizadas en clase.

## Sección 1: Fundamentos y Arquitectura
1. **Abstracción y Rol del SO:** Explica brevemente por qué decimos que el Sistema Operativo actúa como un "administrador de recursos" y a la vez proporciona una "máquina extendida" o abstracción para el usuario.
2. **Ciclo de Vida de los Procesos:** Describe con tus palabras el viaje de un proceso desde que nace (estado *Nuevo*) hasta que muere (*Terminado*). ¿Qué diferencia hay entre un programa y un proceso?
3. **El Chef y la Cocina:** Utilizando la analogía del restaurante, ¿qué rol cumplen el Kernel, la CPU y la RAM? ¿Qué ocurre cuando un proceso (comensal) consume todos los recursos (CPU-bound)?

## Sección 2: La Consola (CLI) y PowerShell
Imagina que eres un administrador de sistemas y no tienes acceso a la interfaz gráfica. Indica el comando o pipeline de PowerShell necesario para realizar las siguientes acciones:
1. **Navegación y Gestión:** Crear una carpeta llamada `Auditoria_SO` y dentro un archivo de texto llamado `reporte.txt`.
2. **Metadatos:** Consultar los atributos (fecha de creación, tamaño) del archivo `reporte.txt`.
3. **Gestión de Procesos:** Encontrar el proceso que más CPU está consumiendo y forzar su cierre.
4. **Seguridad y Permisos:** Revisar la Lista de Control de Acceso (ACL) de un archivo para saber quién puede modificarlo.

## Sección 3: Arranque, Carga (Bootstrapping) y Diagnóstico
1. **Secuencia de Inicio:** Ordena los siguientes conceptos según ocurren al encender la PC: *Carga del SO, BIOS/UEFI, Boot Manager, Ejecución del Kernel*.
2. **Herramienta BCD:** ¿Para qué sirve el comando `bcdedit` y por qué requiere permisos de administrador?
3. **Diagnóstico de Estrés:** En la Clase 6 corrimos un script de PowerShell que creaba un bucle infinito de cálculos matemáticos para estresar la CPU. ¿Cómo detectas visualmente en el *Monitor de Recursos* que los núcleos lógicos están saturados? ¿Qué comando usas para detener los trabajos en segundo plano?

## Sección 4: Estética, "Overhead" y el Registro de Windows
1. **El Costo del "Brillo":** ¿Qué es el proceso `dwm.exe` (Desktop Window Manager) y por qué su consumo de RAM aumenta al usar transparencias y efectos visuales?
2. **Modificación del Registro:** Si necesitamos mejorar el rendimiento de una PC antigua desactivando el suavizado de fuentes (*FontSmoothing*), ¿en qué ruta (clave) del Editor del Registro (Regedit) debemos intervenir y qué valor hay que modificar?
3. **Intervención vs Rendimiento:** Justifica si estarías dispuesto a sacrificar la accesibilidad o la estética (suavizado de fuentes, animaciones) para ganar rendimiento en un servidor. 

## Sección 5: Experiencia de Usuario (UX) y Dark Patterns
1. **Dark Patterns (Patrones Oscuros):** Define qué es un Dark Pattern. Si un instalador usa uno de estos patrones para instalar "software basura" (bloatware) sin que el usuario se dé cuenta, ¿cómo impactaría esto en el rendimiento general del sistema operativo evaluado en clases anteriores?
2. **Arquitectura de Interfaces:** Al diseñar una herramienta de diagnóstico, ¿por qué es importante tener en cuenta principios como la jerarquía de la información y la *Ley de Fitts*?

---
*Nota: Pueden utilizar las presentaciones y apuntes de las clases 1 a 6, así como sus prácticas previas de PowerShell y Registro de Windows como material de consulta.*
