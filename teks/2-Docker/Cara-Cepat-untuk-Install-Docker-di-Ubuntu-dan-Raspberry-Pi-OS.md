# Cara Cepat untuk Install Docker di Ubuntu dan Raspberry Pi OS

OK, sesuai judul, saya tidak akan banyak basa-basi di artikel ini.

Intinya, saya pernah membahas cara install Docker di Ubuntu, tapi itu menurut saya terlalu panjang lebar jika kita hanya perlu Docker saja.

Lagipula, saya belum membahasnya untuk Raspberry Pi OS.

Perlu dicatat bahwa sejujurnya saya tidak memahami seluruh command yang ada di artikel ini, tapi setidaknya ini bekerja di komputer saya.

## Cara Install Docker di Ubuntu

Ini bisa untuk Ubuntu Desktop dan Ubuntu Server 24.04 di komputer saya.

Jalankan command ini baris per baris:

```
# step 1
sudo apt update

# step 2
sudo apt install apt-transport-https ca-certificates curl software-properties-common

# step 3
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# step 4
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# step 5
sudo apt update

# step 6
apt-cache policy docker-ce

# step 7
sudo apt install docker-ce

# step 8
sudo systemctl status docker

# step 9
sudo usermod -aG docker ${USER}

# step 10
su - ${USER}

# step 11
groups

# step 12
sudo reboot now
```

## Cara Install Docker di Raspberry Pi OS

Ini bisa untuk Raspberry Pi OS di komputer saya.

Jalankan command ini baris per baris:

```
# step 1
sudo apt-get update

# step 2
sudo apt-get install ca-certificates curl

# step 3
sudo install -m 0755 -d /etc/apt/keyrings

# step 4
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

# step 5
sudo chmod a+r /etc/apt/keyrings/docker.asc

# step 6
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# step 7
sudo apt-get update

# step 8
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Penutup

Itulah command untuk install Docker yang pernah bekerja di komputer saya.

Barangkali di komputer Anda juga bisa, tapi saya tidak menjamin hal tersebut.

Coba saja...
