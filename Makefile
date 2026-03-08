NAME		= inception
COMPOSE		= ./srcs/docker-compose.yml
DATA_PATH	= /home/rmarrero/data

GREEN		= \033[0;32m
RED			= \033[0;31m
RESET		= \033[0m

all: build up

DOCKER_COMPOSE = docker compose --env-file srcs/.env -f srcs/docker-compose.yml

build:
	@echo "$(GREEN)Creando directorios para volúmenes en $(DATA_PATH)...$(RESET)"
	@mkdir -p $(DATA_PATH)/db_data
	@mkdir -p $(DATA_PATH)/website_files
	@echo "$(GREEN)Construyendo contenedores...$(RESET)"
	$(DOCKER_COMPOSE) build

up:
	@echo "$(GREEN)Levantando servicios...$(RESET)"
	$(DOCKER_COMPOSE) up -d

down:
	@echo "$(RED)Deteniendo servicios...$(RESET)"
	$(DOCKER_COMPOSE) down

clean: down
	@echo "$(RED)Limpiando imágenes y redes de Docker...$(RESET)"
	@docker system prune -a -f

fclean: clean
	@echo "$(RED)Borrando volúmenes y datos físicos en $(DATA_PATH)...$(RESET)"
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf $(DATA_PATH)

re: fclean all

.PHONY: all build up down clean fclean re