#!/bin/sh

[ -f "config/config.env" ] && . ./config/config.env

ACCION=$1
ID_INSTANCIA=${2:-$INSTANCE_ID}
DIR_BACKUP=${3:-$DIRECTORY}
S3_BUCKET=${4:-$BUCKET_NAME}

if [ -z "$ACCION" ]; then
    echo "Error: Uso: $0 <accion> [id_instancia] [directorio] [bucket]"
    exit 1
fi

echo "--- Iniciando Orquestación DevOps ---"
echo "Acción: $ACCION | Instancia: $ID_INSTANCIA"

echo "[PASO 1] Gestionando infraestructura EC2..."
if python3 ec2/gestionar_ec2.py "$ACCION" "$ID_INSTANCIA"; then
    echo "Operación EC2 completada con éxito."
else
    echo "Error crítico en el script de Python. Abortando."
    exit 1
fi
