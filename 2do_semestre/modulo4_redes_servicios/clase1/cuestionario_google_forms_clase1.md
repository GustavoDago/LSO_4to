# Cuestionario Digital: Diagnóstico de Red TCP/IP y Sockets en Windows 11
## Módulo 4 — Clase 1: Direccionamiento, DNS y Sockets
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año

---

> **📋 Formato Optimizado para Google Forms / Google Classroom**  
> *Las 10 preguntas cuentan con opciones homogéneas sin pistas visuales por longitud ni paréntesis. El orden de preguntas y de opciones está **aleatorizado** respecto al Kahoot para evitar la memorización mecánica.*  
> **Puntaje total recomendado:** 100 puntos (10 por pregunta).

---

### ⚙️ Metadatos y Configuración para Google Forms

* **Título del Formulario:** LSO 4.º Año — Evaluación Formativa: Diagnóstico de Red TCP/IP y Sockets en Windows 11
* **Ajustes recomendados:** Activar *Convertir en cuestionario*, todas las preguntas obligatorias de 10 puntos.
* **Carga automática:** Pegar [`crear_google_form_clase1.js`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo4_redes_servicios/clase1/crear_google_form_clase1.js) en https://script.new y ejecutar.

---

## 📝 Preguntas del Cuestionario

---

### Pregunta 1 (10 puntos)
**¿Qué dirección IP identifica a la propia máquina para pruebas internas de loopback?**

* [ ] **A)** 127.0.0.1
* [ ] **B)** 169.254.0.1
* [ ] **C)** 192.168.0.1
* [ ] **D)** 172.16.0.1

---

### Pregunta 2 (10 puntos)
**En la salida de netstat, ¿qué indica el estado LISTENING?**

* [ ] **A)** El puerto se cerró y espera liberación del Kernel.
* [ ] **B)** La conexión fue bloqueada por reglas del firewall.
* [ ] **C)** Un proceso aguarda conexiones entrantes en el puerto.
* [ ] **D)** Existe una transferencia activa de datos en curso.

---

### Pregunta 3 (10 puntos)
**¿Qué función cumple la puerta de enlace predeterminada o gateway?**

* [ ] **A)** Encamina el tráfico dirigido hacia redes externas.
* [ ] **B)** Filtra y bloquea puertos inseguros en la red local.
* [ ] **C)** Asigna direcciones IP dinámicas a cada equipo.
* [ ] **D)** Traduce los nombres de dominio en direcciones IP.

---

### Pregunta 4 (10 puntos)
**Si el comando ping a 8.8.8.8 responde pero a google.com falla, ¿cuál es el problema?**

* [ ] **A)** Desconexión física en el cable de red local.
* [ ] **B)** Caída total del router o puerta de enlace.
* [ ] **C)** Falla en el servicio de resolución DNS.
* [ ] **D)** Daño permanente en la placa de red local.

---

### Pregunta 5 (10 puntos)
**¿Qué cmdlet de PowerShell se utiliza para diagnosticar la conexión a un puerto TCP?**

* [ ] **A)** Test-NetConnection
* [ ] **B)** Resolve-DnsName
* [ ] **C)** Test-Connection
* [ ] **D)** Get-NetTCPConnection

---

### Pregunta 6 (10 puntos)
**¿Para qué se utiliza principalmente el comando tracert?**

* [ ] **A)** Identificar la ruta y saltos hacia un destino.
* [ ] **B)** Borrar los registros en la caché local de DNS.
* [ ] **C)** Listar los sockets y puertos activos del equipo.
* [ ] **D)** Renovar los datos de la concesión por DHCP.

---

### Pregunta 7 (10 puntos)
**¿Qué combinación de parámetros en netstat muestra sockets numéricos con su PID?**

* [ ] **A)** netstat -efq
* [ ] **B)** netstat -bsp
* [ ] **C)** netstat -rnv
* [ ] **D)** netstat -ano

---

### Pregunta 8 (10 puntos)
**¿Qué representa el campo TTL en la respuesta de un ping?**

* [ ] **A)** Ancho de banda disponible en la placa de red de destino.
* [ ] **B)** Límite de saltos por routers antes de descartar el paquete.
* [ ] **C)** Tamaño del búfer de datos transmitido dentro del paquete.
* [ ] **D)** Tiempo total de respuesta del enlace medido en microsegundos.

---

### Pregunta 9 (10 puntos)
**¿Qué elementos identifican de forma única a un socket de red?**

* [ ] **A)** Máscara de subred, puerta de enlace y DNS.
* [ ] **B)** Dirección física MAC y fabricante de placa.
* [ ] **C)** Dirección IP, número de puerto y protocolo.
* [ ] **D)** Nombre del host, grupo de trabajo y usuario.

---

### Pregunta 10 (10 puntos)
**Una PC tiene la IP 169.254.37.12 y no navega. ¿Qué indica esa dirección?**

* [ ] **A)** Configuración manual de la interfaz de loopback.
* [ ] **B)** Falla de DHCP y autoasignación de una IP APIPA.
* [ ] **C)** Asignación pública directa a Internet por NAT.
* [ ] **D)** Dirección estática del servidor DNS de la red.

---

## 🔑 Clave de Respuestas (solo docente)

| Pregunta | Correcta |
| :---: | :---: |
| 1 | A) 127.0.0.1 |
| 2 | C) Un proceso aguarda conexiones entrantes en el puerto. |
| 3 | A) Encamina el tráfico dirigido hacia redes externas. |
| 4 | C) Falla en el servicio de resolución DNS. |
| 5 | A) Test-NetConnection |
| 6 | A) Identificar la ruta y saltos hacia un destino. |
| 7 | D) netstat -ano |
| 8 | B) Límite de saltos por routers antes de descartar el paquete. |
| 9 | C) Dirección IP, número de puerto y protocolo. |
| 10 | B) Falla de DHCP y autoasignación de una IP APIPA. |
