# Last Update: 2025.02.17

# Proje Adı
project_name = "sup-"

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
	docker logs $(project_name)studio -f

# Container Listesi
ps:
	docker ps --format "\nNames: {{.Names}} \nID: {{.ID}} \nSize: {{.Size}} \nStatus: {{.Status}} \nPorts: {{.Ports}} " | grep -A 3 "Names: $(project_name) "

# Düzeltme
fix:
	docker network create --driver bridge proxy

# No Cache
cache:
	docker compose build --no-cache
