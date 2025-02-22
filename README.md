# Self-Hosted Supabase Docker

> Son Güncelleme: 17.02.2025

Bu proje, Supabase'in kendi VPS sunucunuzda self-hosted olarak çalıştırılması için hazırlanmış Docker tabanlı bir altyapı projesidir. Supabase'in tüm temel özelliklerini kendi kontrolünüz altında çalıştırmanıza olanak sağlar.

## İçindekiler

1. [Öne Çıkan Özellikler](#öne-çıkan-özellikler)
2. [Desteklenen Servisler](#desteklenen-servisler)
3. [Güvenlik Özellikleri](#güvenlik-özellikleri)
4. [Performans İyileştirmeleri](#performans-iyileştirmeleri)
5. [Monitoring ve Logging](#monitoring-ve-logging)
6. [Yedekleme ve Felaket Kurtarma](#yedekleme-ve-felaket-kurtarma)
7. [Neden Self-Hosted Supabase?](#neden-self-hosted-supabase)
8. [Teknik Altyapı](#teknik-altyapı)
9. [Yapılandırmalar](#yapılandırmalar)
10. [Kurulum ve Yapılandırması](#kurulum-ve-yapılandırması)
11. [Deployment](#deployment)
12. [Komutlar](#komutlar)
13. [Gereksinimler](#gereksinimler)
14. [Sistem Gereksinimleri](#sistem-gereksinimleri)
15. [Hata Ayıklama](#hata-ayıklama)
16. [Güvenlik Sıkılaştırma](#güvenlik-sıkılaştırma)
17. [Katkıda Bulunma](#katkıda-bulunma)
18. [Lisans](#lisans)
19. [Destek](#destek)

## Öne Çıkan Özellikler

- 🔒 **Tam Veri Kontrolü**: Verileriniz kendi sunucunuzda, sizin kontrolünüzde
- 🚀 **Kolay Kurulum**: Docker Compose ile tek komutta ayağa kaldırma
- 🔄 **Otomatik SSL**: Traefik ile otomatik SSL sertifika yönetimi
- 📦 **Modüler Yapı**: İhtiyacınıza göre servisleri özelleştirme imkanı
- 🛡️ **Güvenlik Odaklı**: JWT, API key rotasyonu ve rol tabanlı erişim kontrolü
- 🔄 **CI/CD Entegrasyonu**: GitHub Actions ile otomatik deployment
- 📊 **Monitoring**: Realtime izleme ve loglama altyapısı

## Desteklenen Servisler

- PostgreSQL Veritabanı (15.8.1)
- Kong API Gateway (2.8.1)
- GoTrue Auth Servisi (v2.167.0)
- Storage API (v1.14.5)
- Realtime (v2.34.7)
- Edge Functions (v1.67.0)
- PostgREST API (v12.2.0)
- Supabase Studio UI

## Güvenlik Özellikleri

- SSL/TLS şifreleme (Traefik + Let's Encrypt)
- JWT tabanlı kimlik doğrulama
- API anahtarı rotasyonu
- Rol tabanlı erişim kontrolü (RBAC)
- Güvenli environment değişkeni yönetimi
- Docker container izolasyonu

## Performans İyileştirmeleri

- Connection pooling optimizasyonu
- Önbellekleme stratejileri
- Yük dengeleme
- Otomatik ölçeklendirme desteği
- Query optimizasyonu

## Monitoring ve Logging

- Realtime sistem metrikleri
- Detaylı log kayıtları
- Hata izleme ve raporlama
- Performans metrikleri
- Kaynak kullanım istatistikleri

## Yedekleme ve Felaket Kurtarma

- Otomatik veritabanı yedekleme
- Yedekleme rotasyonu
- Hızlı geri yükleme prosedürleri
- Veri replikasyonu seçenekleri

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

## Kurulum Öncesi Hazırlık

1. Domain ayarları:
   - A kaydı: api.domain.com -> Sunucu IP
   - CNAME: \*.api.domain.com -> api.domain.com
2. Cloudflare Ayarları:

   - SSL/TLS modu: Full (strict)
   - Edge Certificates: Aktif
   - Always Use HTTPS: Aktif

3. Güvenlik Duvarı Ayarları:
   - HTTP (80)
   - HTTPS (443)
   - PostgreSQL (5432)
     açık olmalıdır.

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

## Sistem Gereksinimleri

- RAM: Minimum 4GB (Önerilen: 8GB)
- CPU: Minimum 2 çekirdek (Önerilen: 4 çekirdek)
- Disk: Minimum 20GB SSD (Önerilen: 50GB SSD)
- Port Gereksinimleri:
  - 80/443: HTTP/HTTPS
  - 5432: PostgreSQL
  - 8000: Kong API Gateway
  - 9000: Storage API
  - 4000: Realtime API

## Hata Ayıklama

### Sık Karşılaşılan Hatalar

1. SSL Sertifika Hataları:

```bash
docker logs supabase-traefik
```

2. Veritabanı Bağlantı Hataları:

```bash
docker logs supabase-db
```

3. API Gateway Hataları:

```bash
docker logs supabase-kong
```

### Çözüm Önerileri

1. SSL Sertifika Sorunları:
   - DNS kayıtlarını kontrol edin
   - Cloudflare SSL modunu doğrulayın
2. Veritabanı Sorunları:
   - PostgreSQL loglarını kontrol edin
   - Disk alanını kontrol edin
3. Bağlantı Sorunları:
   - Port çakışmalarını kontrol edin
   - Docker network ayarlarını kontrol edin

## Güvenlik Sıkılaştırma

1. Network Güvenliği:

   - İç ağ izolasyonu
   - Reverse proxy güvenlik başlıkları
   - Rate limiting kuralları

2. Veritabanı Güvenliği:

   - Rol tabanlı erişim kontrolü
   - Şifreleme politikaları
   - Audit logging

3. API Güvenliği:
   - JWT token rotasyonu
   - API key yönetimi
   - Request/Response validasyonu

## Katkıda Bulunma

Bu projeyi açık kaynak olarak paylaşıyorum. Self-hosted Supabase kurmak isteyen geliştiriciler için bir başlangıç noktası olmasını umuyorum. Issues ve Pull Request'lere açığım.

## Lisans

MIT License - Detaylar için LICENSE dosyasına bakın.

## Destek

Sorularınız ve sorunlarınız için lütfen [Supabase GitHub Issues](https://github.com/supabase/supabase/issues) sayfasını kullanın.
