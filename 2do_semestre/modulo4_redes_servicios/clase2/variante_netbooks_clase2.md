# Variante Netbooks (Modo B – Contingencia): Firewall y Perfiles de Red
## Módulo 4 — Clase 2 · LSO 4.º Año
### Tecnicatura en Informática Personal y Profesional

> **Escenario de Contingencia:** Para días de trabajo directo en netbooks escolares de recursos limitados. Usa comandos directos en **CMD** y **PowerShell ligero**, sin consumo de RAM y sin requerir permisos de administrador. Duración: ~40–50 minutos.

* **Estudiante(s):** __________________________________________________   **Fecha:** ___/___/2026

---

## Actividad 1 — ¿En qué perfil está mi red? (10 min)
En PowerShell o CMD:
```powershell
Get-NetConnectionProfile
```
*(O en CMD clásico: `netsh advfirewall show currentprofile`)*

* **Nombre de la red detectada:** ________________________________________
* **Categoría / Perfil:** `Público` / `Privado`
* **¿Por qué una netbook escolar que se conecta en varias casas debería usar perfil Público?**  
  ____________________________________________________________________________________

---

## Actividad 2 — Auditoría de Firewall sin Admin (15 min)
En CMD ejecutá:
```cmd
netsh advfirewall show allprofiles
```
Completá el cuadro observando las políticas:

| Perfil | Estado (State) | Tráfico Entrante (Inbound) | Tráfico Saliente (Outbound) |
| :--- | :---: | :---: | :---: |
| **Perfil de dominio** | | | |
| **Perfil privado** | | | |
| **Perfil público** | | | |

* **Pregunta:** Si una aplicación intenta comunicarse desde afuera sin permiso, ¿qué hace el firewall según la tabla anterior?  
  ____________________________________________________________________________________

---

## Actividad 3 — Prueba del Ping e ICMP (15 min)
1. Pedile la IP al compañero de la netbook de al lado: `ipconfig`
2. En CMD ejecutá:
   ```cmd
   ping <IP_de_tu_compañero>
   ```
3. Registrá el resultado:
   * ¿Respondió o dio tiempo de espera agotado? ______________________________________
4. Verificá en CMD la regla que lo frena:
   ```cmd
   netsh advfirewall firewall show rule name="Compartir archivos e impresoras (solicitud de eco: ICMPv4-In)"
   ```
   * ¿La regla está habilitada (*Enabled: Yes*) o deshabilitada (*Enabled: No*)? ________

---

## Cierre — Pregunta de Seguridad
¿Por qué el firewall bloquea el `ping` entrante pero permite navegar páginas web normalmente?

> **Respuesta:**  
> ____________________________________________________________________________________  
> ____________________________________________________________________________________

**Entrega:** Captura del comando `netsh advfirewall show allprofiles` y respuestas de la guía completadas.
