# Variante Netbooks (Modo B – Contingencia): Diagnóstico de Red en Windows
## Módulo 4 — Clase 1 · LSO 4.º Año

> Para días **sin laboratorio potente**. Solo **CMD**, sin scripts, sin procesos en segundo plano y sin consumo extra de RAM. Dura ~40–50 minutos.

* **Estudiante(s):** ______________________   **Fecha:** ___/___/2026

---

## Actividad 1 — Mi configuración (5 min)
En CMD: `ipconfig /all`

| Dato | Valor |
| :--- | :--- |
| IPv4 | |
| Máscara | |
| Gateway | |
| DNS | |
| ¿Es 169.254.x.x? | |

## Actividad 2 — Conectividad por capas (10 min)
```
ping 127.0.0.1
ping <tu gateway>
ping 8.8.8.8
ping google.com
```
Anotá cuál es el **primer** comando que falla (si alguno) y qué capa indica.

## Actividad 3 — Ruta (10 min)
`tracert -d -h 10 google.com`  *(`-d` no resuelve nombres y `-h 10` limita a 10 saltos: más rápido).*

* Saltos contados: ____  · Primer salto = ¿gateway? Sí / No

## Actividad 4 — Sockets y procesos (15 min)
1. Abrí el navegador con una página cualquiera.
2. En CMD: `netstat -ano | findstr ESTABLISHED`
3. Elegí un PID y averiguá el proceso: `tasklist /fi "PID eq <PID>"`

| Puerto remoto | PID | Proceso | ¿Qué servicio es? (443 = HTTPS, 80 = HTTP) |
| :---: | :---: | :--- | :--- |
| | | | |

## Cierre — Pregunta integradora
Explicá la diferencia entre un puerto en `LISTENING` y una conexión `ESTABLISHED`.

> ____________________________________________________________________________________

**Entrega:** captura de `ipconfig /all` y de `netstat -ano` con el proceso identificado.
