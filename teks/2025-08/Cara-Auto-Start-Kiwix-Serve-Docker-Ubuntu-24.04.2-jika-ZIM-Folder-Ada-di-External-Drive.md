# Cara Auto Start Kiwix Serve Docker Ubuntu 24.04.2 jika ZIM Folder Ada di External Drive

**Disclaimer: Hanya Teruji di Ubuntu 24.04.2 Desktop.**

Dulu, saya pernah bahas cara install Kiwix-Serve dengan Docker Run [di artikel ini](../2025-06/Aplikasi-Wikipedia-Offline-dan-zim-Viewer.md).

Contoh yang saya berikan di artikel tersebut ternyata hanya bisa diandalkan jika folder yang berisi ZIM file berada di storage internal. Misalnya SSD internal Anda.

Namun, dalam kasus tertentu, yang ternyata saya alami, saya menyimpan file ZIM tersebut di dalam sebuah flashdisk yang dihubungkan via USB.

Saya melakukan itu karena di Ubuntu 24.04.2, flashdisk tersebut otomatis di-mount setiap kali booting.

Selain itu, saya juga melakukannya agar saya bisa menghemat space untuk storage internal saya yang saya prioritaskan untuk development.

Mungkin, saya bisa saja mengganti path dari volume docker ke folder yang ada di flashdisk tersebut, tapi, bagaimana jika saat Kiwix-Serve berjalan flashdisk tersebut belum ter-mount?

Bagaimana solusinya? Terus baca..

## Menerapkan Restart Policy pada Docker Kiwix Serve ke None dan Menyesuaikan Target Folder ZIM

Hal yang perlu kita lakukan pertama kali adalah menerapkan restart policy ke none pada docker container dari Kiwix Serve

```yaml
# jika pakai docker run
--restart=none

# jika pakai docker compose
restart: none
```

Hal itu dilakukan agar docker container Kiwix Serve tidak me-restart sendiri. Ingat bahwa kita ingin Kiwix Serve berjalan jika dan hanya jika FlashDisk sudah ter-mount.

Untuk target folder ZIM nya, sesuaikan:

```apacheconf
# jika pakai docker run
-v '/media/namauseranda/labelflashdiskanda':/data

# jika pakai docker compose
volumes:
  - /media/namauseranda/labelflashdiskanda:/data
```

Itu jika Anda menyimpan file ZIM di root dari flash disk Anda.

Jika Anda memasukkannya ke subfolder, sesuaikan path-nya.

## Membuat Script untuk Memastikan Bahwa Kiwix Serve Hanya Berjalan Jika FlashDisk sudah Ter-Mount

Untuk melakukan ini, gunakan script di bawah ini dan simpan dengan nama "check-fdd.sh".

```apacheconf
#!/bin/bash

# Tunggu sampai /media/$USER/FDD-Blue termount
# Ganti FDD-Blue dengan Label FlashDisk Anda
# Label jangan pakai spasi
while [ ! -d "/media/$USER/FDD-Blue" ]; do
    sleep 1
done

sleep 3

# Lanjutkan script
echo "USB FlashDisk sudah termount"

# container-kiwix-serve adalah nama container saya
# jika beda, tulis nama container kiwix serve versi Anda
docker start container-kiwix-serve
```

Baca komentarnya baik-baik. Saya tidak menjelaskan ulang script tadi.

Beri izin untuk execute script tadi:

```bash
sudo chmod +x check-fdd.sh
```

Sesuaikan path pada command di atas dengan versi Anda.

## Membuat Startup Applications Entry

Aplikasi "Startup Applications" ini setahu saya ada di Ubuntu 24.04.2 yang saya gunakan secara default. **Saya tidak tahu bagaimana dengan distro lain atau versi lain**.

Nah, karena asumsi saya, dan juga sesuai dengan judul artikel ini, kita menggunakan Ubuntu 24.04.2, maka bukalah aplikasi tersebut dari menu aplikasi di Ubuntu.

Begini tampilannya:

<p align="center">
    <img src="../../media/Screenshot-from-2025-08-07-02-01-38.png?raw=true" alt="tampilan"/>
</p>

Klik Add, kemudian beri input dari Command berupa path dari "check-fdd.sh" tadi.

Sisanya, isi Name dengan nama yang mudah dipahami agar Anda tidak lupa. deskripsi juga boleh diisi.

Setelah "check-fdd.sh" dimasukkan ke entry, maka sisanya tinggal pengujian.

## Menguji Bahwa Kiwix-Serve Berjalan dengan Benar

Sekarang, reboot Ubuntu Anda, kemudian jangan langsung buka URL Kiwix Serve, karena aplikasi tersebut, walaupun tergantung isi ZIM file-nya, biasanya agak lama untuk dijalankan.

Hal itu wajar, karena file ZIM dari wikipedia versi full berukuran sekitar 100 GB.

Setelah dirasa agak lama, bukalah URL Kiwix Serve Anda, dan pastikan semua file ZIM Anda termuat.

Jika Anda mendapati halaman error, kemungkinannya:

-   File ZIM ada yang corrupt
-   FlashDisk belum ter-mount
-   Ada kesalahan penulisan script "check-fdd.sh"

Jika masalahnya FlashDisk belum ter-mount, biasanya yang terjadi adalah, aplikasi Kiwix Serve membuat folder kosong bernama "Label-FlashDisk-Anda" karena berasumsi di sana ada folder mount FlashDisk Anda.

Sementara itu, sistem me-mount-kan FlashDisk sebenarnya ke folder lain.

Dalam kondisi seperti tadi, maka hapuslah folder /media/$USER/Label-FlashDisk-Anda. **HATI-HATI, Jangan sampai Anda menghapus isi FlashDisk Anda yang sebenarnya. Pastikan folder tersebut benar-benar kosong.**

Selanjutnya, perbaiki masalah yang menyebabkannya yang kemungkinan adalah kesalahan penulisan script (entah keliru nama labelnya atau faktor lain).

## TIPS:

Cara untuk memastikan bahwa sebenarnya Kiwix Serve Anda bisa membuka FlashDisk Anda adalah dengan me-remove startup script tadi dan menjalankan container Kiwix Serve Anda secara manual dari terminal atau Portainer.

Yang jelas, nama folder target dari Kiwix Serve harus sama dengan folder mount FlashDisk Anda yang sebenarnya. Jika Anda ragu apakah sistem me-mount-kan FlashDisk Anda ke tempat yang seharusnya, buka saja folder /media/$USER dan lihat isinya.