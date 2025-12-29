# Memanfaatkan SSD Bekas untuk Backup Sistem

Sebagai penghobi homelab, saya selalu tertarik mengutak-atik sistem, mencoba distro baru, dan melakukan eksperimen aneh yang kadang berujung sukses… kadang juga bikin sistem nggak mau boot. 

Di sinilah Timeshift jadi penyelamat. Cukup jalankan aplikasinya, klik restore, dan semuanya balik normal. 

Masalahnya, semakin sering saya bereksperimen, snapshot Timeshift makin menumpuk dan SSD internal mulai teriak minta ruang. 

Akhirnya saya memutuskan untuk memindahkan seluruh backup Timeshift ke SSD eksternal. Lebih lega, lebih aman, dan pastinya lebih fleksibel kalau mau dipindah-pindah ke perangkat lain. 

Prosesnya ternyata tidak sesulit yang dibayangkan, tapi tetap ada beberapa langkah penting agar semua snapshot tetap utuh dan Timeshift mengenali lokasi baru tanpa drama.

## Menyiapkan Perangkat Keras

Untuk keperluan tadi, Anda hanya perlu ini:

- SSD SATA Bekas. Saya gunakan yang ukuran 225GB.
- SSD enclosure. Saran saya beli yang bagus. Saya pakai merk Orico.
- Kabel USB penghubung enclosure ke komputer. Biasanya sudah disertakan dalam paket.

Setelah siap, colok USB SSD enclosure ke komputer.

## Menginstall Timeshift

Di sini Anda punya 2 pilihan. Apakah akan diinstall di OS yang dibackup atau di Live USB.

Pilihan pertama bisa dilakukan jika saat sistem di-restore, Anda masih bisa mengakses dan boot ke OS.

Pilihan kedua adalah alternatif terakhir jika OS yang akan di-restore tidak bisa dimasuki.

Untuk menginstall-nya, dengan asumsi bahwa Anda menggunakan Ubuntu 24.04, adalah dengan menjalankan perintah ini:

```
sudo apt update
sudo apt install timeshift
```

Selanjutnya, buka aplikasi tersebut dari tombol "Show Apps" di dash (Dash adalah semacam panel di bagian kiri layar Ubuntu. Anda harus masukkan password Ubuntu saat menjalankan Timeshift).

Selanjutnya, buka setting Timeshift dan pastikan Anda pilih metode RSYNC.

Kemudian, tentukan di mana Anda menyimpan backup.

Tentunya, lokasi backup tersebut adalah di SSD yang telah Anda colok barusan.

Jika Anda tidak yakin yang mana, cek brand dan kapasitas dari SSD external tadi.

Jika Anda belum membackup apapun, maka daftar dari backup akan kosong.

Anda hanya perlu klik tombol create saja untuk melakukan backup pertama (jika perlu). 

**PENTING: Agar Anda tidak lupa password user anda saat me-restore, beri petunjuk di komentar dari backup-nya saat Anda melakukan backup.**

## Memindahkan Lokasi Backup Timeshift

Saya sering mengalami kejadian di mana saya terlanjur menentukan lokasi backup Timeshift di OS target.

Kemudian, saya berubah pikiran setelah melakukan beberapa kali backup.

Dengan demikian pada directory /timeshift/snapshots ada beberapa folder backup OS yang namanya berupa tanggal/waktu.

Untuk melakukan perpindahan backup, saya colok SSD external saya yang sudah diformat dengan ext4, kemudian mengubah lokasinya dengan setting "Location".

Di bagian tersebut hanya ada daftar storage. Pastikan storage yang dipilih benar, yakni yang SSD external, Bisa diverifikasi dari kapasitas dan brand-nya.

Selanjutnya, sebaiknya backup pertama di SSD tersebut dilakukan.

Setelah terbackup, backup sebelumnya yang ada di /timeshift/snapshots dipindahkan ke SSD external.

Caranya dengan menjalankan perintah ini:

```
# sesuaikan /mnt/external/timeshift/snapshots dengan path yang ada di SSD external Anda.
# di saya, contohnya, ada di /media/username/SSD-SATA/timeshift/snapshots
# di komputer Anda mungkin beda

sudo rsync -aAXv /timeshift/snapshots/ /mnt/external/timeshift/snapshots/
```

Proses ini akan lama jika backup sebelumnya cukup banyak. Tunggulah hingga selesai.

## Melakukan Restore

Saat Anda ingin mengembalikan backup Anda, buka aplikasi Timeshift, masukkan password Anda, kemudian pilih backup di tanggal yang mana, kemudian klik "Restore".

Selanjutnya, ikuti sesuai instruksi dari Timeshift.

Mungkin, jika Anda login pertama kali saat restore selesai, Anda perlu mengetahui password user Anda di waktu backup. Inilah gunanya memberi petunjuk password di bagian komentar dari Timeshift.

## Penutup

Jadi, begitulah cara menggunakan SSD bekas untuk menyimpan backup.

Saya harap teknik ini berguna.