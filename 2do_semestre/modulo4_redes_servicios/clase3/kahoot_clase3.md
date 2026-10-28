# Cuestionario Gamificado Kahoot: El Portero y su Lista
## Módulo 4 — Clase 3: Reglas de Entrada y Salida del Firewall
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año

---

### 📋 Estructura y Criterios de Calidad Pedagógica
* **Total de Preguntas:** 10
* **Opciones por Pregunta:** 4 (1 Opción Correcta y 3 Distractores Técnicos Fundamentados)
* **Límites de Caracteres Kahoot:** Pregunta ≤ 120 caracteres | Cada respuesta ≤ 75 caracteres
* **Lenguaje:** cotidiano y directo, pensado para alumnos de 16 años; sin siglas sin explicar.
* **Diseño Antisesgo:** longitudes parecidas, correcta repartida entre A, B, C y D.

---

### ❓ Pregunta 1
**En nuestra analogía, ¿qué es una regla del firewall?**

* **A)** El timbre de un departamento
* **B)** Un renglón de la lista del portero ✔️ *(Opción Correcta)*
* **C)** La dirección del edificio
* **D)** El vecino que atiende la puerta

> **Fundamentación Pedagógica:**
> * *Distractor A:* El timbre representa al puerto, no a la regla.
> * **Opción B (Correcta):** Cada regla es una instrucción de la lista que el firewall consulta para decidir.
> * *Distractor C:* La dirección del edificio representa a la dirección IP.
> * *Distractor D:* El vecino representa al programa que escucha en el puerto.

---

### ❓ Pregunta 2
**Por defecto, ¿qué hace Windows con una conexión que ENTRA y no tiene ninguna regla?**

* **A)** La deja pasar sin revisar
* **B)** Le pregunta al usuario qué hacer
* **C)** La bloquea sin avisar ✔️ *(Opción Correcta)*
* **D)** La guarda para revisarla después

> **Fundamentación Pedagógica:**
> * *Distractor A:* Dejar pasar sin regla es lo que ocurre con la salida, no con la entrada.
> * *Distractor B:* El firewall decide solo con sus reglas; no consulta en cada conexión.
> * **Opción C (Correcta):** La entrada sin regla se descarta en silencio: si nadie avisó, no entra.
> * *Distractor D:* El firewall no pone conexiones en espera; decide en el momento.

---

### ❓ Pregunta 3
**¿Qué significa que una regla sea Inbound?**

* **A)** Que controla lo que entra a mi PC ✔️ *(Opción Correcta)*
* **B)** Que controla lo que sale de mi PC
* **C)** Que funciona solo dentro del aula
* **D)** Que está desactivada por ahora

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** Inbound es entrada: otra PC intenta conectarse a la nuestra.
> * *Distractor B:* Lo que sale de nuestra PC se controla con reglas Outbound.
> * *Distractor C:* Desde dónde se puede entrar lo define la IP remota, no la dirección.
> * *Distractor D:* Estar activa o no depende del campo Enabled, no de Inbound.

---

### ❓ Pregunta 4
**Si una regla no dice desde qué IP se puede entrar, ¿a quién se le aplica?**

* **A)** Solo a las PC del aula
* **B)** Solo a mi propia PC
* **C)** A nadie, queda anulada
* **D)** A cualquier PC del mundo ✔️ *(Opción Correcta)*

> **Fundamentación Pedagógica:**
> * *Distractor A:* Para limitar al aula hay que escribir LocalSubnet.
> * *Distractor B:* La propia PC no es un origen remoto.
> * *Distractor C:* Una regla sin IP remota sí funciona, y funciona para todos.
> * **Opción D (Correcta):** Lo que no se escribe vale cualquiera, por eso una regla corta es muy abierta.

---

### ❓ Pregunta 5
**Una regla Allow y una regla Block coinciden con la misma conexión. ¿Qué pasa?**

* **A)** Pasa, porque Allow es primero
* **B)** No pasa, porque gana Block ✔️ *(Opción Correcta)*
* **C)** Gana la regla más nueva
* **D)** Windows apaga el firewall

> **Fundamentación Pedagógica:**
> * *Distractor A:* El permiso nunca le gana a una prohibición en el firewall de Windows.
> * **Opción B (Correcta):** Block gana siempre, igual que Denegar sobre Permitir en los permisos NTFS.
> * *Distractor C:* El orden de creación de las reglas no importa.
> * *Distractor D:* Un choque de reglas no apaga nada; simplemente gana Block.

---

### ❓ Pregunta 6
**Quiero que solo las PC del aula entren a mi servidor. ¿Qué pongo en la IP remota?**

* **A)** Any
* **B)** 127.0.0.1
* **C)** LocalSubnet ✔️ *(Opción Correcta)*
* **D)** Inbound

> **Fundamentación Pedagógica:**
> * *Distractor A:* Any deja entrar a cualquier PC del mundo.
> * *Distractor B:* 127.0.0.1 es la propia PC, no las del aula.
> * **Opción C (Correcta):** LocalSubnet significa las PC de mi red local, y Windows la calcula solo.
> * *Distractor D:* Inbound es una dirección (entrada), no una IP remota.

---

### ❓ Pregunta 7
**¿Qué comando de PowerShell crea una regla nueva de firewall?**

* **A)** Get-NetFirewallRule
* **B)** Test-NetConnection
* **C)** Remove-NetFirewallRule
* **D)** New-NetFirewallRule ✔️ *(Opción Correcta)*

> **Fundamentación Pedagógica:**
> * *Distractor A:* Get sirve para ver o listar reglas, no para crearlas.
> * *Distractor B:* Test-NetConnection prueba si se puede llegar a un puerto.
> * *Distractor C:* Remove sirve para borrar reglas.
> * **Opción D (Correcta):** New significa nuevo: crea la regla con las respuestas de la ficha.

---

### ❓ Pregunta 8
**En el laboratorio no somos administradores. ¿Qué podemos hacer con las reglas?**

* **A)** Verlas y contarlas ✔️ *(Opción Correcta)*
* **B)** Crear reglas nuevas
* **C)** Cambiar sus puertos
* **D)** Borrarlas todas

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** Mirar reglas es libre; por eso podemos revisar lo que crea el profe.
> * *Distractor B:* Crear reglas cambia la seguridad del equipo y necesita ser administrador.
> * *Distractor C:* Modificar una regla también necesita ser administrador.
> * *Distractor D:* Borrar reglas necesita ser administrador.

---

### ❓ Pregunta 9
**Quiero bloquear solo a curl.exe sin cortarle Internet a Chrome. ¿Qué completo en la ficha?**

* **A)** El puerto 443
* **B)** La IP remota
* **C)** El programa ✔️ *(Opción Correcta)*
* **D)** La dirección Inbound

> **Fundamentación Pedagógica:**
> * *Distractor A:* Chrome también usa el puerto 443 y quedaría bloqueado.
> * *Distractor B:* Ambos programas pueden ir a la misma IP, no los distingue.
> * **Opción C (Correcta):** El campo Programa apunta a un solo ejecutable y no afecta a los demás.
> * *Distractor D:* curl sale de la PC, así que la dirección correcta sería Outbound.

---

### ❓ Pregunta 10
**¿Cuál de estas reglas es la MÁS peligrosa?**

* **A)** Permitir el puerto 8080 solo al aula
* **B)** Permitir todo lo que entra, desde cualquiera ✔️ *(Opción Correcta)*
* **C)** Bloquear a una PC que tiene virus
* **D)** Permitir el ping solo desde el aula

> **Fundamentación Pedagógica:**
> * *Distractor A:* Abre un solo puerto y solo para el aula: respeta el mínimo privilegio.
> * **Opción B (Correcta):** Sin puerto, sin IP y sin programa, deja pasar todo: es como apagar el firewall.
> * *Distractor C:* Bloquear aumenta la seguridad.
> * *Distractor D:* Está limitada al ping y al aula, es una regla acotada.
