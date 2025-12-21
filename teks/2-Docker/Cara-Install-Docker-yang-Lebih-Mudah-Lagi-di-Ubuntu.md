# Cara Install Docker yang Lebih Mudah Lagi di Ubuntu

Untuk menginstall Docker dengan sangat mudah dan tanpa perintah yang berbelit-belit, lakukan ini:

```
wget -qO- https://get.docker.com | sh

# atau

curl -fsSL https://get.docker.com | sh

# kemudian
sudo usermod -aG docker $USER

# lalu restart
sudo reboot now
```

Setelah kembali login setelah restart, begini cara mengujinya:

```
# cek apakah kita ada di group docker
groups
# jika sudah, berarti kita bisa jalankan perintah docker tanpa sudo

# cek apakah perintah docker berjalan dengan benar
docker ps
# jika yang muncul tabel kosong berarti docker jalan dengan benar

# cek apakah docker compose berjalan dengan benar
# buat directory bernama test-compose
# kemudian masuk ke dalamnya
mkdir test-compose && cd test-compose

# buat dan edit docker-compose.yml di dalam directory test compose
nano docker-compose.yml

# isi docker-compose.yml dengan script ini
services:
  hello:
    image: hello-world
# simpan dan keluar dari nano

#lalu jalankan
docker compose up

# jika outputnya adalah hello world dari docker, berarti berhasil
```
