# Menginstall Ollama dan Open WebUI di Ubuntu 24.04 tanpa Docker

Dalam keadaan sangat mengantuk, saya mencoba untuk menginstall Ollama dan WebUI-nya.

Memang saat ini saya telah menginstall llama.cpp dan mencoba menjalankan beberapa model LLM dengan aplikasi llama-cli dan llama-server.

Namun, karena saya duga penggunaan API yang rencananya akan diterapkan pada bot Misskey ini lebih mudah di-setup dengan Ollama dan WebUI, maka akhirnya saya putuskan untuk menginstallnya.

Kali ini tanpa Docker.

Sengaja saya lakukan itu karena saya tidak ingin repot masuk ke dalam container untuk menjalankan Ollama dalam keperluan testing.

Langkah pertama yang saya lakukan adalah menginstall Ollama dulu, baru kemudian dilanjutkan dengan menginstall Python 3.11, kemudian Open WebUI.

## Menginstall Ollama

Penginstallan Ollama mudah dilakukan meski tanpa Docker sekalipun.

Perintahnya adalah:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Selanjutnya saya tinggal menunggu prosesnya selesai.

Setelah selesai, saya langsung coba model gemma3:1b:

```apacheconf
ollama run gemma3:1b
```

Karena model tersebut cukup ringan untuk Mini PC saya.

## Menginstall Python dengan Version Manager-nya yang Bernama pyenv

Version manager Python yang bernama pyenv ini sengaja saya gunakan hanya untuk berjaga-jaga barangkali saya akan memerlukan coding Python dari versi yang berbeda dengan 3.11.

Caranya:

```bash
curl -fsSL https://pyenv.run | bash
```

Selanjutnya, saya copy script bash yang tampil di akhir penginstallan ke .bashrc dan .profile.

Itu saja belum cukup, karena saya masih harus menginstall build dependencies saat saya akan menginstall Python-nya dengan pyenv:

```bash
sudo apt update

sudo apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

Setelah itu, baru saya bisa menginstall Python 3.11:

```bash
pyenv install 3.11
```

Dan menerapkannya secara global:

```bash
pyenv global 3.11.13
```

Di perintah barusan tertulis 3.11.13 karena saat menginstall 3.11, saya mendapatkan versi 3.11.13. Mungkin Anda akan mendapatkan versi lainnya.

## Menginstall Open WebUI

Penginstallan Open WebUI saat ini cukup sederhana:

```bash
pip install open-webui
```

Yang setelah selesai saya pastikan dengan menjalankannya:

```bash
open-webui serve --host 127.0.0.1 --port 8080
```

Setelah output di terminal terlihat selesai saya buka browser saya ke http://127.0.0.1:8080 dan registrasi saya lakukan.

Untungnya, saya tidak harus memasukkan password yang kompleks karena saya juga malas melakukannya.

Dan inilah hasilnya:

<p align="center">
    <img src="../media/Screenshot-from-2025-07-09-02-51-13.png?raw=true" alt="tampilan"/>
</p>

## Bonus! Membuat Systemd --user agar Open WebUI Jalan Otomatis

Saya ingin agar Open WebUI berjalan otomatis saat saya telah login ke Ubuntu.

Maka, saya memulainya dengan membuat script "run-open-webui.sh":

```bash
#!/bin/bash

/home/namauser/.pyenv/versions/3.11.13/bin/open-webui serve --host 127.0.0.1 --port 8080
```

Versi Python di script tadi tergantung apa yang kita dapatkan saat menginstall Python tadi.

Langkah selanjutnya, saya akan memberi permission pada "run-open-webui.sh" untuk bisa di-execute.

```bash
sudo chmod +x run-open-webui.sh
```

Kemudian memindahkannya ke folder "/usr/bin":

```bash
sudo mv ./run-open-webui.sh /usr/bin
```

Selanjutnya, saya akan membuat script systemd di level user dengan cara:

```bash
nano ~/.config/systemd/user/owebui.service
```

Kemudian mengisinya dengan:

```ini
[Unit]
Description=Start open web ui at login
After=graphical-session.target

[Service]
ExecStart=/usr/bin/run-open-webui.sh
Restart=always

[Install]
WantedBy=default.target
```

Kemudian menyelesaikannya dengan:

```bash
loginctl enable-linger $USER

sudo loginctl enable-linger $USER

systemctl --user daemon-reexec

systemctl --user daemon-reload

systemctl --user enable owebui.service

systemctl --user start owebui.service
```

Jika Anda ingin tahu apa itu loginctl enable-linger $USER, itu maksudnya owebui.service bisa jalan walaupun $USER tidak login.

Kita perlu itu karena systemctl menggunakan argument --user.

## Kesimpulan

Menurut saya, Ollama dan Open WebUI saat ini mudah untuk diinstall.

Namun, yang lebih menjadi pertimbangan saya dalam menggunakannya bukan hanya karena itu, tapi juga karena alasan lain seperti dugaan saya tentang kemudahan setup untuk API-nya.