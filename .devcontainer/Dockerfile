# Usar una imagen base con Python y las herramientas esenciales
FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

# Instalar dependencias adicionales
RUN apt-get update && apt-get install -y \
    build-essential \
    patch \
    git \
    wget \
    curl \
    && apt-get clean
