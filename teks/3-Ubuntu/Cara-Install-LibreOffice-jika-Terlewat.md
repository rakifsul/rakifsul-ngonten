# Cara Install LibreOffice jika Terlewat

Saat menginstall Ubuntu, ada pilihan untuk menginstallnya secara komplit, yang artinya termasuk LibreOffice, dan ada yang tidak termasuk LibreOffice.

Karena saya telah menginstall Ubuntu secara minimum di komputer saya, LibreOffice tidak terinstall.

Namun, saya tidak perlu khawatir karena saya bisa melakukannya nanti.

Bagaimana caranya? Lanjut baca...

## Tanda bahwa LibreOffice belum Terinstall

Setelah saya masuk ke desktop Ubuntu, saya tidak melihat ada satupun aplikasi LibreOffice di start menu.

Selanjutnya, jika saya jalankan ini di terminal:

```
libreoffice
```

Maka yang tampil sebagai output seperti ini:

```
$ libreoffice
Command 'libreoffice' not found, but can be installed with:
sudo snap install libreoffice         # version 25.2.6.2, or
sudo apt  install libreoffice-common  # version 4:24.2.7-0ubuntu0.24.04.4
```

Lalu, bagaimana solusinya?

## Perhatikan Output Terminal Tadi

```
Command 'libreoffice' not found, but can be installed with:
sudo snap install libreoffice         # version 25.2.6.2, or
sudo apt  install libreoffice-common  # version 4:24.2.7-0ubuntu0.24.04.4
```

"libreoffice not found, but can be installed with..."

Artinya, saya bisa install aplikasi tersebut dengan perintah yang disediakan di bawahnya.

Ada 2 versi libreoffice di sini, yakni versi snap dan versi apt.

Tampak bahwa versi snap lebih baru: 25.2.6.2 dibandingkan apt: 24.2.7.

Karena saya ingin yang baru, maka saya ambil versi snap.

Perhatikan bahwa karakter setelah tanda # adalah komentar, jadi Anda tidak perlu menyertakannya:

```
sudo snap install libreoffice
```

Setelah Selesai, saya mendapati LibreOffice tersedia di start menu.

## Bonus: Gallery

<p align="center">
    <img src="../../media/Screenshot from 2026-01-01 12-05-24.png?raw=true" alt="tampilan"/>
</p>

