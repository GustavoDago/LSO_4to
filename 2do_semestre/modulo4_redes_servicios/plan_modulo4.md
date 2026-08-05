# Módulo 4: Redes, Conectividad y Administración Remota

## 📌 Objetivos del Módulo
1. Comprender la configuración de la pila de protocolos TCP/IP en Windows 11 y Linux.
2. Utilizar herramientas de diagnóstico de red de capa 3 y 4 (`ping`, `traceroute`/`tracepath`, `netstat`/`ss`).
3. Implementar y administrar conexiones remotas seguras mediante el protocolo SSH (*Secure Shell*).
4. Configurar reglas de filtrado de tráfico con cortafuegos en ambos entornos (`netsh advfirewall` en Windows 11 / `ufw` en Linux).

---

## 📅 Contenidos Específicos
* **Configuración TCP/IP:** Direcciones IP v4/v6, máscara de red, puerta de enlace, DNS (`ipconfig` vs. `ip a`).
* **Diagnóstico de Conectividad:** Latencia, ruteo de paquetes (`ping`, `traceroute`, `pathping`), puertos en escucha (`ss -tulpn`, `netstat -an`).
* **Administración Remota SSH:** Claves públicas y privadas (`ssh-keygen`), autenticación RSA/ED25519, transferencia segura de archivos (`scp` / `sftp`), demonio `sshd`.
* **Seguridad de Red y Firewalls:** Reglas de entrada y salida, puertos permitidos/bloqueados (`netsh advfirewall firewall` / `ufw allow 22/tcp`).
