# Manajemen Halaman Web Ter-Save hanya dengan Browser dan Bookmark

Bagi saya, beberapa halaman web yang saya kunjungi adalah penting untuk disimpan secara lokal.

Itu karena dapat memudahkan saya membacanya saat offline dan juga termasuk dalam pelestarian data.

Saat ini, memang telah ada aplikasi-aplikasi self hosted yang memiliki fungsi tersebut, seperti Archivebox, Karakeep dan aplikasi-aplikasi lainnya.

Namun, ide saya kali ini mencoba untuk melakukan hal yang serupa hanya dengan web browser dan fitur bookmark-nya saja.

## Apa saja yang Diperlukan

Untuk menerapkan ide saya tadi, Anda membutuhkan:

- Web browser berbasis Chromium seperti Chrome, Brave, atau browser lain yang bisa men-save halaman web sebagai single HTML dalam format MHTML dan juga dapat membuka file MTHML tersebut.
- Folder di mana kita menempatkan file-file MHTML tadi.
- Bookmark di web browser tadi.

```
Catatan: Jika Anda belum terbayang tentang file MHTML, 
itu adalah format file tunggal yang bisa menyimpan tag HTML, 
CSS, dan JavaScript-nya sekaligus. 
Jadi, file HTML tidak terpisah dengan CSS dan JavaScript-nya. 
```

## Bagaimana Caranya: Men-Save sebagai MHTML

Saya asumsikan Anda menggunakan browser Brave.

Bukalah sebuah halaman web apapun yang Anda inginkan, kemudian klik kanan pada browser hingga muncul menu.

Kemudian klik "Save As...".

<p align="center">
    <img src="../../media/Screenshot from 2025-11-03 22-09-11.png?raw=true" alt="tampilan"/>
</p>

Saat dialog terbuka, di pojok kanan bawahnya, jika Anda pakai Ubuntu Desktop, pilih "Webpage, Single File".

<p align="center">
    <img src="../../media/Screenshot from 2025-11-03 22-10-10.png?raw=true" alt="tampilan"/>
</p>

Kemudian klik "Save".

Jika berhasil, maka file berformat MHTML akan disimpan di lokasi yang Anda pilih di dialog tadi.

Gunakan folder yang sama sebagai tempat menyimpan file MHTML agar lokasi file-nya terpusat dan lebih cocok untuk membuat bookmark nantinya.

## Bagaimana Caranya: Membuat Bookmark ke Folder Lokasi file MHTML berada

Selanjutnya, jika file MHTML Anda sudah banyak, setidaknya ada 2, buka folder MHTML Anda, dan buka salah satu file MHTML yang ada di sana. Pastikan dibuka dengan browser Brave.

Setelah file MHTML terbuka, perhatikan address bar dari Brave. Di sana ada URL untuk file path dari file MHTML yang Anda buka, dalam hal ini diawali dengan "file:///".

<p align="center">
    <img src="../../media/Screenshot from 2025-11-03 22-16-28.png?raw=true" alt="tampilan"/>
</p>

Itu tandanya browser Brave membuka file lokal, bukan halaman web.

Dalam contoh ini, file path saya seperti di bawah ini (hanya contoh):

```
file:///home/usernamesaya/Documents/Data-Direct-Library/ChatGPT/MHTML/Alternatif%20Puppeteer%20terbaru.mhtml
```

Setelah Anda mendapatkan itu, Anda hanya perlu hapus nama file MHTML dari file path tadi, sehingga hasilnya seperti ini:

```
file:///home/usernamesaya/Documents/Data-Direct-Library/ChatGPT/MHTML/
```

Sekarang, masukkan path tadi ke browser Brave Anda dan buka.

Nanti akan muncul daftar file yang ada di folder tersebut.

Bookmark halaman daftar file tadi, yang ini:

```
file:///home/usernamesaya/Documents/Data-Direct-Library/ChatGPT/MHTML/
```

Selanjutnya, jika Anda ingin menyimpan halaman web lainnya, letakkan di situ.

Jadi, saat Anda ingin membuka halaman-halaman web yang telah Anda simpan, Anda tinggal klik bookmark tadi di web browser Anda.

## Bagaimana Caranya: Jika Folder Berisi MHTML Anda Pindahkan

Jika Anda memindahkan folder tadi, pastikan bookmark yang telah Anda buat tadi disesuaikan.

Anda bisa lakukan hal yang serupa dengan langkah kita tadi dan membuat bookmark baru.

## Penutup

Dengan trik ini, kita bisa melakukan manajemen halaman web yang tersimpan tanpa aplikasi tambahan.

Selamat mencoba.
