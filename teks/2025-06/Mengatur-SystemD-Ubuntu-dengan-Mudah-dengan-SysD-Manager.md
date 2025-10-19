# Mengatur SystemD Ubuntu dengan Mudah dengan SysD Manager

Hari itu saya sedang bergairah untuk menjajal aplikasi-aplikasi yang belum saya ketahui di Ubuntu.

Tidak akan saya install semua, tentunya. Hanya beberapa yang saya duga cukup bermanfaat bagi saya.

Karena saya sudah pernah mengeksplorasi App Center, maka saya coba Googling sebentar tentang daftar aplikasi Ubuntu.

Salah satu aplikasi muncul, tapi bukan itu yang saya perhatikan.

Yang saya perhatikan adalah nama repositorinya, yakni [Flathub](https://flathub.org).

Baru dilihat sekilas saja, saya sudah menduga bahwa di sana banyak aplikasi-aplikasi menarik.

Ternyata benar, mulai dari aplikasi alat hingga games ada di sana.

Seperti biasa, karena saya suka dengan aplikasi yang berkaitan dengan sistem, maka saya mencoba menjelajahi FlatHub sedikit demi sedikit.

Hingga akhirnya saya temukan aplikasi dengan icon gear berwarna hijau, [SysD Manager](https://flathub.org/apps/io.github.plrigaux.sysd-manager).

Setelah melihat screenshotnya, saya paham bahwa itu adalah sesuatu untuk mengatur systemd. Maksud saya systemd yang biasa saya perintahkan seperti ini:

```bash
sudo systemctl status docker
```

Copy

Saya pernah mengalami sendiri saat saya membuat script systemd, mengenable-nya, melakukan daemon-reload, serta men-start-nya hingga men-stop-nya.

Melakukan hal tersebut di terminal memang sedikit merepotkan.

SysD Manager menyelesaikan masalah tersebut dengan menyediakan GUI untuk keperluan tadi.

<p align="center">
    <img src="../../media/Screenshot-from-2025-06-19-06-17-51.png?raw=true" alt="tampilan"/>
</p>

Dengan aplikasi seperti ini, saya tidak perlu repot-repot melakukan ini untuk mengetahui daftar systemd yang ingin saya cari:

```apacheconf
ls /usr/lib/systemd/system
```

Copy

Bahkan fitur tampilan journal-nya pun ada.

Aplikasi ini menurut saya benar-benar keren dan bermanfaat.

Jika Anda pengguna Ubuntu, apalagi masih baru menggunakannya, saya sangat menyarankan untuk menginstallnya [dari Flathub](https://flathub.org/apps/io.github.plrigaux.sysd-manager).

Dengan demikian, saya rasa cukup perkenalannya.

Mudah-mudahan bermanfaat.