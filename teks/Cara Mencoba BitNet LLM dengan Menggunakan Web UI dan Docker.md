# Cara Mencoba BitNet LLM dengan Menggunakan Web UI dan Docker

Sebenarnya, saya tidak terlalu paham dengan konsep BitNet dari Microsoft ini.

Namun, saya berusaha menjelaskannya sedikit berdasarkan apa yang saya pahami.

Menurut [repository GitHub-nya](https://github.com/microsoft/BitNet), BitNet adalah framework LLM 1 bit.

Selain itu, yang saya pahami dari sumber lain, BitNet berbeda dengan LLM tradisional yang mengalami quantization, karena perampingannya dilakukan saat model dilatih. Efeknya, BitNet secara teoritis bisa berjalan lebih cepat pada hardware yang lebih lemah.

Sejujurnya, dari dulu saya ingin mencobanya di komputer mini pc saya, namun baru saat ini saya bisa melakukannya setelah menemukan sebuah [diskusi di GitHub ini](https://github.com/microsoft/BitNet/issues/59).

Dari diskusi tersebut, saya mendapat link ke sebuah [repository yang berisi web ui](https://github.com/stackblogger/bitnet.js) untuk BitNet dalam container Docker.

Anda harus melakukan docker build dulu untuk menggunakannya, tapi sebenarnya itu cukup mudah.

Nanti saya akan tambahkan sedikit modifikasi agar Anda juga bisa menggunakan model lainnya selain model default yang disediakan melalui repository tadi.

## Persiapan

Pertama, clone repository tadi dengan cara ini:

```bash
git clone https://github.com/stackblogger/bitnet.js.git
```

Kemudian masuk ke dalamnya:

```bash
cd bitnet.js
```

Kemudian jalankan 

```bash
docker compose up --build -d
```

Setelah beberapa saat, proses build akan selesai dan container akan dijalankan.

## Membuka Web UI

Dengan konfigurasi default, Anda bisa langsung mengunjungi [http://127.0.0.1:3000](http://127.0.0.1:3000) untuk membuka web ui nya.

Isi prompt-nya sesuka Anda kemudian Anda bisa membiarkan sisanya, kemudian tekan tombol "Send Query" untuk melihat responnya.

Secara default, model yang digunakan dalam aplikasi ini adalah "Llama3-8B-1.58-100B-tokens-TQ2\_0.gguf" yang di-download saat docker build melalui "bitnet.js/app/llm/Dockerfile" di bagian ini:

```docker
# Download the Llama model from HuggingFace
ADD https://huggingface.co/brunopio/Llama3-8B-1.58-100B-tokens-GGUF/resolve/main/Llama3-8B-1.58-100B-tokens-TQ2_0.gguf .
```

Bagaimana saya bisa tahu?

Itu karena pada script "bitnet.js/app/llm/run\_model.py" bagian ini telah menjelaskannya:

```python
command = ['python3', 'run_inference.py', '-m', 'Llama3-8B-1.58-100B-tokens-TQ2_0.gguf', '-p', query]
```

## Mengganti Model BitNet yang Lain

Model BitNet yang kompatibel dengan framework ini sebenarnya ada, tapi saya baru menemukannya sedikit. Misalnya [yang ini](https://huggingface.co/microsoft/bitnet-b1.58-2B-4T-gguf/resolve/main/ggml-model-i2_s.gguf).

Karena itu, kita akan mencoba menjalankannya di aplikasi ini.

Buka file "bitnet.js/app/llm/Dockerfile" dan di bawah script ini:

```docker
# Download the Llama model from HuggingFace
ADD https://huggingface.co/brunopio/Llama3-8B-1.58-100B-tokens-GGUF/resolve/main/Llama3-8B-1.58-100B-tokens-TQ2_0.gguf .
```

Tambahkan kode ini:

```docker
ADD https://huggingface.co/microsoft/bitnet-b1.58-2B-4T-gguf/resolve/main/ggml-model-i2_s.gguf .
```

Dan ubah kode "bitnet.js/app/llm/run\_model.py" ini:

```python
command = ['python3', 'run_inference.py', '-m', 'Llama3-8B-1.58-100B-tokens-TQ2_0.gguf', '-p', query]
```

Menjadi begini:

```python
command = ['python3', 'run_inference.py', '-m', 'ggml-model-i2_s.gguf', '-p', query]
```

Kemudian, jalankan kembali perintah ini dari folder root project ini:

```bash
docker compose up --build -d
```

Kemudian kembali kunjungi [http://127.0.0.1:3000](http://127.0.0.1:3000) dan tulis prompt seperti tadi.

## Akhir Kata

Sekarang, Anda telah mencoba BitNet di web ui.

Bagaimana rasanya?