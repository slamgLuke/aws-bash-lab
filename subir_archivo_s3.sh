#!/bin/bash
# Sube un archivo local a un bucket S3

if [ $# -lt 2 ]; then
    echo "Uso: $0 <archivo_local> <bucket_s3>"
    exit 1
fi

ARCHIVO="$1"
BUCKET="$2"

if ! command -v aws &> /dev/null; then
    echo "AWS CLI no está instalado."
    exit 1
fi

if ! aws sts get-caller-identity &> /dev/null; then
    echo "No estás autenticado en AWS CLI."
    exit 2
fi

if [ ! -f "$ARCHIVO" ]; then
    echo "El archivo '$ARCHIVO' no existe."
    exit 3
fi

echo "Subiendo $ARCHIVO a s3://$BUCKET/ ..."
if aws s3 cp "$ARCHIVO" "s3://$BUCKET/"; then
    echo "✅ Archivo subido correctamente."
else
    echo "❌ Error al subir el archivo."
    exit 4
fi