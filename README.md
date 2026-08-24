*This project has been created as part of the 42 curriculum by rmarrero.*

# Inception - System Administration & Docker Infrastructure

## Description

The **Inception** project at 42 aims to broaden system administration knowledge by building a complete multi-container web infrastructure using **Docker** and **Docker Compose**. 

The stack is composed of multiple autonomous microservices running on isolated containers using Debian Bullseye:

- **NGINX**: Reverse proxy acting as the single TLS (v1.2 / v1.3) secured entry point on port 443.
- **WordPress**: Web application powered by PHP-FPM (FastCGI) listening on port 9000.
- **MariaDB**: Relational database engine running on port 3306 for WordPress data persistence.
- **Redis (Bonus)**: In-memory key-value data store used for WordPress object caching.
- **FTP Server (Bonus)**: Very Secure FTP Daemon (vsftpd) providing direct file access to the WordPress web volume.
- **Adminer (Bonus)**: Lightweight database management interface served on port 8080.
- **Static Website (Bonus)**: Micro web page built with HTML/CSS served on port 8081 via a dedicated NGINX server.
- **cAdvisor (Bonus)**: Container Advisor monitoring service providing real-time resource utilization metrics on port 8082.

All services are orchestrated via custom Dockerfiles and connected through a dedicated private network (`inception_network`) with data persistence managed via host bind mounts (`/home/rmarrero/data/`).

---

## Instructions

### Prerequisites
- Operating System: Linux (Debian/Ubuntu recommended)
- Tools: `git`, `make`, `docker`, `docker compose`

### Setup & Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/rogerdevworld/inception.git
   cd inception

```

2. **Configure local domain resolving:**
Add `rmarrero.42.fr` to your `/etc/hosts` file:
```bash
echo "127.0.0.1 rmarrero.42.fr" | sudo tee -a /etc/hosts

```


3. **Set up Environment Variables:**
Copy the example environment configuration file to `srcs/.env`:
```bash
cp srcs/.env.example srcs/.env

```


*(Ensure sensitive credentials, database passwords, and data paths are properly populated in `srcs/.env`)*

### Management Commands (Makefile)

* **Build and start all services:**
```bash
make

```


* **Stop containers:**
```bash
make down

```


* **Clean Docker containers, networks, and volumes:**
```bash
make clean

```


* **Full cleanup (deletes all physical host data and images):**
```bash
make fclean

```


* **Rebuild the entire stack from scratch:**
```bash
make re

```



### Access Points (Endpoints)

| Service | Access URL / Port | Credentials / Notes |
| --- | --- | --- |
| **WordPress Website** | `https://rmarrero.42.fr` | Secured via SSL/TLS (Self-signed) |
| **WordPress Admin** | `https://rmarrero.42.fr/wp-admin` | Admin credentials set in `srcs/.env` |
| **Adminer** | `http://localhost:8080` | DB Host: `mariadb`, User: `wp_user` |
| **Static Site** | `http://localhost:8081` | Portfolio / Showcase site |
| **cAdvisor** | `http://localhost:8082` | Docker metrics dashboard |
| **FTP Server** | `ftp://localhost:21` | Login with `$FTP_USER` & `$FTP_PASSWORD` |

---

## Resources

### Documentation & Reference Materials

* [Docker Documentation](https://docs.docker.com/) - Official guide for Docker Engine and Docker Compose.
* [NGINX Beginner's Guide](https://nginx.org/en/docs/beginners_guide.html) - Configuration and FastCGI proxy setup.
* [WordPress CLI Handbook](https://developer.wordpress.org/cli/commands/) - Automating WordPress installation.
* [MariaDB Knowledge Base](https://www.google.com/search?q=https://mariadb.com/kb/en/) - Database initialization scripts and user privileges.
* [cAdvisor Github Repository](https://github.com/google/cadvisor) - Installation and volume mount configurations.

### Use of Artificial Intelligence (AI)

In accordance with 42 evaluation policies, Large Language Models (AI) were utilized during the development of this project for:

1. **Conceptual Understanding**: Clarifying Linux namespace mechanisms, cgroups limits, and TLS handshake protocols.
2. **Configuration Troubleshooting**: Debugging FastCGI protocol pass-through between NGINX and PHP-FPM, as well as fixing MariaDB startup script timing issues.
3. **Documentation Structure**: Formatting Markdown files (`README.md`, `USER_DOC.md`, `DEV_DOC.md`) to meet evaluation requirements.
4. **Code Review**: Auditing Dockerfiles and shell scripts against best practices for foreground execution (PID 1).

```

---

## 🔍 Comprobación de Requisitos Exigidos por la Hoja de Evaluación

| Requisito EvalHub | ¿Cumplido en el README? | Ubicación en el archivo |
| :--- | :---: | :--- |
| **Línea 1 exacta en cursiva:** `*This project has been created as part of the 42 curriculum by rmarrero.*` | ✅ **SÍ** | Primera línea del archivo. |
| **Sección `Description`** | ✅ **SÍ** | Sección `## Description`. |
| **Sección `Instructions`** | ✅ **SÍ** | Sección `## Instructions`. |
| **Sección `Resources`** | ✅ **SÍ** | Sección `## Resources`. |
| **Explicación del uso de IA en `Resources`** | ✅ **SÍ** | Subsección `### Use of Artificial Intelligence (AI)`. |

<FollowUp label="¿Quieres que revisemos o generemos USER_DOC.md y DEV_DOC.md para asegurar esa parte también?" query="Genera las plantillas para USER_DOC.md y DEV_DOC.md siguiendo las normas exactas del corrector de 42."/>

```

![Inception Image](./srcs/assets/inception.png)