# Inception - User Documentation

Welcome to the **Inception Infrastructure User Guide**. This document provides instructions for end-users and administrators on how to access, interact with, and utilize the services hosted within this infrastructure.

---

## 🌐 Service Endpoints Overview

All web services are accessible via localhost or the domain `rmarrero.42.fr` (after updating your local `/etc/hosts` file).

| Service | Protocol / URL | Access Purpose | Default Port |
| :--- | :--- | :--- | :--- |
| **WordPress Web Application** | `https://rmarrero.42.fr` | Main public site | `443` (TLS/SSL) |
| **WordPress Admin Panel** | `https://rmarrero.42.fr/wp-admin` | Site administration | `443` (TLS/SSL) |
| **Adminer** | `http://localhost:8080` | Database management UI | `8080` |
| **Static Website** | `http://localhost:8081` | Static portfolio page | `8081` |
| **cAdvisor** | `http://localhost:8082` | System & resource monitoring | `8082` |
| **FTP Server** | `ftp://localhost` | Remote file management | `21` |

---

## 🛠️ Detailed Usage Instructions

### 1. Navigating the WordPress Site
- **Bypassing SSL Warning:** Since the project uses a self-signed SSL certificate (`inception.crt`), your browser will display a security warning. Click **"Advanced"** and proceed to `rmarrero.42.fr` (or type `thisisunsafe` in Chrome).
- **Log in to Admin Dashboard:** Navigate to `https://rmarrero.42.fr/wp-admin`.
  - Enter your admin credentials specified in your `srcs/.env` file (`WP_ADMIN_USER` and `WP_ADMIN_PASSWORD`).
- **Object Cache Verification:** Go to **Plugins** or **Settings -> Redis** to confirm Redis cache status is **"Connected"**.

### 2. Database Management via Adminer
Adminer allows you to inspect and edit the MariaDB relational database directly:
1. Open `http://localhost:8080` in your web browser.
2. Select **System:** `MySQL`.
3. Fill in the login details from your `.env`:
   - **Server:** `mariadb`
   - **Username:** `wp_user` (or `root`)
   - **Password:** `$WP_PASSWORD` (or `$MYSQL_ROOT_PASSWORD`)
   - **Database:** `wordpress`
4. Click **Log in** to view, query, or edit tables (e.g., `wp_posts`, `wp_users`).

### 3. Uploading & Downloading Files via FTP
To manage WordPress files (`wp-content`, themes, plugins) directly:
- **CLI Connection:**
  ```bash
  ftp localhost 21