#!/bin/bash

# 1. Limpieza de instalaciones previas que causan conflictos
echo "Cleaning up old Docker versions..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null

# 2. Instalación de herramientas base
echo "Installing curl, git, make and certificates..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release git build-essential

# 3. Configurar la clave GPG de Docker (Método moderno)
echo "Setting up Docker GPG key..."
sudo mkdir -p /etc/apt/keyrings
# Borramos si existía una clave corrupta anterior
sudo rm -f /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 4. Configurar el repositorio según tu distribución (Ubuntu, Debian, Mint, etc.)
echo "Configuring repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Instalación final
echo "Installing Docker Engine and Compose..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 6. Permisos de usuario
sudo usermod -aG docker $USER

echo "----------------------------------------------------"
echo "¡Listo! Reinicia tu terminal o ejecuta: newgrp docker"