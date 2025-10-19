# Tutorial llama.cpp Seri 3 - Build llama.cpp Konfigurasi Default (CPU)

Walaupun llama.cpp menyediakan prebuilt binaries untuk Linux, membuild llama.cpp dari source code mungkin diperlukan jika:

-   Kita ingin mengoptimasi hasil build-nya dengan konfigurasi build tertentu.
-   Kita ingin memodifikasinya.
-   Kita ingin berkontribusi di pengembangannya.
-   Kita ingin bereksperimen dengan kodenya.
-   Kita ingin mencoba release terbaru yang belum dibuat prebuilt binaries-nya.

Di bagian ini, kita akan mencoba mem-build llama.cpp dengan konfigurasi default atau CPU Build.

## Melakukan Clone Repository

Langkah awal yang diperlukan adalah melakukan clone terhadap repository llama.cpp.

Namun, agar folder build kita cukup rapi, buat dulu folder "/home/username-anda/llama.cpp-build".

Dengan asumsi bahwa kita ada di folder "/home/username-anda", jalankan perintah ini:

```bash
mkdir llama.cpp-build
```

Kemudian, kita masuk ke dalamnya:

```bash
cd llama.cpp-build
```

Lalu kita clone repository llama.cpp:

```bash
git clone https://github.com/ggml-org/llama.cpp
```

Lalu masuk ke dalam folder repository tersebut:

```bash
cd llama.cpp
```

## Menginstall Build Dependencies

Jika Anda lihat dengan perintah "ls", maka di folder tersebut terdapat banyak file.

Jangan takut melihatnya, karena perintah untuk build tidak panjang.

Karena untuk membuild llama.cpp dibutuhkan beberapa aplikasi tambahan, maka mari kita install aplikasi tersebut.

Yang pertama cmake:

```bash
sudo apt install cmake
```

Yang kedua build-essential:

```bash
sudo apt install build-essential
```

Yang ketiga libcurl4-openssl-dev:

```bash
sudo apt install libcurl4-openssl-dev
```

## Membuild llama.cpp

Setelah terinstall, kita bisa langsung membuild llama.cpp dengan konfigurasi default.

Caranya adalah dengan menjalankan perintah ini:

```bash
cmake -B build

cmake --build build --config Release
```

Proses ini memakan waktu yang tidak terlalu lama di virtual machine saya.

## Verifikasi Hasil Build

Setelah selesai, hasil build ada di folder "llama.cpp/build".

Jika Anda masih berada di dalam folder repository, begini cara mengeceknya:

```bash
ls build
```

Adapun binaries-nya ada di "llama.cpp/build/bin". Cara mengeceknya:

```bash
ls build/bin
```

Namun jika kita cek dan kita telah mengerjakan project di tutorial seri sebelumnya, kita mendapati llama-cli **BUKAN** di folder tersebut:

```bash
which llama-cli

# output:
# /home/username-anda/apps/llama-cpp/build/bin/llama-cli
```

Itu karena kita telah mengubah konfigurasi di ~/.profile pada tutorial seri sebelumnya.

Dan llama-cli tadi bukan hasil build kita.

Maka untuk memperbaikinya, kita konfigurasi kembali ~/.profile.

Caranya dengan menjalankan perintah ini:

```bash
nano ~/.profile
```

Kemudian ganti bagian llama.cpp dengan script ini:

```bash
export PATH=/home/me/llama.cpp-build/llama.cpp/build/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/me/llama.cpp-build/llama.cpp/build/bin
```

Kemudian kita logout:

```bash
logout
```

Dan login kembali.

Kemudian kita cek dengan which:

```bash
which llama-cli

# output:
# /home/username-anda/llama.cpp-build/llama.cpp/build/bin/llama-cli
```

Pastikan lagi bahwa llama-cli berjalan:

```bash
llama-cli --help
```

Karena dalam proses build ini saya menggunakan virtual machine dan vm tersebut tidak memungkinkan untuk menjalankan llama-cli dengan model, maka saya tidak memberikan output-nya.

Jika Anda melakukannya di komputer sungguhan, mungkin Anda bisa coba llama-cli hasil build dengan model tertentu, caranya sudah dibahas di [Tutorial Seri 2 - Installasi dan Setup](../2025-08/Tutorial-llama.cpp-Seri-2-Installasi-dan-Setup.md).