# Cerita Waktu Saya Ingin Coding Pakai LLM Lokal dengan VSCode (di Ubuntu 24.04.2)

Setelah saya sadar bahwa alat-alat coding berbasis LLM semakin banyak saya temui, saya jadi tertarik dengan vibe coding.

Walaupun sebenarnya coding dengan cara tadi bisa dilakukan dengan menggunakan layanan di internet, kita juga bisa menggunakan local LLM.

Cara yang baru saya pelajari beberapa jam tadi adalah dengan menggunakan VSCode dan extension VSCode yang bernama [Continue](https://marketplace.visualstudio.com/items?itemName=Continue.continue).

Extension tersebut memungkinkan saya untuk menggunakan Ollama API selain menggunakan OpenAI API.

Saya lebih suka menggunakan Ollama API, karena komputer untuk LLM saya memang sudah saya siapkan sejak saya berhenti gaming. Selain itu, saya juga jadi tidak perlu membayar biaya sewa API.

Komputer tersebut terhubung melalui ethernet di LAN dan telah terinstall Ubuntu Server 24.04.2. Adapun CPU yang digunakan sudah cukup tua (Intel i5 generasi 3, 4 core), namun GPU-nya adalah NVidia RTX 2060 Super. RAM-nya 16 GB dan storage-nya SSD 256 GB.

Komputer tersebut pernah rusak karena (anehnya) ada soket PSU yang rusak, padahal PSU tersebut cukup bagus dan masih baru.

Untungnya, saya menemukan kerusakan tersebut sebelum mengambil langkah yang lebih mahal biayanya. Waktu itu saya hanya memindahkan beberapa kabelnya ke soket lain (PSU saya modular).

Sebenarnya, saya bisa juga menggunakan **komputer kerja** saya, namun, karena **komputer kerja** saya ini tidak menggunakan GPU yang performanya bagus, maka saya pakai komputer gaming saya yang saya sebutkan tadi.

Jadi, komputer gaming saya sekarang berubah menjadi **komputer AI** dan menggunakan Ubuntu Server 24.04.2.

Agar **komputer AI** tadi bisa diakses dari komputer kerja saya, saya menghubungkannya langsung dengan kabel ethernet yang cukup pendek.

Untuk konfigurasinya, saya menggunakan setting ini di **komputer kerja** saya:

-   ip: 192.168.2.1
-   netmask: 255.255.255.0
-   ip v4 method: manual
-   ip v6 method: disabled

Sedangkan, di **komputer AI** saya:

-   ip: 192.168.2.2
-   netmask: 255.255.255.0
-   ip v4 method: manual
-   ip v6 method: disabled

Itu untuk konfigurasi ethernetnya. Adapun untuk WiFi-nya, saya biarkan apa adanya.

Saya memang harus ingat bahwa jika saya menggunakan Ubuntu Server 24.04.2 di **komputer AI** saya, maka saya harus melakukan konfigurasi dengan Netplan yang konfigurasinya diedit melalui file teks via terminal atau ssh. 

Selain itu, karena saya sedikit paranoid, maka saya nonaktifkan WiFi di **komputer AI** saya secara default saat booting. Dengan asumsi bahwa konfigurasi jaringan bagi **komputer kerja** dan **komputer AI** telah beres, caranya adalah dengan masuk ssh ke 192.168.2.2.

Kemudian, untuk mendapatkan info tentang apa nama WiFi interface saya, saya menggunakan perintah ini:

```bash
ip addr
```

Di situ nanti akan muncul daftar ip address. Karena yang ethernet sudah saya ketahui ip-nya, maka biasanya ip untuk WiFi adalah 192.168.x.x yang lainnya.

Kemudian, saya berhasil menebaknya dan saya meng-edit crontab:

```bash
sudo crontab -e
```

Kemudian, saya pilih nano sebagai editornya dan saat editornya terbuka, saya isi dengan:

```bash
@reboot ip link set <wifi-interface-saya> down
```

Dengan cara tadi, setiap **komputer AI** saya dinyalakan, maka **komputer kerja** saya terhubung dengan **komputer AI**, tapi **komputer AI** tidak bisa diakses dari jaringan WiFi dan tidak bisa mengakses **router** maupun **internet**.

Jika saya perlu akses internet untuk **komputer AI** saya, maka saya melakukan perintah ini secara manual:

```bash
sudo ip link set <wifi-interface-saya> up
```

Tentunya, saya harus mengaktifkan WiFi interface saya jika saya ingin melakukan pull terhadap model Ollama. Oleh karena itu, saya aktifkan dengan cara tadi dan melakukan pull terhadap gemma3:4b:

```bash
ollama pull gemma3:4b
```

Jika saya membaca [tutorial cara install Ollama dan Open WebUI ini](../2025-07/Menginstall-Ollama-dan-Open-WebUI-di-Ubuntu-24.04-tanpa-Docker.md), saya cukup mengerti bagaimana kedua aplikasi tersebut diinstall. 

Tentunya, WiFi interface dari komputer AI saya harus diaktifkan terlebih dahulu sebelum menjalankan tutorial tadi.

Saya ingat bahwa server Ollama API di komputer AI saya belum di-binding ke 0.0.0.0 agar bisa diakses dari komputer kerja saya.

Maka saya buka script systemd dari Ollama:

```bash
sudo nano /etc/systemd/system/ollama.service
```

Kemudian saya tambahkan baris ini pada script tadi di bawah baris yang ada keyword Environment lainnya:

```ini
Environment="OLLAMA_HOST=0.0.0.0"
```

Sehingga script tersebut jadi begini:

```ini
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/local/bin/ollama serve
User=ollama
Group=ollama
Restart=always
RestartSec=3
Environment="OLLAMA_HOST=0.0.0.0"
Environment="PATH=/dan/lain/lain"
[Install]
WantedBy=default.target

```

Kemudian saya reboot saja komputer AI saya agar saya tidak perlu memperbanyak perintah:

```bash
sudo reboot now
```

Setelah menyala kembali, akhirnya saya bisa mengakses Ollama API dari http://192.168.2.2:11434

Selanjutnya, saya buka VSCode kemudian saya install extension bernama Continue dengan cara mencarinya dari sidebar VSCode.

Saat saya menggunakannya, saya sadari bahwa ada file konfigurasi yang dibuat di folder home saya: **/home/namausersaya/.continue/config.yaml**.

Langsung saja saya edit dan saya tambahkan baris ini:

```yaml
  - name: My-Gemma-FrankenBox
    provider: ollama
    model: gemma3:4b
    apiBase: http://192.168.2.2:11434
```

Sehingga secara keseluruhan script config.yaml menjadi begini:

```yaml
name: Local Assistant
version: 1.0.0
schema: v1
models:
  - name: My-Gemma-FrankenBox
    provider: ollama
    model: gemma3:4b
    apiBase: http://192.168.2.2:11434
context:
  - provider: code
  - provider: docs
  - provider: diff
  - provider: terminal
  - provider: problems
  - provider: folder
  - provider: codebase
```

Kemudian saya restart VSCode dan saat terbuka lagi saya klik icon paling bawah di sisi kiri.

Dari titik tersebut, saya sudah bisa mengatakan "hi" kepada Ollama di komputer AI saya dan dia menjawabnya.

Saya belum mengeksplorasi lebih jauh lagi tentang fitur dari extension bernama Continue ini. Yang jelas, saya bisa langsung memindahkan kode hasil chat langsung ke file script di project yang diedit dengan VSCode.