# Cuestionario Digital: Arquitectura de Memoria y Aislamiento en Windows 11
## Módulo 3 — Clase 1: Jerarquía, MMU y Espacio de Direcciones Virtuales
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año

---

> **📋 Formato Optimizado para Google Forms / Google Classroom**  
> *Este documento contiene las 10 preguntas con el orden de preguntas y de opciones (A, B, C, D) **completamente aleatorizado** para evitar la memorización mecánica y facilitar su carga directa en Formularios de Google o su asignación como examen individual en Classroom.*  
> **Puntaje total recomendado:** 100 puntos (10 puntos por pregunta).

---

### ⚙️ Metadatos y Configuración para Google Forms

* **Título del Formulario:** LSO 4.º Año — Evaluación Formativa: Arquitectura de Memoria y VAS en Windows 11
* **Descripción sugerida:** Evaluación técnica sobre la jerarquía de almacenamiento, la Unidad de Manejo de Memoria (MMU), el Espacio de Direcciones Virtuales (VAS) y los anillos de protección Ring 3 / Ring 0.
* **Ajustes de Google Forms recomendados:**
  1. Activar **"Convertir en cuestionario"**.
  2. En *Calificaciones*, seleccionar **"Publicar calificaciones más tarde (después de la revisión manual)"** o **"Inmediatamente después de cada entrega"**.
  3. Marcar todas las preguntas con **Obligatorio** y valor de **10 puntos**.

---

## 📝 Preguntas del Cuestionario (Copiar y Pegar en Google Forms)

---

### Pregunta 1 (10 puntos)
**¿Cuál es la función principal de la Unidad de Manejo de Memoria (MMU) integrada en el microprocesador?**

* [ ] **A)** Aumentar la velocidad del cooler si la RAM se calienta.
* [ ] **B)** Desfragmentar discos mecánicos en segundo plano.
* [ ] **C)** Generar claves de cifrado BitLocker del disco del sistema.
* [ ] **D)** Traducir direcciones virtuales a direcciones físicas de RAM en tiempo real.

---

### Pregunta 2 (10 puntos)
**En Windows 11 (64 bits), ¿cuánto espacio de memoria virtual privada tiene cada proceso de usuario?**

* [ ] **A)** 16 Megabytes.
* [ ] **B)** 2 Gigabytes.
* [ ] **C)** 128 Terabytes.
* [ ] **D)** Exactamente la cantidad de RAM física instalada.

---

### Pregunta 3 (10 puntos)
**¿Qué ocurre si un programa en Ring 3 intenta escribir en una dirección del Kernel (Ring 0)?**

* [ ] **A)** Windows se congela y formatea el disco rígido.
* [ ] **B)** El CPU dispara una Violación de Acceso y Windows cierra el proceso.
* [ ] **C)** La memoria RAM duplica su voltaje automáticamente.
* [ ] **D)** Se permite si el usuario tiene sesión de Administrador.

---

### Pregunta 4 (10 puntos)
**¿Cuál es el límite máximo de memoria que puede direccionar un proceso de 32 bits en su VAS?**

* [ ] **A)** 128 Terabytes.
* [ ] **B)** 640 Kilobytes.
* [ ] **C)** No tiene límite, depende de la RAM física instalada.
* [ ] **D)** 4 Gigabytes (2^32 bytes).

---

### Pregunta 5 (10 puntos)
**¿En qué nivel de privilegio del CPU se ejecutan las aplicaciones de usuario como Chrome o Word?**

* [ ] **A)** Ring 3 (Modo Usuario / User Mode).
* [ ] **B)** Ring 7 (Modo Gráfico).
* [ ] **C)** Ring 0 (Modo Núcleo / Kernel Mode).
* [ ] **D)** Ring -1 (Modo BIOS).

---

### Pregunta 6 (10 puntos)
**En el Administrador de Tareas, ¿dónde se ve si un proceso es de 32 bits o de 64 bits?**

* [ ] **A)** En Historial de aplicaciones, ordenando por consumo de red.
* [ ] **B)** En el panel de configuración de pantalla de Windows.
* [ ] **C)** En la pestaña Inicio, clic derecho en el antivirus.
* [ ] **D)** En la pestaña Detalles, habilitando la columna Plataforma.

---

### Pregunta 7 (10 puntos)
**¿Cuál era el gran defecto del direccionamiento de Memoria Real en sistemas como MS-DOS?**

* [ ] **A)** Los programas tardaban días en encender el monitor.
* [ ] **B)** Un error de puntero podía sobrescribir el Kernel por falta de protección.
* [ ] **C)** Windows borraba archivos si se abrían dos ventanas.
* [ ] **D)** No se podían usar teclados ni ratones.

---

### Pregunta 8 (10 puntos)
**¿Por qué las PCs no usan solo Caché L1 si es miles de veces más rápida que la RAM?**

* [ ] **A)** Porque la memoria caché es incompatible con Windows 11.
* [ ] **B)** Porque el bus al disco no soporta más de 128 MB.
* [ ] **C)** Los chips SRAM son muy costosos de fabricar y disipan mucho calor.
* [ ] **D)** Porque la caché solo almacena letras, no binarios.

---

### Pregunta 9 (10 puntos)
**¿Cuál componente de la jerarquía de memoria tiene el menor tiempo de acceso (menor latencia)?**

* [ ] **A)** Registros internos del procesador (CPU).
* [ ] **B)** Unidad de estado sólido SSD NVMe.
* [ ] **C)** Memoria RAM DDR4 o DDR5.
* [ ] **D)** Memoria Caché de tercer nivel (L3).

---

### Pregunta 10 (10 puntos)
**Si dos programas usan la misma dirección virtual 0x00400000, ¿por qué no colisionan sus datos?**

* [ ] **A)** El CPU mezcla los datos y los separa por contraseñas.
* [ ] **B)** Windows solo permite un programa abierto en RAM a la vez.
* [ ] **C)** Tienen VAS privado y la MMU asigna marcos de RAM física distintos.
* [ ] **D)** Un programa va al disco rígido y el otro a la caché L1.

---

## 🔑 Clave de Respuestas Rápida para el Docente

Esta tabla permite configurar la **Clave de respuestas** (*Answer Key*) y la retroalimentación automática en Google Forms de forma inmediata:

| N.º | Opción Correcta | Contenido de la Respuesta | Justificación Técnica de Corrección |
| :---: | :---: | :--- | :--- |
| **1** | **D** | Traducir direcciones virtuales a direcciones físicas de RAM en tiempo real. | La MMU traduce en hardware las direcciones lógicas a direcciones físicas de memoria RAM. |
| **2** | **C** | 128 Terabytes. | Windows 11 de 64 bits asigna un espacio virtual masivo de 128 TB para cada proceso en modo usuario. |
| **3** | **B** | El CPU dispara una Violación de Acceso y Windows cierra el proceso. | El CPU detecta la discrepancia de privilegios, dispara una Violación de Acceso y Windows finaliza el proceso. |
| **4** | **D** | 4 Gigabytes (2^32 bytes). | Un puntero de 32 bits permite 2^32 combinaciones, limitando el espacio virtual a exactamente 4 GB. |
| **5** | **A** | Ring 3 (Modo Usuario / User Mode). | Las aplicaciones de usuario corren en Ring 3 (Modo Usuario) para aislar el hardware y el sistema. |
| **6** | **D** | En la pestaña Detalles, habilitando la columna Plataforma. | En la pestaña Detalles, la columna Plataforma indica explícitamente si el ejecutable es de 32 o 64 bits. |
| **7** | **B** | Un error de puntero podía sobrescribir el Kernel por falta de protección. | Al compartir el espacio físico sin aislamiento, un error de memoria corrompía el Kernel de MS-DOS. |
| **8** | **C** | Los chips SRAM son muy costosos de fabricar y disipan mucho calor. | La memoria SRAM estática de la caché es sumamente costosa de fabricar e inviable a gran escala. |
| **9** | **A** | Registros internos del procesador (CPU). | Los registros del CPU operan en el núcleo del procesador con latencias menores a 1 nanosegundo. |
| **10** | **C** | Tienen VAS privado y la MMU asigna marcos de RAM física distintos. | Cada proceso tiene su propio espacio virtual privado (VAS) mapeado a marcos físicos distintos. |

---

### 💡 Pasos para Cargar en Google Forms en Menos de 3 Minutos:
1. Crear un formulario en blanco en [Google Forms](https://forms.google.com).
2. Tildar **"Convertir en cuestionario"** en la pestaña de configuración.
3. Para cada una de las 10 preguntas:
   - Copiar el texto de la pregunta.
   - Copiar las 4 líneas de opciones (A, B, C, D) juntas y pegarlas en la primera opción de Google Forms; la plataforma creará automáticamente las 4 opciones individuales.
   - En **Clave de respuesta**, seleccionar la letra correcta indicada en la tabla superior, asignar **10 puntos** y pegar la justificación técnica en el campo de retroalimentación.
