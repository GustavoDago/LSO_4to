# Cuestionario Google Forms: Perfiles de Red y Windows Defender Firewall
## Asignatura: Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 2

---

## 📌 Configuración del Formulario
* **Título:** LSO 4.º Año — Evaluación Formativa: Perfiles de Red y Windows Defender Firewall
* **Descripción:** Evaluación técnica formativa del Módulo 4 (Clase 2). Cubre: perfiles de red (Público, Privado, Dominio), reglas de tráfico Inbound y Outbound, filtrado con estado (Stateful), bloqueo de ICMP (ping), auditoría con PowerShell y seguridad ante amenazas como WannaCry.
* **Modo:** Cuestionario con puntuación automática (Quiz: 10 preguntas × 10 puntos = 100 puntos).
* **Campos obligatorios previos:**
  * Dirección de correo electrónico
  * Nombre y Apellido del Estudiante
  * Terminal o Equipo N.º (Laboratorio)

---

## 📋 Banco de Preguntas y Opciones

### Pregunta 1 (10 pts)
**¿Qué perfil de red debe activarse obligatoriamente al conectarse a una red Wi-Fi pública desconocida?**
* A) Perfil Privado (Incorrecta)
* B) Perfil Público (Correcta)
* C) Perfil de Dominio (Incorrecta)
* D) Perfil de Invitado (Incorrecta)
* **Feedback:** El perfil público aplica la máxima restricción de seguridad, desactiva la visibilidad del equipo ante otros dispositivos y bloquea el tráfico de recursos compartidos.

### Pregunta 2 (10 pts)
**¿Cuál es la política o acción predeterminada del Firewall de Windows para el tráfico Inbound?**
* A) Permitir todo el tráfico (Incorrecta)
* B) Redirigir hacia el router (Incorrecta)
* C) Bloquear las conexiones (Correcta)
* D) Cifrar los paquetes de red (Incorrecta)
* **Feedback:** Por defecto, cualquier solicitud que provenga del exterior es bloqueada silenciosamente a menos que exista una regla explícita de permiso.

### Pregunta 3 (10 pts)
**¿Cómo logra una computadora recibir respuestas de páginas web si el tráfico Inbound está bloqueado?**
* A) Mediante inspección con estado (Correcta)
* B) Usando direcciones APIPA (Incorrecta)
* C) Con aislamiento de procesos (Incorrecta)
* D) Por traducción de nombres DNS (Incorrecta)
* **Feedback:** Un cortafuegos con estado reconoce que el paquete entrante es la respuesta directa a una petición que un programa local inició previamente hacia afuera.

### Pregunta 4 (10 pts)
**¿Qué cmdlet de PowerShell informa si la red activa está catalogada como Public o Private?**
* A) Get-NetIPAddress (Incorrecta)
* B) Get-NetConnectionProfile (Correcta)
* C) Get-NetFirewallRule (Incorrecta)
* D) Test-NetConnection (Incorrecta)
* **Feedback:** Get-NetConnectionProfile entrega el nombre de la red, interfaz física asociada y la categoría del perfil asignado.

### Pregunta 5 (10 pts)
**En el laboratorio, dos PC tienen Internet pero el comando ping entre ellas arroja tiempo de espera agotado. ¿Cuál es el motivo?**
* A) El cable de red del switch está roto (Incorrecta)
* B) El servidor DHCP entregó IP duplicada (Incorrecta)
* C) El Firewall bloquea los paquetes ICMP por defecto (Correcta)
* D) La puerta de enlace predeterminada cayó (Incorrecta)
* **Feedback:** En Windows 11 la regla de entrada de solicitud de eco (ICMPv4-In) viene desactivada por defecto para evitar escaneos de red no autorizados.

### Pregunta 6 (10 pts)
**¿Qué comando de PowerShell evalúa si un puerto TCP específico responde exitosamente en un host?**
* A) Resolve-DnsName (Incorrecta)
* B) Clear-DnsClientCache (Incorrecta)
* C) Get-Process (Incorrecta)
* D) Test-NetConnection (Correcta)
* **Feedback:** Test-NetConnection con el parámetro -Port realiza una prueba de saludo TCP de tres vías e informa el estado en el campo TcpTestSucceeded.

### Pregunta 7 (10 pts)
**¿Qué diferencia clave existe entre el Perfil Privado y el Perfil Público?**
* A) El perfil privado apaga la placa física (Incorrecta)
* B) El privado permite compartir recursos en red (Correcta)
* C) El perfil público corta la salida a Internet (Incorrecta)
* D) El público autogenera direcciones de enlace (Incorrecta)
* **Feedback:** El perfil privado activa la detección de redes y el uso compartido de archivos e impresoras entre equipos conocidos.

### Pregunta 8 (10 pts)
**Un programa abre el puerto 8080 en la PC. ¿Qué componente del SO decide si otra máquina externa puede entrar?**
* A) El Administrador de Tareas (Incorrecta)
* B) El registro de Windows (Incorrecta)
* C) El Windows Defender Firewall (Correcta)
* D) El controlador de pantalla (Incorrecta)
* **Feedback:** El firewall inspecciona los paquetes en el kernel y decide si los autoriza antes de que alcancen el socket del proceso.

### Pregunta 9 (10 pts)
**¿Por qué el ransomware WannaCry aprovechaba el puerto TCP 445 en redes corporativas?**
* A) Para alterar los servidores de DNS (Incorrecta)
* B) Para colapsar la caché del navegador (Incorrecta)
* C) Para propagarse por carpetas compartidas (Correcta)
* D) Para modificar la dirección MAC física (Incorrecta)
* **Feedback:** El puerto 445 aloja el servicio SMB (compartición de archivos), el cual presentaba una vulnerabilidad que permitía ejecución remota de código sin interacción del usuario.

### Pregunta 10 (10 pts)
**¿Qué cmdlet de PowerShell permite auditar las políticas activas de cada perfil del Firewall?**
* A) Get-NetFirewallProfile (Correcta)
* B) Format-Volume (Incorrecta)
* C) Stop-Computer (Incorrecta)
* D) Restart-Service (Incorrecta)
* **Feedback:** Get-NetFirewallProfile devuelve el estado (Enabled), la política DefaultInboundAction y DefaultOutboundAction de los perfiles Domain, Private y Public.
