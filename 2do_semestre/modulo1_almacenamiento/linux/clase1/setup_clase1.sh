#!/usr/bin/env bash
# ==============================================================================
# Script de Automatización y Setup: Clase 1 - Almacenamiento en Linux
# Materia: Laboratorio de Sistemas Operativos (LSO) - 4.º Año
# Descripción: Prepara un entorno seguro con imagen de disco y dispositivo loopback
# ==============================================================================

set -euo pipefail

# Colores para la salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

WORKDIR="${HOME}/lab_almacenamiento"
IMG_FILE="${WORKDIR}/disco_lab.img"
IMG_SIZE_MB=256

mostrar_ayuda() {
    echo -e "${BLUE}=================================================================${NC}"
    echo -e "${GREEN}   LSO 4to - Script de Setup: Clase 1 (Almacenamiento Linux)   ${NC}"
    echo -e "${BLUE}=================================================================${NC}"
    echo -e "Uso: $0 [OPCIÓN]"
    echo ""
    echo -e "Opciones disponibles:"
    echo -e "  ${YELLOW}--create${NC}     Crea el directorio de trabajo y la imagen de disco de 256 MB."
    echo -e "  ${YELLOW}--light${NC}      Crea la imagen en modo liviano de 64 MB (para Netbooks escolares)."
    echo -e "  ${YELLOW}--loop${NC}       Asocia la imagen existente al primer dispositivo loop libre con sondeo (-P)."
    echo -e "  ${YELLOW}--status${NC}     Muestra el estado actual del disco virtual y dispositivos loop."
    echo -e "  ${YELLOW}--cleanup${NC}    Desvincula dispositivos loop asociados y elimina la imagen de prueba."
    echo -e "  ${YELLOW}--help${NC}       Muestra este menú de ayuda."
    echo ""
}

crear_laboratorio() {
    local size="${1:-256}"
    echo -e "${BLUE}[+] Creando directorio de trabajo en: ${WORKDIR}${NC}"
    mkdir -p "${WORKDIR}"
    cd "${WORKDIR}"

    if [ -f "${IMG_FILE}" ]; then
        echo -e "${YELLOW}[!] El archivo ${IMG_FILE} ya existe. Si deseas recrearlo, ejecuta primero --cleanup.${NC}"
    else
        echo -e "${BLUE}[+] Generando archivo de imagen de disco sintético (${size} MB)...${NC}"
        dd if=/dev/zero of="${IMG_FILE}" bs=1M count="${size}" status=progress
        echo -e "${GREEN}[✔] Disco virtual creado exitosamente: ${IMG_FILE}${NC}"
    fi

    echo ""
    echo -e "${YELLOW}>>> Siguiente paso:${NC}"
    echo -e "Ejecuta ${GREEN}fdisk ${IMG_FILE}${NC} para comenzar la práctica interactiva de particionamiento."
}

asociar_loop() {
    if [ ! -f "${IMG_FILE}" ]; then
        echo -e "${RED}[✘] Error: No se encontró el archivo ${IMG_FILE}. Ejecuta primero $0 --create${NC}"
        exit 1
    fi

    echo -e "${BLUE}[+] Buscando dispositivo loop libre y asociando particiones...${NC}"
    if [ "$EUID" -ne 0 ]; then
        sudo losetup -Pf "${IMG_FILE}"
    else
        losetup -Pf "${IMG_FILE}"
    fi

    echo -e "${GREEN}[✔] Mapeo de particiones loopback completado.${NC}"
    echo -e "${BLUE}[+] Jerarquía actual de bloques:${NC}"
    lsblk
}

mostrar_estado() {
    echo -e "${BLUE}=================================================================${NC}"
    echo -e "${GREEN}           ESTADO DEL ENTORNO DE LABORATORIO                     ${NC}"
    echo -e "${BLUE}=================================================================${NC}"

    if [ -f "${IMG_FILE}" ]; then
        echo -e "${GREEN}[✔] Imagen de disco:${NC} ${IMG_FILE} ($(du -h "${IMG_FILE}" | cut -f1))"
    else
        echo -e "${RED}[✘] Imagen de disco:${NC} No creada."
    fi

    echo ""
    echo -e "${YELLOW}[+] Dispositivos Loopback Activos:${NC}"
    losetup -a || true

    echo ""
    echo -e "${YELLOW}[+] Árbol de Bloques (lsblk):${NC}"
    lsblk || true
}

limpiar_laboratorio() {
    echo -e "${YELLOW}[!] Limpiando entorno de laboratorio...${NC}"

    # Buscar si la imagen está asociada a algún dispositivo loop
    local loops
    loops=$(losetup -j "${IMG_FILE}" 2>/dev/null | cut -d: -f1 || true)

    if [ -n "${loops}" ]; then
        for l in ${loops}; do
            echo -e "${BLUE}[+] Desvinculando dispositivo ${l}...${NC}"
            if [ "$EUID" -ne 0 ]; then
                sudo losetup -d "${l}"
            else
                losetup -d "${l}"
            fi
        done
        echo -e "${GREEN}[✔] Dispositivos loop desvinculados.${NC}"
    fi

    if [ -f "${IMG_FILE}" ]; then
        rm -f "${IMG_FILE}"
        echo -e "${GREEN}[✔] Archivo ${IMG_FILE} eliminado.${NC}"
    fi

    echo -e "${GREEN}[✔] Entorno limpio y restaurado.${NC}"
}

# Control de argumentos
OPCION="${1:---help}"

case "${OPCION}" in
    --create)
        crear_laboratorio 256
        ;;
    --light)
        crear_laboratorio 64
        ;;
    --loop)
        asociar_loop
        ;;
    --status)
        mostrar_estado
        ;;
    --cleanup)
        limpiar_laboratorio
        ;;
    --help|-h)
        mostrar_ayuda
        ;;
    *)
        echo -e "${RED}[✘] Opción desconocida: ${OPCION}${NC}"
        mostrar_ayuda
        exit 1
        ;;
esac
