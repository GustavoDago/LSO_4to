# Solucionario Docente — Guía N.º 3: Reglas del Firewall
## LSO 4.º Año · Módulo 4 · Clase 3 *(uso exclusivo del docente)*

---

## 🗺️ Secuencia sugerida (2 h)

| Bloque | Tiempo | Qué se hace | Material |
| :--- | :-: | :--- | :--- |
| Apertura | 10' | Recordar el misterio de la Clase 2 + Fase 0 | Guía |
| Teoría breve | 15' | Portero/lista, 5 preguntas, 3 reglas de oro (secciones 1 a 4 del manual) | Manual proyectado |
| Parte 1 | 25' | Demo en vivo (4 reglas) | `demo_docente_reglas_clase3.ps1` |
| Parte 2 | 15' | De pedido a ficha | Guía |
| Parte 3 | 30' | Simulador (5 desafíos) | `simulador_motor_reglas.html` |
| Partes 4 y 5 | 15' | Detective + espiar reglas | Guía + PowerShell |
| Cierre | 10' | Restauración + Kahoot | `restaurar_clase3_reglas.ps1`, Kahoot |

> 💡 Si el tiempo no alcanza, la Parte 5 puede quedar como tarea en casa (es solo lectura y funciona en cualquier PC con Windows).

---

## ⏳ Fase 0
1. **Las bloquea.**
2. **El timbre del departamento.**
3. Respuesta esperada (en sus palabras): *"Dejá entrar solo a las PC del aula al timbre 8080"*.

## 🔬 Parte 1 — Demo

| # | Regla | Entra/sale | Acción | Puerto | Quién | Antes | Después |
| :-: | :--- | :-: | :-: | :-: | :-: | :-: | :-: |
| 1 | Web 8080 aula | Entra | Permitir | TCP 8080 | Las PC del aula | `False` | `True` |
| 2 | Ping aula | Entra | Permitir | *(no usa)* | Las PC del aula | No responde | Responde |
| 3 | Bloquear a un compañero | Entra | Bloquear | Todos | Una PC (IP del alumno) | `True` | `False` (solo ese alumno) |
| 4 | Sin curl | Sale | Bloquear | — | — | `curl` anda | `curl` falla, Chrome anda |

* **a)** Porque si un **Permitir** y un **Bloquear** coinciden, **gana Bloquear** (regla de oro N.º 2). Es la misma idea que *Denegar > Permitir* en NTFS (Módulo 2).
* **b)** La pregunta **"¿Qué programa?"** (campo *Programa*). Bloquear el puerto 443 habría cortado también a Chrome.

## 🔬 Parte 2 — Fichas

| Pedido | Entra/sale | Acción | Puerto | Quién | Programa |
| :-: | :-: | :-: | :-: | :-: | :-: |
| A | Entra | Permitir | TCP 5000 | Las PC del aula | — |
| B | Entra | Bloquear | — | `192.168.10.99` | — |
| C | Sale | Bloquear | — | — | `juego.exe` |
| D | Entra | Permitir | *(ping, no usa)* | Las PC del aula | — |

**Comando A:** `-Direction Inbound -Action Allow -Protocol TCP -LocalPort 5000 -RemoteAddress LocalSubnet`

## 🔬 Parte 3 — Simulador (soluciones)

| # | Regla que resuelve el desafío |
| :-: | :--- |
| 1 | Entra · Permitir · TCP 8080 · Las PC del aula |
| 2 | Entra · Permitir · Ping · Las PC del aula |
| 3 | *(ya hay un Permitir 8080 al aula)* + Entra · Bloquear · Cualquiera · Una PC `192.168.10.66` |
| 4 | Sale · Bloquear · Cualquiera · Cualquiera · Programa `curl.exe` |
| 5 | Borrar "Mi server" y crear: Entra · Permitir · TCP 8080 · Las PC del aula |

## 🔬 Parte 4 — Detective

| | Parte | Escribió | Debería ir |
| :-: | :--- | :-: | :-: |
| Error 1 | Dirección | `Outbound` | `Inbound` |
| Error 2 | Puerto | `8081` | `8080` |
| Mejora | IP remota | *(nada = cualquiera)* | `-RemoteAddress LocalSubnet` (o la IP de la PC vecina) |

**Corregido:** `New-NetFirewallRule -DisplayName "Mi server" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8080 -RemoteAddress LocalSubnet`

## 🔬 Parte 5 — Espiar reglas
* Los números varían según la PC (en Windows 11 suelen ser varias decenas de reglas Allow).
* Las reglas de eco suelen aparecer con `Enabled = False` → por eso el ping entre compañeros fallaba en la Clase 2.
* **No** se pueden crear reglas: el usuario del laboratorio no es administrador.

---

## 🧑‍🏫 Notas para la demo
* Ejecutar como administrador: `.\demo_docente_reglas_clase3.ps1 -IpBloqueada <IP_de_un_alumno>`.
* Por defecto las reglas se crean con perfil **Any** para evitar el problema del perfil Público/Privado (no es contenido de esta clase).
* Al terminar: `.\demo_docente_reglas_clase3.ps1 -Cleanup` (Deep Freeze también las revierte al reiniciar).
