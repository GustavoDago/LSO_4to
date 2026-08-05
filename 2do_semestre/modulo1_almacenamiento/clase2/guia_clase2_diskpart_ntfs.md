# Clase 2: Particionamiento y Formateo NTFS por Consola (`diskpart` & PowerShell)

* **Módulo:** 1 - Almacenamiento y Sistemas de Archivos
* **Duración:** 2 Horas Reloj (Día Jueves)
* **Requisitos:** Windows 11 / PowerShell y CMD como Administrador

---

## 🎯 Objetivos de la Clase
1. Dominar el particionamiento de bajo nivel con la herramienta interactiva `diskpart`.
2. Formatear unidades en sistema de archivos **NTFS** y comprender el rol de la MFT (*Master File Table*).
3. Aplicar cmdlets de PowerShell (`New-Partition`, `Format-Volume`) para la gestión automatizada de volúmenes.

---

## 📖 Momento 1: Explicación Teórica con NotebookLM (15 min)
* **Estructura Interna de NTFS:** MFT (*Master File Table*), registros de metadatos, soporte para permisos ACL, compresión y Journaling (registro transaccional de cambios).
* **Diferencia entre Partición y Volumen:** La partición es la división física/lógica del disco; el volumen es el contenedor formateado con un sistema de archivos listo para montar.

---

## 💻 Momento 2: Laboratorio Práctico en Consola (75 min)

### Escenario A: Trabajo Interactivo en `diskpart` (CMD / PowerShell)
```cmd
diskpart
list disk
select disk <Número_del_VHD_Clase1>
clean
convert gpt
create partition primary size=500
format fs=ntfs quick label="LSO_DATOS"
assign letter=Z
list volume
exit
```

### Escenario B: Automatización mediante PowerShell
```powershell
# Particionar el disco virtual sin usar la GUI
$disk = Get-Disk | Where-Object IsVirtual -eq $true | Select-Object -First 1
$partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -AssignDriveLetter
Format-Volume -Partition $partition -FileSystem NTFS -NewFileSystemLabel "LSO_NTFS" -Confirm:$false
```

---

## 🎮 Momento 3: Cierre y Trivia Kahoot (15 min)
Resolver el cuestionario interactivo de fijación en Kahoot (disponible en `kahoot_clase2.md`).
