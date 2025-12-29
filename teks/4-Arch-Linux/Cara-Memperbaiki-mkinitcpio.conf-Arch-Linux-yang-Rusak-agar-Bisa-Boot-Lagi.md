# Cara Memperbaiki mkinitcpio.conf Arch Linux yang Rusak agar Bisa Boot Lagi

Ada kejadian yang sedikit merepotkan di Arch Linux sebelum saya menulis artikel ini.

Saat saya hendak meng-update sistem dengan perintah ini:

```
sudo pacman -Syu 
```

Saya mendapati pesan error yang maknanya bahwa file "/etc/mkinitcpio.conf" dan initramfs linux-lts tidak ditemukan.

Saya lupa detail tulisannya, tapi kira-kira begitu.

Akhirnya saya reboot Arch Linux, dan saya mendapati Arch Linux tidak bisa boot.

Setelah mencari solusi, saya mendapati bahwa satu-satunya cara adalah dengan menggunakan file iso dari Arch Linux yang saya gunakan untuk menginstall sebelumnya.

Itu karena saya hanya memiliki satu linux kernel di sistem saya, yakni linux-lts.

Selanjutnya, saya perbaiki dengan cara ini. Terus baca...

## Boot dari File ISO Arch Linux

Saya mengganti boot order dari komputer saya ke file ISO Arch Linux, karena saya menggunakan virtual machine.

Jika Anda mengalami masalah ini tapi dengan komputer fisik, silakan cari cara sendiri agar Anda bisa boot dari file installer Arch Linux Anda yang mungkin ada di external disk Anda.

Selanjutnya, saat kita boot dari ISO tadi, kita pilih pilihan pertama (sama dengan waktu kita mau install Arch Linux).

## Mount Partisi ke /mnt dan /mnt/boot

Selanjutnya, kita perlu melakukan mount dari partisi filesystem dan partisi boot.

Karena filesystem saya ada di /dev/vda2, maka saya lakukan ini:

```
mount /dev/vda2 /mnt
```

Sedangkan boot saya ada di /dev/vda1

```
mount /dev/vda1 /mnt/boot
```

Selanjutnya jalankan ini:

```
arch-chroot /mnt
```

Nanti prompt Anda akan berubah sedikit. Dari situlah kita mulai perbaiki mkinitcpio.conf.

Selanjutnya, pastikan bahwa /etc/mkinitcpio.conf ada:

```
ls /etc/mkinitcpio.conf
```

Dan pastikan itu rusak:

```
nano /etc/mkinitcpio.conf
```

Yang rusak di file saya adalah isinya terpotong sekitar setengah.

Entah apa penyebabnya.

## Perbaikan

Prinsip perbaikan dari file mkinitcpio.conf tadi sebenarnya sederhana.

Cukup ganti dengan file yang valid.

Jika Anda tahu cara menulisnya, silakan tulis versi Anda sendiri.

Jika tidak, mari kita download dari repository Arch Linux di GitHub. Yakni dengan cara ini:

```
cd /etc

wget https://raw.githubusercontent.com/archlinux/mkinitcpio/refs/heads/master/mkinitcpio.conf
```

Nanti file mkinitcpio.conf barusan akan disave sebagai mkinitcpio.conf.1 karena yang rusak belum dihapus.

Sekarang, hapus mkinitcpio.conf yang rusak:

```
rm /etc/mkinitcpio.conf
```

Selanjutnya, rename yang baru kita download tadi:

```
mv /etc/mkinitcpio.conf.1 /etc/mkinitcpio.conf
```

Sampai di sini, kita telah memperbaiki file mkinitcpio.conf.

Selanjutnya adalah mengulang installasi kernel.

## Meninstall Ulang Kernel

Untuk melakukannya, jalankan perintah ini:

```
pacman -S mkinitcpio linux-lts --noconfirm
```

Kemudian:

```
mkinitcpio -P
```

Kemudian regenerate GRUB:

```
grub-mkconfig -o /boot/grub/grub.cfg
```

Selanjutnya keluar dan shutdown:

```
exit

umount -R /mnt

sudo shutdown now
```

## Penutup

Sekarang, seharusnya kita sudah bisa boot lagi tanpa ISO atau Installer Arch Linux dan langsung masuk ke installasi yang normal sebelumnya.

Jadi, jika Anda pakai virtual machine, silakan ganti boot ordernya seperti semula lagi.

Atau jika Anda menggunakan komputer fisik, silakan cabut installer disk Anda dan ganti boot ordernya lagi seperti semula.