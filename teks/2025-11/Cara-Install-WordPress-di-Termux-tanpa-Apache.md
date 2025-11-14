# Cara Install WordPress di Termux tanpa Apache

WordPress merupakan salah satu CMS yang populer.

Karena populer, maka tidak ada salahnya saya bahas di artikel ini, karena mungkin saja banyak yang berminat membacanya.

Walaupun secara prinsip menginstall WordPress di Termux masih serupa dengan menginstall WordPress di VPS Ubuntu Server, detail dari langkahnya mungkin ada yang beda.

Selain itu, karena saya juga malas menginstall Apache, saya skip saja HTTP server ini.

Dengan kata lain, kita nanti akan menggunakan PHP built-in server.

Saya tahu, bahwa itu mungkin kurang ideal untuk lingkungan produksi, tapi bukankah kita sekarang menggunakan Termux?

OK, langsung saja saya bahas caranya.

## Install Package yang Dibutuhkan

Pertama, kita perlu php:

```
pkg install php
```

Kedua, kita perlu mariadb:

```
pkg install mariadb
```

## Konfigurasi mariadb

Langkah ini mungkin sedikit rumit dan rentan error, sepertinya karena caranya berbeda-beda dari versi mariadb yang satu dengan yang lain.

Tapi, setidaknya cara yang saya bahas ini adalah cara yang berhasil di tanggal 2025-11-14 di komputer saya.

Pertama, jalankan perintah ini:

```
# ini akan menjalankan mariadb SERVER dengan user root tanpa password
mariadbd-safe -u root &
```

Selanjutnya:

```
# kita akan masuk ke server mariadb sebagai root
mysql -u root
```

Selanjutnya:

```
# set password_baru dengan password anda. itu adalah password root nantinya.
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password_baru';
```

Lalu exit:

```
exit;
```

Untuk masuk ke root lagi:

```
# nanti masukkan password Anda yang tadi.
mysql -u root -p
```

Setelah masuk sebagai root:

```
CREATE DATABASE wordpress;
```

Lalu exit lagi:

```
exit;
```

## Menginstall WordPress

Catatan: Anda bebas memilih lokasi folder untuk WordPress ini.

Sekarang, download package WordPress terbaru dengan:

```
wget https://wordpress.org/latest.tar.gz
```

Kemudian extract:

```
tar -xzf latest.tar.gz
```

Masuk ke dalamnya:

```
cd wordpress
```

Selanjutnya buat file runner:

```
nano run-wordpress

# atau jika pakai micro

micro run-wordpress
```

Kemudian isi dengan script ini:

```
#!/bin/bash

php -S 0.0.0.0:8055
```

Lalu save, kemudian beri permission:

```
chmod +x ./run-wordpress
```

Jalankan script tadi:

```
./run-wordpress
```

Nanti, buka http://ip-android-anda:8055.

## Setup WordPress melalui Browser

Selamat, sekarang Anda tinggal konfigurasi wordpress seperti biasa.

Untuk detail databasenya:

```
database: wordpress
user: root
password: yang tadi anda berikan
host: 127.0.0.1 bukan localhost karena saya coba gagal

sisa konfigurasi database-nya biarkan apa adanya
```

Lanjutkan langkahnya hingga selesai.

## Penutup

Jika ada kendala dalam mengikuti tutorial ini, mungkin Anda perlu  menghentikan aplikasi Termux, kemudian menjalankannya lagi.

Selanjutnya, apa yang akan Anda lakukan dengan WordPress di Termux Anda adalah keputusan Anda sendiri.

Sekian...
