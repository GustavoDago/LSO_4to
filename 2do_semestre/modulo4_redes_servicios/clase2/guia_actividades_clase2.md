# Guía de Actividades de Laboratorio N.º 2: Perfiles de Red y Windows Defender Firewall
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
### Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 2

---

* **Estudiante(s):** __________________________________________________
* **Fecha:** ___ / ___ / 2026
* **Terminal / Equipo N.º:** ________
* **Sistema Operativo:** Windows 11 (Laboratorio / Netbook)

---

## 🎯 Objetivos de Aprendizaje
1. Completar la auditoría de **Sockets y Procesos (PID)** y el razonamiento del **Caso Clínico por capas** iniciado en la clase anterior.
2. Identificar el **Perfil de Red activo** (Público vs. Privado) y comprender sus implicancias en la seguridad perimetral del equipo.
3. Auditar la configuración de **Windows Defender Firewall** (`Inbound` vs. `Outbound`) mediante PowerShell.
4. Experimentar en parejas por qué el tráfico `ping` (ICMP) y conexiones a puertos abiertos son bloqueados o permitidos entre terminales del laboratorio.
5. Evaluar riesgos reales de seguridad vinculados a la exposición indebida de puertos en redes no confiables.

## 🧭 Requisitos Previos y Entorno
* Terminal del laboratorio con Windows 11. **No requiere privilegios de administrador.**
* En caso de reinicio de la terminal (por Deep Freeze), volver a ejecutar el setup:
  ```powershell
  powershell -ExecutionPolicy Bypass -File .\setup_clase2_firewall.ps1
  ```
* Herramientas: **PowerShell** y **Símbolo del sistema (CMD)**.

---

## ⏳ FASE 0: Cierre y Consolidación de la Clase 1 (Primeros 45 min)

> 💡 *En la clase 1 completamos hasta la Parte 3 (Ruteo y Latencia). En esta fase completamos las partes 4 y 5 pendientes.*

### Paso 0.1: Actividad Detective (Sockets y Procesos)
1. Abrí **PowerShell** y buscá el socket en escucha:
   ```powershell
   Get-NetTCPConnection -LocalPort 8080,9090 | Select-Object LocalAddress, LocalPort, State, OwningProcess
   ```
2. Con el número que figura en `OwningProcess` (PID), descubrí qué proceso es:
   ```powershell
   Get-Process -Id <PID_detectado>
   ```
3. Completá:
   * **PID detectado:** ____________
   * **Nombre del proceso ejecutable:** __________________________________
   * **¿Qué pasaría si ese proceso fuese un programa desconocido descargado de Internet?**  
     ____________________________________________________________________________________

### Paso 0.2: Caso Clínico "No Hay Internet"
Completá el cuadro deduciendo en qué capa está la falla técnica:

| Escenario | Síntomas | Capa afectada | Diagnóstico técnico |
| :--- | :--- | :---: | :--- |
| **A** | IP `169.254.x.x` asignada; no responde el router. | | |
| **B** | `ping 127.0.0.1` OK, `ping gateway` OK, `ping 8.8.8.8` falla. | | |
| **C** | `ping 8.8.8.8` responde OK, pero `ping google.com` falla. | | |

### Paso 0.3: Trivia Kahoot de Clase 1 🏆
* Unirse a la partida proyectada por el docente con el pin de juego para evaluar la fijación de conceptos de la Clase 1.

---

## 🔬 PARTE 1: Auditoría del Perfil de Red Activo

Windows clasifica cada red a la que te conectás como **Pública** o **Privada**. Vamos a auditar la conexión actual del laboratorio.

1. En **PowerShell**, ejecutá:
   ```powershell
   Get-NetConnectionProfile
   ```
2. Registrá los datos obtenidos:

| Parámetro | Valor Obtenido en tu Terminal |
| :--- | :--- |
| **Name (Nombre de la red):** | |
| **InterfaceAlias (Adaptador):** | |
| **NetworkCategory (Perfil):** | `Public` / `Private` / `DomainAuthenticated` |
| **IPv4Connectivity:** | |

### 📝 Pregunta de Análisis 1:
Si estuvieras conectado al Wi-Fi de una cafetería o estación de tren, ¿cuál perfil debería estar activo obligatoriamente y por qué? ¿Qué riesgo corrés si queda en `Private`?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🔬 PARTE 2: Inspección de Políticas del Firewall

El Firewall tiene una política predeterminada para cada perfil de red.

1. Ejecutá en **PowerShell**:
   ```powershell
   Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction
   ```
2. Completá la tabla con los valores observados:

| Perfil (Name) | ¿Habilitado? (Enabled) | Tráfico Entrante (Inbound) | Tráfico Saliente (Outbound) |
| :--- | :---: | :---: | :---: |
| **Domain** | | | |
| **Private** | | | |
| **Public** | | | |

### 📝 Pregunta de Análisis 2:
¿Por qué la política predeterminada para el tráfico entrante (*Inbound*) es `Block` mientras que la de salida (*Outbound*) es `Allow`? ¿Qué principio de seguridad fundamenta esta decisión?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🔬 PARTE 3: El Enigma del PING (ICMPv4) y la Regla Oculta

En este laboratorio vamos a comprobar por qué las computadoras de la escuela parecen "invisibles" al comando `ping`.

1. Preguntale la dirección IPv4 a tu compañero de banco de la terminal de al lado (usando `ipconfig`).
   * **IP de la máquina vecina:** ________________________
2. Desde tu terminal, intentá hacerle ping:
   ```cmd
   ping <IP_de_tu_compañero>
   ```
   * **¿Respondió con bytes o arrojó "Tiempo de espera agotado"?** ______________________

3. Ahora vamos a auditar en PowerShell por qué ocurrió eso, buscando la regla que controla el ping:
   ```powershell
   Get-NetFirewallRule -DisplayName "*eco*" | Select-Object DisplayName, Enabled, Direction, Action, Profile
   ```
4. Observá el campo `Enabled` de la regla **Compartir archivos e impresoras (solicitud de eco: ICMPv4-In)**:
   * **¿La regla está en `True` o `False`?** ____________
   * **¿En qué perfiles de red aplica?** ________________

### 📝 Pregunta de Análisis 3:
¿Por qué Windows 11 desactiva por defecto la respuesta a los paquetes de ping provenientes de otras máquinas en la red? ¿Qué ventaja táctica le da esto contra un atacante que escanea la red local?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🔬 PARTE 4: Experimento Cruzado en Parejas (Socket vs. Firewall)

En la Actividad 0 dejamos corriendo un servicio en el puerto local **8080** de tu máquina.

1. Probá conectarte **desde tu propia máquina** (local):
   ```powershell
   Test-NetConnection -ComputerName 127.0.0.1 -Port 8080
   ```
   * **Resultado de TcpTestSucceeded:** `True` / `False`

2. Ahora pedile a tu compañero que, **desde su máquina**, intente probar ese mismo puerto en tu IP:
   ```powershell
   Test-NetConnection -ComputerName <TU_IP> -Port 8080
   ```
   * **Resultado de TcpTestSucceeded desde la máquina de tu compañero:** `True` / `False`

3. Analicen juntos el resultado:

### 📝 Pregunta de Análisis 4:
Si el proceso estaba corriendo y el socket estaba en `LISTENING`, ¿quién frenó la conexión cuando vino desde la máquina vecina y por qué motivo?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🔬 PARTE 5: Caso de Ciberseguridad Aplicada

En mayo de 2017, el ataque global del ransomware **WannaCry** infectó a más de 200.000 computadoras en 150 países en pocas horas. El virus se propagaba automáticamente escaneando el puerto **TCP 445 (SMB)** de cualquier equipo conectado a la red.

1. Verificá si tu equipo tiene reglas de entrada para el servicio SMB (puerto 445):
   ```powershell
   Get-NetFirewallPortFilter | Where-Object LocalPort -eq 445
   ```
2. Reflexioná con tu compañero y respondé:
   * Si una notebook corporativa se conecta a la red Wi-Fi de un hotel con el perfil configurado en **Privado** y sin actualizar, ¿qué le permite hacer un gusano como WannaCry?
   * ¿De qué manera el perfil **Público** y el Firewall salvan a esa notebook aunque el usuario no sea experto en seguridad?

> **Conclusión Técnica:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🧹 Cierre y Restauración
1. Guardá tus respuestas en el informe de la clase o completá el formulario de Classroom.
2. Ejecutá el script de limpieza antes de retirarte:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\restaurar_clase2_firewall.ps1
   ```
3. Participá del **Kahoot de Cierre de la Clase 2** (10 preguntas).
