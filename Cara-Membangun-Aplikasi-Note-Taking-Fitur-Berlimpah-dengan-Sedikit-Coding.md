# Cara Membangun Aplikasi Note Taking Fitur Berlimpah dengan Sedikit Coding

Pernahkah Anda terbayang, memiliki aplikasi pencatat atau note taking, yang gratis, cepat, berlimpah fitur, portable, tanpa Anda harus coding kecuali sedikit sekali?

Hal tersebut memungkinkan.

Yang jelas, sebelum Anda mulai melakukan coding, sadarilah bahwa saat ini aplikasi-aplikasi siap pakai saat ini sudah sangat banyak.

Tugas kita adalah memanfaatkannya dan memanipulasinya dengan sedikit usaha.

Memang, coding dari nol adalah salah satu cara untuk memecahkan masalah, tapi tidak semua masalah harus dilakukan dengan coding dari nol.

Oleh karena itulah, skill memanfaatkan dan memanipulasi aplikasi siap pakai penting untuk dikuasai.

## Bagaimana Bisa?

Tentu saja bisa. Anda tahu [VS Code](https://code.visualstudio.com/)? Anda bisa menjadikan aplikasi tersebut sebagai alat untuk mencatat, tidak hanya coding.

Saat ini fork-nya sudah ada beberapa. Salah satunya adalah [VS Codium](https://github.com/VSCodium/vscodium).

Nah, fork dari VS Codium yang bernama [Codium](https://github.com/Alex313031/codium) memiliki fitur yang tidak jauh berbeda dengan VS Code. Bahkan performanya lebih cepat menurut saya (silakan cek sendiri, mungkin beda).

Dengan kata lain, ide utama dari artikel ini adalah, menggunakan Code Editor sebagai aplikasi Note Taking.

Basis aplikasi yang digunakan adalah salah satu fork dari fork VS Code yang bernama Codium.

Codium digunakan karena fungsinya berlimpah dan performanya bagus.

Pemilihan basis aplikasi ini bukan tanpa alasan.

VS Code dan fork-fork-nya mendukung penginstallan extension, termasuk Codium.

Dan extension tersebut sangat banyak.

Beberapa extension bahkan sangat cocok untuk keperluan note taking seperti:

-   Markdown to PDF
-   PDF reader
-   Excalidraw, untuk menggambar
-   Draw.io untuk membuat diagram

Aplikasi semacam Codium ini siap pakai, jadi kalaupun Anda perlu coding, sebenarnya tidak terlalu banyak. Hanya sedikit script bash di Ubuntu atau script batch jika Anda di Windows.

Namun, di sini saya hanya membahas manipulasinya di Ubuntu.

## Kenapa Kita Memerlukan Coding Bash?

Jadi, kita perlu sedikit coding bash karena kita ingin Codium jadi portable secara sempurna.

Sebenarnya, paket executable yang disediakan Codium ada yang sudah portable dalam artian bisa dijalankan dari folder manapun.

Namun, saya ingin kita menyempurnakan keportabelannya dengan menyatukan folder project dengan folder executable-nya sehingga baik aplikasi Codium, konfigurasi, dan folder projectnya mudah dibackup dan ditransfer. Cukup mengompresinya menjadi file zip dan memindahkannya ke flash disk.

Dengan menempatkan konfigurasi secara portable, maka data extension dan setting dari Codium ada di folder yang menyatu dengan folder aplikasi.

## Bagaimana Caranya?

Pertama, buat folder bernama "Note-Taker" di lokasi manapun yang bisa Anda akses di ubuntu.

Selanjutnya, [download Codium di sini](https://github.com/Alex313031/codium/releases/download/1.93.1.24277/Codium_linux_x64_1.93.1.24277.zip).

Di folder "Note-Taker", buat folder "bin".

Masuk ke folder "bin" ekstrak zip tadi dan rename menjadi "Codium-Linux".

Masuk ke folder "Codium-Linux", buat folder bernama "data".

Sisa ekstraksi zipnya boleh Anda pindahkan ke luar folder "Note-Taker" atau dihapus.

Kembali ke folder "Note-Taker", buat folder "Projects".

Buat file bernama "Codium.sh".

Isi dengan script ini, save, kemudian tutup:

```bash
#!/bin/bash

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

($SCRIPTPATH/bin/Codium-Linux/codium --no-sandbox $SCRIPTPATH/Projects) &
```

Jalankan perintah ini:

```bash
sudo chmod +x Codium.sh
```

Sekarang, coba klik kanan pada "Codium.sh" kemudian pilih "Run as Program".

Jika aplikasi Codium terbuka dan menggunakan folder "Note-Taker/Projects" sebagai folder default, maka Anda berhasil.

## Tapi Masih Ada Lagi

Sekarang Anda telah mendapatkan aplikasi note taking portable, full feature, yang cepat selesai.

Tapi, mungkin Anda ingin supaya Anda bisa langsung membukanya dari desktop.

Sekarang, mari kita lakukan.

Pertama, aktifkan menu create link di Nautilus (file explorer Ubuntu) dengan cara yang saya bahas [di artikel ini](https://rakifsul.github.io/cara-mengaktifkan-create-link-di-nautilus-ubuntu-2404.html).

Kedua, klik kanan pada "Codium.sh" dan klik "Create Link".

Pindahkan file link yang telah dibuat ke desktop.

Sekarang Anda bisa membuka aplikasi Codium portable Anda dari desktop.

## Akhir Kata

Sekian dan terus baca artikel saya.