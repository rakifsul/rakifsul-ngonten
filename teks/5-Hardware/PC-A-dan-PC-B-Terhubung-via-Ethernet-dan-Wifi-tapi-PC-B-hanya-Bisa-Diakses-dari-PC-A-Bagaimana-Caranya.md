# PC A dan PC B Terhubung via Ethernet dan Wifi, Tapi PC B hanya Bisa Diakses dari PC A. Bagaimana Caranya?

Sudah cukup lama saya tidak menulis artikel. Sekaranglah saat yang tepat karena mood saya lagi bagus.

Terkait judul artikel ini, sebenarnya itu adalah yang terjadi di PC A dan PC B saya.

Namun sebelumnya, agar persepsi tentang PC - PC tersebut sama, saya definisikan dulu.

PC A adalah Mini PC saya yang saya gunakan sebagai komputer utama untuk bekerja. Saya menggunakan Kubuntu 24.04 di PC A.

PC B adalah PC Gaming saya yang saya gunakan sebagai penyokong komputasi AI bagi Mini PC saya tadi. Saya menggunakan Ubuntu Server 24.04 di PC B.

Nah, karena PC B tadi fungsinya adalah sebagai penyokong dari PC A, maka saya merancangnya agar tidak terlalu tergantung pada jaringan Wifi.

PC B memang bisa digunakan untuk mengakses Wifi dan internet, tapi hanya saat saya perlukan saja. Adapun PC A hampir selalu terkoneksi dengan Wifi dan internet.

## Use Case dari Setup Seperti Itu

Beberapa kali saya melakukan percobaan dengan Ollama API dan membutuhkan model yang cukup berat.

Dengan menggunakan PC A saja, proses penggunaan modelnya akan sedikit lama.

Karena PC B merupakan mantan PC gaming dengan GPU yang lumayan, maka proses tadi menjadi lebih cepat.

Maka, saat saya menjalankan program yang menggunakan LLM, seperti [code generator yang dibahas di artikel ini](../1-Trik-LLM/Membuat-Bahasa-Pemrograman-Web-yang-Menggunakan-Bahasa-Manusia-dengan-LLM.md), dengan model yang lebih berat seperti gemma3:12b, mungkin saya bisa menjalankannya lebih cepat dengan setup ini.

Selain itu, jika kita berada dalam jaringan yang tidak terlalu private, misalnya di kantor atau restoran, dan kita memiliki komputer yang seperti PC A dan PC B tadi, maka setup semacam ini cukup baik untuk mencegah user yang tidak diinginkan mengakses PC B.

Wifi dan internet masih diperlukan untuk setup ini, karena Ollama perlu model yang didapatkan melalui proses download (dengan ollama pull). Selain itu, kita juga perlu update dari sistem operasinya sewaktu-waktu.

## Prinsip Kerja

Setup ini memiliki kebijakan seperti ini:

-   PC B hanya bisa diakses dari PC A dari jaringan ethernet saat Wifi PC B aktif maupun tidak aktif.
-   Saat Wifi PC B aktif, maka semua port inbound diblokir untuk seluruh ip dari jaringan Wifi, tapi hanya beberapa port yang dibuka hanya untuk jaringan PC A dan PC B yang terhubung via kabel ethernet.

Dengan kebijakan tadi, maka kita harus melibatkan pemberian ip yang tepat dan konfigurasi firewall yang tepat juga.

Dengan kata lain, fokus dari "bagaimana caranya" adalah seputar pengaturan ip, port, dan firewall.

## Bagaimana Cara Menerapkannya

Pertama, saya asumsikan bahwa jaringan Wifi PC A dan PC B adalah 192.168.0.0/24.

Saya juga berasumsi bahwa Ollama API dibroadcast pada 0.0.0.0:11434 seperti yang dibahas [di artikel ini](../1-Trik-LLM/Cerita-Waktu-Saya-Ingin-Coding-Pakai-LLM-Lokal-dengan-VSCode-di-Ubuntu-24.04.2.md).

Saya juga berasumsi bahwa Wifi PC B sudah disetup, biasanya saat Ubuntu Server baru diinstall.

Setelah slot ethernet dari PC A terhubung ke slot ethernet PC B melalui kabel, lakukan ini:

-   Ethernet PC A diberi ip: 192.168.2.1 dan network mask: 255.255.255.0
-   Ethernet PC B diberi ip: 192.168.2.2 dan network mask: 255.255.255.0
-   Kosongkan default gateway keduanya.

Sekarang, ping ip PC B dari PC A:

```bash
ping 192.168.2.2
```

Jika berhasil, maka langkah tersebut sukses.

Dalam kondisi PC B tidak terkoneksi ke Wifi, maka seharusnya itu sudah cukup.

Namun, PC B juga harus bisa mengakses internet via Wifi, maka langkah selanjutnya adalah pengaturan firewall dari PC B. Caranya:

-   `sudo ufw allow from 192.168.2.1 to any port 22 proto tcp` => agar PC A bisa ssh ke PC B
-   `sudo ufw allow from 192.168.2.1 to any port 11434 proto tcp` => agar PC A bisa akses ke Ollama API.
-   `sudo ufw allow from 192.168.2.1 to any port 80 proto tcp` => Jika Anda menginstall open webui untuk ollama di port 80. Ganti 80 dengan port versi Anda jika diperlukan.

Karena di Ubuntu Server berlaku bahwa ip dan port yang tidak dikonfigurasi sebagai deny:

```bash
Default: deny (incoming), allow (outgoing), deny (routed)
```

Maka konfigurasi firewall tadi sudah cukup.

Untuk memastikannya, jalankan perintah ini di PC B:

```bash
sudo ufw status verbose
```

Hasilnya, seharusnya:

```bash
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), deny (routed)
New profiles: skip

To                         Action      From
--                         ------      ----     
80/tcp                  ALLOW IN    192.168.2.1               
22/tcp                     ALLOW IN    192.168.2.1               
11434/tcp                  ALLOW IN    192.168.2.1  
```

Tapi itu belum selesai. Kita juga harus memastikan bahwa secara default Wifi PC B tidak diaktifkan saat PC B dinyalakan.

Caranya adalah dengan konfigurasi crontab. Untuk itu, jalankan perintah ini:

```bash
sudo crontab -e
```

Kemudian isi dengan script ini di bagian paling bawah:

```bash
@reboot ip link set wlp5s0 down
```

wlp5s0 bisa jadi berbeda di PC Anda, jadi, sesuaikan dengan milik Anda. Caranya dengan mengeceknya dengan perintah ini:

```bash
ip addr
```

Kemudian cari interface untuk ethernet PC B Anda.

Nanti, saat PC B perlu akses internet via Wifi, yang perlu kita lakukan adalah:

```bash
sudo ip link set wlp5s0 up
```

Dan untuk menonaktifkan Wifi-nya lagi, Anda bisa reboot PC B atau dengan menjalankan perintah ini:

```bash
sudo ip link set wlp5s0 down
```

Tapi, sekali lagi, sesuaikan "wlp5s0" dengan milik Anda, karena wlp5s0 bisa jadi berbeda di PC Anda.

## Penutup

Nah, dengan cara ini, saya bisa menggunakan PC gaming bekas saya sebagai penyokong AI PC mini saya dengan cukup aman.

Jadi, mungkin saya tidak perlu beli PC gaming baru untuk sementara.
