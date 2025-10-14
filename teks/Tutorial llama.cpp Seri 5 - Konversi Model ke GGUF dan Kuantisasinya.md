# Tutorial llama.cpp Seri 5 - Konversi Model ke GGUF dan Kuantisasinya

Sekarang, kita akan belajar **mengonversi** file .safetensors ke .gguf.

Beberapa model di [HuggingFace](https://huggingface.co) belum memiliki format .gguf.

Padahal, mungkin saja model tersebut bagus untuk keperluan tertentu.

Jika demikian, kita harus bisa mengonversinya ke .gguf sendiri.

Tidak hanya itu, kita juga akan melakukan **kuantisasi** pada model dengan format .gguf yang merupakan output dari konversi .safetensors ke .gguf.

Untuk itulah artikel ini ditulis.

Pada artikel ni, saya akan memberi contoh cara mengonversi file .safetensors dari model [openhands](https://huggingface.co/all-hands/openhands-lm-1.5b-v0.1).

Namun, kita harus mempersiapkan software-nya dulu.

Selain itu, saya menganggap Anda telah membaca [seri Tutorial llama.cpp dari awal](Tutorial%20llama.cpp%20Seri%201%20-%20Perkenalan%20dan%20Prasyarat.md).

Jika belum, baca dulu...

## Menginstall git lfs

git lfs diperlukan nantinya untuk mendukung proses clone dari model yang saya bahas.

Cara menginstall git lfs adalah dengan perintah ini:

```bash
sudo apt update

sudo apt install git-lfs -y

git lfs install

# untuk memverifikasinya
git lfs version
```

## Menginstall Dependencies dari .gguf Converter

Jalankan perintah ini dengan Python 3.11.13, bisa dengan [pyenv](https://github.com/pyenv/pyenv) jika Anda mau:

```bash
cd llama.cpp

pip install -r requirements.txt
```

Kemudian, buat alias di ~/.bashrc agar nanti kita tidak repot menjalankannya dari folder manapun:

```apacheconf
nano ~/.bashrc
```

Tambahkan baris ini di bagian paling bawah:

```bash
alias llama-cpp-convert='python /path/ke/llama.cpp/convert_hf_to_gguf.py'
```

Tutup terminal Anda lalu buka lagi.

Sekarang, pindah ke folder lain di luar folder llama.cpp, lalu clone [openhands](https://huggingface.co/all-hands/openhands-lm-1.5b-v0.1) dengan perintah ini:

```bash
git clone https://huggingface.co/all-hands/openhands-lm-1.5b-v0.1
```

Kemudian masuk ke dalamnya:

```bash
cd openhands-lm-1.5b-v0.1
```

Lalu konversi ke .gguf:

```bash
llama-cpp-convert . --outfile openhands.gguf
```

Parameter . di sebelah kanan llama-cpp-convert tadi artinya folder saat ini. Setahu saya, saat kita mengonversi safetensors ke gguf, inputnya adalah folder repository dari model tersebut.

Setelah konversi tadi selesai, file openhands.gguf masih dalam keadaan belum dikuantisasi.

Sekarang lakukan kuantisasi:

```bash
llama-quantize ./openhands.gguf openhands-lm-1.5b-v0.1.gguf Q4_K_M
```

Silakan tunggu sampai selesai.

Hasilnya ada di folder yang sama saat Anda menjalankan perintah barusan.