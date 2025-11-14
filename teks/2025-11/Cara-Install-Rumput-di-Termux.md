# Cara Install Rumput di Termux

Tadinya, saya ingin mencoba lagi untuk menginstall code-server di Termux, namun kelihatannya kali ini saya mendapatkan sedikit kesulitan.

Karena saya kira ini akan memakan waktu cukup lama, maka saya putuskan untuk menginstall aplikasi saya yang bernama Rumput terlebih dahulu.

Rumput adalah aplikasi web dashboard buatan saya yang fiturnya tidak hanya membuat daftar link atau bookmarks, namun juga catatan terenkripsi, trigger JavaScript, dan kemungkinan akan bertambah lagi.

## Prasyarat Install

Untuk menginstall Rumput di Termux, Anda perlu install Termux terlebih dahulu. Pastikan bahwa Anda menggunakan versi GitHub-nya dan bukan versi Play Store nya.

Selain itu, Anda juga perlu Node.js, install dengan perintah ini:

```
pkg update

pkg install which

pkg install nodejs-lts
```

Untuk memastikannya, jalankan perintah ini:

```
node -v
# harus muncul versi nodejs

npm -v
# harus muncul versi npm

which node
# harus muncul path nodejs
```

Syarat lainnya adalah:
- IP Android Anda harus bisa diakses
- Port 3000 tidak sedang digunakan

## Cara Install

Setelah semua prasyarat terpenuhi, clone Rumput dari GitHub.

```
mkdir Rumput

cd Rumput

git clone https://github.com/rakifsul/rumput.git

cd rumput
```

Selanjutnya:

```
# agar versi saya di tutorial ini sama dengan versi Anda
git checkout 2025.11.04-0420

npm install

npm run dev

# sekarang, buka ke http://ip-android-anda:3000
```

Jika berhasil, maka Anda akan melihat tampilan ini:

<p align="center">
    <img src="../../media/Screenshot from 2025-11-14 18-40-28.png?raw=true" alt="tampilan"/>
</p>

## Penutup

Sekian...
