# Cara Saya Menginstall Termux di Android

Karena sudah lama saya tidak mengoprek Android, kali ini saya mencoba untuk bernostalgia menggunakan aplikasi Termux.

Dulu saya sempat pernah bisa menginstall code-server di Termux dan membukanya via browser dengan Tablet saya. Sayangnya saya sudah lupa caranya.

Tapi tidak apa-apa, setidaknya sekarang saya memulainya dengan menginstall Termux dari awal.

## Gunakan Termux dari GitHub

Walaupun Termux ada di F-Droid, saya secara pribadi lebih suka menggunakan versi GitHub-nya. Dengan demikian saya tidak perlu menginstall F-Droid.

Agar konsisten, jika Anda menginstall Termux dari GitHub, maka Addon-nya juga sebaiknya (atau bahkan mungkin harus) diinstall dari GitHub juga.

Jangan install Termux dari Play Store karena setahu saya sudah tidak di-update.

## Menginstall Addon Seperlunya

Karena saya sedang bernostalgia dengan Termux, saya menginstall Addon API dan Boot.

Saya tidak yakin apakah Termux:Boot bekerja dengan normal atau tidak, tapi saya yakin bahwa Termux:API berfungsi dengan benar.

Memang ada sedikit kendala saat saya menginstall Termux:API. Yakni, saat saya mengklik icon apk-nya, Play Protect mencegah installasi.

Akhirnya, saya putuskan untuk menonaktifkan Play Protect dari aplikasi Play Store saya. Jadi ada dua izin yang harus Anda berikan: izin untuk menginstall apk dari luar dan izin yang didapat dengan menonaktifkan Play Protect.

Setelah terinstall dengan benar, saya kemudian mengaktifkan Play Protect kembali. Sebagai info tambahan, saya menggunakan Android versi 11 saat itu. Jika Anda mengalami hal yang serupa, mungkin Anda bisa menggunakan cara saya tadi.

## Memberi Izin Storage Eksternal

Setelah saya menginstall Termux dan Addon tadi, selanjutnya saya menjalankan perintah ini:

```
termux-setup-storage
```

Lakukan ini di aplikasi Termux-nya langsung, jangan via SSH. Berikan izin yang muncul di popup.

Dengan demikian saya bisa melihat isi file dan folder di smartphone saya dengan perintah ini:

```
ls ~/storage
```

## Meng-upgrade Package

Selanjutnya, saya update dan upgrade package Termux:

```
pkg update
pkg upgrade
```

## Menginstall SSH Server

Saya merasa kurang cocok menggunakan layar smartphone saya untuk mengetik, maka saya mengendalikan Termux secara remote via ssh.

Agar bisa begitu, maka saya menginstall SSH Server di Termux.

Caranya:

```
pkg install openssh
```

## Mencoba Addon Termux:API

Ini yang paling menarik, karena dengan Addon Termux:API, saya bisa mendapatkan info seputar komponen dari smartphone saya via CLI.

Maka, saya jalankan perintah ini:

```
termux-battery-status
```

Hasil outputnya seperti ini:

```
~ $ termux-battery-status
{
  "present": true,
  "technology": "",
  "health": "GOOD",
  "plugged": "PLUGGED_USB",
  "status": "CHARGING",
  "temperature": 32.2,
  "voltage": 4271,
  "current": 553000,
  "current_average": 553000,
  "percentage": 86,
  "level": 86,
  "scale": 100,
  "charge_counter": 4234464
}

```

## Menginstal Text Editor

Saya bukan pengguna vim, tapi saya lebih cenderung menggunakan nano.

Karena saya merasa lebih nyaman dengan micro, maka saya beralih dari nano ke micro.

Cara menginstallnya:

```
pkg install micro
```

Yang bagus dari micro editor adalah keybindingnya serupa dengan text editor dengan gui native pada umumnya.

## Menginstall Development Tools

Saya pengguna Node.js sejak dulu.

Meskipun nvm (Node Version Manager) tidak disupport di Termux, saya masih bisa menginstall Node.js versi LTS dengan perintah ini:

```
pkg install nodejs-lts
```

Memang saya tidak bisa switch version dengan mudah, tapi setidaknya saya bisa coding Node.js dengan ini.

Sebenarnya ada package alternatif dari Node.js, yakni:

```
pkg install nodejs
```

Anda hanya bisa memilih salah satunya saja.

## Penutup

Sebenarnya, keberadaan Termux sangat membantu developer yang belum memiliki budget untuk memiliki laptop atau komputer desktop.

Itu karena hanya dengan text editor micro dan Node.js saja, kita secara teoritis sudah bisa coding.

Jadi, skill Termux bagi saya adalah skill survival bagi developer yang berguna saat tidak bisa mendapatkan akses ke laptop atau komputer dekstop.

Sekian...
