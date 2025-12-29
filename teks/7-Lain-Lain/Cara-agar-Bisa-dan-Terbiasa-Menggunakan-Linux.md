# Cara agar Bisa dan Terbiasa Menggunakan Linux

Tidak ada kata telat untuk belajar selama kita masih mampu melakukannya.

Keputusan saya pindah ke Linux beberapa bulan yang lalu bukan tanpa alasan.

Walaupun ada banyak alasan untuk melakukan itu, alasan terkuat bagi saya untuk pindah ke Linux adalah CPU usage yang mendekati nol saat komputer Linux sedang idle.

Saya pun yakin bahwa masih ada di antara kita yang ingin mencoba, bahkan membiasakan diri untuk menggunakan Linux untuk keperluan sehari-hari.

Di sini, di RAKIFSUL Ngonten, saya berusaha membantu saya dan mereka untuk membiasakan diri menggunakan sistem operasi Linux.

Inilah hal-hal yang ingin saya sampaikan untuk tujuan tersebut.

## Install Apa Adanya, tanpa Dual Boot, tanpa WSL, tanpa Virtualisasi

Jika Anda termasuk orang yang ingin menggunakan Linux setiap hari, maka saran saya langsung install distro Linux pilihan Anda tanpa dual boot, tanpa WSL, dan tanpa virtual machine, karena itu satu-satunya cara untuk bisa dan terbiasa menggunakan distro Linux tersebut.

Dengan kata lain, jika Anda:

- ingin terbiasa menggunakan Ubuntu, install Ubuntu tanpa dual boot maupun virtualisasi, lalu gunakan setiap hari.
- ingin terbiasa menggunakan Arch Linux, install Arch Linux secara manual dari nol tanpa dual boot maupun virtualisasi, lalu gunakan setiap hari.

Entah Anda peminat distro Ubuntu, Kubuntu, Linux Mint, Xubuntu, Arch Linux, Fedora, atau distro apapun, caranya masih serupa dengan poin-poin tadi.

## Seringlah Membaca Website yang Bertopik Linux

Walaupun sekarang sudah masuk ke zaman AI, ingat bahwa AI bisa keliru.

Lalu, bagaimana kita bisa tahu apakah info dari AI benar atau keliru?

Caranya adalah dengan mengecek ulang info tersebut:

- Di sumber info lain dengan topik yang sesuai dengan distro yang Anda gunakan.
- Di distro Linux itu sendiri dengan mencobanya.

Tapi karena mencoba langsung di distro Linux itu sendiri mungkin ada resikonya, sebaiknya kita cek dari sumber lain terlebih dahulu, misalnya di website terkait.

Untuk mempelajarinya, saya merekomendasikan topik-topik di bawah ini.

- Dokumentasi Distro Linux yang Anda Pilih
- Forum Distro Linux yang Anda Pilih, jika Ada
- DigitalOcean Blog
- Linux Journey
- Bash Tutorial
- StackExchange
- GitHub Issues
- GitHub Readme
- Search Engine apapun

## Sesekali, Install Aplikasi tanpa Docker atau Semacamnya

Saya tahu bahwa Docker sangat mempermudah pengguna Linux, tapi suatu keterampilan itu sebenarnya terasah dari kesulitan.

Jika saya mau install [aplikasi Rumput](https://github.com/rakifsul/rumput) dengan docker, maka saya hanya perlu jalankan ```docker compose up -d --build``` setelah melakukan git clone.

Sementara, jika saya mau install aplikasi barusan tanpa docker, setidaknya saya harus yakin bahwa port 3000 tidak digunakan, melakukan ```npm install```, lalu menjalankan ```npm run dev```. Tidak berhenti sampai di situ, nanti saya juga harus install ```pm2``` dan menjalankan beberapa perintahnya agar [aplikasi Rumput](https://github.com/rakifsul/rumput) bisa dijalankan otomatis saat boot. Ada error? Saya harus paham Node.js, Handlebars, CSS, dan HTML dulu baru kemudian mencoba memperbaiki kodenya sendiri.

## Gunakan 2 Perintah Linux yang Mengungkap Makna Perintah Linux

Daripada googling atau tanya LLM tentang:

- Perintah apa sajakah yang bisa untuk apa
- Untuk apakah perintah apa

Langsung pakai:

- apropos untuk cari perintah apa sajakah yang bisa untuk apa
- whatis untuk cari untuk apakah perintah apa

Berikut ini contohnya:

```
apropos network

# outputnya daftar perintah seperti ip link dan lain-lain
```

```
whatis ls

# outpunya: ls adalah untuk...
```

## Belajarlah Saat Diperlukan, Lalu Catat

Saya sangat **tidak** menyarankan Anda untuk mempelajari sebanyak mungkin info tentang Linux sebelum menggunakannya.

Itu karena memori kita terbatas.

Otak kita tidak dirancang untuk menyimpan data sebanyak itu seperti SSD.

Pecahkanlah masalah-masalah kecil yang muncul di hari-hari Anda menggunakan Linux dengan sumber-sumber yang saya sebutkan tadi, kemudian catat.

Pastikan juga Anda paham dengan solusi dari masalah tersebut.

Jika masalah itu muncul dan Anda lupa solusinya, buka dan baca catatan tersebut, kemudian praktikkan lagi.

Lakukan itu pada masalah masalah lainnya.

Mudah-mudahan, lama kelamaan Anda akan mampu memecahkan masalah tersebut tanpa lihat catatan lagi.

## (Optional) Jadikanlah Penggunaan Linux sebagai Tujuan, bukan hanya Alat untuk Mencapai Tujuan

Bagi saya, penggunaan Linux bukan sekedar alat untuk mencapai tujuan, tapi juga merupakan tujuan saya.

Dulu, waktu saya masih sekolah, saya ingin cepat-cepat pulang agar nantinya bisa main game.

Sekarang, saya bosan main game, jadi, saya bekerja mengumpulkan uang agar saya bisa beli PC yang diinstall Linux.

Saya juga ingin pekerjaan saya cepat selesai, agar nanti saya bisa menikmati komputer saya yang diinstall Linux barusan.

Apakah tujuan saya itu nanti akan berubah? Saya tidak tahu...

Mungkin Anda berbeda dengan saya dalam hal ini, tapi saya bisa memahami itu dan karena itulah poin ini adalah optional, tergantung keputusan Anda.

## Penutup

Hanya itu yang terpikirkan oleh saya terkait judul artikel ini saat saya menulis artikel ini, mungkin saja ada hal yang saya lupa.