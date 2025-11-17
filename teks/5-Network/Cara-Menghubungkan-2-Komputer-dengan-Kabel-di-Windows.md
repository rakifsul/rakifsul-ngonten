# Cara Menghubungkan 2 Komputer dengan Kabel di Windows

Sekarang, kita andaikan bahwa terdapat 2 komputer yang masing-masing memiliki 1 slot ethernet dan masing masing memiliki 1 adapter WiFi.

Komputer 1 adalah komputer utama yang mana aktivitas online kita dilakukan.

Komputer 2 merupakan komputer cadangan yang jarang digunakan tapi terinstall aplikasi self-hosted seperti Kiwix Serve.

Catatan: Jika Anda belum tahu tentang Kiwix Serve, itu adalah aplikasi web self hosted yang berfungsi sebagai server wikipedia offline.

Seandainya, jika kita bertujuan mengakses komputer 2 karena ingin membaca wikipedia dari web browser di komputer 1, kita perlu menghubungkan kedua komputer tadi.

Cara ini sebenarnya tidak perlu sulit.

Kita tinggal menyalakan kedua komputer tadi, kemudian menghubungkannya ke jaringan WiFi kita di rumah.

Tapi, di sini, saya membahas koneksi dengan kabel ethernet.

Karena, biasanya, walaupun tergantung fitur komputernya, kecepatan transfer data dengan kabel ethernet lebih cepat.

Selain itu, dengan menghubungkannya via kabel, maka kita bisa memilih apakah komputer 2 tadi akan diberi akses ke internet atau tidak.

Lalu, bagaimana caranya? Saya akan bahas, tapi untuk sistem operasi Windows saja.

Yang harus Anda ingat, pada prinsipnya, di komputer 1 dan komputer 2, ip yang dipasang harus berada pada network yang sama.

## Langkah 1: Hubungkan kedua komputer tadi dengan kabel ethernet.

Setelah terhubung, nyalakan kedua komputer tadi.

Anda mungkin perlu 2 monitor, tapi, jika hanya ada 1, bisa berganti-gantian satu sama lain. Pastikan saat menukar monitor, semua komputer sudah dimatikan dan kabel listriknya dicabut.

Sekarang, lakukan ini di komputer 1...

Buka settingan network di Windows melalui control panel. Caranya adalah dengan mencari keyword control panel dengan mengklik tombol search di taskbar.

Setelah terbuka, pilih "View By: Small Icons".

Nanti akan ada daftar sub setting.

Selanjutnya pilih Network and Sharing Center > Change Adapter Settings.

Di Adapter Settings, yang bisa disebut juga Network Connections, ada beberapa daftar koneksi jaringan.

Jika Anda menggunakan WiFi dengan komputer anda, biasanya di situ ada koneksi yang bernama "WiFi". Kita tidak perlu memusingkannya.

Yang jelas, kita harus cari nama koneksi yang ada kata "Ethernet"-nya.

Tapi, bagaimana jika ada banyak koneksi yang memiliki nama "Ethernet"? Anda tinggal fokus pada yang ada tulisan di bawahnya "Unidentified Network".

Jika hanya ada yang bertuliskan "Network Cable Unplugged", kemungkinan, kedua komputer tadi belum terhubung secara fisik dengan benar.

## Langkah 2: Konfigurasi koneksi ethernet

Setelah anda tahu mana koneksi yang terhubung dengan komputer 2, klik kanan pada koneksi > Properties > Internet Protocol Version 4 > Properties. (masih di komputer 1)

Di sana akan muncul input untuk ip.

Di komputer 1, isi:

- ip address: 192.168.1.20
- subnet mask: 255.255.255.0
- default gateway: kosongkan
- preferred dns server: 8.8.8.8 [atau dns favorit anda]
- alternate dns server: 8.8.4.4 [atau dns favorit anda]

Sekarang simpan konfigurasi dengan klik tombol ok.

Selanjutnya, pindah ke komputer 2...

Di komputer 2, isi:

- ip address: 192.168.1.55
- subnet mask: 255.255.255.0
- default gateway: kosongkan
- preferred dns server: 8.8.8.8 [atau dns favorit anda]
- alternate dns server: 8.8.4.4 [atau dns favorit anda]

Simpan konfigurasi dengan klik tombol ok.

Ingat:

Anda bisa memilih ip yang beda jaringan dengan WiFi Anda agar salah satu komputer yang tak terhubung WiFi terisolasi. Tapi, kedua komputer tadi harus dengan ip yang satu jaringan ethernet.

Misal:

- ip wifi komputer 1: 192.168.0.3
- ip wifi komputer 2: 192.168.0.5
- ip ethernet komputer 1: 192.168.1.20
- ip ethernet komputer 2: 192.168.1.55

Itulah yang kita lakukan pada langkah ini.

## Langkah 3: Pengujian

Jika Anda telah selesai di langkah 2, maka sekarang tinggal memastikan.

Ping ip komputer 2 dari komputer 1.

Karena saya berasumsi komputer 2 memiliki ip 192.168.1.55 maka jalankan perintah ini di command line:

```
ping 192.168.1.55
```

jika ada respon reply, berarti kita berhasil.

jika tidak, maka ada yang keliru.

Jika Anda berhasil, komputer 2 Anda bisa terhubung secara network dengan ip 192.168.1.55 jika diakses dari komputer 1.

## Akhir Kata

Begitulah cara ringkas untuk menghubungkan 2 komputer Windows dengan ethernet.

Jika Anda masih belum berhasil, maka silakan diagnosis sendiri dengan search engine atau dengan AI chatbot.

Jika Anda berhasil, Anda bahkan bisa me-remote komputer 2 dengan remote desktop, tapi itu tidak dibahas di sini.

Apalagi, sekarang sudah banyak sekali aplikasi web self hosted. Mulai dari wikipedia offline, ebook manager, youtube archiver, dan lain-lain.

OK.. Sudah dulu ya...