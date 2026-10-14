# Resumen para NotebookLM — Módulo 4, Clase 2
## Cuaderno: "LSO 4to - 2do semestre"
### Perfiles de Red y Windows Defender Firewall en Windows 11

> **Cómo usarlo en NotebookLM:** Cargar este documento como fuente en el cuaderno *"LSO 4to - 2do semestre"* y solicitar:
> 1. **Audio Overview (Podcast):** Dos conductores dialogando sobre por qué Windows no responde al `ping` por defecto y cómo el Firewall salvó a miles de máquinas durante el ataque de WannaCry.
> 2. **Infografía Conceptual:** Diagrama de flujo mostrando qué ocurre cuando entra un paquete Inbound vs cuando sale un paquete Outbound.
> 3. **Guía de Estudio:** Ficha técnica de comandos de PowerShell para auditoría de perfiles y reglas sin permisos de administrador.

---

## 1. Ideas Centrales y Analogías Didácticas

* **El Firewall como Portero del Edificio:**
  * Si la **IP** es la dirección de la calle y el **Puerto** es el timbre de un departamento, el **Firewall** es el guardia de seguridad apostado en la entrada.
  * Aunque el inquilino (proceso con PID) esté esperando visitas en el departamento (`LISTENING`), si la persona no está anotada en la lista de invitados autorizados (**Regla Inbound Allow**), el guardia no la deja entrar y la frena en la puerta.
* **Sentidos de Tráfico:**
  * **Inbound (Entrada):** Conexiones iniciadas desde afuera hacia nosotros. *Por defecto: Bloqueadas (`BlockInbound`).*
  * **Outbound (Salida):** Conexiones que inician nuestros programas hacia el exterior. *Por defecto: Permitidas (`AllowOutbound`).*
* **Firewall con Estado (Stateful):**
  * Cuando abrimos una página web, nuestros paquetes salen al exterior. El firewall "recuerda" la conversación.
  * Cuando el servidor web nos responde, el firewall permite la entrada porque identifica que es la respuesta legítima a una salida previa. No requiere abrir puertos permanentes.
* **Los Perfiles de Red en Windows 11:**
  * **Público (Public):** Desconfianza total. Oculta el equipo ante la red, desactiva compartir archivos e impresoras y bloquea solicitudes externas.
  * **Privado (Private):** Red hogareña o de trabajo de confianza. Permite descubrimiento de dispositivos y recursos compartidos.
  * **Dominio (Domain):** Administrado mediante Active Directory por directivas centralizadas.
* **El "Misterio" del PING en Windows 11:**
  * El comando `ping` usa el protocolo **ICMP**.
  * En Windows 11, la regla de firewall para responder al ping (*Compartir archivos e impresoras: Solicitud de eco ICMPv4-In*) viene **deshabilitada por defecto**. Que una máquina no responda ping no significa que esté apagada o desconectada; significa que su firewall la protege del escaneo.

---

## 2. Árbol de Decisión del Técnico: Auditoría de Firewall

```
¿El servicio responde localmente con 127.0.0.1?
    ├── NO  -> El problema es el proceso (no inició el socket o crasheó).
    └── SÍ  -> El socket funciona. Pasamos a probar desde la red externa.
                │
                ¿Responde desde otra máquina de la red local?
                ├── SÍ  -> El firewall tiene una regla que autoriza el puerto.
                └── NO  -> El Firewall está descartando el tráfico.
                            │
                            Verificar:
                            1. Get-NetConnectionProfile (¿Está en Public o Private?)
                            2. Get-NetFirewallProfile (¿Inbound está en Block?)
                            3. Get-NetFirewallRule (¿Existe regla que permita el puerto?)
```

---

## 3. Comandos de Consola para el Técnico de Laboratorio

| Objetivo de Diagnóstico | Comando en PowerShell | Resultado Esperado |
| :--- | :--- | :--- |
| **Identificar perfil de red activo** | `Get-NetConnectionProfile` | Indica si la red es `Public` o `Private`. |
| **Ver estado y política de cada perfil**| `Get-NetFirewallProfile` | Muestra si está `Enabled` y la acción `DefaultInboundAction`. |
| **Buscar la regla del comando ping** | `Get-NetFirewallRule -DisplayName "*eco*"` | Muestra si `ICMPv4-In` está activa o apagada. |
| **Buscar reglas de un puerto específico**| `Get-NetFirewallPortFilter \| ? LocalPort -eq 445` | Permite rastrear qué regla protege un puerto sensible. |
| **Probar conectividad a puerto remoto**| `Test-NetConnection [IP] -Port [N]` | Informa `TcpTestSucceeded: True/False`. |

---

## 4. Caso Histórico: Lección de Ciberseguridad (WannaCry y Puerto 445)
* El malware **WannaCry** (2017) demostró por qué un firewall bien configurado es la primera línea de defensa.
* El gusano buscaba en Internet y redes locales el puerto **TCP 445** (servicio SMB de compartir archivos de Windows).
* Aquellas computadoras conectadas a redes públicas pero configuradas erróneamente con perfil Privado y sin reglas de bloqueo fueron infectadas sin que el usuario tocara nada.
* El perfil Público y la política `BlockInbound` actúan como un escudo automático para usuarios inexpertos.
