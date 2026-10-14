# Módulo 4: Redes Locales, Recursos Compartidos y Seguridad en Windows 11

> Entorno: **100% Windows 11 nativo** (sin Linux/WSL2/SSH). Equipos del laboratorio con Deep Freeze y sin credenciales de administrador; variante liviana para netbooks.

## 📌 Objetivos del Módulo
1. Comprender la configuración de la pila TCP/IP en Windows 11 (IPv4, máscara, gateway, DNS, DHCP).
2. Utilizar herramientas de diagnóstico por capas (`ping`, `tracert`, `nslookup`, `Test-NetConnection`, `netstat`).
3. Relacionar **sockets y puertos** con los procesos que los abren (PID).
4. Compartir recursos en red local con SMB y calcular **permisos efectivos** (permisos de recurso compartido vs NTFS).
5. Filtrar tráfico con Windows Defender Firewall (`netsh advfirewall` / `New-NetFirewallRule`).

---

## 📅 Cronograma de Clases

| Clase | Tema | Herramientas | Estado |
| :---: | :--- | :--- | :---: |
| **1** (Jue 8/10) | Diagnóstico TCP/IP, DNS, ruteo y sockets/puertos ↔ PID | `ipconfig`, `ping`, `tracert`, `nslookup`, `netstat -ano`, `Get-NetTCPConnection`, `Test-NetConnection` | ✅ [clase1](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo4_redes_servicios/clase1) |
| **2** | Cierre de Sockets, Perfiles de Red y Windows Defender Firewall | `Get-NetConnectionProfile`, `Get-NetFirewallProfile`, `Get-NetFirewallRule`, `Test-NetConnection` | ✅ [clase2](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo4_redes_servicios/clase2) |
| **3** | Reglas de filtrado Inbound/Outbound | `netsh advfirewall`, `New-NetFirewallRule` | ⏳ |
| **4** | Recursos compartidos SMB y mapeo de unidades | `net share`, `net use`, `Get-SmbShare` | ⏳ |
| **5** | Matriz de permisos efectivos: SMB vs NTFS | `icacls`, `Get-SmbShareAccess` | ⏳ |

> Las clases 2 y 3 no requieren privilegios de administrador para la auditoría en el laboratorio (se audita con PowerShell/CMD en espacio de usuario y con simulador interactivo); la creación de reglas avanzadas se planifica con credencial del docente o equipos personales.

---

## 📚 Contenidos Específicos
* **Configuración TCP/IP:** IPv4, máscara, gateway, DNS, DHCP, APIPA y loopback (`ipconfig /all` / `Get-NetIPConfiguration`).
* **Diagnóstico de conectividad:** metodología por capas, latencia, TTL y ruteo (`ping`, `tracert`, `pathping`).
* **Sockets y puertos:** estados `LISTENING` / `ESTABLISHED`, asociación con PID (`netstat -ano`, `Get-NetTCPConnection`).
* **Seguridad de red y Firewall:** perfiles (Público/Privado), inspección con estado (Stateful), reglas de entrada y salida, bloqueo de ICMP (ping), auditoría sin privilegios de admin.
* **Recursos compartidos y grupos de trabajo:** SMB, `net share`, `net use`, permisos de compartición vs NTFS.

## 🗂️ Material desarrollado
* [`clase1/`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo4_redes_servicios/clase1): manual teórico, guía de actividades, setup/restauración `.ps1`, variante netbooks, resumen NotebookLM, Kahoot (10 preguntas × 4 opciones), Google Form y simulador.
* [`clase2/`](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo4_redes_servicios/clase2): manual teórico de firewall y perfiles, guía de actividades (cierre de guía 1 + auditoría de firewall), setup/restauración `.ps1` (0.0.0.0 listeners), variante netbooks, resumen NotebookLM, Kahoot (10 preguntas × 4 opciones), Google Form (`.js`/`.md`), plantilla Excel `.xlsx` y simulador interactivo web.

