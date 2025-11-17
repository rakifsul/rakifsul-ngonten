# Cara Skip Update NVidia saat Upgrade Ubuntu

Setelah beberapa lama saya menggunakan Ubuntu Server di PC AI saya, terkadang update yang dilakukan dengan perintah sudo apt update dan sudo apt upgrade menimbulkan masalah pada driver NVidia.

Saya kurang tahu persis apa sebabnya. Mungkin karena driver yang terupdate tidak kompatibel dengan hardware saya.

Maka, daripada saya troubleshoot error driver tersebut terus menerus, saya memutuskan untuk tidak mengupdate package terkait dengan NVidia di setiap kali saya menjalankan upgrade di Ubuntu Server saya.

Untuk melakukan itu, saya melakukan ini di setiap upgrade Ubuntu Server saya (versi 24.04):

```
# cek kondisi awal driver nvidia
nvidia-smi

# cek apa yang sudah di-hold dari nvidia
apt-mark showhold | grep nvidia

# hold semua update terkait nvidia
sudo apt-mark hold $(dpkg -l | awk '/nvidia/ {print $2}')

# verifikasi lagi
apt-mark showhold | grep nvidia

# update
sudo apt update

# upgrade
sudo apt upgrade

# shutdown
sudo shutdown now

# kemudian nyalakan lagi

# cek lagi kondisi driver nvidia setelah upgrade
nvidia-smi

# jika nvidia-smi tampak normal, selanjutnya bisa anda gunakan seperti biasa atau di-shutdown
```

Jalankan perintah tadi satu per satu.
