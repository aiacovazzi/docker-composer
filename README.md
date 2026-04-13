# PHP Composer Test — Laravel con Docker

Progetto didattico per imparare Laravel usando Docker (PHP 8.3 + Apache + MySQL + phpMyAdmin).

## Prerequisiti

- [Docker](https://www.docker.com/) e Docker Compose installati

## Setup iniziale

### 1. Avviare i container

```bash
docker compose up -d --build
```

### 2. Installare Laravel

```bash
docker compose exec app composer create-project laravel/laravel /tmp/laravel --no-scripts
docker compose exec app cp -a /tmp/laravel/. /var/www/html/
docker compose exec app php artisan key:generate --ansi
```

### 3. Configurare il database

Aprire il file `.env` dal proprio editor e modificare:

```env
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=app
DB_USERNAME=app
DB_PASSWORD=secret
```

### 4. Eseguire le migration

```bash
docker compose exec app php artisan migrate
```

### 5. Verificare

- **http://localhost:8080** — Applicazione Laravel
- **http://localhost:8081** — phpMyAdmin (user: `root`, password: `root`)

## Comandi utili

```bash
# Entrare nel container
docker compose exec app bash

# Eseguire le migration
php artisan migrate

# Creare un Model + Migration + Controller
php artisan make:model NomeModello -mcr

# Installare un pacchetto Composer
composer require nome/pacchetto

# Console interattiva (Tinker)
php artisan tinker

# Lista comandi Artisan
php artisan list
```

## Struttura Laravel — file principali

| Percorso | Descrizione |
|---|---|
| `routes/web.php` | Definizione delle route |
| `app/Http/Controllers/` | Controller |
| `app/Models/` | Model (Eloquent ORM) |
| `resources/views/` | Viste Blade (template HTML) |
| `database/migrations/` | Migration (schema del database) |
| `.env` | Configurazione ambiente (DB, mail, ecc.) |

## Stack Docker

| Servizio | Immagine | Porta |
|---|---|---|
| `app` | PHP 8.3 + Apache (custom) | `8080` |
| `db` | MySQL 8.0 | `3307` |
| `phpmyadmin` | phpMyAdmin 5 | `8081` |

## Stop / Restart

```bash
# Fermare i container
docker compose down

# Riavviare e ricostruire
docker compose down && docker compose up -d --build
```
