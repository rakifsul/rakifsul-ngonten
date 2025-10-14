# Beberapa Kebiasaan Saya saat Baru Menyewa VPS

Walaupun sedikit lebih _ribet_ dibandingkan shared hosting yang telah terinstall cpanel, VPS memberikan kita kebebasan dalam melakukan konfigurasi dan penginstallan softwarenya.

Jika di shared hosting dengan cpanel kita bisa langsung menggunakan web ui untuk melakukan manajemen pada servernya, di VPS linux yang bukan managed mau tidak mau admin harus menguasai skill command line interface (CLI).

Jika Anda baru pertama kali menggunakan VPS, Anda tidak harus menguasai semua perintah CLI. Cukup yang penting-penting dan sering-sering digunakan saja.

Bahkan, saya hanya tahu ls dan cd saja waktu pertama kali menggunakannya. Sisanya saya googling dan copy paste. Setelah AI semakin populer dan umum digunakan, seharusnya hal itu lebih mudah.

Selain itu, saya juga memiliki beberapa kebiasaan saat baru menyewa VPS yang sebenarnya saya pelajari [dari blog digitalocean](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu) (VPS pertama saya telah saya sewa di situ).

Menurut saya kebiasaan itu cukup masuk akal dan saya menambahkan beberapa poin tambahan untuk melengkapinya.

Ingin tahu bagaimana? Lanjut...

## Login sebagai Default Root

Biasanya, saat baru menyewa VPS, penyewa akan diberi halaman dashboard berbasis web untuk menyalakan, mematikan, merestart dan memanage VPS. Di situ biasanya tercantum ip dan root password VPS penyewa.

Gunakan ip dan password tadi untuk login ke VPS:

```bash
ssh root@ip-vps
```

## Menambah sudo User

Menggunakan root untuk memanajemen VPS sehari-hari tidak seharusnya dilakukan, karena jika akun root VPS Anda dibobol, maka pembobol VPS Anda akan mendapatkan akses penuh terhadap VPS Anda.

Maka, kita harus membuat user untuk administrasi yang harus memasukan credentials setiap melakukan perintah root.

```bash
adduser namauseranda
```

Sesuaikan "namauseranda" dengan nama pilihan Anda.

Selanjutnya, daftarkan "namauseranda" ke dalam grup sudo:

```bash
usermod -aG sudo namauseranda
```

## Menginstall UFW untuk Manajemen Firewall

Firewall dapat memblokir akses ke port VPS Anda sehingga akan menambah perlindungan terhadap VPS Anda. Untuk menginstallnya:

```bash
apt install ufw
```

Secara default, saat UFW diaktifkan, maka semua port akan terblokir, jika saat itu Anda menggunakan ssh dan ssh belum diberi izin, maka koneksi ssh Anda akan terputus dan Anda tidak bisa melanjutkan manajemen VPS Anda via ssh.

Oleh karena itu, mari kita izinkan ssh.

Untuk melihat daftar aplikasi yang bisa diterapkan dengan UFW:

```bash
ufw app list
```

Pastikan di daftar tadi ada OpenSSH.

Selanjutnya, kita izinkan ssh:

```bash
ufw allow OpenSSH
```

Karena sekarang UFW masih inaktif:

```bash
ufw status
```

Maka mari kita aktifkan:

```bash
ufw enable
```

Sekarang cek lagi statusnya:

```bash
ufw status
```

Selanjutnya, kita akan melakukan manajemen dengan "namauseranda" yang sudah bisa melakukan sudo. Oleh karena itu, mari kita logout:

```bash
logout
```

## SSH Sebagai namauseranda

Sekarang, kembali login ke SSH dengan namauseranda:

```bash
ssh namauseranda@ip-vps
```

Kemudian cek bahwa namauseranda sudah berada dalam group sudo:

```bash
groups
```

Jika ada group "sudo" di daftarnya, berarti kita siap.

## Mengganti Mirror Repository APT

Jika kita menyewa VPS di penyedia tertentu dan menginstall Ubuntu Server di dalamnya, terkadang mirror dari apt yang digunakan berada di server yang jauh.

Saya pernah mendapatkan mirror bawaan di Eropa dan speed-nya sangat rendah.

Jika keadaannya seperti itu, kita perlu mengganti mirrornya ke lokasi yang dekat.

Namun, kita harus mengeceknya dulu:

```bash
sudo apt update
```

Jika daftar domain mirror apt yang muncul di outputnya semacam "de.archive.ubuntu.com" atau yang lain, yang kira-kira jauh, itu artinya kita perlu menggantinya.

Untuk menggantinya, backup daftar mirror defaultnya terlebih dahulu:

```bash
sudo cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.backup
```

Kemudian ubah prefix domain dari "de.\*" ke "id.\*":

```bash
sudo nano /etc/apt/sources.list.d/ubuntu.sources
```

Lakukan secara manual saja.

**Catatan: Jika Anda melakukan kesalahan di sini dan Anda tidak tahu apa yang akan anda lakukan, gunakan backup tadi, yang ada di "/etc/apt/sources.list.d/ubuntu.sources.backup".**

Selanjutnya, update repository:

```bash
sudo apt update
```

Jika Anda ingin upgrade package sekalian, gunakan perintah ini:

```bash
sudo apt upgrade
```

## Menginstall Docker

Dulu, waktu saya menggunakan Windows, saya pernah memiliki prasangka buruk terhadap aplikasi ini.

Itu karena, di Windows, Docker hanya bisa berjalan dengan virtualisasi yang umumnya menggunakan RAM cukup besar.

Saya bertanya-tanya, untuk apa pula menggunakan sistem yang boros memori seperti itu?

Setelah saya pindah ke linux dan menginstall Docker, saya baru menyadari bahwa kenyataannya tidak seburuk itu di linux.

Bahkan saya telah menginstall Docker di VPS low end saya dan penggunaan memorinya tidak terlalu besar.

<p align="center">
    <img src="../media/Screenshot-from-2025-07-26-06-10-54.png?raw=true" alt="tampilan"/>
</p>

Untuk menginstallnya, jalankan perintah ini:

```bash
sudo apt update

sudo apt install curl
```

Kemudian ini:

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

Kemudian ini:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

Kemudian ini:

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Kemudian ini:

```bash
sudo apt update
```

```bash
apt-cache policy docker-ce
```

Di sini mungkin Anda akan melihat bahwa repository docker telah ditambahkan ke apt list.

Selanjutnya:

```bash
sudo apt install docker-ce
```

Pastikan docker daemon berjalan:

```bash
sudo systemctl status docker
```

Di titik ini, Anda sudah bisa menggunakan perintah docker, tapi harus pakai sudo.

Untuk menjalankannya tanpa sudo, masukkan namauseranda ke grup docker:

```bash
sudo usermod -aG docker ${USER}
```

${USER} adalah nama user saat ini, yakni namauseranda.

Selanjutnya:

```bash
su - ${USER}
```

Cek group:

```bash
groups
```

Mulai saat ini, Anda dapat menjalankan perintah docker tanpa sudo.

## Menginstall Portainer dengan Docker

Docker adalah aplikasi CLI secara default.

Jadi, sebenarnya Anda siap menggunakannya sekarang jika Anda merasa nyaman dengan CLI.

Jika Anda ingin web ui untuk docker, Anda bisa menggunakan aplikasi bernama Portainer yang juga berjalan dengan docker.

Untuk menginstallnya, buat volume untuk portainer dulu:

```bash
docker volume create portainer_data
```

Kemudian:

```bash
docker run -d -it -p 9000:9000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```

Sekarang Anda bisa mengaksesnya dengan browser Anda di http://ip-vps:9000

Buat akunnya terlebih dahulu dan gunakan untuk login ke dalamnya.

Berikut ini ilustrasi Portainer:

<p align="center">
    <img src="../media/Screenshot-from-2025-07-26-06-22-58.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../media/Screenshot-from-2025-07-26-06-23-14.png?raw=true" alt="tampilan"/>
</p>

## Penutup

Begitulah kebiasaan saya saat baru menyewa VPS.

Apakah itu merupakan kebiasan baik, buruk, atau di antaranya, silakan Anda nilai sendiri.

Mungkin, seiring Anda terbiasa menggunakan VPS, Anda akan melengkapi poin-poin yang telah saya lakukan sebelumnya dan menyempurnakannya.