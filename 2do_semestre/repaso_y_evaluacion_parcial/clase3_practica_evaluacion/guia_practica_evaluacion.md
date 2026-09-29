# Guía de Práctica / Simulacro Parcial Rápido (Clase 3)
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional — Ciclo 2026

---

## 📋 Información y Pautas de la Práctica

* **Modalidad:** Simulacro práctico de entrenamiento para la evaluación parcial.
* **Tiempo Estimado:** 45 a 60 minutos.
* **Estructura Reducida:**
  * 📝 **Parte 1 (Conceptos Clave):** 2 preguntas teóricas breves y concretas (3 Puntos).
  * 💻 **Parte 2 (Desafío en Consola):** 2 tareas prácticas integradoras con **2 capturas de pantalla obligatorias** (7 Puntos).
* **Entrega:** Completar la plantilla simplificada al final de esta guía y adjuntar las 2 capturas en Google Classroom.

---

## 📝 PARTE 1: Conceptos Clave (3 Puntos)

*Responde de manera sintética y con vocabulario técnico en tu hoja o documento:*

1. **Almacenamiento y Seguridad (1.5 Puntos):**
   * ¿Por qué en un disco de más de 2 TB es obligatorio usar el esquema **GPT** en lugar de **MBR**?
   * Si en una carpeta la lista de permisos (DACL) tiene para tu usuario un permiso de **Denegar (Deny)** y a la vez pertenece a un grupo con **Permitir (Allow)**, ¿puedes ingresar? Explica qué regla de precedencia se aplica.

2. **Memoria y Diagnóstico (1.5 Puntos):**
   * ¿Cuál es la diferencia entre la **Memoria RAM física (Working Set)** de un proceso y su **Memoria Virtual comprometida (Pagefile / Commit Size)**?
   * ¿Qué es un **Hard Page Fault** (fallo de página duro) y por qué degrada el rendimiento del equipo si ocurre con alta frecuencia?

---

## 💻 PARTE 2: Desafío Práctico en Consola (7 Puntos)

---

### 🔲 Tarea 1: Aprovisionamiento y Seguridad en CMD (3.5 Puntos)

> **Objetivo:** Crear una unidad virtual formateada en NTFS y configurar el control de accesos restringido.

1. Abre **CMD** como Administrador.
2. Inicia `diskpart` y ejecuta la siguiente secuencia rápida:
   ```cmd
   diskpart
   create vdisk file="C:\disco_practica.vhdx" maximum=128 type=expandable
   select vdisk file="C:\disco_practica.vhdx"
   attach vdisk
   convert gpt
   create partition primary
   format fs=ntfs label="PRACTICA" quick
   assign letter=V
   exit
   ```
3. En la misma consola CMD, crea un directorio protegido y desactiva la herencia de permisos:
   ```cmd
   mkdir V:\AreaProtegida
   icacls V:\AreaProtegida /inheritance:d
   icacls V:\AreaProtegida /remove "Usuarios"
   icacls V:\AreaProtegida
   ```

> 📸 **CAPTURA N.º 1 (CMD):**  
> Muestra en la ventana de CMD la salida final del comando `icacls V:\AreaProtegida` donde se verifique que la herencia fue desactivada (`inheritance:d`) y los permisos asignados en la unidad `V:`.

---

### 🟦 Tarea 2: Auditoría y Diagnóstico de Memoria en PowerShell (3.5 Puntos)

> **Objetivo:** Auditar la nueva unidad y diagnosticar los procesos con mayor consumo de memoria física en el sistema.

1. Abre **PowerShell** como Administrador.
2. Ejecuta el cmdlet para verificar el sistema de archivos del volumen `V`:
   ```powershell
   Get-Volume -DriveLetter V | Select-Object DriveLetter, FileSystemLabel, FileSystem, SizeRemaining
   ```
3. Ejecuta el pipeline de diagnóstico para listar los **5 procesos que más memoria RAM consumen**, convirtiendo los bytes a Megabytes (MB):
   ```powershell
   Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 Id, ProcessName, @{Name="RAM_MB"; Expression={[math]::Round($_.WorkingSet64 / 1MB, 2)}} | Format-Table -AutoSize
   ```

> 📸 **CAPTURA N.º 2 (PowerShell):**  
> Muestra en la consola de PowerShell la salida combinada de `Get-Volume` (confirmando el volumen `V:` NTFS) y la tabla de los 5 procesos con mayor consumo de memoria en MB.

---

## 📊 Criterios de Evaluación

| Tarea | Criterio de Logro | Puntaje |
| :--- | :--- | :---: |
| **Parte 1 — Teoría** | Justificación concisa de GPT vs MBR, regla *Deny > Allow*, y RAM física vs virtual. | **3.0 pts** |
| **Parte 2 — Captura 1 (CMD)** | Creación de VHDX en GPT/NTFS montado en `V:` + corte de herencia con `icacls`. | **3.5 pts** |
| **Parte 2 — Captura 2 (PowerShell)** | Verificación de volumen con `Get-Volume` y diagnóstico de memoria con `Get-Process`. | **3.5 pts** |
| **TOTAL** | **Calificación de la Práctica** | **10.0 PUNTOS** |

---

## 📋 Plantilla Rápida de Entrega (Google Docs / Classroom)

```markdown
# Práctica / Simulacro Parcial — LSO 4.º Año
**Estudiante:** [Apellido y Nombre] | **Puesto PC:** PC N.º _____ | **Fecha:** ___/___/2026

### 📝 Respuestas Teóricas (En evaluación se responderá en hojas de papel, no en la computadora)
1. **GPT vs MBR y Regla Deny:**
   * [Respuesta breve]
2. **RAM Física vs Virtual y Hard Fault:**
   * [Respuesta breve]

---

### 💻 Evidencias Prácticas

#### Captura N.º 1: Configuración en CMD (`diskpart` + `icacls`)
[ Pegar aquí Captura N.º 1 de CMD con salida de icacls ]

#### Captura N.º 2: Auditoría y Diagnóstico en PowerShell (`Get-Volume` + `Get-Process`)
[ Pegar aquí Captura N.º 2 de PowerShell con Get-Volume y Top 5 procesos ]
```
