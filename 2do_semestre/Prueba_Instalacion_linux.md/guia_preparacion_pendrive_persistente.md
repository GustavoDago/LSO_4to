# Guía de Laboratorio: Creación de Pendrive Persistente con Lubuntu / Linux Mint y Rufus

* **Materia:** Laboratorio de Sistemas Operativos (LSO) - 4.º Año
* **Especialidad:** Tecnicatura en Informática Personal y Profesional
* **Destinatarios:** Alumnos y Docentes de LSO
* **Propósito:** Disponer de un entorno Linux nativo completo y portable para las prácticas del 2.º Semestre, garantizando la persistencia de configuraciones y archivos sin modificar el disco rígido ni alterar la congelación (*Deep Freeze*) de las PCs del colegio.

---

## 🧭 1. ¿Qué es un Live USB Persistente y por qué lo usamos?

Cuando iniciamos una distribución Linux desde un pendrive "Live" tradicional, el sistema corre 100% en la memoria RAM. Al apagar el equipo, cualquier archivo creado, programa instalado o configuración se pierde por completo.

Un **Live USB con Persistencia** soluciona esto agregando una partición o archivo especial de almacenamiento (llamado `casper-rw`). De este modo:
* **Persistencia Total:** Los paquetes que instales (`sudo apt install ...`), tus scripts en Bash y las configuraciones de red o servicios (`sshd`, `ufw`) quedan guardados en el pendrive para la próxima clase.
* **Cero Impacto en el Colegio:** No toca la tabla de particiones del disco rígido local de la computadora ni altera el software *Deep Freeze*.
* **Portabilidad:** Puedes continuar tu práctica en tu casa o en cualquier computadora del laboratorio conectando tu pendrive.

```
┌────────────────────────────────────────────────────────┐
│               MEMORIA USB (PENDRIVE)                   │
├─────────────────────────┬──────────────────────────────┤
│  Partición 1: ISO Linux │ Partición 2: Casper-RW       │
│  (Solo Lectura / Boot)  │ (Espacio Persistente: Datos, │
│  Lubuntu / Mint XFCE    │  Scripts, Paquetes Instalados│
└─────────────────────────┴──────────────────────────────┘
```

---

## 🧰 2. Requisitos Previos

1. **Unidad Flash USB (Pendrive):** Capacidad mínima de **8 GB** (recomendado **16 GB o 32 GB**, preferentemente USB 3.0 para mayor velocidad).
   > [!WARNING]
   > El proceso de flasheo formateará el pendrive. **Respalda cualquier archivo personal previo que tengas en esa memoria.**
2. **Imagen ISO de Linux (Liviana):**
   * **Opción Recomendada 1:** [Lubuntu Desktop (LXQt)](https://lubuntu.me/) - Consumo mínimo de RAM (< 600 MB) e ideal para pendrives.
   * **Opción Recomendada 2:** [Linux Mint XFCE](https://linuxmint.com/) - Muy amigable y basada en Ubuntu.
3. **Software Rufus para Windows:** Descargar la versión portable desde [rufus.ie](https://rufus.ie/).

---

## 🚀 3. Paso a Paso: Flasheo con Persistencia en Rufus

1. Conecta el pendrive en una PC con Windows y abre **Rufus** (como Administrador).
2. En el menú desplegable **Dispositivo**, selecciona la unidad de tu pendrive.
3. En **Elección de arranque**, haz clic en el botón **SELECCIONAR** y busca el archivo ISO descargado (ej. `lubuntu-XX.XX-desktop-amd64.iso`).
4. **¡EL PASO CLAVE - TAMAÑO DE PARTICIÓN PERSISTENTE!**
   * Verás que se habilita un control deslizante llamado **Tamaño de partición persistente** (*Persistent partition size*).
   * Desliza la barra para asignar espacio a la persistencia:
     * Si tu pendrive es de **8 GB:** Asigna entre **3 GB y 4 GB**.
     * Si tu pendrive es de **16 GB:** Asigna entre **8 GB y 10 GB**.
     * Si tu pendrive es de **32 GB:** Asigna **15 GB o más**.
5. En **Esquema de partición**, selecciona **GPT** (para computadoras UEFI modernas) o **MBR** si trabajas en netbooks escolares más antiguas con BIOS heredada.
6. En **Sistema de destino**, selecciona **UEFI (no CSM)**.
7. Haz clic en el botón **EMPEZAR**.
   * Si Rufus muestra un diálogo sobre modo ISO vs modo DD, selecciona **Escribir en modo imagen ISO (Recomendado)**.
   * Acepta la advertencia de formateo de datos y espera a que la barra de progreso llegue al 100% (**PREPARADO**).

---

## 💻 4. Cómo Iniciar la Computadora desde el Pendrive (Boot Menu)

No es necesario ingresar a la configuración del BIOS Setup ni cambiar configuraciones permanentes. Usamos la **tecla de acceso rápido al Menú de Inicio temporal**:

1. Conecta el pendrive en un puerto USB de la computadora (si tiene puertos azules USB 3.0, úsalos para mayor rapidez).
2. Enciende la computadora y presiona **inmediatamente y de forma repetida** la tecla de Menú de Arranque según la marca del equipo:
   * **HP / Compaq:** Tecla `F9` o `Esc`
   * **Lenovo / ThinkPad:** Tecla `F12` (o botón Novo / `Fn + F12`)
   * **Dell:** Tecla `F12`
   * **Asus:** Tecla `F8` o `Esc`
   * **Acer:** Tecla `F12`
   * **Exomate / Positivo BGH / Netbooks Escolares:** Tecla `F11` o `F12`
3. En la lista desplegable de dispositivos que aparecerá en pantalla, usa las flechas del teclado para seleccionar tu unidad USB (suele aparecer como *UEFI: Kingston / Sandisk / Generic USB*) y presiona **Enter**.
4. En el menú GRUB de bienvenida, selecciona **Lubuntu** o **Linux Mint** e inicia el sistema.

---

## 🧪 5. Prueba de Fuego: Verificación de la Persistencia

Para asegurarte de que tu entorno está guardando los datos correctamente antes de iniciar las prácticas:

1. Abre una terminal en Linux (`Ctrl + Alt + T`).
2. Crea una carpeta de trabajo y un archivo de prueba con un mensaje:
   ```bash
   mkdir -p ~/LSO_Practicas
   echo "Prueba de persistencia exitosa - LSO 4to" > ~/LSO_Practicas/test.txt
   ```
3. Instala una herramienta de monitoreo del sistema:
   ```bash
   sudo apt update
   sudo apt install -y htop tree
   ```
4. Reinicia la computadora (`sudo reboot`), retira el pendrive para verificar que Windows 11 arranca normal e intacto.
5. Vuelve a conectar el pendrive, arranca con el **Boot Menu** y ejecuta en la terminal:
   ```bash
   cat ~/LSO_Practicas/test.txt
   htop
   ```
   * Si el archivo contiene el texto y `htop` abre directamente sin tener que instalarlo de nuevo: **¡Tu entorno persistente está 100% operativo y listo para todo el semestre!**

---

## 🛡️ 6. Buenas Prácticas de Trabajo y Seguridad

1. **Apagado Seguro:** Apaga siempre el sistema desde el menú gráfico o ejecutando `sudo poweroff` en terminal. **Nunca desconectes el pendrive mientras la PC esté encendida**, para evitar corromper la partición `casper-rw`.
2. **Respaldo en la Nube (Google Drive / Classroom):** Aunque la persistencia es confiable, acostumbra subir una copia de tus scripts `.sh` y reportes a Google Drive o al Classroom de la materia al terminar la clase.
3. **No tocar los discos locales internos:** En las prácticas de almacenamiento (`fdisk`, `mkfs`, `dd`), **siempre** utilizaremos archivos contenedores de imagen (`~/disco.img`) y montaje en loopback (`mount -o loop`). De esta forma nunca pondremos en riesgo las particiones reales del laboratorio.
