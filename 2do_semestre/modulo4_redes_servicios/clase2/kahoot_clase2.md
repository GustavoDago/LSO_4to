# Cuestionario Gamificado Kahoot: Perfiles de Red y Windows Defender Firewall
## Módulo 4 — Clase 2: Seguridad Perimetral, Reglas Inbound/Outbound y Filtrado ICMP
### Laboratorio de Sistemas Operativos (LSO) — 4.º Año

---

### 📋 Estructura y Criterios de Calidad Pedagógica
* **Total de Preguntas:** 10
* **Opciones por Pregunta:** 4 (1 Opción Correcta y 3 Distractores Técnicos Fundamentados)
* **Límites de Caracteres Kahoot:** Pregunta ≤ 120 caracteres | Cada respuesta ≤ 75 caracteres
* **Diseño Antisesgo (Anti Test-Wiseness):**
  * ✅ Opciones con **longitudes homogéneas** dentro de cada pregunta.
  * ✅ **Sin paréntesis** ni siglas aisladas en las opciones de respuesta.
  * ✅ Distribución balanceada de la respuesta correcta entre A, B, C y D.
* **Alineación con el Diseño Curricular:** Tecnicatura en Informática Personal y Profesional (Res. 3828/09).

---

### ❓ Pregunta 1
**¿Qué perfil de red debe activarse al conectarse al Wi-Fi de un aeropuerto o bar?**

* **A)** Perfil Privado
* **B)** Perfil Público ✔️ *(Opción Correcta)*
* **C)** Perfil de Dominio
* **D)** Perfil de Invitado

> **Fundamentación Pedagógica:**
> * *Distractor A:* El perfil privado asume confianza y activa el descubrimiento de recursos locales.
> * **Opción B (Correcta):** El perfil público aplica máxima restricción y oculta el equipo ante otros dispositivos.
> * *Distractor C:* Requiere validación previa contra un servidor Active Directory corporativo.
> * *Distractor D:* No existe como perfil nativo de red en Windows Defender Firewall.

---

### ❓ Pregunta 2
**¿Cuál es la acción predeterminada del Firewall para el tráfico Inbound en Windows?**

* **A)** Permitir todo el tráfico
* **B)** Redirigir hacia el router
* **C)** Bloquear las conexiones ✔️ *(Opción Correcta)*
* **D)** Cifrar los paquetes de red

> **Fundamentación Pedagógica:**
> * *Distractor A:* Dejar entrar todo expondría cualquier puerto y servicio local a ataques.
> * *Distractor B:* El firewall no realiza funciones de ruteo ni reenvío hacia la puerta de enlace.
> * **Opción C (Correcta):** Por defecto se bloquea todo intento externo que no tenga una regla de excepción.
> * *Distractor D:* El cortafuegos filtra y descarta paquetes, no cifra su contenido.

---

### ❓ Pregunta 3
**¿Qué característica permite recibir respuestas web si el tráfico Inbound está bloqueado?**

* **A)** La inspección con estado ✔️ *(Opción Correcta)*
* **B)** El uso de direcciones APIPA
* **C)** El aislamiento de procesos
* **D)** La traducción de nombres DNS

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** Un firewall con estado reconoce que el paquete entrante responde a una salida previa.
> * *Distractor B:* APIPA es un mecanismo de autoconfiguración cuando falla el servidor DHCP.
> * *Distractor C:* El aislamiento de memoria de procesos no gestiona el tráfico de red del kernel.
> * *Distractor D:* El servicio DNS traduce dominios a IPs numéricas sin evaluar reglas de filtrado.

---

### ❓ Pregunta 4
**¿Qué cmdlet de PowerShell muestra si la red actual está configurada como pública o privada?**

* **A)** Get-NetIPAddress
* **B)** Get-NetConnectionProfile ✔️ *(Opción Correcta)*
* **C)** Get-NetFirewallRule
* **D)** Test-NetConnection

> **Fundamentación Pedagógica:**
> * *Distractor A:* Detalla las direcciones IP configuradas en las placas de red locales.
> * **Opción B (Correcta):** Muestra el nombre de la red, interfaz y categoría del perfil asignado.
> * *Distractor C:* Lista las reglas de filtrado individuales configuradas en el sistema.
> * *Distractor D:* Prueba conectividad y diagnóstico hacia destinos o puertos específicos.

---

### ❓ Pregunta 5
**En el laboratorio dos PC tienen red, pero el comando ping entre ellas falla. ¿Por qué ocurre?**

* **A)** El cable de red del switch se encuentra averiado
* **B)** El servidor DHCP asignó direcciones repetidas
* **C)** El Firewall bloquea los paquetes ICMP por defecto ✔️ *(Opción Correcta)*
* **D)** La puerta de enlace predeterminada está apagada

> **Fundamentación Pedagógica:**
> * *Distractor A:* Si el cable estuviera dañado no habría conexión ni salida a otros destinos.
> * *Distractor B:* Una colisión IP genera conflicto explícito de red y no explica el descarte ICMP.
> * **Opción C (Correcta):** La regla de solicitud de eco ICMPv4-In viene deshabilitada por seguridad.
> * *Distractor D:* El tráfico entre equipos de la misma subred local no pasa por el gateway.

---

### ❓ Pregunta 6
**¿Qué comando de PowerShell evalúa si un puerto TCP específico responde en un equipo?**

* **A)** Resolve-DnsName
* **B)** Clear-DnsClientCache
* **C)** Get-Process
* **D)** Test-NetConnection ✔️ *(Opción Correcta)*
* *(Parámetro: `-Port`)*

> **Fundamentación Pedagógica:**
> * *Distractor A:* Realiza consultas de resolución de nombres en servidores DNS.
> * *Distractor B:* Vacía la memoria caché local de nombres previamente resueltos.
> * *Distractor C:* Informa los procesos en memoria pero no prueba puertos de red remotos.
> * **Opción D (Correcta):** Realiza un saludo TCP de tres vías al puerto indicado y reporta el éxito.

---

### ❓ Pregunta 7
**¿Qué diferencia principal existe entre el Perfil Privado y el Perfil Público?**

* **A)** El privado deshabilita la placa de red física
* **B)** El privado permite compartir recursos en red ✔️ *(Opción Correcta)*
* **C)** El público apaga el acceso hacia sitios de Internet
* **D)** El público asigna direcciones de enlace local

> **Fundamentación Pedagógica:**
> * *Distractor A:* Ningún perfil apaga la interfaz de red física ni desconecta el enlace.
> * **Opción B (Correcta):** El perfil privado habilita el descubrimiento de equipos y el uso de SMB.
> * *Distractor C:* En ambos perfiles la navegación web saliente está completamente permitida.
> * *Distractor D:* La asignación de IP depende de DHCP o configuración manual, no del firewall.

---

### ❓ Pregunta 8
**Un programa abre el puerto 8080 en la PC. ¿Qué componente decide si otra máquina entra?**

* **A)** El Administrador de Tareas
* **B)** El registro de Windows
* **C)** El Windows Defender Firewall ✔️ *(Opción Correcta)*
* **D)** El controlador de video

> **Fundamentación Pedagógica:**
> * *Distractor A:* Supervisa consumo de memoria y CPU pero no intercepta paquetes de red.
> * *Distractor B:* Almacena configuraciones del sistema pero no filtra paquetes en tiempo real.
> * **Opción C (Correcta):** El firewall inspecciona y autoriza o descarta el tráfico antes del socket.
> * *Distractor D:* Administra la salida gráfica y no interviene en la pila de protocolos TCP/IP.

---

### ❓ Pregunta 9
**¿Por qué el ataque masivo de WannaCry aprovechaba el puerto SMB 445?**

* **A)** Para alterar los servidores de nombres DNS
* **B)** Para saturar la memoria caché del navegador
* **C)** Para propagarse a través de carpetas de red ✔️ *(Opción Correcta)*
* **D)** Para cambiar la dirección MAC de las placas

> **Fundamentación Pedagógica:**
> * *Distractor A:* No utilizaba resolución de dominios para vulnerar la máquina víctima.
> * *Distractor B:* No requería interacción del usuario ni ejecución en navegadores web.
> * **Opción C (Correcta):** Explotaba una vulnerabilidad en el protocolo SMB de compartición de archivos.
> * *Distractor D:* La dirección física MAC no puede ser modificada en la ROM por este ataque.

---

### ❓ Pregunta 10
**Si un técnico necesita auditar las políticas activas de cada perfil, ¿qué comando utiliza?**

* **A)** Get-NetFirewallProfile ✔️ *(Opción Correcta)*
* **B)** Format-Volume
* **C)** Stop-Computer
* **D)** Restart-Service

> **Fundamentación Pedagógica:**
> * **Opción A (Correcta):** Lista perfiles con sus estados y acciones predeterminadas Inbound y Outbound.
> * *Distractor B:* Se utiliza para formatear particiones de almacenamiento en el disco.
> * *Distractor C:* Apaga el equipo y cerraría abruptamente la sesión de trabajo.
> * *Distractor D:* Reinicia servicios locales del sistema sin consultar el estado del firewall.
