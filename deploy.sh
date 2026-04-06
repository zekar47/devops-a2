#!/bin/sh

LOG_FILE="$(dirname "$0")/logs/deploy.log"
mkdir -p "$(dirname "$LOG_FILE")"

[ -f "config/config.env" ] && . ./config/config.env

{
    ACCION=$1
    ID_INSTANCIA=${2:-$INSTANCE_ID}
    DIR_BACKUP=${3:-$DIRECTORY}
    S3_BUCKET=${4:-$BUCKET_NAME}

    if [ -z "$ACCION" ]; then
        echo "Error: Uso: $0 <accion> [id_instancia] [directorio] [bucket]"
        exit 1
    fi

    echo "[PASO 1] Gestionando infraestructura EC2..."
    if python3 ec2/gestionar_ec2.py "$ACCION" "$ID_INSTANCIA"; then
        echo "Operación EC2 completada con éxito."
    else
        echo "Error crítico en el script de Python. Abortando."
        exit 1
    fi

    echo "[INFO] Iniciando respaldo de seguridad en S3..."
    if [ -n "$DIR_BACKUP" ] && [ -n "$S3_BUCKET" ]; then
        sh s3/backup.sh "$DIR_BACKUP" "$S3_BUCKET"
    else
        echo "[WARN] Saltando backup: Faltan variables de S3."
    fi
} 2>&1 | tee -a "$LOG_FILE"
