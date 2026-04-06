#!/bin/sh

# Definir el archivo de log
REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)
LOG_FILE="$REPO_ROOT/logs/s3.log"
mkdir -p "$(dirname "$LOG_FILE")"

{
  echo "Iniciando proceso..."

  DIRECTORIO=${1:-$DIRECTORY}
  BUCKET=${2:-$BUCKET_NAME}

  if [ -z "$DIRECTORIO" ] || [ -z "$BUCKET" ]; then
    echo "Error: Faltan variables."
    exit 1
  fi

  # Simulación de comando
  echo "Respaldando $DIRECTORIO en $BUCKET"

} 2>&1 | tee -a "$LOG_FILE"
