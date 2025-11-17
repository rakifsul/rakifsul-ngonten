# Lagi-Lagi Bahas PHP, tapi Kali ini Dengan Docker dan Dockerfile

Dari kemarin saya agak bosan dan saat itu saya belum tahu penyebabnya.

Itulah sebabnya saya kemarin membahas sebuah chrome extension [di artikel ini](./Web-Archiving-Terstruktur-Tanpa-Menggunakan-Docker.md).

Namun, setelah direnungi...

Tidakkah Anda merasa, bahwa selama ini yang saya lakukan dengan docker adalah seputar docker compose, docker compose up, docker compose down?

Itu pun menggunakan docker-compose.yml yang sudah siap pakai.

Karena sekarang saya sudah terlalu banyak membahas hal tersebut, bagaimana jika kali ini saya bahas sesuatu yang agak beda.

Apa itu?

Itu adalah Dockerfile.

Kali ini, saya akan membahas penginstallan PHP dengan menggunakan docker compose dan Dockerfile.

Jika Anda belum tahu apa itu Dockerfile, coba ingat kembali. Pernahkah Anda lihat file bernama "Dockerfile" di folder source code yang isinya semacam ini:

```docker
FROM alpine
RUN echo "kacang.... telor... (bergema)"
```

Walaupun contoh di atas agak ngawur, tapi itulah Dockerfile.

Dan tentunya kode di atas bukanlah cerita tentang seseorang yang berteriak "kacang.. telor.." dari pegunungan.

Nah, sekarang, kita akan membuild Dockerfile untuk PHP 8.3 dan menggunakannya melalui docker compose.

Selain itu, kita akan menyatukan dua docker-compose.yml yang mana yang satu adalah untuk PHP tadi dan yang lainnya adalah untuk MariaDB dan phpMyAdmin.

Ingat: 2 docker-compose.yml dalam 2 folder yang berbeda.

Agar phpMyAdmin dan PHP 8.3 bisa diakses dari dua docker-compose.yml yang berbeda, maka kita akan menggunakan network external.

## Membuat Network External

Langkah pertama yang perlu kita lakukan adalah membuat network external dulu:

```bash
docker network create external-net
```

nama "external-net" ini nantinya akan digunakan di dalam docker-compose.yml.

## Membuat Folder Project

Agar folder project ini terlihat rapi, maka buatlah folder baru bernama "PHP-MariaDB-Network" yang didalamnya memiliki struktur seperti ini:

-   PHP-MariaDB-Network/mariadb
-   PHP-MariaDB-Network/php

nanti di PHP-MariaDB-Network/php ada file ini:

-   PHP-MariaDB-Network/php/docker-compose.yml
-   PHP-MariaDB-Network/php/Dockerfile-83

dan di PHP-MariaDB-Network/mariadb ada file ini:

-   PHP-MariaDB-Network/docker-compose.yml

## Membuat Docker Compose untuk PHP, MariaDB dan phpMyAdmin

Isilah "PHP-MariaDB-Network/mariadb/docker-compose.yml" dengan script ini:

```yaml
services:
  mariadb:
    image: mariadb:latest
    container_name: tutorial-mariadb
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: example_database
      MYSQL_USER: user
      MYSQL_PASSWORD: user
    ports:
      - "11004:3306"
    volumes:
      - ./data:/var/lib/mysql
    networks:
      - external-net

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: tutorial-phpmyadmin
    restart: always
    environment:
      PMA_HOST: mariadb:3306
      PMA_USER: root
      PMA_PASSWORD: root
    ports:
      - "11005:80"
    depends_on:
      - mariadb
    networks:
      - external-net

networks:
  external-net:
    external: true
```

Isilah "PHP-MariaDB-Network/php/docker-compose.yml" dengan script ini:

```yaml
services:
 php83:
  container_name: tutorial-php83
  build:
   context: .
   dockerfile: Dockerfile-83
  ports:
   - 8282:80
  volumes:
   - ./php83:/var/www/html/
  networks:
      - external-net

networks:
  external-net:
    external: true
```

## Membuat Dockerfile untuk PHP

Isilah "PHP-MariaDB-Network/php/Dockerfile-83" dengan script ini:

```docker
FROM php:8.3-apache
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN apt update
RUN a2enmod rewrite
RUN apt-get install -y git
RUN apt-get install -y curl
RUN curl -s https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN mkdir /var/www/html/php83
```

## Menjalankan Command

Sekarang masuk ke folder "PHP-MariaDB-Network/mariadb" dan jalankan:

```bash
docker compose up -d
```

Kemudian, masuk ke folder "PHP-MariaDB-Network/php dan jalankan:

```bash
docker compose up -d
```

Buat file index.php di dalam folder "PHP-MariaDB-Network/php/php83" dan isi dengan script ini:

```php
<?php

phpinfo();
```

Buat file connect.php dalam folder "PHP-MariaDB-Network/php/php83" dan isi dengan script ini:

```php
<?php
$servername = "mariadb:3306";
$username = "root";
$password = "root";

$conn = new mysqli($servername, $username, $password);
if ($conn->connect_error) {
  die("Koneksi gagal: " . $conn->connect_error);
}
echo "Koneksi suskes";
```

Sekarang, coba buka URL ini di browser Anda dan pastikan semua sukses:

-   [http://127.0.0.1:11005](http://127.0.0.1:11005) akan membuka phpMyAdmin
-   [http://127.0.0.1:8282](http://127.0.0.1:8282) akan membuka phpinfo
-   [http://127.0.0.1:8282/connect.php](http://127.0.0.1:8282/connect.php) akan memberi output bahwa koneksi sukses

Berikut ini screenshotnya:

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-18-00-19-58.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-18-00-20-09.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-18-01-08-51.png?raw=true" alt="tampilan"/>
</p>

## Sedikit Penjelasan

Karena saya sudah cukup lama membahas docker compose, maka yang perlu Anda ketahui dalam artikel ini adalah:

```yaml
  build:
   context: .
   dockerfile: Dockerfile-83
```

Kode di atas ada di docker compose milik PHP.

Itu maksudnya adalah bahwa script tadi memberitahu docker compose untuk mem-build Dockerfile-83 yang ada di dalam folder . (titik) atau folder di mana command dari terminal dijalankan.

Selain itu Anda perlu tahu juga bahwa pada Dockerfile-83, RUN itu maksudnya adalah perintah untuk menjalankan command yang ada di sebelahnya.

Adapun FROM adalah perintah untuk mengimpor image yang ada di sebelahnya, dalam hal ini php:8.3-apache.

Dengan melakukan docker compose up -d maka Dockerfile-83 akan dibuild dan scriptnya dijalankan.

## Kesimpulan

Sekarang saya telah membahas, walaupun sedikit, tentang Dockerfile.

Pengetahuan tentang Dockerfile mungkin diperlukan jika kelak kita akan membangun aplikasi dari nol yang menggunakan docker atau bahkan hanya sekadar memodifikasi source code lain yang menggunakan docker.

Selain itu, memahami Dockerfile juga membantu kita untuk memperbaiki masalah penginstallan aplikasi yang menggunakan docker karena itu menjelaskan apa yang terjadi saat image docker dibuat.