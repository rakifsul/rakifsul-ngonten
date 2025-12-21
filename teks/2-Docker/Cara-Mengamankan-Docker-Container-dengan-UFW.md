# Cara Mengamankan Docker Container dengan ufw

Jika Anda telah mengenal Ubuntu, mungkin Anda tahu bahwa ufw bisa digunakan untuk membatasi atau mengizinkan akses ke ip atau port tertentu.

Tadinya, saya mengira bahwa dengan konfigurasi ufw saja, maka port di container docker saya akan ter-manage.

Tapi, baru hari ini saya sadar bahwa port container docker saya yang tidak didaftarkan ufw bisa diakses dari luar ip lokal komputer saya. Padahal, secara default ufw saya dikonfigurasi untuk deny incoming.

Akhirnya, saya memutuskan untuk mengubah konfigurasi dari docker itu sendiri.

Caranya cukup mudah, tapi, sebelum itu semua dilakukan harap pastikan ufw mengizinkan port ssh Anda.

```
sudo ufw status verbose
```

Selanjutnya, jalankan perintah ini:

```
# Pastikan SSH diizinkan
sudo ufw allow 22/tcp

# Simpan konfigurasi Docker baru
sudo nano /etc/docker/daemon.json

# isi dengan ini:
{
  "iptables": false
}

# Reload ufw dulu (pastikan active)
sudo ufw reload

# Restart Docker dengan aman
sudo systemctl restart docker
```
