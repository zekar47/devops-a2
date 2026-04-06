#!/bin/sh

[ -f "config/config.env" ] && . ./config/config.env

# 2. Captura de argumentos con prioridad: Argumento > Variable de Entorno
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
