# Mencoba Menginstall Tiga Social Media Self Hosted dengan Docker

Karena penasaran untuk mencoba beberapa social media self hosted, saya memulainya dari mencoba menginstall [Mastodon](https://docs.joinmastodon.org).

## Mencoba Menginstall Mastodon

Saya melakukan kesalahan di saat menginstallnya. Jika Anda ingin lihat cara install Mastodon yang benar, kunjungi artikel ini:

[Mencoba Kembali untuk Install Mastodon dengan Docker](../2025-07/Mencoba-Kembali-untuk-Install-Mastodon-dengan-Docker.md)

## Mencoba Menginstall Misskey

Selanjutnya saya mencari beberapa alternatifnya yang lebih ringan dan saya menemukan Misskey.

Aplikasi tersebut memiliki [dokumentasi yang cukup jelas](https://misskey-hub.net/en/docs/for-admin/install/guides/docker/) dan saya akhirnya memutuskan untuk mengikuti langkah yang disediakan.

Bedanya, karena saya sudah mengonfigurasi docker agar tidak perlu sudo, maka saya menjalankan perintah-perintah di dokumentasi tadi tanpa sudo.

Hasilnya sukses dan saya masih merasakan bahwa aplikasi tadi lebih ringan di komputer saya.

Namun, saya ingin mencoba lebih banyak lagi.

## Menginstall Pleroma

Terakhir, setelah melakukan sedikit konsultasi dengan chatbot, saya mendapati sebuah aplikasi sosial media yang masih sejenis dengan kedua sosial media tadi, yakni Pleroma.

Saya melakukan clone pada docker compose repository di repositorynya:

```bash
git clone https://git.pleroma.social/pleroma/pleroma-docker-compose.git
```

Saya melakukan sedikit modifikasi pada docker-compose.yml nya menjadi seperti ini:

```yaml
version: '3.1'

services:
  pleroma:
    image: git.pleroma.social:5050/pleroma/pleroma:latest
    container_name: "pleroma"
    hostname: "pleroma"
    labels:
      - "org.label-schema.group=pleroma"
    restart: always
    env_file: ./environments/pleroma/pleroma.env
    depends_on:
      - pleroma-db
    ports:
      - "127.0.0.1:9006:4000"
    volumes:
      - ./volumes/pleroma/config.exs:/var/lib/pleroma/config.exs
      - ./volumes/pleroma/uploads:/var/lib/pleroma/uploads

  pleroma-db:
    image: postgres:12.1-alpine
    container_name: "pleroma-db"
    hostname: "pleroma-db"
    labels:
      - "com.centurylinklabs.watchtower.enable=False"
      - "org.label-schema.group=pleroma"
    restart: always
    env_file: ./environments/pleroma-db/postgres.env
    ports:
      - "127.0.0.1:5432:5432"
    volumes:
      - ./volumes/pleroma-db/pgdata:/var/lib/postgresql/data
      - ./volumes/pleroma-db/pginit:/docker-entrypoint-initdb.d
```

Kemudian melakukan sedikit perubahan pada .env-nya yang letaknya di /environments/pleroma/plereoma.env sehingga menjadi:

```bash
DB_USER=pleroma
DB_PASS=pleroma
DB_HOST=pleroma-db
DB_NAME=pleroma
INSTANCE_NAME=Pleroma
ADMIN_EMAIL=admin@example.com
NOTIFY_EMAIL=pleroma+admin@example.com
DOMAIN=127.0.0.1:9006
PORT=4000
```

Selanjutnya melakukan:

```bash
docker compose up -d
```

Setelah saya melakukan itu, saya membuka [http://127.0.0.1:9006](http://127.0.0.1:9006) dan ternyata berhasil, namun saya belum membuat akun adminnya.

Langsung saja saya buka terminal pada containernya yang menggunakan **/bin/ash** alih-alih **/bin/bash** dengan menjalankan perintah ini:

```bash
docker exec -it pleroma /bin/ash
```

Kemudian menjalankan perintah ini dari folder root atau / :

```bash
/opt/pleroma/bin/pleroma_ctl user new admin100 admin100@example.com --admin
```

Setelah perintah tersebut dijalankan, saya mendapatkan link untuk mereset password untuk mengganti passwordnya (**cari saja output yang ada link-nya kemudian ganti jadi http**) dan akhirnya saya berhasil login.

## Kesan Pertama

Setelah saya menjalankannya, saya merasa bahwa Pleroma lebih ringan daripada kedua alternatif tadi.

Selain itu, setelah saya perhatikan dengan htop:

```bash
sudo apt install htop

htop
```

Saya melihat bahwa Misskey cenderung berat di sisi browsernya.

Jika Browser yang membuka Misskey dihentikan, maka penggunaan cpu-nya cenderung sama dengan Pleroma.

## Kesimpulan

Dari ketiga aplikasi social media self hosted yang saya coba, ternyata secara kasar bisa disimpulkan bahwa Pleroma yang paling ringan.

Namun, Misskey memiliki user interface yang lebih menarik.

Saya belum ada rencana khusus tentang apa yang saya akan lakukan dengan Pleroma atau Misskey tadi.

Namun, jika Pleroma atau Misskey menyediakan API untuk bot dan pc gaming saya telah diperbaiki, saya mungkin akan mencoba membuat bot dengan LLM lokal yang berjalan di pc gaming saya.
