#!/bin/bash
# Lista buckets S3, usuarios y roles IAM

if ! command -v aws &> /dev/null; then
    echo "AWS CLI no está instalado."
    exit 1
fi

if ! aws sts get-caller-identity &> /dev/null; then
    echo "No estás autenticado en AWS CLI."
    exit 2
fi

echo "\n=== Buckets S3 ==="
aws s3 ls

echo "\n=== Usuarios IAM ==="
aws iam list-users --output table

echo "\n=== Roles IAM ==="
aws iam list-roles --output table | head -30