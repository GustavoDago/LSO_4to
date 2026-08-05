# Resumen Pedagógico para NotebookLM: Clase 1 - Arquitectura de Almacenamiento y GPT

## 📌 Sinopsis del Contenido
Este material proporciona la base teórica y conceptual sobre cómo los sistemas operativos modernos organizan y gestionan la información en medios de almacenamiento masivo.

---

## 🔑 Conceptos Clave

1. **MBR vs. GPT:**
   * **MBR (Master Boot Record):** Guardado en el primer sector de 512 bytes del disco. Incluye el código de arranque y la tabla de 4 entradas. Limitado a 2 TB de direccionamiento por sector de 512 bytes.
   * **GPT (GUID Partition Table):** Utiliza identificadores globales únicos para cada partición. Mantiene una copia de respaldo de la tabla al final del disco (*Secondary GPT Header*) para recuperación ante fallos de hardware.

2. **Ventajas del Almacenamiento Virtualizado (VHD/VHDX):**
   * **VHD (Virtual Hard Disk):** Formato contenedor estandarizado para máquinas virtuales y sistemas de prueba.
   * **Dinámico vs. Fijo:** El formato dinámico ocupa en el disco real solo el espacio ocupado por los archivos guardados, creciendo hasta el tamaño máximo asignado.

3. **Glosario Técnico:**
   * **PartitionStyle:** Esquema de la tabla de particiones (`RAW`, `MBR`, `GPT`).
   * **Diskpart:** Utilidad nativa de línea de comandos de bajo nivel de Windows.
