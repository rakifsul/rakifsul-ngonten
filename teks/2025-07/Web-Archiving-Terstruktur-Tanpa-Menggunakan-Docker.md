# Web Archiving Terstruktur Tanpa Menggunakan Docker

Waktu itu sebenarnya saya sedang ingin mengerjakan penulisan artikel untuk website ini, namun karena mood saya masih kurang, pikiran saya sedikit melayang.

"Sebaiknya install apa lagi?", kata saya dalam hati.

Biasanya, saya memang sering merasa "gatal" untuk menginstall sesuatu ke komputer saya, terutama saat sedang bosan.

Itu karena saya tidak ingin menyia-nyiakan space SSD dan RAM saya yang sebenarnya masih tersisa cukup banyak.

Karena alasan tadi, saya mulai browsing dan melihat-lihat kembali browser bookmark saya.

Saya tidak mendapati sesuatu yang menarik dari sana.

Hingga akhirnya, terlintas masalah baru dalam pikiran saya.

"Bagaimana caranya agar saya bisa browsing secara offline dengan URL yang sama dengan versi online-nya?", kata saya dalam hati.

Kemudian saya coba langsung tanya ke ChatGPT.

Jawaban yang dia berikan cukup banyak, setidaknya ada sekitar lima alternatif, tapi kebanyakan harus melibatkan lebih dari satu aplikasi.

Hanya satu solusi dari jawaban tadi, yang bisa menjawab masalah offline browsing tadi dalam satu aplikasi (atau lebih tepatnya extension).

Extension tersebut bernama [Webrecorder ArchiveWeb.page](https://chromewebstore.google.com/detail/webrecorder-archivewebpag/fpeoodllldobpkbkabpblcfaogecpndd).

Extension tadi adalah untuk Chrome, tapi saya belum cek apa ada untuk browser lain.

Karena saya menggunakan Brave yang masih berbasis Chromium, maka saya langsung menginstallnya melalui link tadi.

Setelah saya install, di pojok kanan atas Brave jadi seperti gambar ini:

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-16-21-37-58.png?raw=true" alt="tampilan"/>
</p>

Saya coba jalankan "Start Archiving" dengan mencentang "Start With Autopilot".

Browser saya bereaksi dengan melakukan scrolling ke bawah secara otomatis.

Kemudian, saat saya rasa prosesnya telah selesai, saya klik "View Archived Pages".

Dan kira-kira seperti inilah yang saya dapatkan (gambar ini hanya sebagai ilustrasi):

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-16-21-35-32.png?raw=true" alt="tampilan"/>
</p>

Saya coba klik salah satunya:

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-16-22-35-32.png?raw=true" alt="tampilan"/>
</p>

Kemudian saya eksplorasi lebih jauh lagi:

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-16-21-35-45.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-16-21-36-02.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-16-21-36-19.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../../media/Screenshot-from-2025-07-16-21-36-26.png?raw=true" alt="tampilan"/>
</p>

Dari apa yang saya alami tadi, sepertinya extension ini melakukan penyimpanan DOM dari halaman yang terbuka saat itu, kemudian automatic scrolling tadi mungkin berguna jika halaman tadi menerapkan infinite scroll atau lazy loading.

Saya sempat membackup daftar-daftar website pada listing tadi, kemudian me-restore-nya ke extension itu, namun saya lupa format apa yang saya gunakan (entah WACZ atau WARC).

Sebenarnya, masih banyak hal menarik yang bisa saya eksplorasi di extension tersebut, tapi yang paling menarik adalah bahwa extension tersebut benar-benar menjawab pertanyaan saya saat bosan tadi.

Bagaimana? Apakah Anda tertarik untuk mencobanya?