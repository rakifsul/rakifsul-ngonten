# Membuat CLI Cerdas yang Paham Command Bahasa Manusia

Waktu itu, saya lagi bingung karena sedang bosan.

Saya berusaha mencari ide untuk dilakukan agar kebosanan saya pada waktu itu bisa terobati.

Sebenarnya, tutorial berseri saya tentang llama.cpp belum selesai, tetapi entah mengapa saya sedang kurang mood untuk melanjutkannya.

Saya kira, mengalihkan kegiatan saya pada hal lain, apalagi masih satu topik dengan tutorial berseri saya tadi itu adalah ide yang bagus.

Tak lama kemudian, saya teringat sebuah aplikasi terminal yang bisa digunakan dengan bahasa manusia untuk menjalankan perintahnya.

Seketika itu juga, saya langsung dapat ide: bagaimana kalau saya buat yang semacam itu, tapi dalam bentuk script bash.

Tentunya saya akan mengerjakannya untuk digunakan di Linux mengingat saya sekarang menggunakan Kubuntu 24.04.3.

Walaupun tidak sama dengan Ubuntu yang beberapa jam yang lalu saya ganti dengan Kubuntu, namun teknik scriptingnya masih sama, yakni dengan bash.

## Memastikan Konfigurasi Network sudah Benar

Saya tidak ingin menggunakan PC yang sama untuk API dari Ollama.

Itu karena PC saya yang satu lagi sudah siap untuk keperluan tersebut, meskipun menggunakan sistem operasi Ubuntu Server 24.04.3.

Dari sini, saya mulai mengubah konfigurasi untuk ethernet kedua PC LLM saya, sementara konfigurasi WiFi saya biarkan apa adanya.

PC LLM server saya memiliki ip 192.168.1.2, network mask 255.255.255.0 dan saya memberi ip pada PC LLM client saya 192.168.1.1 dengan network mask 255.255.255.0.

DNS yang saya set di PC LLM client saya adalah 1.1.1.1 dan 1.0.0.1

Default gateway kedua PC LLM dikosongkan.

ipv6 kedua PC LLM di-disable

Tentunya, kedua PC LLM tadi terhubung secara fisik dengan kabel ethernet.

Sebenarnya saya bisa menggunakan Wi-Fi dan memasukkan kedua PC LLM saya ke wireless network rumah saya, tapi saya lebih suka menghubungkan kedua PC LLM saya dengan kabel secara langsung agar koneksi internetnya bersifat opsional.

## Memastikan Ollama sudah Diinstall

Saya telah menginstall Ollama sebelumnya di PC LLM server.

Caranya sederhana, yakni dengan menggunakan setup script dari Ollama yang bisa didownload di website resminya.

Tapi itu saja tidak cukup, karena nanti saya harus mengubah Environment Variable dari script systemd, sehingga Ollama mem-bind ip 0.0.0.0.

Dengan mem-bind ke ip tadi, maka PC LLM server saya yang memiliki ip berbeda dengan PC LLM client-nya bisa diakses.

Saya melakukan itu dengan perintah ini (sesudah Ollama terinstall):

```
sudo nano /etc/systemd/system/ollama.service
```

Kemudian mengubah script tersebut menjadi seperti ini:

```
... sebelumnya
[Service]
ExecStart=/usr/local/bin/ollama serve
User=ollama
Group=ollama
Restart=always
RestartSec=3
Environment="OLLAMA_HOST=0.0.0.0"
... selanjutnya
```

Ini yang saya tambahkan:

```
Environment="OLLAMA_HOST=0.0.0.0"
```

Sisanya sama dengan bawaan ollama saat baru diinstall.

Setelah itu dilakukan, saya langsung reboot PC LLM server saya dengan perintah ini:

```
sudo reboot now
```

## Melakukan Prompt Engineering untuk Minta Dibuatkan Script Bash oleh ChatGPT

Inilah fase yang paling seru, karena saya harus melakukan prompt engineering dengan tepat.

Karena saya sudah terdaftar di ChatGPT, saya langsung login ke akun saya dan menjalankan prompt ini:

```
buatlah script bash yang me-request ke ollama api untuk mendapatkan perintah cli saja (tanpa penjelasan atau semacamnya) berdasarkan pertanyaan pada request tersebut
```

Kemudian, inilah respon dari ChatGPT (saya hanya tampilkan kodenya saja, tanpa komentar dari ChatGPT):

```
#!/bin/bash

# Script: ollama-cli.sh
# Fungsi: Mengirim pertanyaan ke Ollama API dan hanya mendapatkan perintah CLI (tanpa penjelasan).

# Pastikan pertanyaan dimasukkan sebagai argumen
if [ $# -eq 0 ]; then
 echo "Usage: $0 \"pertanyaan anda\""
 exit 1
fi

QUESTION="$*"

# Prompt agar Ollama hanya menjawab dengan 1 baris perintah CLI
PROMPT="Jawab hanya dengan perintah CLI tunggal yang benar.
Tanpa penjelasan, tanpa teks tambahan, tanpa markdown.
Pertanyaan: $QUESTION"

# Request ke Ollama API
curl -s http://localhost:11434/api/generate \
 -d "{
   \"model\": \"llama3\",
   \"prompt\": \"$PROMPT\",
   \"stream\": false
 }" | jq -r '.response' | head -n 1

```

Langsung saya copy ke PC LLM client saya, kemudian saya save, kemudian saya beri nama "llm-cli".

Setelah itu, saya beri permission +x pada script tadi dengan cara:

```
chmod +x llm-cli
```

Kemudian, saya menjalankan perintah ini untuk memastikan bahwa Ollama sudah running di PC LLM server saya:

```
# setelah ssh ke 192.168.1.2

sudo systemctl status ollama.service

# outputnya memperlihatkan sudah active dan running, warna hijau
```

Kemudian saya langsung mencoba script llm-cli tersebut.

## Pengujian Pertama

Saya coba jalankan perintah ini di PC LLM client:

```
./llm-cli “buat sebuah folder baru bernama test”
```

Ternyata gagal karena outputnya adalah null.

Setelah saya periksa ternyata ada kesalahan:

- URL salah, seharusnya bukan ke domain localhost, tapi ke ip 192.168.1.2
- Model yang ditulis di script adalah llama3 yang belum saya install.

## Perbaikan Pertama

Setelah melakukan beberapa perbaikan, akhirnya saya berhasil.

Adapun perbaikannya adalah:

- ip-nya diperbaiki jadi 192.168.1.2
- model yang saya gunakan dibuat menjadi qwen2.5-coder:7b.

Saya masukkan script yang sudah saya perbaiki tadi ke prompt ChatGPT seperti ini:

```
sudah berhasil dengan kode ini:

... script yang telah diperbaiki (tidak saya tampilkan di sini)
```

```
sekarang, beri pertanyaan apakah anda mau jalankan perintah ini ? yes/no
```

ChatGPT memberi output yang hasil akhirnya adalah seperti ini:

```
#!/bin/bash

if [ $# -eq 0 ]; then
 echo "Usage: $0 \"pertanyaan anda\""
 exit 1
fi

QUESTION="$*"

PROMPT="Jawab hanya dengan perintah CLI tunggal yang benar. Tanpa penjelasan, tanpa teks tambahan, tanpa markdown. Pertanyaan: $QUESTION"

RESPONSE=$(curl -s http://192.168.1.2:11434/api/generate \
 -d "{
   \"model\": \"qwen2.5-coder:7b\",
   \"prompt\": \"$PROMPT\",
   \"stream\": false
 }")

# Debug kalau mau lihat raw response
# echo "$RESPONSE" | jq '.'

COMMAND=$(echo "$RESPONSE" | jq -r '.response' | sed '/^\s*$/d' | head -n 1)

echo "Perintah yang dihasilkan:"

echo "$COMMAND"

echo

read -p "Apakah anda mau jalankan perintah ini? (yes/no) " confirm

if [[ "$confirm" == "yes" || "$confirm" == "y" ]]; then
 echo "Menjalankan: $COMMAND"
 eval "$COMMAND"
else
 echo "Dibatalkan."
fi
```

## Pengujian Kedua

Karena model qwen2.5-coder:7b belum saya install, maka saya jalankan perintah ini di PC LLM server saya:

```
ollama pull qwen2.5-coder:7b
```

Kemudian, menggunakan script terbaru tadi, saya coba jalankan perintah ini lagi di PC LLM client saya:

```
./llm-cli “buat sebuah folder baru bernama test”
```

Outputnya:

```
Perintah yang dihasilkan:
mkdir test

Apakah anda mau jalankan perintah ini? (yes/no) y
Menjalankan: mkdir test
```

Kemudian, saya memastikan folder test benar-benar ada:

```
ls
```

Ternyata folder tersebut ada.

Dengan demikian, project saya hari ini selesai.

## Penutup

Itu adalah gambaran dari proses coding aplikasi LLM dengan menggunakan LLM juga. Tampak mudah, bukan?

Namun, karena jawaban ChatGPT bisa berbeda-beda walau promptnya sama, maka kemungkinan kita harus menyesuaikan script hasilnya.

Walaupun terkesan mudah, masih ada sedikit bug fixing yang diperlukan, sehingga skill coding masih diperlukan dalam project ini.
