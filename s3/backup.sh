#!/bin/sh

# Definir el archivo de log
REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)
LOG_FILE="$REPO_ROOT/logs/s3.log"
FECHA="$(date +%Y%m%d_%H%M%S)"
TMP_FILE="$(mktemp)"
mkdir -p "$(dirname "$LOG_FILE")"

{
    echo "Iniciando proceso..."

    DIRECTORIO=${1:-$DIRECTORY}
    BUCKET=${2:-$BUCKET_NAME}

    if [ -z "$DIRECTORIO" ] || [ -z "$BUCKET" ]; then
        echo "Error: Faltan variables."
        exit 1
    fi

    echo "[$FECHA] Comprimiendo $DIRECTORIO..."
    if tar -czf "$TMP_FILE" "$DIRECTORIO"; then
        echo "[$FECHA] Éxito: Compresión exitosa."

        echo "[$FECHA] Subiendo a s3://$BUCKET..."
        if aws s3 cp "$TMP_FILE" "s3://$BUCKET/"; then
            echo "[$FECHA] Éxito: Backup completado."
            rm "$TMP_FILE"
        else
            echo "[$FECHA] Error: Falló la subida a S3."
            rm "$TMP_FILE"
            exit 1
        fi
    else
        echo "[$FECHA] Error: Falló la compresión."
        exit 1
    fi

} 2>&1 | tee -a "$LOG_FILE"
