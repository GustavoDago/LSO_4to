# Guía de Actividades de Laboratorio N.º 1: Arquitectura de Memoria y Aislamiento en Windows 11
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
### Módulo 3: Arquitectura y Administración de Memoria — Clase 1

---

* **Estudiante(s):** __________________________________________________
* **Fecha:** ___ / ___ / 2026
* **Terminal / Equipo N.º:** ________
* **Sistema Operativo:** Windows 11

---

## 🎯 Objetivos de Aprendizaje
1. Auditar en tiempo real la jerarquía de memorias del hardware físico (Cachés L1/L2/L3 y memoria RAM) utilizando el Administrador de Tareas de Windows.
2. Identificar la diferencia operativa y de direccionamiento entre procesos de 32 bits y 64 bits en Windows 11.
3. Comprender el mecanismo de aislamiento de memoria y las consecuencias técnicas de una Violación de Acceso (*Access Violation*) al violar los anillos de protección Ring 3 / Ring 0.
4. Relacionar las latencias relativas de los niveles de almacenamiento con el rendimiento del sistema operativo.

---

## 🧭 Requisitos Previos y Herramientas
* Computadora del laboratorio con Windows 11 (no requiere descongelar Deep Freeze ni privilegios de administrador).
* Herramienta principal: **Administrador de Tareas de Windows** (`taskmgr.exe`).

---

## 🔬 Parte 1: Auditoría de la Jerarquía de Memorias en Hardware Real

1. Abrí el Administrador de Tareas presionando simultáneamente las teclas:  
   `Ctrl` + `Shift` + `Esc`  
   *(Si se abre en vista compacta, hacé clic en "Más detalles" en la parte inferior).*
2. En la barra lateral izquierda, seleccioná el ícono de **Rendimiento** (gráfico de pulsos) y luego hacé clic en **CPU**.
3. En la esquina inferior derecha de la ventana, registrá los valores de memoria caché de tu procesador:

| Parámetro de CPU | Valor Detectado en la Terminal |
| :--- | :--- |
| **Modelo exacto del Procesador:** | |
| **Caché L1:** | |
| **Caché L2:** | |
| **Caché L3:** | |
| **Núcleos físicos / Procesadores lógicos:** | |

4. En la misma pestaña de **Rendimiento**, seleccioná ahora **Memoria**:

| Parámetro de Memoria RAM | Valor Detectado en la Terminal |
| :--- | :--- |
| **Capacidad Total de RAM Física:** | |
| **Velocidad de la memoria:** | ____________ MHz / MT/s |
| **Ranuras usadas:** | _____ de _____ |
| **Memoria reservada para hardware:** | |

### 📝 Pregunta de Análisis 1:
Observando los valores que anotaste: ¿Por qué la memoria caché L1 mide apenas unos pocos Kilobytes y la memoria RAM varios Gigabytes? Si la memoria caché es miles de veces más rápida, ¿por qué los fabricantes de computadoras no fabrican toda la memoria de la máquina usando memoria caché? Justificá con la relación costo/velocidad del Tema 1.

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  

---

## 🔬 Parte 2: Procesos de 32 bits vs. 64 bits en el Espacio de Direcciones (VAS)

1. En el Administrador de Tareas, dirigite a la pestaña **Detalles** (ícono de lista con viñetas).
2. Hacé clic derecho sobre la cabecera de cualquier columna (por ejemplo, sobre *Nombre*) y seleccioná la opción **Elegir columnas**.
3. Activá las siguientes tres casillas y presioná **Aceptar**:
   * ☑ **Plataforma**
   * ☑ **Tamaño de espacio de trabajo**
   * ☑ **Memoria confirmada**
4. Recorré la lista de procesos en ejecución. Localizá al menos un proceso cuya plataforma sea de **32 bits** y otro cuya plataforma sea de **64 bits**, y registrá sus datos:

| Nombre del Ejecutable | PID | Plataforma (32 o 64 bits) | Espacio de Trabajo (RAM Física) | Límite Máximo Teórico de su VAS |
| :--- | :---: | :---: | :---: | :---: |
| | | **32 bits** | | |
| | | **64 bits** | | |

### 📝 Pregunta de Análisis 2:
Si el proceso de 32 bits que encontraste fuera un programa de edición de video e intentara cargar un archivo de 6 GB en su memoria de un solo golpe, ¿qué sucedería con la aplicación aunque la computadora tenga 16 GB de RAM física? Justificá utilizando el límite de direccionamiento de $2^{32}$ bytes.

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  

---

## 🔬 Parte 3: Estudio de Casos Clínicos de Seguridad y Aislamiento

Leé atentamente los dos casos técnicos a continuación y respondé basándote en la teoría de la MMU y los anillos de protección del procesador:

### Caso A: El Puntero Descontrolado
Un estudiante de programación compila un programa en C++. Por un error en una variable de puntero, el programa intenta escribir datos directamente en la dirección física de memoria `0xFFFF800000000000` (perteneciente al Kernel de Windows).
1. ¿Qué circuito de hardware del microprocesador intercepta de inmediato esta instrucción antes de que llegue a la memoria RAM?  
   *Respuesta:* ____________________________________________________________________
2. ¿Por qué el procesador no permite que un programa en **Modo Usuario (Ring 3)** escriba en esa zona?  
   *Respuesta:* ____________________________________________________________________
3. ¿Qué acción toma el Sistema Operativo Windows con el programa del estudiante?  
   *Respuesta:* ____________________________________________________________________

### Caso B: Aislamiento entre Navegadores
Tenés abiertas simultáneamente dos ventanas del navegador: en una estás viendo tu correo electrónico institucional y en la otra estás jugando un juego en línea en una página web desconocida. Ambas aplicaciones utilizan internamente la misma dirección virtual relativa `0x00401000`.
1. ¿Es posible que el juego en línea lea las contraseñas que el correo tiene cargadas en la memoria RAM? ¿Por qué?
2. Explicá cómo la **MMU** y el **Espacio de Direcciones Virtuales privado** impiden que los procesos se espíen o se sobrescriban mutuamente.

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  

---

## 🔬 Parte 4: Desafío de Cálculo de Latencias a Escala Humana

Imaginá que un ciclo de reloj de la CPU (1 nanosegundo) equivale a **1 segundo** en la vida real. Completá la siguiente tabla de equivalencias a escala humana basándote en la tabla del manual teórico:

| Nivel de Memoria | Tiempo Real de Acceso | Equivalente a Escala Humana |
| :--- | :--- | :--- |
| **Registros del CPU** | < 1 nanosegundo | **1 segundo** |
| **Caché L1** | ~1 nanosegundo | |
| **Caché L3** | ~10 - 20 nanosegundos | |
| **Memoria RAM DDR4/DDR5** | ~50 - 100 nanosegundos | |
| **Unidad SSD NVMe** | ~0.05 - 0.1 milisegundos | |
| **Disco Rígido Mecánico (HDD)**| ~10 milisegundos | |

### 📝 Conclusión Técnica Final:
Teniendo en cuenta que ir a buscar un dato al disco mecánico equivale a esperar **meses** comparado con los **segundos** del procesador, ¿por qué es tan importante la arquitectura de memoria del sistema operativo para que la computadora se sienta rápida y fluida para el usuario?

> **Conclusión:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________  
