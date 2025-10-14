# Mencoba Kembali untuk Install Mastodon dengan Docker

Jika  Anda telah membaca [artikel tentang penginstallan Mastodon sebelumnya](https://rakifsul.github.io/mencoba-menginstall-tiga-social-media-self-hosted-dengan-docker.html), mungkin Anda ingat bahwa saya membatalkan penginstallan Mastodon karena terasa berat.

Ternyata saya keliru. Justru saya salah dalam penginstallannya.

Perintah bundle exec rake.... di bawah ini:

```bash
docker compose run --rm mastodon bundle exec rake db:setup
```

Sebenarnya tidak perlu dilakukan jika kita menggunakan image dari linuxserver.io.

Dan pada waktu lain, peningkatan cpu usage juga terjadi saat saya melihat halaman error, tapi saya kira halaman tersebut muncul karena salah setup tadi.

Pada hari ini, saya sengaja meluangkan waktu untuk kembali me-review langkah saya dalam menginstall Mastodon.

Saya memulainya dari membuild source code-nya yang saya dapatkan dari repository-nya, namun saya gagal.

Akhirnya, dengan berbekal sedikit info dari pengalaman tersebut, saya mencoba kembali untuk menginstall Mastodon dengan image dari linuxserver.io.

Dari pengalaman tadi, ada beberapa hal yang saya pelajari:

-   Bahwa sebelum docker compose up dilakukan, semua keys yang tidak optional wajib diisi.
-   Untuk mendapatkan key tersebut, kita harus menjalankan image dari Mastodon.
-   Namun, untuk menjalankan image Mastodon tadi, kita tidak bisa menggunakan docker compose up, melainkan dengan docker run dengan parameter -rm sehingga hanya dijalankan sebentar, kemudian container-nya di-remove.
-   Setelah urusan key beres, baru kita lanjut ke docker compose.
-   Selain itu, karena Mastodon, setidaknya sepemahaman saya, MUTLAK perlu nama domain dan akses HTTP akan me-redirect-nya ke HTTPS, maka kita tidak bisa mengaksesnya dari HTTP dan tidak bisa menggunakan http://IP:PORT.
-   Selain itu, setelah container berjalan lancar jaya, kita masih perlu SMTP, karena saat registrasi admin, akan ada link yang dikirimkan ke email, padahal kita ada di komputer lokal.
-   SMTP untuk komputer lokal bisa di-solve dengan aplikasi Mailpit yang nanti akan saya tunjukkan.

Sekarang, kita akan langsung praktek. Siap???

## Membuat Domain mastodon.local di Hosts

Jalankan perintah ini:

```bash
sudo nano /etc/hosts
```

Kemudian tambahkan baris ini di bawah localhost:

```bash
127.0.0.1 mastodon.local
```

Dengan demikian, jika kita mengakses mastodon.local kita akan mengarah ke ip 127.0.0.1.

## Membuat Folder Installasi

Pertama, buat folder bernama "Mastodon", serta file docker-compose.yml di dalamnya.

Jadi sekarang ada folder "Mastodon" dan file "Mastodon/docker-compose.yml".

Buka file "docker-compose.yml", kemudian isi dengan script ini:

```yaml
services:
  db:
    restart: always
    image: postgres:14-alpine
    container_name: mastodon-postgres
    environment:
      - POSTGRES_DB=mastodon
      - POSTGRES_USER=mastodon
      - POSTGRES_PASSWORD=mastodon
      - 'POSTGRES_HOST_AUTH_METHOD=trust'
    volumes:
      - ./postgres14:/var/lib/postgresql/data
      
  redis:
    restart: always
    image: redis:7-alpine
    container_name: mastodon-redis
    volumes:
      - ./redis:/data
      
  mailpit:
    image: axllent/mailpit
    container_name: mastodon-mailpit
    restart: unless-stopped
    volumes:
      - ./mailpit_data:/data
    ports:
      - 2000:8025
      - 2001:1025
    environment:
      MP_MAX_MESSAGES: 5000
      MP_DATABASE: /data/mailpit.db
      MP_SMTP_AUTH_ACCEPT_ANY: 1
      MP_SMTP_AUTH_ALLOW_INSECURE: 1

  mastodon:
    image: lscr.io/linuxserver/mastodon:4.4.1
    container_name: mastodon
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Jakarta
      - LOCAL_DOMAIN=mastodon.local
      - REDIS_HOST=redis
      - REDIS_PORT=6379
      - DB_HOST=db
      - DB_USER=mastodon
      - DB_NAME=mastodon
      - DB_PASS=mastodon
      - DB_PORT=5432
      - ES_ENABLED=false
      - ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY=nanti
      - ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY=nanti
      - ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT=nanti
      - SECRET_KEY_BASE=nanti
      - OTP_SECRET=nanti
      - VAPID_PRIVATE_KEY=nanti
      - VAPID_PUBLIC_KEY=nanti
      - SMTP_SERVER=mailpit
      - SMTP_PORT=1025
      - SMTP_AUTH_METHOD=none
      - SMTP_OPENSSL_VERIFY_MODE=none
      - SMTP_ENABLE_STARTTLS=auto
      - SMTP_FROM_ADDRESS=Mastodon <notifications@mastodon.local>
      # - S3_ENABLED=false
      - WEB_DOMAIN=mastodon.local
      # - ES_HOST=es #optional
      # - ES_PORT=9200 #optional
      # - ES_USER=elastic #optional
      # - ES_PASS=elastic #optional
      # - S3_BUCKET= #optional
      # - AWS_ACCESS_KEY_ID= #optional
      # - AWS_SECRET_ACCESS_KEY= #optional
      # - S3_ALIAS_HOST= #optional
      # - SIDEKIQ_ONLY=false #optional
      # - SIDEKIQ_QUEUE= #optional
      # - SIDEKIQ_DEFAULT=false #optional
      # - SIDEKIQ_THREADS=5 #optional
      # - DB_POOL=5 #optional
      # - NO_CHOWN= #optional
    volumes:
      - ./mastodon/config:/config
      - ./mastodon/data:/data
    ports:
      - 80:80
      - 443:443
    restart: unless-stopped
    depends_on:
      - db
      - redis
```

Perhatikan bahwa:

-   POSTGRES\_DB = DB\_NAME
-   POSTGRES\_USER = DB\_USER
-   POSTGRES\_PASSWORD = DB\_PASS

Adapun DB\_HOST adalah nama service dari PostgreSQL, yakni "db".

Saya kira sisanya cukup jelas.

## Menggenerate Keys Penting

Masih di dalam folder "Mastodon", generate SECRET\_KEY\_BASE & OTP\_SECRET dengan menjalankan perintah ini **dua** kali:

```bash
docker run --rm -it --entrypoint /bin/bash lscr.io/linuxserver/mastodon:latest generate-secret
```

Yang satu untuk SECRET\_KEY dan yang lain untuk OTP\_SECRET.

Letakkan di environment dari service mastodon.

Untuk menggenerate VAPID\_PRIVATE\_KEY & VAPID\_PUBLIC\_KEY, jalankan perintah ini:

```bash
docker run --rm -it --entrypoint /bin/bash lscr.io/linuxserver/mastodon:latest generate-vapid
```

Hasilnya semacam ini:

```bash
VAPID_PRIVATE_KEY=W2A3uZaK-o6JC6nN6ERrBRicKcRFEAmrWmf-k99bd-U=
VAPID_PUBLIC_KEY=BKfWmIl8Q7Cdygt4xCtLg2_eM-AZ5eldgcXBEnzQ3wgiUvhLafFdFki8ncCSZrmZSuImRdfhsrKVbTaXq3ijY_k=
```

Letakkan di environment dari service mastodon.

Untuk menggenerate ACTIVE\_RECORD\_ENCRYPTION\_DETERMINISTIC\_KEY, ACTIVE\_RECORD\_ENCRYPTION\_KEY\_DERIVATION\_SALT, & ACTIVE\_RECORD\_ENCRYPTION\_PRIMARY\_KEY, lakukan:

```bash
docker run --rm -it --entrypoint /bin/bash lscr.io/linuxserver/mastodon:latest generate-active-record
```

Hasilnya semacam ini:

```bash
ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY=q4XvfvE19fkTUguOcYJ9QyHo5n2ei9WK
ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT=fXBrNE2LUE7gqFFqsPblFIHIe9FetVlV
ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY=FPfP1x9vZPLBZmpMwnv7YcG9jBlo8pfs
```

Letakkan di environment dari service mastodon.

Jadi, pada titik ini, "Mastodon/docker-compose.yml" terlihat seperti ini:

```yaml
services:
  db:
    restart: always
    image: postgres:14-alpine
    container_name: mastodon-postgres
    environment:
      - POSTGRES_DB=mastodon
      - POSTGRES_USER=mastodon
      - POSTGRES_PASSWORD=mastodon
      - 'POSTGRES_HOST_AUTH_METHOD=trust'
    volumes:
      - ./postgres14:/var/lib/postgresql/data
      
  redis:
    restart: always
    image: redis:7-alpine
    container_name: mastodon-redis
    volumes:
      - ./redis:/data
      
  mailpit:
    image: axllent/mailpit
    container_name: mastodon-mailpit
    restart: unless-stopped
    volumes:
      - ./mailpit_data:/data
    ports:
      - 2000:8025
      - 2001:1025
    environment:
      MP_MAX_MESSAGES: 5000
      MP_DATABASE: /data/mailpit.db
      MP_SMTP_AUTH_ACCEPT_ANY: 1
      MP_SMTP_AUTH_ALLOW_INSECURE: 1

  mastodon:
    image: lscr.io/linuxserver/mastodon:4.4.1
    container_name: mastodon
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Jakarta
      - LOCAL_DOMAIN=mastodon.local
      - REDIS_HOST=redis
      - REDIS_PORT=6379
      - DB_HOST=db
      - DB_USER=mastodon
      - DB_NAME=mastodon
      - DB_PASS=mastodon
      - DB_PORT=5432
      - ES_ENABLED=false
      - ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY=FPfP1x9vZPLBZmpMwnv7YcG9jBlo8pfs
      - ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY=q4XvfvE19fkTUguOcYJ9QyHo5n2ei9WK
      - ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT=fXBrNE2LUE7gqFFqsPblFIHIe9FetVlV
      - SECRET_KEY_BASE=ef449a8f3d79ccf5baf42a7ac711b8984b1e5ef313693ed8e4ce51e98bc1a192e93be22eb8d4586d6b21fbf2c2b705237f80e3d2e81ced2f1ecc1fde6aff2abe
      - OTP_SECRET=563bef49c3226b5481b5408cc5122d10b2f763af05bdbae18522591bd07494c7f58c54877417b88a30f101f70818c901efa0bfe4724b964a3745e6b92dd5bf9b
      - VAPID_PRIVATE_KEY=W2A3uZaK-o6JC6nN6ERrBRicKcRFEAmrWmf-k99bd-U=
      - VAPID_PUBLIC_KEY=BKfWmIl8Q7Cdygt4xCtLg2_eM-AZ5eldgcXBEnzQ3wgiUvhLafFdFki8ncCSZrmZSuImRdfhsrKVbTaXq3ijY_k=
      - SMTP_SERVER=mailpit
      - SMTP_PORT=1025
      - SMTP_AUTH_METHOD=none
      - SMTP_OPENSSL_VERIFY_MODE=none
      - SMTP_ENABLE_STARTTLS=auto
      - SMTP_FROM_ADDRESS=Mastodon <notifications@mastodon.local>
      # - S3_ENABLED=false
      - WEB_DOMAIN=mastodon.local
      # - ES_HOST=es #optional
      # - ES_PORT=9200 #optional
      # - ES_USER=elastic #optional
      # - ES_PASS=elastic #optional
      # - S3_BUCKET= #optional
      # - AWS_ACCESS_KEY_ID= #optional
      # - AWS_SECRET_ACCESS_KEY= #optional
      # - S3_ALIAS_HOST= #optional
      # - SIDEKIQ_ONLY=false #optional
      # - SIDEKIQ_QUEUE= #optional
      # - SIDEKIQ_DEFAULT=false #optional
      # - SIDEKIQ_THREADS=5 #optional
      # - DB_POOL=5 #optional
      # - NO_CHOWN= #optional
    volumes:
      - ./mastodon/config:/config
      - ./mastodon/data:/data
    ports:
      - 80:80
      - 443:443
    restart: unless-stopped
    depends_on:
      - db
      - redis
```

Sekarang, kita siap menjalankan perintah ini:

```bash
docker compose up -d
```

Setelah container berjalan, jika Anda mengakses:

https://mastodon.local/ 

Maka kemungkinan akan ada pesan peringatan.

Di sini, kita perlu menjalankan suatu aplikasi yang bisa membuatkan SSL certificate.

Namanya adalah mkcert.

Untuk menginstallnya:

```bash
sudo apt install mkcert
```

Selanjutnya, jalankan perintah ini:

```bash
mkcert -install
```

Jika ada pesan permintaan untuk menginstall package tambahan, seperti "libnss3-tools", lakukan saja, karena itu dibutuhkan. Selanjutnya ulangi mkcert -install tadi.

Langkah selanjutnya adalah membuat ssl certificate untuk mastodon.local, localhost, dan 127.0.0.1:

```bash
mkcert mastodon.local 127.0.0.1 localhost
```

Nanti di folder di mana perintah tersebut dijalankan, akan muncul "Mastodon/mastodon.local+2.pem" dan "Mastodon/mastodon.local+2-key.pem".

Copy file tersebut ke folder keys di nginx:

```bash
cp mastodon.local+2-key.pem  mastodon.local+2.pem ./mastodon/config/keys
```

Sekarang, buka "Mastdodon/mastodon/config/nginx/ssl.conf", Anda akan lihat file berisi script ini:

```bash
## Version 2025/05/31 - Changelog: https://github.com/linuxserver/docker-baseimage-alpine-nginx/commits/master/root/defaults/nginx/ssl.conf.sample

### Mozilla Recommendations
# generated 2025-05-31, Mozilla Guideline v5.7, nginx 1.28.0, OpenSSL 3.5.0, intermediate config, no OCSP
# https://ssl-config.mozilla.org/#server=nginx&version=1.28.0&config=intermediate&openssl=3.5.0&ocsp=false&guideline=5.7

ssl_certificate /config/keys/cert.crt;
ssl_certificate_key /config/keys/cert.key;
ssl_session_timeout 1d;
ssl_session_cache shared:MozSSL:10m; # about 40000 sessions
ssl_session_tickets off;

# curl https://ssl-config.mozilla.org/ffdhe2048.txt > /path/to/dhparam
ssl_dhparam /config/nginx/dhparams.pem;

# intermediate configuration
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ecdh_curve X25519:prime256v1:secp384r1;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305;
ssl_prefer_server_ciphers off;

# HSTS (ngx_http_headers_module is required) (63072000 seconds)
#add_header Strict-Transport-Security "max-age=63072000" always;

# Optional additional headers
#add_header Cache-Control "no-transform" always;
#add_header Content-Security-Policy "upgrade-insecure-requests; frame-ancestors 'self'" always;
#add_header Permissions-Policy "interest-cohort=()" always;
#add_header Referrer-Policy "same-origin" always;
#add_header X-Content-Type-Options "nosniff" always;
#add_header X-Frame-Options "SAMEORIGIN" always;
#add_header X-UA-Compatible "IE=Edge" always;
#add_header X-XSS-Protection "1; mode=block" always;
```

Ubah baris yang ada cert.crt dan cert.key hingga menjadi begini:

```bash
ssl_certificate /config/keys/mastodon.local+2.pem;
ssl_certificate_key /config/keys/mastodon.local+2-key.pem;
```

Pada titik ini, file ssl.conf tersebut menjadi seperti ini:

```bash
## Version 2025/05/31 - Changelog: https://github.com/linuxserver/docker-baseimage-alpine-nginx/commits/master/root/defaults/nginx/ssl.conf.sample

### Mozilla Recommendations
# generated 2025-05-31, Mozilla Guideline v5.7, nginx 1.28.0, OpenSSL 3.5.0, intermediate config, no OCSP
# https://ssl-config.mozilla.org/#server=nginx&version=1.28.0&config=intermediate&openssl=3.5.0&ocsp=false&guideline=5.7

ssl_certificate /config/keys/mastodon.local+2.pem;
ssl_certificate_key /config/keys/mastodon.local+2-key.pem;
ssl_session_timeout 1d;
ssl_session_cache shared:MozSSL:10m; # about 40000 sessions
ssl_session_tickets off;

# curl https://ssl-config.mozilla.org/ffdhe2048.txt > /path/to/dhparam
ssl_dhparam /config/nginx/dhparams.pem;

# intermediate configuration
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ecdh_curve X25519:prime256v1:secp384r1;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305;
ssl_prefer_server_ciphers off;

# HSTS (ngx_http_headers_module is required) (63072000 seconds)
#add_header Strict-Transport-Security "max-age=63072000" always;

# Optional additional headers
#add_header Cache-Control "no-transform" always;
#add_header Content-Security-Policy "upgrade-insecure-requests; frame-ancestors 'self'" always;
#add_header Permissions-Policy "interest-cohort=()" always;
#add_header Referrer-Policy "same-origin" always;
#add_header X-Content-Type-Options "nosniff" always;
#add_header X-Frame-Options "SAMEORIGIN" always;
#add_header X-UA-Compatible "IE=Edge" always;
#add_header X-XSS-Protection "1; mode=block" always;
```

Save file tersebut.

Selanjutnya, restart container-container mastodon anda:

```bash
docker compose down --volumes

docker compose up -d
```

Sekarang, buka:

https://mastodon.local/

**BUKA DENGAN Firefox bawaan Ubuntu** atau **Browser lain yang diinstall melalui deb**, **JANGAN yang dengan snap**. Itu karena folder app data dari aplikasi snap berbeda dengan yang deb dan terisolasi. Nanti saya akan bahas cara menengahinya.

Jika Firefox tadi masih menunjukkan warning, tutup Firefox, dan jalankan lagi:

```bash
mkcert -install
```

Kemudian coba buka lagi.

Di sini saya tidak bisa berbuat apa-apa jika masih gagal, jadi good luck! 

**Update 2025.07.13-1931:**

**Setelah saya cek, ternyata Firefox bawaan Ubuntu 24.04 juga diinstall dengan Snap. Namun entah kenapa pada percobaan saya, Firefox bisa tapi Brave dengan Snap tidak bisa. Namun, saya sudah coba Brave dengan deb (sudo apt install...) bisa mengakses Mastodon HTTPS tanpa masalah.**

## Menggunakan Brave yang Diinstall dengan Snap untuk Mengakses Mastodon Tadi

Sekarang, kita akan coba menggunakan Brave yang diinstall dengan Snap.

Pertama Anda perlu mencari lokasi certificate di Ubuntu Anda, caranya:

```bash
mkcert -CAROOT
```

Jalankan dari terminal yang terbuka di Home Anda.

Nanti akan muncul semacam ini:

```bash
/home/namauser/.local/share/mkcert
```

Buka setting Brave:

brave://settings/security?search=certificate

Jika ada "Manage Certificates", maka klik tombolnya.

Klik Custom (installed by you).

Klik Trusted Certificates > Import

Buka path di output terminal barusan ("/home/namauser/.local/share/mkcert"), dan ambil "rootCA.pem".

Restart Brave.

Coba buka alamat Mastodon tadi.

Semoga berhasil.

## Langkah Selanjutnya (Jika Anda Berhasil Membuka Mastodon dengan HTTPS)

Sekarang, buka terminal dalam container mastodon Anda:

```bash
docker exec -it mastodon /bin/bash
```

Selanjutnya, jalankan perintah ini:

```bash
tootctl accounts create nama_anda --email email_anda@example.com --role Admin --approve
```

Nanti akan ada password muncul:

```bash
OK
New password: db21...
```

Gunakan email dan password tersebut untuk login pertama kali. Nanti Anda akan bisa menggantinya dengan yang lain.

Saat login, Anda akan dikirimi email. Cek email Anda di Mailpit di:

http://127.0.0.1:2000/

Gunakan link di email Mailpit tadi untuk melanjutkan login.

Selanjutnya, ganti password Anda, karena akun tadi adalah akun Admin.

## Akhir Kata

Bagi saya, Mastodon adalah salah satu aplikasi yang paling menantang untuk diinstall.

Itu bukan hanya karena langkahnya yang rumit, tapi juga karena betapa strict-nya ketentuan yang diterapkan, seperti HTTPS tadi.

Tapi, bagaimanapun, setelah saya menghabiskan waktu dari malam kemarin hingga sore hari ini, saya merasa puas.

Jadi. Selamat mencoba...

## Bonus: Gallery

<p align="center">
    <img src="../media/Screenshot-from-2025-07-13-14-22-30-Copy.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../media/Screenshot-from-2025-07-13-14-22-47-Copy.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../media/Screenshot-from-2025-07-13-14-22-41-Copy-2.png?raw=true" alt="tampilan"/>
</p>