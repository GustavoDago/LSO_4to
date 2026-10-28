# Guía de Actividades N.º 3: El Portero y su Lista — Reglas del Firewall
## Laboratorio de Sistemas Operativos (LSO) — 4.º Año
### Módulo 4: Redes, Recursos Compartidos y Seguridad — Clase 3

---

* **Estudiante(s):** __________________________________________________
* **Fecha:** ___ / ___ / 2026
* **PC N.º:** ________

---

## 🎯 ¿Qué vas a aprender hoy?
1. Que una **regla** de firewall responde **5 preguntas**: ¿entra o sale? ¿pasa o no? ¿qué puerto? ¿quién? ¿qué programa?
2. A **pasar un pedido** ("que el aula pueda entrar a mi servidor") a una **ficha de regla**.
3. Que cuando un **Permitir** y un **Bloquear** chocan, **gana Bloquear**.
4. A **leer** un comando de regla y **encontrar errores**.

## 🧰 Antes de empezar
* Abrí **PowerShell** (Inicio → escribí `powershell` → Enter). **No hace falta ser administrador.**
* Ejecutá el preparador de la clase (y otra vez si la PC se reinició):
  ```powershell
  powershell -ExecutionPolicy Bypass -File .\setup_clase3_reglas.ps1
  ```
* Tené a mano el **manual** (`manual_teorico_reglas_firewall`) y el **simulador** (`simulador_motor_reglas.html`, funciona sin Internet).

---

## ⏳ FASE 0: Calentamiento (10 min)

Marcá con una ✗ la respuesta correcta:

1. El firewall de Windows, **por defecto**, con las conexiones que **entran** sin permiso...
   ☐ las deja pasar  ☐ las bloquea  ☐ pregunta al usuario
2. En nuestra analogía, el **puerto** es...
   ☐ la dirección del edificio  ☐ el portero  ☐ el timbre del departamento
3. Si quisieras que **solo** las PC del aula entren a tu servidor, ¿qué le dirías al portero?
   ______________________________________________________________________

---

## 🔬 PARTE 1: El profe crea reglas en vivo (25 min)

El profe va a crear **4 reglas** en su PC. Antes y después de cada una, vas a hacer una prueba desde tu PC.

* **IP del profe (la proyecta en el pizarrón):** ________________________

**Las pruebas que vas a usar:**
```powershell
# ¿Puedo entrar al servidor del profe? (True = sí, False = no)
Test-NetConnection <IP_del_profe> -Port 8080

# ¿El profe me responde el ping?
ping <IP_del_profe>
```

Completá la tabla (marcá o escribí):

| # | Regla del profe | ¿Entra o sale? | ¿Permitir o bloquear? | Puerto | ¿Quién? | Prueba | Antes | Después |
| :-: | :--- | :-: | :-: | :-: | :-: | :--- | :-: | :-: |
| 1 | Web 8080 aula | | | | | `Test-NetConnection` | | |
| 2 | Ping aula | | | *(no usa)* | | `ping` | | |
| 3 | Bloquear a un compañero | | | *(todos)* | | El compañero elegido repite la prueba 1 | | |
| 4 | Sin curl *(lo prueba el profe)* | | | — | — | El profe usa `curl.exe` y luego Chrome | | |

### 🤔 Pensá y respondé

**a)** Después de la regla 3, tu compañero bloqueado **no puede entrar**, aunque la regla 1 sigue diciendo que el aula sí puede. ¿Por qué? *(Pista: regla de oro N.º 2 y la lista del cumple 🎂)*

> ____________________________________________________________________________________

**b)** Con la regla 4, `curl.exe` no anda pero Chrome sigue funcionando. ¿Qué pregunta de la ficha hizo posible eso?

> ____________________________________________________________________________________

---

## 🔬 PARTE 2: De pedido a ficha (20 min)

Sos el técnico del laboratorio y te llegan estos pedidos. Completá la **ficha** de cada uno. Si una pregunta no importa, poné **—** (que significa "cualquiera").

**Pedido A.** 🗒️ *"El profe tiene una página de notas en el puerto 5000. Solo las PC del aula tienen que poder entrar."*

| ¿Entra o sale? | ¿Permitir o bloquear? | Puerto | ¿Quién? | Programa |
| :-: | :-: | :-: | :-: | :-: |
| | | | | |

**Pedido B.** 🦠 *"La PC `192.168.10.99` tiene un virus. No tiene que poder entrar a mi PC por nada."*

| ¿Entra o sale? | ¿Permitir o bloquear? | Puerto | ¿Quién? | Programa |
| :-: | :-: | :-: | :-: | :-: |
| | | | | |

**Pedido C.** 🎮 *"Que el juego `juego.exe` no se pueda conectar a Internet."*

| ¿Entra o sale? | ¿Permitir o bloquear? | Puerto | ¿Quién? | Programa |
| :-: | :-: | :-: | :-: | :-: |
| | | | | |

**Pedido D.** 🏓 *"Que el aula me pueda hacer ping."*

| ¿Entra o sale? | ¿Permitir o bloquear? | Puerto | ¿Quién? | Programa |
| :-: | :-: | :-: | :-: | :-: |
| | | | | |

### ✍️ Completá el comando del Pedido A
Usá la tabla del manual (sección 5.1). Completá los espacios:

```text
New-NetFirewallRule -DisplayName "Notas" -Direction ________ -Action ________ -Protocol TCP -LocalPort ________ -RemoteAddress ________________
```

---

## 🔬 PARTE 3: Simulador "El Portero" — 5 desafíos (30 min)

Abrí `simulador_motor_reglas.html`. Tu PC es la **PC-21**. Armá las reglas con el formulario (o pegando un comando) y apretá **"¡Probar!"**. El simulador te muestra quién pasó y quién no, y **por qué**.

| # | Desafío | ¿Lo superé? |
| :-: | :--- | :-: |
| 1 | Abrí el puerto 8080 para el aula | ☐ |
| 2 | Que el aula te pueda hacer ping | ☐ |
| 3 | Lucas fue hackeado: bloquealo | ☐ |
| 4 | Bloqueá curl.exe sin cortar Chrome | ☐ |
| 5 | Arreglá la regla rota | ☐ |

* **Puntaje final:** ______ / 5 → 📸 **Sacale captura** para subir a Classroom.
* ¿Cuál te costó más? ¿Por qué? ____________________________________________

---

## 🔬 PARTE 4: Detective de errores 🕵️ (10 min)

Martina quiere que la PC de al lado entre a su servidor en el puerto **8080**. Escribió esta regla, pero **no anda**:

```powershell
New-NetFirewallRule -DisplayName "Mi server" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 8081
```

Encontrá los **2 errores** y una **mejora de seguridad**:

| | ¿Qué parte? | ¿Qué escribió? | ¿Qué debería ir? |
| :-: | :--- | :-: | :-: |
| Error 1 | | | |
| Error 2 | | | |
| Mejora 🛡️ | *(¿qué le falta para que no entre cualquiera?)* | *(nada)* | |

---

## 🔬 PARTE 5: Espiá las reglas de tu PC 🔍 (10 min)

Mirar reglas **no necesita ser administrador**. Copiá estos comandos en PowerShell:

```powershell
# 1. ¿Cuántas reglas dejan ENTRAR tráfico en mi PC?
(Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True).Count

# 2. ¿Cuántas reglas BLOQUEAN la entrada?
(Get-NetFirewallRule -Direction Inbound -Action Block -Enabled True).Count

# 3. ¿Cómo están las reglas del ping?
Get-NetFirewallRule -DisplayName "*eco*" | Select-Object DisplayName, Enabled, Direction, Action
```

* Reglas que **permiten** entrar: ________  · Reglas que **bloquean** la entrada: ________
* ¿Las reglas del ping están activas (`Enabled = True`)? ________ ¿Por eso nadie te podía hacer ping? ________
* 🤔 ¿Podrías **crear** una regla en esta PC? ¿Por qué? ______________________________

---

## 🧹 Cierre (15 min)
1. Completá el informe que se creó en `%TEMP%\LSO_Redes_Clase3\informe_clase3_reglas.txt` (o el formulario de Classroom).
2. Ejecutá la limpieza (copia tu informe al Escritorio):
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\restaurar_clase3_reglas.ps1
   ```
3. ¡A jugar el **Kahoot de la Clase 3**! 🎮 (10 preguntas)

> 🏠 **Desafío opcional en casa** *(solo si tenés una PC propia con usuario administrador y permiso de un adulto)*: ejecutá el setup, creá la regla "Web 8080 aula" y probá entrar desde otro dispositivo de tu casa. **Al terminar, ejecutá la limpieza como administrador** para borrar la regla.
