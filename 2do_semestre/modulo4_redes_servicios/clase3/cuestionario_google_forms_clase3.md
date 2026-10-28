# Cuestionario Google Forms: El Portero y su Lista (Reglas del Firewall)
## Asignatura: Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 3

---

## 📌 Configuración del Formulario
* **Título:** LSO 4.º Año — Evaluación Formativa: El Portero y su Lista (Reglas del Firewall)
* **Descripción:** Evaluación formativa del Módulo 4 (Clase 3). Cubre: qué es una regla, entrada/salida, las 5 preguntas de una regla, gana el NO (Block > Allow), LocalSubnet, filtrar por programa y mínimo privilegio.
* **Modo:** Cuestionario con puntuación automática (Quiz: 10 preguntas × 10 puntos = 100 puntos).
* **Campos obligatorios previos:**
  * Dirección de correo electrónico
  * Nombre y Apellido del Estudiante
  * Terminal o Equipo N.º (Laboratorio)

---

## 📋 Banco de Preguntas y Opciones

### Pregunta 1 (10 pts)
**En nuestra analogía, ¿qué es una regla del firewall?**
* A) El timbre de un departamento (Incorrecta)
* B) Un renglón de la lista del portero (Correcta)
* C) La dirección del edificio (Incorrecta)
* D) El vecino que atiende la puerta (Incorrecta)
* **Feedback:** Cada regla es una instrucción de la lista que el firewall consulta para decidir.

### Pregunta 2 (10 pts)
**Por defecto, ¿qué hace Windows con una conexión que ENTRA y no tiene ninguna regla?**
* A) La deja pasar sin revisar (Incorrecta)
* B) Le pregunta al usuario qué hacer (Incorrecta)
* C) La bloquea sin avisar (Correcta)
* D) La guarda para revisarla después (Incorrecta)
* **Feedback:** La entrada sin regla se descarta en silencio: si nadie avisó, no entra.

### Pregunta 3 (10 pts)
**¿Qué significa que una regla sea Inbound?**
* A) Que controla lo que entra a mi PC (Correcta)
* B) Que controla lo que sale de mi PC (Incorrecta)
* C) Que funciona solo dentro del aula (Incorrecta)
* D) Que está desactivada por ahora (Incorrecta)
* **Feedback:** Inbound es entrada: otra PC intenta conectarse a la nuestra.

### Pregunta 4 (10 pts)
**Si una regla no dice desde qué IP se puede entrar, ¿a quién se le aplica?**
* A) Solo a las PC del aula (Incorrecta)
* B) Solo a mi propia PC (Incorrecta)
* C) A nadie, queda anulada (Incorrecta)
* D) A cualquier PC del mundo (Correcta)
* **Feedback:** Lo que no se escribe vale cualquiera, por eso una regla corta es muy abierta.

### Pregunta 5 (10 pts)
**Una regla Allow y una regla Block coinciden con la misma conexión. ¿Qué pasa?**
* A) Pasa, porque Allow es primero (Incorrecta)
* B) No pasa, porque gana Block (Correcta)
* C) Gana la regla más nueva (Incorrecta)
* D) Windows apaga el firewall (Incorrecta)
* **Feedback:** Block gana siempre, igual que Denegar sobre Permitir en los permisos NTFS.

### Pregunta 6 (10 pts)
**Quiero que solo las PC del aula entren a mi servidor. ¿Qué pongo en la IP remota?**
* A) Any (Incorrecta)
* B) 127.0.0.1 (Incorrecta)
* C) LocalSubnet (Correcta)
* D) Inbound (Incorrecta)
* **Feedback:** LocalSubnet significa las PC de mi red local, y Windows la calcula solo.

### Pregunta 7 (10 pts)
**¿Qué comando de PowerShell crea una regla nueva de firewall?**
* A) Get-NetFirewallRule (Incorrecta)
* B) Test-NetConnection (Incorrecta)
* C) Remove-NetFirewallRule (Incorrecta)
* D) New-NetFirewallRule (Correcta)
* **Feedback:** New significa nuevo: crea la regla con las respuestas de la ficha.

### Pregunta 8 (10 pts)
**En el laboratorio no somos administradores. ¿Qué podemos hacer con las reglas?**
* A) Verlas y contarlas (Correcta)
* B) Crear reglas nuevas (Incorrecta)
* C) Cambiar sus puertos (Incorrecta)
* D) Borrarlas todas (Incorrecta)
* **Feedback:** Mirar reglas es libre; por eso podemos revisar lo que crea el profe.

### Pregunta 9 (10 pts)
**Quiero bloquear solo a curl.exe sin cortarle Internet a Chrome. ¿Qué completo en la ficha?**
* A) El puerto 443 (Incorrecta)
* B) La IP remota (Incorrecta)
* C) El programa (Correcta)
* D) La dirección Inbound (Incorrecta)
* **Feedback:** El campo Programa apunta a un solo ejecutable y no afecta a los demás.

### Pregunta 10 (10 pts)
**¿Cuál de estas reglas es la MÁS peligrosa?**
* A) Permitir el puerto 8080 solo al aula (Incorrecta)
* B) Permitir todo lo que entra, desde cualquiera (Correcta)
* C) Bloquear a una PC que tiene virus (Incorrecta)
* D) Permitir el ping solo desde el aula (Incorrecta)
* **Feedback:** Sin puerto, sin IP y sin programa, deja pasar todo: es como apagar el firewall.
