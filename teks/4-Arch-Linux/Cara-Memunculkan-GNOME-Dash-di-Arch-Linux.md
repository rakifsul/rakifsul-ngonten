# Cara Memunculkan GNOME Dash di Arch Linux

Jika kita menggunakan fitur archinstall dari Arch Linux, maka jika kita juga memilih GNOME untuk desktop-nya, maka Dash akan tersembunyi secara default, kecuali kita mengklik tombol kiri atas layar.

Seandainya saya ingin untuk membuat Dash muncul terus menerus di bawah layar, maka saya memerlukan extension GNOME bernama Dash to Dock.

Extension tersebut hanya bisa diinstall jika kita sudah menginstall 2 package ini:

- gnome-shell-extensions
- gnome-browser-connector

Package pertama digunakan untuk memanajemen GNOME extensions.

Package kedua akan menghubungkan Browser default dari archinstall ke GNOME extensions repository yang ada di:

https://extensions.gnome.org

Setelah kedua package tadi terinstall, Anda hanya perlu jelajahi website tadi dan klik "Install" pada extension yang Anda pilih.

Untuk menginstall kedua package tadi:

```
sudo pacman -S gnome-shell-extensions

sudo pacman -S gnome-browser-connector
```

Selanjutnya buka:

https://extensions.gnome.org/extension/307/dash-to-dock/

Kemudian klik tombol "Install" di browser Anda.

Popup akan muncul dan izinkan penginstallan.

Hasilnya seperti ini:

<p align="center">
    <img src="../../media/gnome-dash-to-dock.png?raw=true" alt="tampilan"/>
</p>

Selamat mencoba!
