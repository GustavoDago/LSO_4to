param(
    [Parameter(Mandatory=$true)]
    [ValidateRange(1, 9)]
    [int]$StudentNumber
)

# Ensure folder exists
$LsoFolder = "C:\LSO"
if (!(Test-Path $LsoFolder)) {
    New-Item -ItemType Directory -Path $LsoFolder -Force | Out-Null
}

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "   CONFIGURANDO DESAFIO PARA EL ESTUDIANTE $StudentNumber" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Cleanup helper: terminate any running custom processes and delete old keys/files
Get-Process -Name "Apolo_13" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Get-CimInstance Win32_Process -Filter "Name = 'powershell.exe'" | Where-Object { 
    $_.CommandLine -like "*LSO_NetListener*" 
} | ForEach-Object { 
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue 
}

sc.exe delete "LSO_Service" | Out-Null

switch ($StudentNumber) {
    1 {
        # Copy powershell to LSO folder as Apolo_13.exe to make it show up in CPU list
        Copy-Item C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe (Join-Path $LsoFolder "Apolo_13.exe") -Force
        
        # Start Apolo_13.exe consuming CPU
        $p = Start-Process (Join-Path $LsoFolder "Apolo_13.exe") -ArgumentList "-NoProfile -WindowStyle Hidden -Command `"while(`$true) { [Math]::Sqrt([Random]::new().Next()) | Out-Null; Start-Sleep -Milliseconds 10 }`"" -PassThru
        $targetPid = $p.Id
        
        # Clean up old apolo_* files and write the file containing the secret
        Remove-Item (Join-Path $LsoFolder "apolo_*") -ErrorAction SilentlyContinue
        $secretFile = Join-Path $LsoFolder "apolo_$targetPid.txt"
        Set-Content -Path $secretFile -Value "Clave: K" -Force
        
        Write-Host "[OK] Proceso 'Apolo_13.exe' iniciado en segundo plano (PID: $targetPid)." -ForegroundColor Green
        Write-Host "Mision: Buscar en el Monitor de Recursos (pestana CPU) el proceso 'Apolo_13.exe' que esta consumiendo CPU y anotar su PID. Con ese numero, busca el archivo 'C:\LSO\apolo_<PID>.txt' para leer la clave." -ForegroundColor Yellow
    }
    2 {
        # Student 2: Registry Delay. MenuShowDelay in HKCU\Control Panel\Desktop set to 270 (first digit is 2)
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "270" -Force
        Write-Host "[OK] Modificado el retardo de menu (MenuShowDelay) en el Registro." -ForegroundColor Green
        Write-Host "Mision: Navegar con regedit a HKCU\Control Panel\Desktop. Obtener el valor de 'MenuShowDelay'. Tu codigo es el primer digito (2)." -ForegroundColor Yellow
    }
    3 {
        # Student 3: Registry Fonts. FontSmoothing in HKCU\Control Panel\Desktop set to 3 (code is 3)
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothing" -Value "3" -Force
        Write-Host "[OK] Modificado el suavizado de fuentes (FontSmoothing) en el Registro." -ForegroundColor Green
        Write-Host "Mision: Navegar con regedit a HKCU\Control Panel\Desktop. Obtener el valor de 'FontSmoothing'. Tu codigo es el numero completo (3)." -ForegroundColor Yellow
    }
    4 {
        # Student 4: Netstat / Network. Start a background process listening on port 4444.
        # $LSO_NetListener = 1 is used instead of a comment so it doesn't nullify the rest of the command in the CLI.
        $p = Start-Process powershell.exe -ArgumentList "-NoProfile -WindowStyle Hidden -Command `"`$LSO_NetListener = 1; `$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, 4444); `$listener.Start(); while(`$true) { Start-Sleep 1 }`"" -PassThru
        $targetPid = $p.Id
        
        # Clean up old net_* files and write the file containing the secret
        Remove-Item (Join-Path $LsoFolder "net_*") -ErrorAction SilentlyContinue
        $secretFile = Join-Path $LsoFolder "net_$targetPid.txt"
        Set-Content -Path $secretFile -Value "Clave: S" -Force
        
        Write-Host "[OK] Puerto 4444 activo escuchando conexiones en el PID $targetPid." -ForegroundColor Green
        Write-Host "Mision: Usar 'netstat -ano' o el Monitor de Recursos (Red) para hallar el PID que escucha en el puerto 4444. Con ese numero, busca el archivo 'C:\LSO\net_<PID>.txt' para leer la clave." -ForegroundColor Yellow
    }
    5 {
        # Student 5: Environment Variables (NO ADMIN REQUIRED). Set user environment variable LSO_KEY = O
        [Environment]::SetEnvironmentVariable("LSO_KEY", "O", "User")
        Write-Host "[OK] Variable de entorno de usuario 'LSO_KEY' configurada." -ForegroundColor Green
        Write-Host "Mision: Abrir una consola (CMD o PowerShell) y leer el valor de la variable 'LSO_KEY' (con 'echo %LSO_KEY%' o `$env:LSO_KEY`). Tu codigo es la letra obtenida (O)." -ForegroundColor Yellow
    }
    6 {
        # Student 6: Confiabilidad. Write an error log for Siberia.exe
        $eventLog = New-Object System.Diagnostics.EventLog("Application")
        $eventLog.Source = "Application Error"
        $msg = "Fallo critico en el modulo de telemetria de la aplicacion Siberia.exe. Direccion de error: 0x00A38210. Codigo de error: H"
        $eventLog.WriteEntry($msg, [System.Diagnostics.EventLogEntryType]::Error, 1000)
        Write-Host "[OK] Evento de error de Siberia.exe registrado en el Visor de Eventos." -ForegroundColor Green
        Write-Host "Mision: Abrir el 'Monitor de Confiabilidad' (perfmon /rel), buscar el error critico registrado hoy para 'Siberia.exe', ver los detalles tecnicos y extraer la letra del 'Codigo de error'." -ForegroundColor Yellow
    }
    7 {
        # Student 7: Visor de Eventos. EventID 1337 under Application log
        New-EventLog -LogName Application -Source "LSO_Audit" -ErrorAction SilentlyContinue
        Write-EventLog -LogName Application -Source "LSO_Audit" -EntryType Information -EventId 1337 -Message "Sistema vulnerado. Codigo fragmentado: T. Registro de seguridad verificado."
        Write-Host "[OK] Evento con ID 1337 registrado en el log de Aplicacion." -ForegroundColor Green
        Write-Host "Mision: Abrir el 'Visor de Eventos' (eventvwr.msc), filtrar el registro de Aplicacion por el ID de Evento 1337 y encontrar el codigo secreto en el cuerpo del mensaje." -ForegroundColor Yellow
    }
    8 {
        # Student 8: Servicios. Display name contains LSO Service Key: Y
        # Requires Admin.
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = [Security.Principal.WindowsPrincipal]$identity
        if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
            New-Service -Name "LSO_Service" -BinaryPathName "C:\Windows\System32\svchost.exe" -DisplayName "LSO Service Key: Y" -Description "Servicio de diagnostico de LSO" -ErrorAction SilentlyContinue | Out-Null
            sc.exe config "LSO_Service" DisplayName= "LSO Service Key: Y" | Out-Null
            Write-Host "[OK] Servicio del sistema 'LSO_Service' configurado." -ForegroundColor Green
        } else {
            # Fallback mock service registry key for non-admins
            $mockServicePath = "HKCU:\Software\LSO_MockServices\LSO_Service"
            if (!(Test-Path $mockServicePath)) {
                New-Item -Path $mockServicePath -Force | Out-Null
            }
            Set-ItemProperty -Path $mockServicePath -Name "DisplayName" -Value "LSO Service Key: Y" -Force
            Write-Host "[OK] Clave de Simulacion de Servicio creada en HKCU:\Software\LSO_MockServices\LSO_Service." -ForegroundColor Green
        }
        Write-Host "Mision: Abrir 'services.msc' o usar PowerShell para buscar el servicio 'LSO_Service'. Tu codigo es la letra clave al final de su DisplayName (Y)." -ForegroundColor Yellow
    }
    9 {
        # Student 9: Simple file reading via Notepad (NO HASHING). Read C:\LSO\evidencia.txt
        $filePath = Join-Path $LsoFolder "evidencia.txt"
        $fileContent = @"
==========================================
REGISTRO DE EVIDENCIA FORENSE - MISION 9
==========================================
Analista de Sistemas, has llegado al final.
El fragmento de codigo secreto es: 5

Por favor, comparte este codigo con el lider del equipo.
"@
        [System.IO.File]::WriteAllText($filePath, $fileContent)
        Write-Host "[OK] Archivo de evidencia 'evidencia.txt' creado en C:\LSO." -ForegroundColor Green
        Write-Host "Mision: Abrir el archivo 'C:\LSO\evidencia.txt' usando el Bloc de Notas (Notepad) y leer el codigo que se encuentra alli." -ForegroundColor Yellow
    }
}

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "   [ENTORNO LISTO! A TRABAJAR]" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
