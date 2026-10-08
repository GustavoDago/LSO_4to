# Cuestionario Gamificado Kahoot: Diagnóstico de Red TCP/IP y Sockets en Windows 11
## Módulo 4 — Clase 1: Direccionamiento, DNS, Diagnóstico por Capas y Sockets
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año

---

### 📋 Estructura y Criterios de Calidad Pedagógica
* **Total de Preguntas:** 10
* **Opciones por Pregunta:** 4 (1 Opción Correcta y 3 Distractores Técnicos Fundamentados)
* **Límites de Caracteres Kahoot:** Pregunta ≤ 120 caracteres | Cada respuesta ≤ 75 caracteres
* **Diseño Antisesgo (Anti Test-Wiseness):**
  * ✅ Opciones con **longitudes homogéneas** dentro de cada pregunta (se eliminó la pista visual de la respuesta más larga).
  * ✅ **Sin paréntesis** ni siglas aisladas en las opciones de respuesta.
  * ✅ Distribución balanceada de la respuesta correcta entre A, B, C y D.
* **Plantilla Excel:** Sincronizado con [`kahoot_clase1.xlsx`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo4_redes_servicios/clase1/kahoot_clase1.xlsx) (listo para importar a Kahoot).

---

### ❓ Pregunta 1
**¿Qué dirección IP identifica a la propia máquina para pruebas internas de loopback?**

* **A)** 192.168.0.1
* **B)** 127.0.0.1 ✔️ *(Opción Correcta)*
* **C)** 169.254.0.1
* **D)** 172.16.0.1

> **Fundamentación Pedagógica:**
> * *Distractor A:* Es una IP privada típica de routers hogareños, no la interfaz loopback de la PC.
> * **Opción B (Correcta):** 127.0.0.0/8 es el rango loopback: el tráfico no sale de la máquina y prueba la pila TCP/IP local.
> * *Distractor C:* Pertenece al rango APIPA (169.254.0.0/16), usado cuando falla DHCP.
> * *Distractor D:* Es una dirección IP privada clase B de red local, no la interfaz loopback.

---

### ❓ Pregunta 2
**Una PC tiene la IP 169.254.37.12 y no navega. ¿Qué indica esa dirección?**

* **A)** Asignación pública directa a Internet por NAT.
* **B)** Falla de DHCP y autoasignación de una IP APIPA. ✔️ *(Opción Correcta)*
* **C)** Dirección estática del servidor DNS de la red.
* **D)** Configuración manual de la interfaz de loopback.

> **Fundamentación Pedagógica:**
> * *Distractor A:* Las IP públicas no están en el rango 169.254.x.x; este rango es de enlace local.
> * **Opción B (Correcta):** APIPA (169.254.0.0/16) se autoasigna cuando no hay respuesta de un servidor DHCP: síntoma de falla de red local.
> * *Distractor C:* El DNS traduce nombres; su IP no define la IP de la PC ni es APIPA.
> * *Distractor D:* La dirección de loopback estándar es 127.0.0.1 y no pertenece a este rango.

---

### ❓ Pregunta 3
**¿Qué función cumple la puerta de enlace predeterminada o gateway?**

* **A)** Traduce los nombres de dominio en direcciones IP.
* **B)** Asigna direcciones IP dinámicas a cada equipo.
* **C)** Encamina el tráfico dirigido hacia redes externas. ✔️ *(Opción Correcta)*
* **D)** Filtra y bloquea puertos inseguros en la red local.

> **Fundamentación Pedagógica:**
> * *Distractor A:* Esa es la función del servidor de nombres de dominio (DNS).
> * *Distractor B:* Esa es la función del servicio de direccionamiento dinámico (DHCP).
> * **Opción C (Correcta):** El gateway es el punto de salida: todo destino fuera de la red local se envía al router.
> * *Distractor D:* El filtrado y bloqueo de puertos es tarea del cortafuegos (firewall).

---

### ❓ Pregunta 4
**Si el comando ping a 8.8.8.8 responde pero a google.com falla, ¿cuál es el problema?**

* **A)** Desconexión física en el cable de red local.
* **B)** Caída total del router o puerta de enlace.
* **C)** Falla en el servicio de resolución DNS. ✔️ *(Opción Correcta)*
* **D)** Daño permanente en la placa de red local.

> **Fundamentación Pedagógica:**
> * *Distractor A:* Sin enlace físico no habría respuesta desde 8.8.8.8.
> * *Distractor B:* Si el router o gateway estuviese caído, tampoco se llegaría a 8.8.8.8.
> * **Opción C (Correcta):** La conectividad IP funciona (8.8.8.8 responde), pero falla la traducción de nombres a IP.
> * *Distractor D:* Si la placa estuviese rota, se perdería toda comunicación IP en la máquina.

---

### ❓ Pregunta 5
**¿Para qué se utiliza principalmente el comando tracert?**

* **A)** Identificar la ruta y saltos hacia un destino. ✔️ *(Opción Correcta)*
* **B)** Listar los sockets y puertos activos del equipo.
* **C)** Renovar los datos de la concesión por DHCP.
* **D)** Borrar los registros en la caché local de DNS.

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** tracert envía paquetes con TTL incremental para descubrir cada router del trayecto.
> * *Distractor B:* Los puertos abiertos se auditan mediante netstat o Get-NetTCPConnection.
> * *Distractor C:* La renovación de IP por DHCP se efectúa con el comando ipconfig /renew.
> * *Distractor D:* La caché de resolución DNS se limpia mediante ipconfig /flushdns.

---

### ❓ Pregunta 6
**¿Qué elementos identifican de forma única a un socket de red?**

* **A)** Dirección física MAC y fabricante de placa.
* **B)** Dirección IP, número de puerto y protocolo. ✔️ *(Opción Correcta)*
* **C)** Nombre del host, grupo de trabajo y usuario.
* **D)** Máscara de subred, puerta de enlace y DNS.

> **Fundamentación Pedagógica:**
> * *Distractor A:* La MAC opera en la capa de enlace y no distingue conexiones ni procesos de software.
> * **Opción B (Correcta):** Un socket es la combinación de IP + puerto + protocolo (TCP o UDP).
> * *Distractor C:* El nombre y el usuario pertenecen a la gestión del sistema operativo, no al socket de red.
> * *Distractor D:* La máscara, gateway y DNS configuran el adaptador, pero no definen un socket específico.

---

### ❓ Pregunta 7
**En la salida de netstat, ¿qué indica el estado LISTENING?**

* **A)** Existe una transferencia activa de datos en curso.
* **B)** La conexión fue bloqueada por reglas del firewall.
* **C)** El puerto se cerró y espera liberación del Kernel.
* **D)** Un proceso aguarda conexiones entrantes en el puerto. ✔️ *(Opción Correcta)*

> **Fundamentación Pedagógica:**
> * *Distractor A:* Ese estado se denomina ESTABLISHED en las conexiones TCP activas.
> * *Distractor B:* Los bloqueos de firewall impiden el tráfico, pero no generan el estado LISTENING.
> * *Distractor C:* Los puertos en espera de cierre transitorio ingresan en el estado TIME_WAIT.
> * **Opción D (Correcta):** LISTENING indica que un proceso abrió un socket servidor esperando clientes.

---

### ❓ Pregunta 8
**¿Qué combinación de parámetros en netstat muestra sockets numéricos con su PID?**

* **A)** netstat -ano ✔️ *(Opción Correcta)*
* **B)** netstat -bsp
* **C)** netstat -rnv
* **D)** netstat -efq

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** Los modificadores -a (todos los puertos), -n (formato numérico) y -o (incluye PID) asocian el socket al proceso.
> * *Distractor B:* La combinación -bsp no es la opción estándar para listar todos los sockets numéricos con PID.
> * *Distractor C:* Los modificadores -rnv consultan principalmente tablas de ruteo sin vincular el PID del proceso.
> * *Distractor D:* La opción -efq no representa los modificadores válidos para listar conexiones activas con PID.

---

### ❓ Pregunta 9
**¿Qué cmdlet de PowerShell se utiliza para diagnosticar la conexión a un puerto TCP?**

* **A)** Test-NetConnection ✔️ *(Opción Correcta)*
* **B)** Get-NetTCPConnection
* **C)** Resolve-DnsName
* **D)** Test-Connection

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** Test-NetConnection (con el parámetro -Port) prueba la apertura del socket TCP y devuelve TcpTestSucceeded.
> * *Distractor B:* Get-NetTCPConnection inspecciona los sockets TCP locales existentes, pero no prueba la conexión a un puerto remoto.
> * *Distractor C:* Resolve-DnsName realiza consultas de nombres de dominio hacia servidores DNS.
> * *Distractor D:* Test-Connection envía paquetes de eco ICMP (ping), sin probar puertos TCP específicos.

---

### ❓ Pregunta 10
**¿Qué representa el campo TTL en la respuesta de un ping?**

* **A)** Tiempo total de respuesta del enlace medido en microsegundos.
* **B)** Límite de saltos por routers antes de descartar el paquete. ✔️ *(Opción Correcta)*
* **C)** Tamaño del búfer de datos transmitido dentro del paquete.
* **D)** Ancho de banda disponible en la placa de red de destino.

> **Fundamentación Pedagógica:**
> * *Distractor A:* El tiempo de respuesta se informa como valor de latencia en milisegundos, no como TTL.
> * **Opción B (Correcta):** Cada router decrementa el TTL en 1; si llega a cero, el paquete se descarta evitando bucles.
> * *Distractor C:* El tamaño del paquete se indica como carga de bytes (bytes=32 por defecto).
> * *Distractor D:* El comando ping no mide el ancho de banda ni la capacidad máxima del enlace.

---

