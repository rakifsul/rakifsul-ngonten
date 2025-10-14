# Cara Mem-Build Beberapa Versi PHP di Ubuntu (Sepertinya Portable)

```
Update 2025.06.10: Hasil build ini kemungkinan tidak portabel.
```

Sejak saya migrasi dari Windows ke Linux, OS yang saya gunakan adalah Ubuntu.

Saat artikel ini ditulis, saya menggunakan Ubuntu 24.04.

Karena saya hobi coding, saat itu saya ingin menginstall PHP.

Namun, saya tidak ingin PHP versi bawaan repository Ubuntu, melainkan yang multi versi.

Setidaknya versi 7.4, 8,1, 8.3 dan 8.4.

Untuk menggunakan multi versi PHP, saya harus membuatnya portable atau semi portable sehingga lebih mudah untuk dipindah-pindahkan dan diutak-atik folder aplikasinya.

Sayang sekali, versi portable atau semi portable PHP tidak tersedia binary-nya untuk Ubuntu.

Mau tidak mau, saya harus mem-build-nya sendiri.

Bagaimana saya melakukan itu? Mari kita simak.

## Mendownload Source Code PHP

Source code PHP bisa didownload di website resminya:

[https://www.php.net/downloads.php](https://www.php.net/downloads.php)

Pilih versi antara 7.4.x hingga 8.4.x

Versi yang saya pilih adalah 7.4.x, 8.1.x, 8.3.x, dan 8.4.x.

Versi 8.1.x hingga 8.4.x sama caranya, sedangkan 7.4.x sedikit berbeda.

Jadi, ada dua pembahasan di artikel ini:

- Build PHP untuk versi 8.1.x hingga 8.4.x
- Build PHP untuk versi 7.4.x

Setelah selesai mendownload, buat folder build dengan nama apapun.

Selanjutnya, ekstrak file archive dari source code PHP tadi.

## Menginstall Dependencies

Karena untuk mem-build PHP diperlukan beberapa dependencies, maka itu harus diinstall dulu agar bisa di-build.

Dependencies yang perlu diinstall juga tergantung dari opsi build yang nanti akan anda terapkan.

Namun, di artikel ini, saya telah buatkan opsi buildnya, dan inilah dependencies yang perlu anda install:

- libonig-dev
- libcurl4-openssl-dev
- libssl-dev
- libzip-dev
- libpng-dev
- libjpeg-dev
- libwebp-dev
- libavif-dev

Anda bisa menginstallnya sekaligus dengan perintah ini:

```
sudo apt install libonig-dev libcurl4-openssl-dev libssl-dev libzip-dev libpng-dev libjpeg-dev libwebp-dev libavif-dev
```

## Membuild PHP

Setelah semua itu terinstall, sekarang Anda bisa membuild PHP.

Saya mulai dari versi 8.1.x hingga 8.4.x. Caranya sama.

Masuklah ke dalam folder source masing-masing. Ingat. Kita melakukannya satu per satu.

Jadi, kita misalkan mulai dari versi 8.4.x dulu:

```
cd php-8.4.x
```

Selanjutnya:

```
./buildconf
```

Lalu:

```
./configure --prefix=$HOME/Apps/PHP/php84 --enable-mbstring --enable-mysqlnd --with-mysqli --with-pdo-mysql --with-pdo-sqlite --with-sqlite3 --enable-bcmath --enable-opcache --enable-soap --with-zlib --with-curl --with-openssl --enable-intl --with-zip --enable-exif --enable-calendar --enable-sockets --enable-ftp --with-gettext --enable-shmop --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-cli --enable-gd
```

Prefix $HOME/Apps/PHP/php84 itu bisa Anda ubah tergantung anda mau memasukkan hasil build PHP Anda ke mana.

Kemudian, jika anda mau menggunakan 4 core dari cpu Anda saat proses build:

```
make -j 4
```

Jika tidak error, maka lanjutkan dengan:

```
make install
```

Sekarang, bagaimana dengan yang versi 7.4.x?

Sama dengan yang tadi, hanya saja hapus bagian dari script configure-nya, yang ini:

```
--with-openssl
```

Dengan demikian, perintah configure untuk 7.4.x selengkapnya adalah:

```
./configure --prefix=$HOME/Apps/PHP/php74 --enable-mbstring --enable-mysqlnd --with-mysqli --with-pdo-mysql --with-pdo-sqlite --with-sqlite3 --enable-bcmath --enable-opcache --enable-soap --with-zlib --with-curl --enable-intl --with-zip --enable-exif --enable-calendar --enable-sockets --enable-ftp --with-gettext --enable-shmop --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-cli --enable-gd
```

Perhatikan, saya mengganti prefixnya menjadi: $HOME/Apps/PHP/php74

Itu folder yang berbeda. Anda tentunya tidak ingin php 8.4.x tadi filenya ditimpa dengan yang 7.4.x bukan?

## Bonus!!!

Setelah selesai, jika Anda ingin bisa menggunakannya sekaligus sehingga bisa berganti-ganti versi, Anda bisa membuat alias dari bash.

Caranya, buka folder $HOME/.bashrc kemudian tambahkan script ini di paling bawah file:

```
alias php84='/home/cangkul/Apps/PHP/php84/bin/php'
alias php83='/home/cangkul/Apps/PHP/php83/bin/php'
alias php81='/home/cangkul/Apps/PHP/php81/bin/php'
alias php74='/home/cangkul/Apps/PHP/php74/bin/php'
```

Kemudian save file tersebut.

Selanjutnya, reboot ubuntu Anda.

Dengan demikian, cara untuk menjalankan php 8.4.x adalah dengan perintah php84.

Dan untuk menjalankan php 8.1.x adalah dengan perintah php81 dan seterusnya.

## Akhir Kata

Setelah saya mendapati hasil build saya, saya berkesimpulan bahwa ini kemungkinan besar adalah aplikasi Portable, karena buktinya prefix dari configure tadi bisa diubah sesuai keinginan kita.

Tapi, mungkin saya salah juga.. Jadi silakan pastikan sendiri.

Yang jelas, saran saya sebaiknya Anda mem-backup seluruh build PHP tadi ke tempat lain agar jika dugaan saya tadi benar, Anda tidak perlu mengulangi langkah build tadi.
