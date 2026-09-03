# 🎮 Kahoot: Almacenamiento y Dispositivos de Bloque en Linux
**Materia:** Laboratorio de Sistemas Operativos — 4.º Año Técnico
**Temas:** Presentaciones "Almacenamiento en Linux" y "Ejercicios 2 - 5 (Laboratorio)"

Este documento contiene un cuestionario de **10 preguntas** optimizado para importar o escribir directamente en Kahoot!. Todas las preguntas y respuestas respetan estrictamente los límites de caracteres de Kahoot!:
* **Límite de caracteres por Pregunta:** Máximo 120 caracteres.
* **Límite de caracteres por Opción:** Máximo 75 caracteres.

---

### ❓ Pregunta 1 (Conceptos)
* **Pregunta (91 caracteres):**
  ¿Cómo se llama la carpeta donde se "ancla" un disco físico en el árbol jerárquico de Linux?
* **Opciones:**
  * [A] Letra de unidad
  * [B] Enlace de bloque
  * [C] **Punto de montaje** *(Correcta)*
  * [D] Nodo de dispositivo
* **Tiempos de respuesta sugerido:** 20 segundos

---

### ❓ Pregunta 2 (Permisos POSIX)
* **Pregunta (85 caracteres):**
  ¿Qué valor numérico representa los permisos de Lectura y Escritura juntos en Linux?
* **Opciones:**
  * [A] 5
  * [B] 4
  * [C] 7
  * [D] **6** *(Correcta, r=4 + w=2)*
* **Tiempos de respuesta sugerido:** 20 segundos

---

### ❓ Pregunta 3 (Laboratorio dd)
* **Pregunta (97 caracteres):**
  En el comando `dd if=/dev/zero of=disco.img bs=1M count=256`, ¿qué indica el parámetro "bs=1M"?
* **Opciones:**
  * [A] **El tamaño de cada bloque copiado a la vez** *(Correcta)*
  * [B] El espacio máximo final del archivo
  * [C] La cantidad total de bloques a escribir
  * [D] El modo de velocidad de transferencia
* **Tiempos de respuesta sugerido:** 30 segundos

---

### ❓ Pregunta 4 (Seguridad umask)
* **Pregunta (84 caracteres):**
  ¿Qué hace exactamente la máscara "umask" al crear un nuevo archivo o carpeta en Linux?
* **Opciones:**
  * [A] Asigna permisos de ejecución obligatorios
  * [B] Suma permisos de administrador (root)
  * [C] **Resta o quita permisos por defecto** *(Correcta)*
  * [D] Cambia el grupo propietario del archivo
* **Tiempos de respuesta sugerido:** 20 segundos

---

### ❓ Pregunta 5 (Laboratorio fdisk)
* **Pregunta (109 caracteres):**
  ¿Con qué tecla guardas definitivamente los cambios y escribes la tabla de particiones al salir de fdisk?
* **Opciones:**
  * [A] q
  * [B] p
  * [C] g
  * [D] **w** *(Correcta, de write)*
* **Tiempos de respuesta sugerido:** 20 segundos

---

### ❓ Pregunta 6 (Sistemas de Archivos)
* **Pregunta (104 caracteres):**
  ¿Qué sistema de archivos de Linux ofrece snapshots y funcionalidad de copia al escribir (Copy-on-Write)?
* **Opciones:**
  * [A] Ext4
  * [B] **Btrfs** *(Correcta)*
  * [C] XFS
  * [D] NTFS
* **Tiempos de respuesta sugerido:** 20 segundos

---

### ❓ Pregunta 7 (Laboratorio Swap en GPT)
* **Pregunta (98 caracteres):**
  En fdisk para tablas GPT, ¿qué código numérico se ingresa para cambiar el tipo a "Linux swap"?
* **Opciones:**
  * [A] 82
  * [B] 83
  * [C] **19** *(Correcta)*
  * [D] 7
* **Tiempos de respuesta sugerido:** 20 segundos

---

### ❓ Pregunta 8 (Laboratorio losetup)
* **Pregunta (73 caracteres):**
  ¿Qué hace el modificador "-P" en el comando `losetup -Pf disco_lab.img`?
* **Opciones:**
  * [A] **Escanea la imagen y crea nodos de particiones internas** *(Correcta)*
  * [B] Protege el archivo de escrituras accidentales
  * [C] Formatea de manera rápida el disco virtual
  * [D] Desvincula el dispositivo loop del Kernel
* **Tiempos de respuesta sugerido:** 30 segundos

---

### ❓ Pregunta 9 (Permisos POSIX)
* **Pregunta (102 caracteres):**
  ¿Cuáles son las tres categorías fijas de usuarios que componen el esquema clásico de permisos POSIX?
* **Opciones:**
  * [A] Administrador, Alumnos y Profesores
  * [B] Read (lectura), Write (escritura) y Execute (ejecución)
  * [C] System (sistema), User (usuario) y Guest (invitado)
  * [D] **Owner (dueño), Group (grupo) y Others (otros)** *(Correcta)*
* **Tiempos de respuesta sugerido:** 20 segundos

---

### ❓ Pregunta 10 (Laboratorio Nomenclatura)
* **Pregunta (100 caracteres):**
  ¿Cómo identifica el Kernel la primera partición del dispositivo de bloque virtual "/dev/loop0"?
* **Opciones:**
  * [A] /dev/loop0s1
  * [B] **/dev/loop0p1** *(Correcta)*
  * [C] /dev/loop01
  * [D] /dev/loop0-1
* **Tiempos de respuesta sugerido:** 20 segundos
