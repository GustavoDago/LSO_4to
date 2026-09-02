#!/usr/bin/env bash
# ==============================================================================
# Script de Automatización y Setup: Clase 2 - Sistemas de Archivos y Montaje
# Materia: Laboratorio de Sistemas Operativos (LSO) - 4.º Año
# Descripción: Automatiza formateo, montaje en /mnt, prueba de inodos y limpieza
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
MNT_EXT4="/mnt/datos_lso"
MNT_FAT="/mnt/usb_fat"

mostrar_ayuda() {
    echo -e "${BLUE}=================================================================${NC}"
    echo -e "${GREEN}   LSO 4to - Script de Setup: Clase 2 (Sistemas de Archivos)    ${NC}"
    echo -e "${BLUE}=================================================================${NC}"
    echo -e "Uso: $0 [OPCIÓN]"
    echo ""
    echo -e "Opciones disponibles:"
    echo -e "  ${YELLOW}--prepare${NC}        Prepara el disco sintético, particiona, formatea y monta en /mnt."
    echo -e "  ${YELLOW}--test-inodes${NC}    Ejecuta el experimento de consumo masivo de inodos en /mnt/datos_lso."
    echo -e "  ${YELLOW}--status${NC}         Muestra sistemas de archivos montados, espacio (-h) e inodos (-i)."
    echo -e "  ${YELLOW}--cleanup${NC}        Desmonta puntos en /mnt y desvincula dispositivos loop."
    echo -e "  ${YELLOW}--help${NC}           Muestra este menú de ayuda."
    echo ""
}

obtener_loop_activo() {
    losetup -j "${IMG_FILE}" 2>/dev/null | head -n1 | cut -d: -f1 || true
}

preparar_laboratorio() {
    echo -e "${BLUE}[+] Preparando entorno de almacenamiento para Clase 2...${NC}"
    mkdir -p "${WORKDIR}"
    cd "${WORKDIR}"

    # 1. Crear imagen si no existe
    if [ ! -f "${IMG_FILE}" ]; then
        echo -e "${BLUE}[+] Creando disco sintético de 256 MB...${NC}"
        dd if=/dev/zero of="${IMG_FILE}" bs=1M count=256 status=progress
    fi

    # 2. Particionar con GPT de forma no interactiva con sfdisk / fdisk si no está particionada
    local loop_dev
    loop_dev=$(obtener_loop_activo)

    if [ -z "${loop_dev}" ]; then
        echo -e "${BLUE}[+] Creando tabla GPT y particiones en la imagen...${NC}"
        # Script de particionamiento con sfdisk (Part1: 100M, Part2: 50M, Part3: resto)
        if command -v sfdisk &>/dev/null; then
            echo -e "label: gpt\nsize=100M, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4\nsize=50M, type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7\nsize=+, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4" | sfdisk "${IMG_FILE}" >/dev/null 2>&1 || true
        fi

        echo -e "${BLUE}[+] Vinculando dispositivo loopback...${NC}"
        if [ "$EUID" -ne 0 ]; then
            sudo losetup -Pf "${IMG_FILE}"
        else
            losetup -Pf "${IMG_FILE}"
        fi
        loop_dev=$(obtener_loop_activo)
    fi

    echo -e "${GREEN}[✔] Dispositivo loop asignado: ${loop_dev}${NC}"

    # 3. Formateo de particiones
    local p1="${loop_dev}p1"
    local p2="${loop_dev}p2"

    # En caso de no tener p1 directamente (compatibilidad con kernels antiguos)
    if [ ! -b "${p1}" ]; then
        p1="${loop_dev}"
    fi

    echo -e "${BLUE}[+] Formateando ${p1} en EXT4 (Label: DatosLSO)...${NC}"
    if [ "$EUID" -ne 0 ]; then
        sudo mkfs.ext4 -F -L "DatosLSO" "${p1}" >/dev/null 2>&1
    else
        mkfs.ext4 -F -L "DatosLSO" "${p1}" >/dev/null 2>&1
    fi

    if [ -b "${p2}" ]; then
        echo -e "${BLUE}[+] Formateando ${p2} en FAT32 (Label: USB_FAT)...${NC}"
        if [ "$EUID" -ne 0 ]; then
            sudo mkfs.vfat -F 32 -n "USB_FAT" "${p2}" >/dev/null 2>&1
        else
            mkfs.vfat -F 32 -n "USB_FAT" "${p2}" >/dev/null 2>&1
        fi
    fi

    # 4. Crear puntos de montaje y montar
    echo -e "${BLUE}[+] Creando puntos de montaje en /mnt y montando unidades...${NC}"
    if [ "$EUID" -ne 0 ]; then
        sudo mkdir -p "${MNT_EXT4}" "${MNT_FAT}"
        sudo mount "${p1}" "${MNT_EXT4}"
        if [ -b "${p2}" ]; then
            sudo mount "${p2}" "${MNT_FAT}" || true
        fi
        sudo chown -R "${USER}:${USER}" "${MNT_EXT4}"
    else
        mkdir -p "${MNT_EXT4}" "${MNT_FAT}"
        mount "${p1}" "${MNT_EXT4}"
        if [ -b "${p2}" ]; then
            mount "${p2}" "${MNT_FAT}" || true
        fi
    fi

    echo -e "${GREEN}[✔] ¡Laboratorio de la Clase 2 preparado con éxito!${NC}"
    echo ""
    mostrar_estado
}

test_inodos() {
    if ! mount | grep -q "${MNT_EXT4}"; then
        echo -e "${RED}[✘] Error: ${MNT_EXT4} no está montado. Ejecuta primero $0 --prepare${NC}"
        exit 1
    fi

    echo -e "${BLUE}=================================================================${NC}"
    echo -e "${YELLOW}       EXPERIMENTO DE LABORATORIO: AGOTAMIENTO DE INODOS        ${NC}"
    echo -e "${BLUE}=================================================================${NC}"
    echo ""
    echo -e "${BLUE}[1] Estado inicial de Inodos:${NC}"
    df -i "${MNT_EXT4}"
    echo ""
    echo -e "${BLUE}[2] Generando miles de archivos vacíos de 0 bytes en ${MNT_EXT4}/test_inodos...${NC}"
    
    mkdir -p "${MNT_EXT4}/test_inodos"
    local total=8000
    for i in $(seq 1 $total); do
        touch "${MNT_EXT4}/test_inodos/archivo_prueba_${i}.tmp" 2>/dev/null || {
            echo -e "${RED}[!] Se alcanzó el límite de inodos en el archivo ${i}.${NC}"
            break
        }
    done

    echo -e "${GREEN}[✔] Generación de archivos finalizada.${NC}"
    echo ""
    echo -e "${YELLOW}>>> Comparativa de Resultados:${NC}"
    echo -e "${GREEN}1. Consumo de Inodos (-i):${NC}"
    df -i "${MNT_EXT4}"
    echo ""
    echo -e "${GREEN}2. Consumo de Espacio en Megabytes (-h):${NC}"
    df -h "${MNT_EXT4}"
    echo ""
    echo -e "${YELLOW}Observación Didáctica: Los archivos de 0 bytes no ocupan espacio en MB pero han consumido miles de Inodos.${NC}"
}

mostrar_estado() {
    echo -e "${BLUE}=================================================================${NC}"
    echo -e "${GREEN}           ESTADO DE ALMACENAMIENTO Y MONTAJES                   ${NC}"
    echo -e "${BLUE}=================================================================${NC}"
    echo -e "${YELLOW}[+] Espacio en Disco (df -h):${NC}"
    df -h | grep -E "Filesystem|${MNT_EXT4}|${MNT_FAT}|loop" || true
    echo ""
    echo -e "${YELLOW}[+] Tabla de Inodos (df -i):${NC}"
    df -i | grep -E "Filesystem|${MNT_EXT4}|${MNT_FAT}|loop" || true
    echo ""
    echo -e "${YELLOW}[+] Jerarquía lsblk:${NC}"
    lsblk || true
}

limpiar_laboratorio() {
    echo -e "${YELLOW}[!] Desmontando unidades y limpiando laboratorio...${NC}"
    cd "${HOME}"

    # Desmontar
    for m in "${MNT_EXT4}" "${MNT_FAT}"; do
        if mount | grep -q "${m}"; then
            echo -e "${BLUE}[+] Desmontando ${m}...${NC}"
            if [ "$EUID" -ne 0 ]; then
                sudo umount -f "${m}" || true
            else
                umount -f "${m}" || true
            fi
        fi
    done

    # Desvincular loops
    local loops
    loops=$(losetup -j "${IMG_FILE}" 2>/dev/null | cut -d: -f1 || true)
    if [ -n "${loops}" ]; then
        for l in ${loops}; do
            echo -e "${BLUE}[+] Desvinculando loop ${l}...${NC}"
            if [ "$EUID" -ne 0 ]; then
                sudo losetup -d "${l}" || true
            else
                losetup -d "${l}" || true
            fi
        done
    fi

    # Eliminar imagen si se desea
    if [ -f "${IMG_FILE}" ]; then
        rm -f "${IMG_FILE}"
        echo -e "${GREEN}[✔] Archivo ${IMG_FILE} eliminado.${NC}"
    fi

    echo -e "${GREEN}[✔] Limpieza completada con éxito.${NC}"
}

# Control de argumentos
OPCION="${1:---help}"

case "${OPCION}" in
    --prepare|--setup)
        preparar_laboratorio
        ;;
    --test-inodes)
        test_inodos
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
