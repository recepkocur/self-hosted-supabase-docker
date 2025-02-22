# Self-Hosted Supabase Docker

> Son Güncelleme: 17.02.2025

Bu proje, Supabase'in kendi VPS sunucumda self-hosted olarak çalıştırılması için hazırladığım Docker tabanlı bir altyapı projesidir. Supabase'in açık kaynak kodlu olması sayesinde, kendi sunucumda tam kontrol sağlayarak çalıştırabiliyorum.

## Neden Self-Hosted Supabase?

Modern web ve mobil uygulamalarım için merkezi bir backend platformuna ihtiyaç duyuyorum. Supabase'in sunduğu:

- Gerçek zamanlı veritabanı
- Kimlik doğrulama
- Dosya depolama
- Edge Functions
- Auto-API oluşturma

gibi özellikleri kendi sunucumda barındırarak, verilerimin tam kontrolünü sağlayabiliyorum. Bu sayede:

- Veri egemenliği
- Maliyet optimizasyonu
- Özelleştirilebilir altyapı
- Yüksek performans

avantajlarından faydalanabiliyorum.

## Teknik Altyapı

Projede kullanılan temel bileşenler:

- Ubuntu 24.04+ VPS sunucu
- Docker 28.0.0
- Traefik reverse proxy
- Cloudflare DNS ve SSL
- OpenAI API entegrasyonu
- GitHub Actions CI/CD

## Yapılandırmalar

### 1. Traefik Yapılandırması

- SSL sertifikalarının otomatik yönetimi
- Reverse proxy ile güvenli yönlendirme
- Let's Encrypt entegrasyonu

### 2. GitHub Actions Deployment

- Main branch -> Development ortamı
- Prod branch -> Production ortamı
- Otomatik deployment ve rollback
- SSH ile güvenli bağlantı

### 3. Supabase Servisleri

- PostgreSQL veritabanı
- GoTrue auth servisi
- Storage API
- Realtime
- Edge Functions
- PostgREST API

### 4. Güvenlik Yapılandırmaları

- SSL sertifikaları (Traefik + Cloudflare)
- JWT token yönetimi
- API key rotasyonu
- Role-based access control

### 5. Entegrasyonlar

- Cloudflare DNS yönetimi
- OpenAI API bağlantısı
- SMTP mail servisi
- S3 uyumlu storage

## Kurulum ve Yapılandırması

```bash
git clone https://github.com/username/vps-docker-supabase
cd vps-docker-supabase
cp .env.example .env
```

### .env dosyasını düzenleyin

SELF_HOST_NAME parametresi, Traefik reverse proxy için domain adını belirtir. Bu parametre:

- Sadece domain adı formatında olmalıdır (örn: api.example.com)
- http:// veya https:// protokol belirteçleri içermemelidir
- Alt domain kullanılabilir (örn: supabase.example.com)
- Doğru format: api.domain.com
- Yanlış format: https://api.domain.com

Bu parametre Traefik'in SSL sertifikası yönetimi ve reverse proxy yönlendirmeleri için kullanılır. docker-compose.dev.yml dosyasında ilgili servislerin labels kısmında kullanılmaktadır.

Örnek kullanım:

```bash
SELF_HOST_NAME=kong.example.com
```

docker-compose -f docker-compose.dev.yml up -d

## Deployment

Proje, GitHub Actions üzerinden otomatik deployment sürecine sahip:

- `main` branch -> Development ortamı
- `prod` branch -> Production ortamı

Her push işleminde ilgili ortama otomatik deployment gerçekleşir.

## Komutlar

### Reset İşlemi

Projeyi sıfırlamak için `reset.sh` betiği kullanılır. Bu betik:

- Tüm Docker container'ları durdurur ve siler
- Bind-mount edilmiş dizinleri temizler
- .env dosyasını korur (güvenlik nedeniyle)

Kullanımı:

```bash
./reset.sh
```

Not: Güvenlik nedeniyle .env dosyası reset işleminde silinmez. Eğer .env dosyasını da sıfırlamak isterseniz, reset.sh dosyasındaki ilgili yorum satırlarını kaldırabilirsiniz.

reset.sh dosyasındaki yorum satırına alınan kısım (.env ile ilgili), hassas verileri içeren .env dosyasının yanlışlıkla silinmesini önlemek için kapatılmıştır. Bu sayede:

1. Mevcut çalışan ortamın konfigürasyonu korunur
2. Kritik API anahtarları ve şifreler güvende kalır
3. Production ortamında yanlış konfigürasyon oluşması engellenir

İlgili kod bloğu:

```29:42:reset.sh
# echo "Resetting .env file..."
# if [ -f ".env" ]; then
#   echo "Removing existing .env file..."
#   rm -f .env
# else
#   echo "No .env file found. Skipping .env removal step..."
# fi

# if [ -f ".env.example" ]; then
#   echo "Copying .env.example to .env..."
#   cp .env.example .env
# else
#   echo ".env.example file not found. Skipping .env reset step..."
# fi
```

Bu kısım ihtiyaç halinde yorum satırından çıkarılarak aktif edilebilir, ancak özellikle production ortamında dikkatli kullanılmalıdır.

## Gereksinimler

- Ubuntu 24.04+ VPS sunucu
- Docker 28.0.0+
- Domain name
- Cloudflare hesabı
- OpenAI API key (opsiyonel)

## Katkıda Bulunma

Bu projeyi açık kaynak olarak paylaşıyorum. Self-hosted Supabase kurmak isteyen geliştiriciler için bir başlangıç noktası olmasını umuyorum. Issues ve Pull Request'lere açığım.

## Lisans

MIT License - Detaylar için LICENSE dosyasına bakın.

## Destek

Sorularınız ve sorunlarınız için lütfen [Supabase GitHub Issues](https://github.com/supabase/supabase/issues) sayfasını kullanın.
