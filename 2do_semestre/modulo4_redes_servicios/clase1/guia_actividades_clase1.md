# Guía de Actividades de Laboratorio N.º 1: Diagnóstico de Red TCP/IP y Sockets en Windows 11
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Tecnicatura en Informática Personal y Profesional (Res. 3828/09)
### Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 1

---

* **Estudiante(s):** __________________________________________________
* **Fecha:** ___ / ___ / 2026
* **Terminal / Equipo N.º:** ________
* **Sistema Operativo:** Windows 11

---

## 🎯 Objetivos de Aprendizaje
1. Auditar la configuración TCP/IP de la terminal (IP, máscara, gateway, DNS) e identificar direcciones especiales (loopback, APIPA, privadas).
2. Aplicar la metodología de **diagnóstico por capas** con `ping`, `nslookup` y `tracert`.
3. Identificar **sockets y puertos** en escucha y asociarlos al **proceso** que los abrió mediante su PID.
4. Resolver un caso clínico de falla de red razonando desde la capa física hacia la de aplicación.

## 🧭 Requisitos Previos
* Terminal del laboratorio con Windows 11 y salida a Internet. **No requiere privilegios de administrador.**
* Haber ejecutado el docente/alumno el setup: `powershell -ExecutionPolicy Bypass -File .\setup_clase1_redes.ps1`
* Herramientas: **Símbolo del sistema (CMD)**, **PowerShell**, **Administrador de Tareas** (`Ctrl+Shift+Esc`).
* 🔹 *¿Netbook con pocos recursos?* Usá la [variante liviana](file:///f:/Mochila/Antigravity/LSO_4to/2do_semestre/modulo4_redes_servicios/clase1/variante_netbooks_clase1.md).

> ⚠️ **Prohibido en esta clase:** `ipconfig /release`, `/renew` y cualquier cambio de configuración. Hoy **solo observamos**.

---

## 🔬 Parte 1: Radiografía de la Interfaz de Red

1. Abrí **CMD** y ejecutá: `ipconfig /all`
2. Buscá el adaptador activo (Ethernet o Wi-Fi) y completá:

| Parámetro | Valor Detectado |
| :--- | :--- |
| **Nombre del adaptador:** | |
| **Dirección física (MAC):** | |
| **¿DHCP habilitado?** | Sí / No |
| **Dirección IPv4:** | |
| **Máscara de subred:** | |
| **Puerta de enlace predeterminada:** | |
| **Servidor DHCP:** | |
| **Servidores DNS:** | |

3. Ahora en **PowerShell**: `Get-NetIPConfiguration` y `Get-NetIPAddress -AddressFamily IPv4`

### 📝 Pregunta de Análisis 1:
¿Tu IPv4 es **privada** o **pública**? ¿Cómo lo sabés? ¿Empieza con `169.254`? ¿Qué significaría eso?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🔬 Parte 2: Conectividad por Capas (de abajo hacia arriba)

Ejecutá cada prueba en orden y registrá el resultado:

| Paso | Comando | ¿Responde? | Tiempo prom. (ms) | Capa que verifica |
| :---: | :--- | :---: | :---: | :--- |
| 1 | `ping 127.0.0.1` | | | |
| 2 | `ping <tu gateway>` | | | |
| 3 | `ping 8.8.8.8` | | | |
| 4 | `ping google.com` | | | |

Luego probá la resolución de nombres:

```
nslookup google.com
Resolve-DnsName google.com        (PowerShell)
ipconfig /displaydns              (observar la caché)
```

### 📝 Pregunta de Análisis 2:
Si el paso 3 funciona y el paso 4 falla, ¿qué componente está fallando y cómo lo demostrás? ¿Por qué el paso 1 funciona aunque desconectes el cable?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🔬 Parte 3: Ruteo y Latencia

1. Ejecutá en CMD: `tracert google.com` (puede demorar; con `Ctrl+C` cortás).
2. En PowerShell: `Test-NetConnection google.com -TraceRoute`
3. Completá:

| Dato | Valor |
| :--- | :--- |
| **Cantidad de saltos hasta el destino:** | |
| **IP del primer salto (¿coincide con tu gateway?):** | |
| **Salto con mayor latencia:** | |
| **¿Algún salto mostró `*` (sin respuesta)?** | |

### 📝 Pregunta de Análisis 3:
Explicá con tus palabras cómo `tracert` descubre cada router usando el campo **TTL**.

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🔬 Parte 4: Sockets, Puertos y Procesos (Misión Detective 🕵️)

> El setup dejó un **proceso misterioso** con sockets abiertos en la terminal. ¡Encontralo!

1. En CMD: `netstat -ano | findstr LISTENING`
2. Identificá los puertos **8080** y **9090** y anotá el **PID** que aparece en la última columna.
3. Verificalo en PowerShell: `Get-NetTCPConnection -LocalPort 8080,9090 | Select LocalPort, State, OwningProcess`
4. Descubrí qué proceso es: `Get-Process -Id <PID>`  (o Administrador de Tareas → pestaña **Detalles** → columna PID).
5. Mirá también las conexiones establecidas: `netstat -ano | findstr ESTABLISHED`

| Puerto local | Estado | PID | Nombre del proceso |
| :---: | :---: | :---: | :--- |
| 8080 | | | |
| 9090 | | | |

6. Probá el puerto con `Test-NetConnection 127.0.0.1 -Port 8080` y luego con `-Port 7777`.

| Puerto probado | `TcpTestSucceeded` | Interpretación |
| :---: | :---: | :--- |
| 8080 | | |
| 7777 | | |

### 📝 Pregunta de Análisis 4:
1. ¿Por qué el puerto 8080 aparece también en estado `ESTABLISHED`?  
2. Si un puerto en `LISTENING` perteneciera a un proceso desconocido, ¿qué riesgo de seguridad implica y qué harías?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🔬 Parte 5: Caso Clínico "No Hay Internet"

Para cada escenario, indicá **en qué capa está la falla** y qué comando lo demuestra:

| Escenario | Síntomas observados | Capa afectada | Diagnóstico y comando clave |
| :--- | :--- | :---: | :--- |
| **A** | `ipconfig` muestra IP `169.254.12.7`; no responde ni el gateway. | | |
| **B** | `ping 127.0.0.1` OK, `ping gateway` OK, `ping 8.8.8.8` falla. | | |
| **C** | `ping 8.8.8.8` OK, `ping google.com` → "No se pudo encontrar el host". | | |

### 📝 Conclusión Técnica Final:
¿Por qué es más eficiente diagnosticar una falla de red **por capas** en lugar de probar cosas al azar?

> **Conclusión:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

---

## 🧹 Cierre y Restauración
1. Copiá `%TEMP%\LSO_Redes\informe_clase1_redes.txt` a tu pendrive / Drive.
2. Ejecutá: `powershell -ExecutionPolicy Bypass -File .\restaurar_clase1_redes.ps1`
3. Verificá que 8080 y 9090 ya no estén en `LISTENING`.

## 📋 Entrega (Google Classroom)
* Capturas de: `ipconfig /all`, `tracert`, y `netstat -ano` con el PID del proceso identificado.
* Esta guía completada (Preguntas de Análisis 1 a 4 y Caso Clínico).
