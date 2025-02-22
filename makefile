# Last Update: 2025.02.17

# Proje Adı
project_name = supabase

# Yeniden Başlat
restart:
	docker compose down -v --remove-orphans
	docker compose up -d --build

# Build
build:
	docker compose build

# Başlat
up:
	docker compose up -d

# Kapat
down:
	docker compose down -v --remove-orphans

# Temizle
clean:
	docker system prune -a

# Log
log:
	docker logs $(project_name) -f

# Container Listesi
ps:
	docker ps --format "\nNames: {{.Names}} \nID: {{.ID}} \nSize: {{.Size}} \nStatus: {{.Status}} \nPorts: {{.Ports}} "

# Düzeltme
fix:
	docker network create --driver bridge proxy

# No Cache
cache:
	docker compose build --no-cache
