# Actividad práctica: Uso de comandos PowerShell y CMD

## Objetivo
Esta actividad está diseñada para que los estudiantes practiquen todos los comandos **PowerShell** y **CMD** que hemos visto en clase. 

Los alumnos deberán:
1. Navegar a la carpeta de su perfil de usuario.
2. Ejecutar una serie de acciones de gestión de archivos, procesos, servicios y diagnóstico.
3. Registrar la salida de cada comando en un archivo de reporte.

---

## Requisitos previos
- Windows 10/11 con PowerShell 5.1 o superior.
- Acceso a la consola **CMD** y **PowerShell**.

---

## Instrucciones paso a paso
### 1️⃣ Acceso a la carpeta de usuario
```powershell
# PowerShell
Set-Location $HOME   # Cambia al directorio del usuario
Get-ChildItem         # Lista contenido
```
```cmd
rem CMD
cd %USERPROFILE%      :: Cambia al directorio del usuario
dir                    :: Lista contenido
```
---
### 2️⃣ Gestión de archivos y carpetas
| Acción | PowerShell | CMD |
|-------|-----------|-----|
| Crear una carpeta `Practica` | `New-Item -ItemType Directory -Path .\Practica` | `mkdir Practica` |
| Crear archivo `info.txt` dentro de la carpeta | `New-Item -Path .\Practica\info.txt -ItemType File` | `type NUL > Practica\info.txt` |
| Escribir texto en el archivo | `Set-Content -Path .\Practica\info.txt -Value "Actividad de comandos"` | `echo Actividad de comandos > Practica\info.txt` |
| Eliminar el archivo | `Remove-Item .\Practica\info.txt` | `del Practica\info.txt` |
| Eliminar la carpeta | `Remove-Item .\Practica -Recurse` | `rmdir /S /Q Practica` |
---
### 3️⃣ Gestión de procesos
```powershell
# Listar procesos que usan más CPU
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
# Detener un proceso (reemplazar 1234 por el PID real)
Stop-Process -Id 1234 -Force
```
```cmd
rem Listar procesos con mayor uso de memoria
tasklist /FO LIST | findstr /I "Mem Usage"
rem Finalizar proceso (reemplazar 1234 por el PID)
taskkill /PID 1234 /F
```
---
### 4️⃣ Gestión de servicios
```powershell
Get-Service -Name wuauserv            # Ver estado del servicio Windows Update
Stop-Service -Name wuauserv           # Detener
Start-Service -Name wuauserv          # Iniciar
```
```cmd
rem Ver estado del servicio
sc query wuauserv
rem Detener el servicio
net stop wuauserv
rem Iniciar el servicio
net start wuauserv
```
---
### 5️⃣ Herramientas de diagnóstico y forense
```cmd
rem Abrir el Monitor de recursos
start resmon.exe
rem Ver conexiones de red activas
netstat -an
```
---
## Entregables
1. **Reporte.txt** – Archivo de texto que contiene la salida (stdout) de cada comando ejecutado.  
   - En PowerShell puedes redirigir con `>> Reporte.txt`.
   - En CMD con `>> Reporte.txt`.
2. Captura de pantalla del **Monitor de recursos** abierto.
3. Respuestas a las preguntas de reflexión al final del documento.
---
## Preguntas de reflexión
1. ¿Qué diferencias observaste entre los cmdlets de PowerShell y los comandos de CMD al gestionar procesos?
2. ¿Cuál de los dos shells consideras más adecuado para tareas de automatización y por qué?
---
## Notas adicionales
- Si un comando falla, anota el mensaje de error en el **Reporte.txt** y describe brevemente qué crees que lo provocó.
- Puedes combinar varios comandos en scripts PowerShell (`.ps1`) o archivos batch (`.bat`) para automatizar la secuencia.

¡Éxitos y buen aprendizaje!
