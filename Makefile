# Makefile for the Inception
NAME		= inception
COMPOSE		= ./srcs/docker-compose.yml
# Usamos tu login para la ruta de datos como pide el subject
DATA_PATH	= /home/rmarrero/data

# Colores para que la terminal se vea bien
GREEN		= \033[0;32m
RED			= \033[0;31m
RESET		= \033[0m

all: build up

# Añadimos el flag --env-file para que sepa exactamente dónde está el secreto
DOCKER_COMPOSE = docker compose --env-file srcs/.env -f srcs/docker-compose.yml

# 1. Crear directorios y construir imágenes
build:
	@echo "$(GREEN)Creando directorios para volúmenes en $(DATA_PATH)...$(RESET)"
	@mkdir -p $(DATA_PATH)/db_data
	@mkdir -p $(DATA_PATH)/website_files
	@echo "$(GREEN)Construyendo contenedores...$(RESET)"
	$(DOCKER_COMPOSE) build

# 2. Levantar los servicios
up:
	@echo "$(GREEN)Levantando servicios...$(RESET)"
	$(DOCKER_COMPOSE) up -d

# 3. Detener los servicios
down:
	@echo "$(RED)Deteniendo servicios...$(RESET)"
	$(DOCKER_COMPOSE) down

# 4. Limpieza total (Borra contenedores, imágenes y redes)
clean: down
	@echo "$(RED)Limpiando imágenes y redes de Docker...$(RESET)"
	@docker system prune -a -f

# 5. Limpieza profunda (¡CUIDADO! Borra también los volúmenes/datos)
fclean: clean
	@echo "$(RED)Borrando volúmenes y datos físicos en $(DATA_PATH)...$(RESET)"
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf $(DATA_PATH)

# 6. Reiniciar todo
re: fclean all

.PHONY: all build up down clean fclean re