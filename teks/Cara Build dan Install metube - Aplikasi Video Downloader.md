# Cara Build dan Install metube - Aplikasi Video Downloader

Biasanya, jika ada video bagus di suatu website, saya mendownloadnya.

Salah satu tool yang sering saya pakai adalah [yt-dlp](https://github.com/yt-dlp/yt-dlp).

Namun, karena terkadang saya lupa parameter-parameternya, seringkali saya langsung gunakan tanpa parameter tambahan, sehingga mungkin saja kualitas video yang saya download belum optimal.

Untungnya ada sebuah aplikasi self hosted yang bisa membantu mendownload video-video tadi dengan web ui.

Dengan menggunakan web ui, saya bisa mendownload video dengan yt-dlp tanpa harus memikirkan parameter-parameternya.

Aplikasi tersebut bernama [metube](https://github.com/alexta69/metube).

Metube sangat mudah digunakan. Kita hanya perlu memainkan web ui-nya agar video didownload sesuai konfigurasi downloadnya.

Bagaimana cara menginstall dan membuildnya? Lanjut...

## Cara Install metube dari Image Docker-nya

Untuk menginstallnya cukup mudah.

Buat folder bernama "MeTube" kemudian buat lagi folder bernama "image" di dalamnya.

Kemudian masuk ke dalam folder tersebut, kemudian buat file bernama "docker-compose.yml".

Isi "docker-compose.yml" dengan script ini:

```yaml
services:
  metube:
    image: ghcr.io/alexta69/metube
    container_name: image-metube
    restart: unless-stopped
    ports:
      - "10000:8081"
    environment:
      - PUID=$(id -u)
      - PGID=$(id -g)
    volumes:
      - ./downloads:/downloads
```

Selanjutnya, jalankan:

```bash
docker compose up -d
```

Kunjungi [http://127.0.0.1:10000](http://127.0.0.1:10000)

## Cara Build dan Install metube dari Source Code-nya

Sekarang kita akan coba yang lebih sulit, yakni membuild dan menginstall metube dari source code-nya.

Pertama, buat folder bernama "build" di dalam folder "MeTube" yang telah kita buat tadi.

Kemudian, masuk ke dalam folder "build".

Kemudian, clone repository-nya:

```bash
git clone https://github.com/alexta69/metube.git
```

Kemudian, masuk ke dalam folder "metube".

Lakukan checkout:

```bash
git checkout 2025.07.31
```

Kemudian buat file "docker-compose.yml" di dalamnya.

Isi file tersebut dengan script ini:

```yaml
services:
  metube:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: build-metube
    restart: unless-stopped
    ports:
      - "11000:8081"
    environment:
      - PUID=$(id -u)
      - PGID=$(id -g)
    volumes:
      - ./downloads:/downloads
```

Selanjutnya, jalankan perintah ini:

```bash
docker compose up -d --build
```

Tunggu sejenak, setelah siap, buka url ini:

[http://127.0.0.1:11000](http://127.0.0.1:11000)

## Penutup

Selesai.