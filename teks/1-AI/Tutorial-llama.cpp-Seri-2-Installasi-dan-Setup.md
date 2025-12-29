# Tutorial llama.cpp Seri 2 - Installasi dan Setup

Sekarang, saya tegaskan sekali lagi, bahwa mulai dari bagian ini dan seterusnya, saya berasumsi bahwa Anda menggunakan Ubuntu Server 24.04...

Jika Anda menggunakan distro lain, maka silakan sesuaikan sendiri perintah-perintah yang diberikan.

Sebagian path di artikel ini mengandung nama folder "username-anda".

Harap sesuaikan dengan username yang Anda berikan saat Anda login ke Ubuntu Server Anda.

Jika Anda ragu apa username Anda, maka jalankan:

```bash
whoami
```

Jadi, jika whoami mengembalikan output:

```bash
me
```

Berarti "/home/username-anda" adalah "home/me".

## System Requirements

Saya tidak bisa memberikan informasi pasti tentang minimum system requirements agar bisa menjalankan llama.cpp.

Namun, karena saya menguji script-script ini di mini pc saya dengan spesifikasi hardware ini:

-   CPU: Intel® Core™ i3-1215U
-   Graphics: Intel® UHD Graphics (Core i3)
-   RAM: 16 GB DDR4 2666/ 3200MHz SO-DIMMs
-   Storage: M.2 SSD (NVMe PCIe Gen4 x4 / SATA auto switch)

Setidaknya itu memberikan info bahwa spesifikasi hardware tadi mungkin bisa digunakan.

## Cara Menginstall llama.cpp

Pastikan Anda berada di "/home/username-anda":

```bash
cd ~
```

### Mendownload llama.cpp Prebuilt Binaries

Untuk menginstall llama.cpp, buka URL ini:

[https://github.com/ggml-org/llama.cpp/releases](https://github.com/ggml-org/llama.cpp/releases)

Saat artikel ini ditulis, versi terkini adalah b6215.

Di sana ada beberapa pilihan dari prebuilt binaries.

Jika Anda menggunakan Ubuntu 24.04 x64, pilih yang:

[llama-b6215-bin-ubuntu-x64.zip](https://github.com/ggml-org/llama.cpp/releases/download/b6215/llama-b6215-bin-ubuntu-x64.zip)

Download file tadi:

```bash
wget https://github.com/ggml-org/llama.cpp/releases/download/b6215/llama-b6215-bin-ubuntu-x64.zip
```

### Mengekstrak Paket llama.cpp yang masih Berbentuk Zip

Install unzip:

```bash
sudo apt update

sudo apt install unzip
```

Selanjutnya ekstrak file zip tadi:

```bash
unzip llama-b6215-bin-ubuntu-x64.zip
```

Jika kita baca isi directory saat ini:

```bash
ls
```

Maka Anda akan melihat folder bernama "build".

### Meletakkan folder "build" di Tempat yang Jelas dan Tetap

Agar llama.cpp binaries bisa diakses dengan perintah yang tetap, maka kita perlu meletakkan binaries-nya di tempat yang jelas dan tetap.

Sekarang buat folder "apps" di "/home/username-anda":

```bash
mkdir ~/apps
```

Selanjutnya buat folder "llama-cpp" di folder "/home/username-anda/apps":

```bash
mkdir ~/apps/llama-cpp
```

Kemudian jalankan perintah ini:

```bash
mv ./build ~/apps/llama-cpp
```

Selanjutnya, agar bisa diakses dari semua folder, maka kita harus mengonfigurasi file "~/.profile" yang ada di folder "/home/username-anda".

Caranya dengan menjalankan perintah ini:

```bash
nano ~/.profile
```

Setelah isi dari "~/.profile" terbuka, tambahkan baris-baris ini ke bagian paling bawahnya:

```bash
# llama.cpp
export PATH=/home/username-anda/apps/llama-cpp/build/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/username-anda/apps/llama-cpp/build/bin
```

Selanjutnya, tekan ctrl+x kemudian tekan y kemudian enter.

Jika Anda melakukan kesalahan di saat memasukkan script tadi, lebih mudah memperbaikinya dengan menekan ctrl + x kemudian tekan n. selanjutnya ulangi langkah tadi mulai dari nano ~/.profile tadi.

Setelah langkah ini selesai, maka Anda tinggal logout:

```bash
logout
```

Kemudian login lagi.  
  
Atau...

Restart dengan perintah ini:

```bash
sudo reboot now
```

### Verifikasi Installasi llama.cpp

Untuk memverifikasi installasi llama.cpp, jalankan perintah ini:

```bash
llama-cli --help
```

Jika muncul help dari aplikasi "llama-cli" berarti installasi berhasil.

Anda bisa memastikan juga bahwa path dari llama-cli sesuai dengan konfigurasi path llama.cpp binaries di "~/.profile" tadi:

```bash
which llama-cli
```

Jika outputnya seperti ini:

```bash
/home/username-anda/apps/llama-cpp/build/bin/llama-cli
```

Berarti sudah benar.

## Setup

Sejauh ini kita sudah berhasil menempatkan llama.cpp di tempat yang jelas dan tetap.

Selain itu, kita juga bisa menjalankan llama-cli dari folder manapun.

Tapi, kita harus bisa memastikan bahwa llama.cpp bisa membuka dan menggunakan model yang kita inginkan.

Oleh karena itu, Anda perlu mendownload setidaknya satu file .gguf yang bisa Anda dapatkan dari Hugging Face.

Maka, download file tersebut dari URL ini:

[google\_gemma-3-1b-it-Q4\_K\_M.gguf](https://huggingface.co/bartowski/google_gemma-3-1b-it-GGUF/resolve/main/google_gemma-3-1b-it-Q4_K_M.gguf)

Caranya dengan menjalankan perintah ini:

```bash
wget https://huggingface.co/bartowski/google_gemma-3-1b-it-GGUF/resolve/main/google_gemma-3-1b-it-Q4_K_M.gguf
```

Setelah terdownload, pastikan hasilnya ada di folder saat ini. Cara mengeceknya:

```bash
ls
```

Selanjutnya, buat folder models:

```bash
mkdir /home/username-anda/apps/llama-cpp/models
```

Pindahkan file tersebut ke dalam folder "/home/username-anda/apps/llama-cpp/models":

```bash
mv google_gemma-3-1b-it-Q4_K_M.gguf /home/username-anda/apps/llama-cpp/models
```

Untuk membukanya dengan llama.cpp, maka kita bisa melakukan cara ini:

```bash
llama-cli -m /home/username-anda/apps/llama-cpp/models/google_gemma-3-1b-it-Q4_K_M.gguf
```

Jika muncul output seperti ini:

```bash
== Running in interactive mode. ==
 - Press Ctrl+C to interject at any time.
 - Press Return to return control to the AI.
 - To return control without starting a new line, end your input with '/'.
 - If you want to submit another line, end your input with '\'.
 - Not using system message. To change it, set a different value via -sys PROMPT


> 
```

Maka Anda telah berhasil menjalankan model yang dibuka dengan llama.cpp binaries, dalam hal ini llama-cli.

Cobalah ajak chat LLM tersebut, misalnya dengan prompt ini:

```bash
hai, apa skill Anda?
```

Jika keluar jawaban seperti:

```bash
Halo! Saya adalah model bahasa besar yang dikembangkan oleh Google DeepMind. Saya dilatih oleh Meta AI dan saya adalah model open-weights. 

Secara umum, saya bisa melakukan berbagai hal, seperti:
```

Maka bab ini selesai.