# Cara Membuat PHP Build Kemarin Menjadi Portable

Masih ingat dengan artikel [cara build PHP yang kemarin](../2025-06/Cara-Mem-Build-Beberapa-Versi-PHP-di-Ubuntu.md)?

Di artikel tersebut saya bilang "... Sepertinya Portable". Kalimat tersebut ada di Judulnya.

Jujur saja saya waktu itu benar-benar ragu apakah benar hasil build PHP tersebut portable.

Itu karena, saat development kita menginstall library pihak ketiga sebelum melakukan build.

Walaupun PHP tadi berjalan di komputer tempat build-nya, bagaimana jika PHP tadi dijalankan di linux distro lain secara fresh install?

Nah. Untuk menutup keraguan tersebut, sekarang saya akan membahas cara membuat PHP build kemarin benar-benar portable.

Di sini saya menggunakan format AppImage agar yakin bahwa PHP build-nya portable.

Namun. Saya akan membahas ini untuk PHP versi 8.4.x saja, karena yang lain langkahnya kurang lebih sama.

Bagaimana caranya? Terus simak...

## Menyiapkan Bahan yang Diperlukan

Sebelum kita mulai:

-   Download aplikasi [linuxdeploy](https://github.com/linuxdeploy/linuxdeploy/releases/tag/continuous) sesuai architecture cpu Anda. 
-   Download aplikasi [appimagetool](https://github.com/AppImage/appimagetool/releases/tag/continuous) sesuai architecture cpu Anda.
-   Siapkan gambar svg dan rename jadi "logo.svg".
-   Siapkan PHP build untuk versi 8.4.x kemarin. Ambil dari folder executablenya.

Rename hasil download link linuxdeploy tadi menjadi "linuxdeploy".

Rename hasil download link appimagetool tadi menjadi "appimagetool".

Pindahkan kedua file executable tadi ke "/usr/local/bin".

Kemudian jalankan perintah ini:

```bash
sudo chmod +x /usr/local/bin/linuxdeploy
sudo chmod +x /usr/local/bin/appimagetool
```

## Mempersiapkan Folder untuk AppImage Development

Buat folder baru bernama "php84"

Di dalamnya buat folder baru bernama "php84.AppDir".

Buat folder:

-   php84.AppDir/usr
-   php84.AppDir/usr/bin
-   php84.AppDir/usr/lib
-   php84.AppDir/usr/share
-   php84.AppDir/etc

Buat file "php84.AppDir/AppRun", isi dengan:

```bash
#!/bin/bash

exec "$APPDIR/usr/bin/php" -c "$APPDIR/etc/php/php.ini" -z "$APPDIR/usr/lib/php/extensions/no-debug-non-zts-20240924/opcache.so" "$@"
```

Copy seluruh isi "php84/bin/" dari folder build kemarin ke "php84.AppDir/usr/bin/"

Copy folder "php84/lib/php" dari folder build kemarin ke "php84.AppDir/usr/lib/php"

Copy "php.ini-production" dari paket source code php 8.4.x kemarin ke "php84.AppDir.usr/etc/php/php.ini".

Cari settingan php.ini terkait extension, ubah menjadi seperti di bawah ini, tapi sisanya biarkan apa adanya:

```ini
# ...

;extension=bz2
extension=curl
;extension=ffi
extension=ftp
;extension=fileinfo
extension=gd
extension=gettext
;extension=gmp
extension=intl
;extension=ldap
extension=mbstring
extension=exif      ; Must be after mbstring as it depends on it
extension=mysqli
;extension=odbc
extension=openssl
;extension=pdo_firebird
extension=pdo_mysql
;extension=pdo_odbc
;extension=pdo_pgsql
extension=pdo_sqlite
;extension=pgsql
extension=shmop

; The MIBS data available in the PHP distribution must be installed.
; See https://www.php.net/manual/en/snmp.installation.php
;extension=snmp

extension=soap
extension=sockets
;extension=sodium
extension=sqlite3
;extension=tidy
;extension=xsl
extension=zip

zend_extension=opcache

# ...

[opcache]
; Determines if Zend OPCache is enabled
opcache.enable=1

#...
```

Di dalam folder "php84.AppDir", jalankan perintah ini:

```bash
linuxdeploy --appdir . --output appimage
```

Nanti kemungkinan besar hasilnya error, tapi akan dibuatkan folder-folder pendukungnya di dalam "php84.AppDir".

Selanjutnya, copy logo.svg ke "php84.AppDir/usr/share/icons/hicolor/scalable/apps/logo.svg"

Selanjutnya, buat file "php84.AppDir/usr/share/applications/php84.desktop", kemudian isi dengan:

```ini
[Desktop Entry]
Name=PHP84
Exec=php
Icon=logo
Type=Application
Categories=Development;
```

Keterangan:

-   Name berisi nama aplikasi, saya beri nama PHP84.
-   Icon berisi nama file logo.svg tanpa extension (.svg)
-   Exec berisi nama binary ELF php utama yang ada di "php84.AppDir/usr/bin", yakni php.
-   Type tulis saja Application
-   Categories tidak bisa sembarangan, sekarang isi dengan "Development". Selengkapnya, [bisa lihat di sini](https://specifications.freedesktop.org/menu-spec/latest/category-registry.html).

Jalankan lagi perintah tadi:

```bash
linuxdeploy --appdir . --output appimage
```

Walaupun kemungkinan ada pesan error, tapi hasilnya sudah benar. jadi, lanjut ke langkah berikutnya.

Naik satu folder ke atas:

```bash
cd ..
```

Jalankan perintah ini:

```bash
appimagetool php84.AppDir
```

Setelah selesai file berextension .AppImage akan muncul di folder ini.

## Pengujian

Copy dan rename file berextension .AppImage tadi menjadi "php84-test".

Izinkan jadi executable dengan perintah ini:

```apacheconf
sudo chmod +x php84-test
```

Masih di folder yang sama, buat file "index.php", isi dengan script ini:

```php
<?php

phpinfo();
```

Jalankan perintah ini:

```apacheconf
./php84-test -z opcache.so
```

Jika ada pesan semacam "..loaded" di terminal, berarti opcache berhasil berjalan.

Selanjutnya:

```apacheconf
./php84-test -S 127.0.0.1:9090
```

Kemudian buka [http://127.0.0.1:9090](http://127.0.0.1:9090)

Pastikan modul-modul php yang telah dienable muncul di halaman phpinfo tadi.

## Akhir Kata

Sepertinya cukup sekian.

Jika ada error atau yang semacamnya, silakan pahami apa yang kurang berdasarkan pesan errornya.