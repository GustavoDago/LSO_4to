# Módulo 3: Virtualización Ligera (WSL2) + Scripting en Bash

## 📌 Objetivos del Módulo
1. Entender la arquitectura de virtualización ligera mediante WSL2 (Windows Subsystem for Linux 2) sobre Windows 11.
2. Manejar la interoperabilidad del sistema de archivos entre Windows 11 (`C:\`) y Linux (`/mnt/c`).
3. Dominar la sintaxis de programación de scripts en Bash (`.sh`): variables, condicionales (`if`), bucles (`for`, `while`), parámetros `$1` y funciones.
4. Automatizar tareas del sistema con el programador de tareas `cron` y scripts de diagnóstico.

---

## 📅 Contenidos Específicos
* **Virtualización Ligera (WSL2):** Kernel Linux real sobre Hyper-V en Windows 11, comandos `wsl --list`, `wsl --status`, `wsl --shutdown`.
* **Interoperabilidad:** Montaje del sistema host (`/mnt/c`), ejecución cruzada de binarios de Windows desde Linux (`ipconfig.exe`, `powershell.exe`).
* **Bash Scripting:** Shebang (`#!/bin/bash`), tipos de variables, entrada de usuario (`read`), estructuras condicionales, bucles y manipulación de texto con `grep`, `awk` y `sed`.
* **Automatización:** Tareas periódicas con `crontab -e`.
