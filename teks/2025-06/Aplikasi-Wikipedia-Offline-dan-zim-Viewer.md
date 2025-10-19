# Kiwix-Serve - Aplikasi Wikipedia Offline dan zim Viewer

Apakah Anda suka baca Wikipedia?

Jika iya, apakah Anda ingin membacanya secara offline, entah di komputer lokal Anda atau di komputer lain dalam jaringan internal Anda?

Jika ya, maka Anda hanya perlu menginstall beberapa aplikasi di komputer Anda.

## Aplikasi yang Anda Perlukan

Untuk membaca Wikipedia offline, Anda bisa menggunakan [Kiwix-Serve](https://wiki.kiwix.org/wiki/Kiwix-serve) yang merupakan bagian dari Kiwix-Tools.

Aplikasi tadi bisa diinstall dengan menggunakan Docker.

Jika Anda belum tahu tentang Docker, silakan cek [di dokumentasi resminya](https://docs.docker.com), kemudian Anda install.

Sebenarnya Kiwix-Serve bisa dijalankan dan diinstall tanpa Docker, namun, mengunakan Docker, terutama di Linux membuka peluang untuk memudahkan Anda menggunakan aplikasi self hosted berbasis web lainnya.

Jadi, lebih baik Anda install saja.

## Cara Menginstall Kiwix-Serve

Sekarang, saya berasumsi bahwa Anda telah menginstall Docker.

Bukalah terminal, kemudian jalankan perintah ini:

```bash
docker run -d -it --name kiwix-serve --restart=unless-stopped -v '/path/ke/file/zim/folder/anda':/data -p 7001:8080 ghcr.io/kiwix/kiwix-serve:3.7.0 '*.zim'
```

Dari perintah tadi, Anda bisa tahu bahwa:

-   docker run -d -it artinya "detach container setelah dijalankan secara interaktif dan tty (bisa berinteraksi dengan container dengan terminal)".
-   nama container adalah kiwix-serve
-   kebijakan restart adalah unless-stopped atau "akan di-restart kecuali sudah distop"
-   /path/ke/file/zim/folder/anda adalah folder di mana kumpulan file zim Anda berada. Anda bisa mendapatkan file zim dari [Kiwix Library](https://library.kiwix.org/#lang=&q=).
-   \-p 7001:8000 artinya port internal container yang 8000 dimap ke port 7001 di sistem operasi Anda
-   ghcr.io/kiwix/kiwix-serve:3.7.0 artinya install kiwix-serve versi 3.7.0 yang didapat dari registry bernama ghcr.io
-   '\*.zim' artinya buka semua file berekstensi .zim di folder tadi

## Lebih Jauh tentang Kiwix-Serve

Kiwix-Serve adalah aplikasi berbasis web.

<p align="center">
    <img src="../../media/Screenshot-from-2025-06-09-22-56-01.png?raw=true" alt=""/>
</p>

Jadi, Anda mengaksesnya dengan menggunakan browser.

Dalam kasus tadi, Anda harus membuka browser ke http://ip-address-komputer-terinstall-docker:7001

Jadi, jika Anda menginstall Kiwix-Serve di komputer lokal Anda, alamatnya adalah [http://127.0.0.1:7001](http://127.0.0.1:7001)

Anda bisa mengubah port tadi dengan mengubah perintah docker run tadi di bagian port-nya, yang 7001.

## Fitur-Fitur

Kiwix-Serve memiliki fitur-fitur ini:

-   berbasis web, jadi nyaman untuk dibookmark
-   fitur internal zim search yang cukup baik dengan pagination
-   fitur filtering dari jenis zim file.
-   fitur searching zim file

## Akhir Kata

Walaupun sebenarnya Wikipedia atau website lain yang ada zim file-nya umumnya bisa diakses online, Kiwix-Serve tetap memiliki fungsi yang bermanfaat jika Anda sedang tidak bisa online.

Selain itu, karena diinstall di komputer lokal atau dalam jaringan internal, Anda bisa mendapatkan privasi yang lebih baik

Jadi, tunggu apa lagi? Segera install Kiwix-Serve....