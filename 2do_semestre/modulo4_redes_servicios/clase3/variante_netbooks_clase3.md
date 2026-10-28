# Variante Netbooks (Modo B – Contingencia): El Portero y su Lista
## Módulo 4 — Clase 3 · LSO 4.º Año

> **Para días sin laboratorio:** netbooks escolares con pocos recursos. Solo se **mira** (no hace falta ser administrador) y se usa el simulador `simulador_motor_reglas.html` (un único archivo, funciona sin Internet). Duración: ~60 minutos.

* **Estudiante(s):** __________________________________________________   **Fecha:** ___/___/2026

---

## Actividad 1 — Leer una regla de verdad (15 min)
Abrí **CMD** y copiá este comando (es largo: copialo tal cual):
```cmd
netsh advfirewall firewall show rule name="Compartir archivos e impresoras (solicitud de eco: ICMPv4-In)"
```
> Si aparece "No hay reglas que coincidan", probá en PowerShell: `Get-NetFirewallRule -DisplayName "*eco*" | Select-Object DisplayName, Enabled, Direction, Action`

Buscá en lo que aparece en pantalla y completá la ficha:

| Pregunta | Lo que dice Windows | En castellano |
| :--- | :--- | :--- |
| ¿Está activa? (*Habilitada / Enabled*) | | |
| ¿Entra o sale? (*Dirección / Direction*) | | |
| ¿Permitir o bloquear? (*Acción / Action*) | | |
| ¿Quién? (*IP remota / RemoteIP*) | | |

* Con esta regla así, **¿te pueden hacer ping?** ¿Por qué? ____________________________________

---

## Actividad 2 — Contar reglas (10 min)
En **PowerShell**:
```powershell
(Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True).Count
(Get-NetFirewallRule -Direction Inbound -Action Block -Enabled True).Count
```
* Reglas que **permiten** entrar: ________  · Reglas que **bloquean** la entrada: ________
* Si una conexión coincide con una que **permite** y otra que **bloquea**, ¿pasa o no? ________

---

## Actividad 3 — De pedido a ficha (15 min, en papel)

| Pedido | ¿Entra o sale? | ¿Permitir o bloquear? | Puerto | ¿Quién? | Programa |
| :--- | :-: | :-: | :-: | :-: | :-: |
| *"Que el aula entre a mi servidor del puerto 8080"* | | | | | |
| *"Que la PC 192.168.10.99 no entre por nada"* | | | | | |
| *"Que juego.exe no se conecte a Internet"* | | | | | |

---

## Actividad 4 — Simulador (20 min)
Abrí `simulador_motor_reglas.html` y resolvé los **5 desafíos** (como mínimo el 1, el 3 y el 4).

* Puntaje: ______ / 5 → 📸 captura para Classroom.

---

## Cierre
¿Por qué conviene bloquear **un programa** (`curl.exe`) en vez de **un puerto** (443)?

> ____________________________________________________________________________________

**Entrega:** captura del simulador y respuestas de esta hoja.
