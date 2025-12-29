# Cara Memantau Output Banyak Aplikasi Terminal dengan Lebih Nyaman

Beberapa aplikasi CLI yang ada di Linux terus menampilkan output setelah dijalankan melalui terminal.

Menekan ctrl+c biasanya akan menghentikan aplikasi semacam itu.

Padahal, boleh jadi kita juga ingin menjalankan aplikasi CLI yang lain bersama dengan aplikasi tersebut.

Benar bahwa terminal ubuntu memiliki fitur new tab, tapi di context menu Nautilus, membuka sesi terminal baru tidak akan muncul sebagai tab baru, tapi sebagai jendela baru.

Apalagi, melakukan switching antara jendela aplikasi yang sama bagi saya tidak terlalu nyaman.

Benar juga bahwa aplikasi CLI bisa menyembunyikan outputnya dan jalan di background dengan menambahkan '&' di akhir perintah dan memungkinkan aplikasi lain dijalankan setelah itu.

Tapi, bagaimana jika kita tidak ingin menggunakan '&' karena belum tahu atau belum terbiasa menggunakan perintah untuk menghentikan jalannya aplikasi CLI yang berjalan di background tadi?

Atau, bagaimana jika kita memang tetap ingin melihat output aplikasi CLI tadi di terminal?

Saya punya solusinya.

**Caranya adalah dengan menggunakan aplikasi terminal lain yang berbeda dengan terminal bawaan distro.**

Tapi tidak hanya itu, terminal tersebut juga harus memiliki **fitur tab atau session** dalam satu jendela, agar kita lebih mudah memantau output banyak aplikasi dalam satu jendela terminal tambahan tersebut.

Sebagai contoh, saat saya menggunakan Ubuntu, maka saya akan menggunakan aplikasi terminal bernama Tilix.

```
sudo apt install tilix
```

Setelah saya install Tilix, saya juga akan mem-pin Tilix ke dash.

Maka, saat saya menjalankan Stable Diffusion, misalnya, saya buka dengan Tilix.

Output Stable Diffusion akan terus muncul di Tilix, tapi terminal bawaan Ubuntu tetap bekerja dengan nyaman.

Dengan menggunakan cara tadi, saya mendapatkan kenyamanan yang lebih saat bekerja dengan aplikasi CLI yang memang harus dipantau output-nya.

Jika saya ingin menghentikan aplikasi CLI tersebut, saya hanya perlu tekan ctrl+c di Tilix.

Jika saya ingin menjalankannya lagi, saya tinggal ketikkan perintahnya lagi di Tilix.
