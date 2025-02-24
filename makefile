# Last Update: 2025.02.17

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
	docker logs sup-studio -f

# Container Listesi
ps:
	watch -n 2 'docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Size}}\t{{.Ports}}" | grep sup-'

# Düzeltme
fix:
	docker network create --driver bridge proxy

# No Cache
cache:
	docker compose build --no-cache
