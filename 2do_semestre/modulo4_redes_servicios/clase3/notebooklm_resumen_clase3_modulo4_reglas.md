# Resumen para NotebookLM — Módulo 4, Clase 3
## Cuaderno: "LSO 4to - 2do semestre"
### El Portero y su Lista: Reglas de Entrada y Salida del Firewall de Windows

> **Cómo usarlo en NotebookLM:** cargar este documento como fuente en el cuaderno *"LSO 4to - 2do semestre"* y pedir:
> 1. **Audio Overview (Podcast, ~8 min):** *"Explicalo para chicos de 16 años, con lenguaje simple, usando la analogía del portero del edificio y de la lista de invitados de un cumpleaños. Evitá tecnicismos que no estén en el documento."*
> 2. **Infografía:** *"Las 5 preguntas de una regla de firewall y las 3 reglas de oro, con íconos."*
> 3. **Guía de estudio / tarjetas:** *"10 tarjetas de pregunta y respuesta para repasar antes del Kahoot."*

---

## 1. La idea principal

* El **firewall** de Windows es como el **portero de un edificio**: decide quién entra y quién sale.
* El portero tiene una **lista**. Cada renglón de esa lista es una **regla**.
* **Por defecto:** lo que **entra** sin permiso se **bloquea**; lo que **sale** se **permite**.
* La respuesta a algo que **vos pediste** (por ejemplo, una página web) entra sola: el firewall se acuerda de que la pediste.

| En el edificio | En la computadora |
| :--- | :--- |
| Dirección del edificio | Dirección IP |
| Timbre del departamento | Puerto (ej.: 8080) |
| Vecino que atiende | Programa |
| Portero | Firewall |
| Lista del portero | Reglas |

## 2. Las 5 preguntas de una regla

| Pregunta | Nombre en Windows | Ejemplos |
| :--- | :--- | :--- |
| ¿Entra o sale? | Dirección | Inbound (entra) · Outbound (sale) |
| ¿La dejo pasar? | Acción | Allow (permitir) · Block (bloquear) |
| ¿A qué timbre va? | Puerto | 80 y 443 (web), 445 (carpetas compartidas), 8080 (servidor de prueba) |
| ¿Quién es? | IP remota | Cualquiera (Any) · Las PC del aula (LocalSubnet) · Una PC puntual |
| ¿Qué programa? | Programa (opcional) | chrome.exe, curl.exe |

* El **ping** no usa puerto: en la regla se elige el tipo **ICMPv4**.

## 3. Las 3 reglas de oro

1. **Lo que no escribís vale para todos.** Una regla sin IP remota deja entrar a cualquier PC del mundo.
2. **Si hay un SÍ y un NO, gana el NO.** Como en la lista de un cumple: "entran todos los del curso" + "Juan no entra" → Juan no entra. En el firewall, **Block le gana a Allow**. Es la misma idea que en los permisos NTFS del Módulo 2 (Denegar le gana a Permitir).
3. **Abrí lo justo (mínimo privilegio).** Mejor una PC puntual que el aula, y mejor el aula que cualquiera. Nunca "permitir todo desde cualquiera": eso es como apagar el firewall.

## 4. De la ficha al comando

Pedido: *"Abrir el puerto 8080 solo para las PC del aula."*

```powershell
New-NetFirewallRule -DisplayName "Web 8080 aula" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8080 -RemoteAddress LocalSubnet
```

* `New-NetFirewallRule` = crear regla nueva.
* `-Direction Inbound` = entra · `-Action Allow` = permitir · `-LocalPort 8080` = timbre 8080 · `-RemoteAddress LocalSubnet` = solo el aula.
* **Crear, cambiar o borrar** reglas necesita ser **administrador**. **Mirarlas** no: `Get-NetFirewallRule`.

## 5. Los 3 errores más comunes

| Error | Qué pasa |
| :--- | :--- |
| Poner Outbound cuando querías dejar entrar | La regla cuida la otra puerta: nadie entra |
| Abrir un puerto equivocado (8081 en vez de 8080) | La regla nunca se usa |
| No poner IP remota | Entra cualquiera, no solo el aula |

**Truco del técnico:** probar siempre las dos caras: que entre quien debe y que no entre quien no debe.
