# Cara Pilih Workspace GNOME Otomatis Setelah Login di Arch Linux

Setelah penginstallan Arch Linux GNOME selesai, user bisa melakukan reboot.

Saat masuk ke layar login, user hanya perlu memasukkan password dan klik enter.

Setelah login, biasanya user dihadapkan dengan pilihan beberapa workspace yang baru bisa dimasuki setelah diklik.

Jika Anda belum tahu apa itu workspace dalam istilah GNOME, workspace adalah apa yang muncul seperti layar lengkap dengan wallpapernya.

Biasanya dalam keadaan default, workspace GNOME harus dipilih dulu sebelum kita bisa melakukan hal yang lebih lanjut di Arch Linux GNOME.

Menurut saya, akan lebih ringkas jika pemilihan  workspace tersebut otomatis.

Untuk itu, kita harus menginstall GNOME extension bernama "No overview at startup" terlebih dahulu.

Setelah extension tersebut diinstall, kemudian reboot, maka setelah login screen dilalui, pemilihan workspace terjadi secara otomatis.

Cara menginstall extension tersebut adalah dengan mengunjungi extension repository GNOME di URL ini:

https://extensions.gnome.org

Kemudian cari dan install "No overview at startup".

Namun, [ikuti langkah ini](./Cara-Memunculkan-GNOME-Dash-di-Arch-Linux.md) sebelumnya untuk menginstall package-package di bawah ini:

- gnome-shell-extensions
- gnome-browser-connector

Kedua package tadi merupakan requirement sebelum Anda bisa menginstall GNOME extension.