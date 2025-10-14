# Aplikasi Catatan Terenkripsi Portable untuk Ubuntu - Notesnook

Entah sudah berapa banyak catatan pribadi yang telah saya buat di komputer saya, entah itu catatan teknis maupun yang lain...

Namun, bukankah ide yang bagus jika hanya saya yang bisa baca catatan tersebut?

Bayangkan jika catatan tersebut sampai dibaca orang lain, mungkin blog ini menjadi duplicate content yang tidak bagus untuk SEO.

Apakah kekhawatiran saya tadi ada solusinya?

Jawabnya: YA! Ada.

Salah satu aplikasi yang telah saya ketahui dapat mengenkripsi catatan saya adalah [Notesnook](https://notesnook.com).

Aplikasi tersebut bisa dijalankan di Linux dan portable, karena menggunakan format AppImage.

Walaupun begitu, karena saya biasanya ingin aplikasi yang saya gunakan portable secara sempurna, maka saya akan sedikit lakukan modifikasi.

Prinsipnya:

*   Aplikasi harus portable, misal dengan format AppImage
*   Aplikasi, data aplikasi, dan data konten harus dalam satu folder, sehingga jika saya mau backup tinggal compress dan copy ke external drive.
*   Link atau shortcut harus ada agar mudah dibuka dari desktop.

Untuk menerapkan prinsip-prinsip tadi, kita akan sama-sama belajar:

*   Mendownload Notesnook
*   Memasukkan Notesnook dalam sebuah folder
*   Menerapkan folder data aplikasi dan data konten pada folder tadi
*   Membuat desktop shortcut untuk Notesnook agar mudah diakses dari desktop

Bagaimana caranya? Lanjut....

## Menyiapkan gambar SVG

Anda perlu sebuah file SVG untuk menjadi logo bagi shortcut aplikasi Notesnook.

Terserah Anda mau seperti apa gambarnya. Yang penting, rename gambar SVG tersebut menjadi "logo.svg".

## Mendownload Notesnook

Notesnook bisa didownload di situs resminya:

```bash
wget https://notesnook.com/api/v1/releases/linux/latest/notesnook_linux_x86_64.AppImage
```

Copy

Itu adalah versi terbaru saat artikel ini ditulis. Jika Anda membaca artikel ini di masa depan, silakan cek kembali link download-nya.

## Memasukkan Notesnook dalam sebuah folder

Sekarang, di mana Anda mau mengerjakan catatan Anda? Buat folder bernama "My-Notes" di folder tersebut.

Di folder "My-Notes", buat subfolder:

*   bin
*   data

Copy aplikasi Notesnook tadi ke dalam folder "My-Notes/bin", kemudian copy "logo.svg" ke dalam folder "My-Notes" sehingga di folder "My-Notes" ada:

*   My-Notes/bin/notesnook\_linux\_x86\_64.AppImage
*   My-Notes/data
*   My-Notes/logo.svg

## Mengizinkan Notesnook untuk dijalankan

Sekarang saya berasumsi bahwa posisi terminal Anda ada di folder "My-Notes/bin".

Jalankan perintah ini untuk izin menjalankan Notesnook sebagai executable:

```bash
sudo chmod +x notesnook_linux_x86_64.AppImage
```

## Membuat desktop entry untuk Notesnook

Hal pertama yang perlu Anda lakukan adalah mencari tahu absolute path dari AppImage Notesnook.

Caranya adalah dengan pergi ke folder "My-Notes/bin", kemudian jalankan:

```bash
pwd
```

Nanti Anda akan mendapat output semacam ini:

```bash
/home/namauseranda/Documents/Project/My-Notes/bin
```

Tambah teks di atas dengan "/notesnook\_linux\_x86\_64.AppImage", hasil akhirnya adalah:

```bash
/home/namauseranda/Documents/Project/My-Notes/bin/notesnook_linux_x86_64.AppImage
```

Selanjutnya, di folder "My-Notes", buat file bernama "notesnook.desktop" yang isinya:

```ini
[Desktop Entry]
Version=1.0
Name=Notesnook
Comment=Launcher untuk Notesnook
Exec=/home/namauseranda/Documents/Project/My-Notes/bin/notesnook_linux_x86_64.AppImage --no-sandbox --user-data-dir=/home/namauseranda/Documents/Project/My-Notes/data
Icon=/home/namauseranda/Documents/Project/My-Notes/logo.svg
Terminal=false
Type=Application
```

## Mengaktifkan Menu "Create Link" pada Nautilus (jika belum)

Agar Anda tidak perlu mengcopy file .desktop tadi ke folder di mana desktop shortcut berada, Anda perlu membuat link.

Pertama buka preferences dari Nautilus:

<p align="center">
    <img src="../media/Screenshot-from-2025-08-01-06-39-10.png?raw=true" alt="tampilan"/>
</p>

Kemudian toggle Create Link:

<p align="center">
    <img src="../media/Screenshot-from-2025-08-01-06-38-18.png?raw=true" alt="tampilan"/>
</p>

## Membuat Link untuk file notesnook.desktop

Selanjutnya, klik kanan pada "notesnook.desktop" dan pilih "Create Link".

Nanti akan muncul file "Link to notesnook.desktop".

Copy file tadi ke "/home/namauseranda/.local/share/applications".

Rename  "Link to notesnook.desktop" menjadi "notesnook.desktop".

Reboot Komputer Anda, kemudian cek di "Show Apps" Ubuntu.

Kalau tidak ada yang salah maka icon aplikasi Notesnook portable Anda akan muncul.

## Penutup

Dari langkah tadi, jika benar hasilnya, maka seharusnya Anda dapat melakukan pin ke panel.

Jika masih belum bisa, coba cek kembali path dari aplikasi yang telah dimasukkan.

Juga, cek bahwa "namauseranda" sudah disesuaikan dengan nama user yang Anda gunakan di komputer Anda.