# Cara Modifikasi Aplikasi SearXNG dari Source Code

Saat itu sudah tengah malam.

Setelah membaca beberapa artikel di beberapa website favorit saya, saya memutuskan untuk menulis artikel baru di blog ini.

Saya masih ingat bahwa beberapa waktu yang lalu saya pernah membahas cara menginstall SearXNG, yang merupakan self hosted search engine.

Jika Anda ingin membacanya, [klik di sini](Cara%20Membuat%20Search%20Engine%20Pribadi%20dengan%20SearXNG.md).

Tapi, lebih dari itu, terinspirasi dari cara installnya, saya mendapat ide tentang bagaimana jika saya membuatkan artikel tentang cara memodifikasinya.

Idenya sederhana.

Di aplikasi SearXNG, ada logo bertuliskan "SearXNG", tepatnya pada homepage-nya.

Agar mudah untuk dipahami, saya memutuskan untuk membahas cara mengganti logo tadi karena itu cukup mudah.

Bagaimana caranya? Lanjut baca...

## Mempersiapkan Peralatan dan Bahan

Saya asumsikan Anda menggunakan Ubuntu 24.04.

Selain itu, package dan aplikasi ini telah terinstall:

*   VSCode
*   Git
*   Image viewer apapun
*   Browser apapun
*   Python 3.11.13 (agar sama dengan saya)

Juga, Anda perlu sebuah gambar PNG apapun yang beda dengan logo SearXNG.

Pastikan ukuran PNG tadi tidak berbeda jauh dengan logo SearXNG di homepage-nya.

Jika Anda tertarik untuk menggunakan pyenv dalam menginstall Python 3.11.13, saya sudah pernah membahasnya [di artikel ini](https://rakifsul.github.io/menginstall-ollama-dan-open-webui-di-ubuntu-2404-tanpa-docker.html). Cari saja subbab tentang pyenv.

## Melakukan Clone Repository SearXNG

Buatlah clone dari repository SearXNG dengan menjalankan perintah ini:

```bash
git clone https://github.com/searxng/searxng.git
```

Selanjutnya masuk ke dalam folder searxng dan buka VSCode di sana.

## Membuild dan Menjalankan SearXNG

Buka integrated terminal dari VSCode, kemudian jalankan:

```bash
make run
```

Nanti browser Anda akan terbuka ke [http://127.0.0.1:8888](http://127.0.0.1:8888) secara otomatis.

<p align="center">
    <img src="../media/Screenshot-from-2025-07-19-01-11-47.png?raw=true" alt="tampilan"/>
</p>

Karena itulah, saran saya port 8888 Anda tidak digunakan untuk keperluan lain.

## Menganalisis Lokasi Gambar Logo SearXNG di Homepage-nya

Untuk mengetahui lokasi logo SearXNG, Anda bisa klik kanan pada browser, kemudian inspect element, jika Anda menggunakan Chrome atau browser yang berbasis Chrome seperti Brave.

Setelah inspector window muncul buka tab "styles" di bagian kanannya, dan cari property css yang kira-kira berupa gambar.

<p align="center">
    <img src="../media/Screenshot-from-2025-07-19-01-12-11.png?raw=true" alt="tampilan"/>
</p>

Screenshot di atas menunjukkan bahwa background url itu sedikit "mencurigakan" karena ada file bernama "searxng.png".

Mari kita analisis lebih lanjut dengan mengklik link di css tadi.

Setelah diklik, kita bisa lihat gambarnya:

<p align="center">
    <img src="../media/Screenshot-from-2025-07-19-01-12-48.png?raw=true" alt="tampilan"/>
</p>

Ternyata benar.

## Mencari Lokasi "searxng.png"

Sekarang, kita kembali ke source code SearXNG yang telah dibuka dengan VSCode. Jika belum dibuka, maka bukalah sekarang.

Setelah kita membuka source code SearXNG, kita hanya perlu mencari lokasi "searxng.png" dengan cara menekan CTRL+P dan menulis "searxng.png" di input box-nya.

<p align="center">
    <img src="../media/Screenshot-from-2025-07-19-01-13-38.png?raw=true" alt="tampilan"/>
</p>

Ingat baik-baik path yang ada di hasil pencariannya dan langsung buka dengan mengkliknya.

<p align="center">
    <img src="../media/Screenshot-from-2025-07-19-01-14-04.png?raw=true" alt="tampilan"/>
</p>

Nah. Di sinilah kita mendapatkan akar dari permasalahan kita.

Sekarang lanjut ke solusinya.

## Mengganti Gambar "searxng.png"

Untuk mengganti gambar tadi, kita hanya perlu mereplace gambar tadi dengan gambar yang telah kita siapkan sejak awal dari artikel ini.

Gambarnya tinggal dicopy, paste, dan replace ke gambar "searxng.png".

Pastikan gambar baru bernama sama dengan gambar lama, yaitu "searxng.png".

<p align="center">
    <img src="../media/Screenshot-from-2025-07-19-01-14-58.png?raw=true" alt="tampilan"/>
</p>

## Pengujian

Sekarang kembali ke integrated terminal dari VSCode, lalu tekan CTRL+C untuk menghentikan server.

Kemudian, jalankan kembali SearXNG dengan:

```bash
make run
```

Nanti Browser Anda akan kembali terbuka ke [http://127.0.0.1:8888](http://127.0.0.1:8888) **TAPI** gambarnya kemungkinan belum berubah karena masih ada cache di Browser.

Untuk memastikan bahwa cache tersebut bersih, silakan **clear browsing data** atau **gunakan private window** jika Anda menggunakan Brave.

Sekarang inilah hasilnya:

<p align="center">
    <img src="../media/Screenshot-from-2025-07-19-01-15-43.png?raw=true" alt="tampilan"/>
</p>

## Penutup

Memodifikasi aplikasi dari source code sebenarnya bisa sulit namun juga bisa mudah.

Untungnya, SearXNG ini termasuk aplikasi yang mudah dimodifikasi, setidaknya untuk kasus ini.

Walaupun begitu, secara prinsip, untuk memodifikasi aplikasi apapun dari source code-nya, kita perlu memastikan bahwa kita bisa menjalankannya dalam keadaan asli melalui source code-nya.