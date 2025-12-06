# Cara Mengatasi Ollama Macet saat Memproses Prompt

Ollama merupakan salah satu solusi untuk LLM lokal.

Penggunaan Ollama cukup mudah karena setelah install, kita hanya perlu menjalankan perintah pull atau run disertai nama model yang disediakan di website resminya.

Namun, sayangnya, terkadang pemrosesan prompt di Ollama macet, setidaknya di komputer saya yang menggunakan NVidia RTX 2060.

Bahkan, dalam kondisi tadi, perintah ollama stop juga seringkali tidak berfungsi.

Saya kurang tahu apa penyebabnya, tapi saya tahu cara mengatasinya.

Saat Ollama macet di pemrosesan prompt dan tidak bisa menangani perintah ollama stop, maka yang Anda perlu lakukan adalah menghentikan, kemudian menjalankan lagi ollama.service.

Caranya seperti ini.

Keluar dahulu dari prompt Ollama dengan menekan ctrl+d.

Lalu, jalankan perintah ini:

```
sudo systemctl stop ollama.service
```

Kemudian dilanjutkan dengan:

```
sudo systemctl start ollama.service
```

Pastikan juga bahwa ollama.service sudah berjalan kembali dengan cara ini:

```
sudo systemctl status ollama.service

# pastikan ada kata "running"
```

Walaupun singkat dan sederhana, perintah-perintah tadi bekerja saat Ollama macet di tengah pemrosesan prompt. Setidaknya di komputer saya.
