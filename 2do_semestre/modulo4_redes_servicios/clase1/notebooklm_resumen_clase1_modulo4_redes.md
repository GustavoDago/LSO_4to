# Resumen para NotebookLM — Módulo 4, Clase 1
## Cuaderno: "LSO 4to - 2do semestre"
### Diagnóstico de Red TCP/IP, DNS y Sockets en Windows 11

> **Cómo usarlo en NotebookLM:** Cargar este archivo como fuente en el cuaderno *"LSO 4to - 2do semestre"* y solicitar:
> 1. Resumen en audio (Podcast de 2 presentadores explicando la analogía del correo postal y el portero eléctrico).
> 2. Generación de infografía y mapa conceptual del *Árbol de Decisión del Técnico*.
> 3. Cuestionario de repaso para estudiar antes del Kahoot de clase.

---

## 1. Ideas Centrales y Analogías Didácticas (Para recordar siempre)

* **¿Por qué el Sistema Operativo controla la red?** Las aplicaciones de usuario (*Modo Usuario / Ring 3*) como Chrome o Spotify jamás tocan la placa de red directamente por seguridad. El Kernel de Windows (`tcpip.sys` en *Modo Kernel / Ring 0*) actúa como aduana, empaquetador y remitente.
* **La Gran Metáfora Postal y del Edificio:**
  * **Dirección MAC (Capa 2):** El número de chasis del auto o la huella digital grabada de fábrica en la placa.
  * **Dirección IP (Capa 3):** La dirección de la calle y número del edificio en la ciudad.
  * **Puerto TCP/UDP (Capa 4):** El número de departamento o el timbre en el portero eléctrico (del 0 al 65.535).
  * **Socket (IP + Puerto + Protocolo):** El sobre postal completo con remitente y destinatario.
  * **Proceso (PID):** El inquilino que atiende la puerta del departamento cuando tocan el timbre.
* **Modelo TCP/IP (El viaje de una carta):** Se diagnostica **de abajo hacia arriba** (Acceso Físico -> Red/IP -> Transporte/Puertos -> Aplicación). Si el cable o enlace falla, nada de lo superior puede funcionar.
* **Direcciones especiales clave:**
  * **`127.0.0.1` (Loopback):** *"Hablarte al espejo"*. Prueba interna de tu propia pila de red sin salir a la calle.
  * **IPs Privadas (`192.168.x.x`, `10.x.x.x`):** Los nombres de entrecasa dentro de la red local. El router las traduce a una sola IP pública mediante **NAT**.
  * **`169.254.x.x` (APIPA):** *"El número provisorio cuando nadie te atiende en la ventanilla"*. Indica que **DHCP falló** y no hay comunicación con el router.
* **Estados TCP en el portero eléctrico:**
  * `LISTENING`: El proceso está sentado esperando que alguien toque el timbre en ese puerto (actúa de servidor).
  * `ESTABLISHED`: Conexión activa; dos máquinas intercambian datos por el intercomunicador.
  * `TIME_WAIT`: La conexión terminó y el puerto aguarda unos segundos antes de liberarse.

---

## 2. Árbol de Decisión Clínico: "Se cayó Internet"
1. `ping 127.0.0.1` → ¿Funciona el software y la pila de red local?
2. `ipconfig /all` → ¿Tengo IP válida asignada o tengo la temida 169.254 (APIPA)? ¿Veo la IP del Gateway?
3. `ping [Gateway]` → ¿Llego físicamente al router del laboratorio/casa?
4. `ping 8.8.8.8` → ¿El router sale al mundo exterior por dirección IP numérica?
5. `ping google.com` → ¿Funciona la traducción de nombres (DNS)?
6. `Test-NetConnection google.com -Port 443` → ¿El servicio web remoto responde y el puerto está abierto en el firewall?

---

## 3. Tabla de Comandos Rápidos

| Objetivo Clínico | Comando en CMD | Comando en PowerShell |
| :--- | :--- | :--- |
| **Ver configuración completa** | `ipconfig /all` | `Get-NetIPConfiguration` |
| **Probar conectividad y latencia** | `ping [destino]` | `Test-Connection [destino]` |
| **Traducir nombres a IP** | `nslookup [dominio]` | `Resolve-DnsName [dominio]` |
| **Ver caché de nombres resueltos** | `ipconfig /displaydns` | `Get-DnsClientCache` |
| **Trazar la ruta salto por salto** | `tracert [destino]` | `Test-NetConnection -TraceRoute` |
| **Probar un puerto TCP remoto** | — | `Test-NetConnection [IP] -Port [N]` |
| **Auditar puertos y PIDs locales**| `netstat -ano` | `Get-NetTCPConnection` |
| **Descubrir el proceso por su PID**| `tasklist /fi "PID eq [N]"` | `Get-Process -Id [N]` |

---

## 4. Glosario Técnico Esencial
* **APIPA (169.254.0.0/16):** Dirección de emergencia asignada por Windows cuando el servidor DHCP no responde.
* **DNS (Domain Name System):** La libreta de contactos de Internet que traduce nombres comprensibles a números IP.
* **Gateway (Puerta de Enlace):** La IP del router que conecta la red local con redes externas o Internet.
* **Loopback (`127.0.0.1`):** Interfaz virtual interna para autodiagnóstico del sistema operativo.
* **NAT (Network Address Translation):** Mecanismo del router que convierte múltiples IPs privadas locales en una sola IP pública.
* **PID (Process Identifier):** Número entero único asignado por el Kernel a cada proceso en ejecución.
* **Socket:** La tupla que identifica unívocamente un extremo de conexión: IP + Puerto + Protocolo.
* **TTL (Time To Live):** Contador de saltos de un paquete IP que decrementa en 1 en cada router para evitar bucles infinitos.

---

## 5. Preguntas Disparadoras para el Chat de NotebookLM
1. *¿Por qué una computadora necesita números de puerto si ya tiene una dirección IP asignada?*
2. *Si un alumno me dice que puede mandar mensajes por WhatsApp Web pero no puede abrir ninguna página web nueva, ¿qué comando y qué capa deberíamos revisar primero?*
3. *¿Cuál es la diferencia entre el estado LISTENING y ESTABLISHED en la salida de `netstat -ano`?*
4. *Si en la terminal veo la IP `169.254.120.45`, ¿por qué no tiene sentido intentar cambiar los servidores DNS?*

---

## 6. Guion Sugerido para Audio / Podcast en NotebookLM (3 a 4 min)
> **Locutor 1:** *"Imaginate que tu computadora es un edificio de departamentos enorme. La dirección postal del edificio es la IP. Pero adentro del edificio viven muchos vecinos: el señor Chrome, la señora Discord y el joven Spotify. ¿Cómo sabe el cartero a qué puerta tocar?"*  
> **Locutor 2:** *"¡Ahí entran los puertos! El puerto es el número de departamento o el timbre. Y cuando un proceso se sienta a esperar que toquen el timbre, Windows dice que está en LISTENING. En esta clase aprendemos a ser detectives de redes: si un departamento tiene la puerta abierta con un inquilino desconocido, miramos su PID y descubrimos quién es realmente..."*
