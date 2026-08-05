# Guía Práctica de Laboratorio: Permisos, Usuarios y Seguridad (Windows 11 & Linux)

## 🎯 Objetivo Práctico
Auditar y configurar permisos de seguridad avanzadas en carpetas y archivos utilizando PowerShell / `icacls` en Windows 11 y `chmod` / `chown` en Linux WSL2.

---

## 🛠️ Parte A: Permisos NTFS y ACLs en Windows 11

### Paso 1: Crear Estructura de Prueba
Abre PowerShell como Administrador:

```powershell
New-Item -Path "C:\Temp\Empresa" -ItemType Directory -Force
New-Item -Path "C:\Temp\Empresa\Privado.txt" -ItemType File -Value "Datos confidenciales de la empresa"
```

### Paso 2: Auditar Permisos Actuales con PowerShell
```powershell
Get-Acl -Path "C:\Temp\Empresa\Privado.txt" | Format-List
```

### Paso 3: Romper Herencia y Asignar Permisos Específicos
```powershell
# Romper la herencia (preservando permisos explícitos)
$acl = Get-Acl "C:\Temp\Empresa\Privado.txt"
$acl.SetAccessRuleProtection($true, $true)
Set-Acl "C:\Temp\Empresa\Privado.txt" $acl

# Quitar acceso al usuario "Usuarios" (Users) mediante icacls
icacls "C:\Temp\Empresa\Privado.txt" /remove "Usuarios"
icacls "C:\Temp\Empresa\Privado.txt" /grant:r "Administradores:(F)"
```

### Paso 4: Comprobación con `icacls`
```cmd
icacls "C:\Temp\Empresa\Privado.txt"
```

---

## 🐧 Parte B: Permisos POSIX en Linux (WSL2 / Ubuntu)

### Paso 1: Crear Archivo de Prueba en Linux
En la terminal de WSL2 (Ubuntu):

```bash
mkdir -p ~/laboratorio_permisos
cd ~/laboratorio_permisos
echo "Clave secreta de servidor" > secreto.conf
ls -la secreto.conf
```

### Paso 2: Modificar Permisos Simbólicos y Octales
```bash
# 1. Quitar todos los permisos a Otros (others) y Grupo (group)
chmod og-rwx secreto.conf
ls -la secreto.conf   # Debe mostrar: -rw------- (600 en octal)

# 2. Asignar permiso octal 644 (Lectura/Escritura para Owner, Lectura para Group y Others)
chmod 644 secreto.conf
ls -la secreto.conf   # Debe mostrar: -rw-r--r--

# 3. Hacer el script ejecutable para el propietario (755)
chmod 755 secreto.conf
ls -la secreto.conf   # Debe mostrar: -rwxr-xr-x
```

### Paso 3: Gestión de Propietario (`chown`)
```bash
# Cambiar propietario y grupo al usuario root (requiere sudo)
sudo chown root:root secreto.conf
ls -la secreto.conf

# Restablecer propietario a tu usuario
sudo chown $USER:$USER secreto.conf
```

---

## 📋 Consignas de Entrega
1. Adjuntar captura del comando `icacls` en Windows 11 mostrando la carpeta con herencia rota.
2. Adjuntar captura de `ls -la` en Linux mostrando la transición de permisos octales (600 -> 644 -> 755).
3. Responder: ¿Qué sucede cuando se aplica el comando `chmod +x` sobre un archivo de texto en Linux vs. Windows 11?
