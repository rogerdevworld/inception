#!/bin/bash

# 1. Actualizar el índice de paquetes e instalar dependencias iniciales
echo "Updating system and installing base tools (curl, git, make)..."
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
    build-essential  # Esto incluye 'make'

# 2. Agregar la clave GPG oficial de Docker
echo "Adding Docker's GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 3. Configurar el repositorio de Docker
echo "Setting up Docker repository..."
echo \
  "座eb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Instalar Docker Engine y Docker Compose
echo "Installing Docker and Docker Compose..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 5. Configurar permisos para el usuario actual (opcional)
# Esto permite ejecutar docker sin usar 'sudo'
echo "Configuring user permissions..."
sudo usermod -aG docker $USER

echo "----------------------------------------------------"
echo "¡Instalación completada con éxito!"
echo "IMPORTANTE: Cierra sesión y vuelve a entrar para aplicar los cambios de grupo."
echo "Versiones instaladas:"
docker --version
docker compose version
git --version
make --version