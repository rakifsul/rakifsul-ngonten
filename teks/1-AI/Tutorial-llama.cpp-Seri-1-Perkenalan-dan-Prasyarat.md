# Tutorial llama.cpp Seri 1 - Perkenalan dan Prasyarat

## Apa itu llama.cpp?

llama.cpp adalah library dan framework open-source berbasis C/C++ untuk menjalankan model bahasa besar (LLM) di perangkat lokal, baik CPU maupun GPU, dengan fokus pada:

-   Efisiensi memori dan performa
    -   Bisa menjalankan model besar.
    -   Mendukung kuantisasi.
-   Portabilitas
    -   Bisa dijalankan di Linux, Windows, macOS, bahkan Android.
    -   Mendukung multi-backend GPU (CUDA, Metal, Vulkan, OpenCL) dan CPU multi-threading.
-   Fleksibilitas penggunaan
    -   Bisa dipakai sebagai CLI (command line interface), library untuk Python/Node.js, web ui via browser, atau backend untuk server API.
    -   Mendukung mode inference dasar dan embeddings.
-   Open-source dan ekosistem luas
    -   Dikembangkan secara komunitas di GitHub.
    -   Bisa dipadukan dengan berbagai UI dan memiliki banyak binding seperti Python dan Node.js.

## Mengapa llama.cpp Penting sebagai LLM Lokal

Walaupun banyak LLM lokal yang tidak sekuat LLM yang ternama di cloud, llama.cpp sebagai LLM lokal memiliki keunggulan-keunggulan ini:

-   Lebih privat
-   Bebas memilih model
-   Tidak tergantung internet jika model dan binaries-nya sudah didownload
-   Bisa disertakan pada program LLM standalone yang dibuat sendiri.
-   Mendukung kreativitas
-   Bisa menjadi hobi yang menyenangkan.
-   Bisa melatih optimasi LLM dari sisi penggunanya, misalnya dengan prompt engineering yang efektif dan efisien.

## Fitur-Fitur Penting

Walaupun banyak program yang disertakan dalam paket binaries dari llama.cpp, beberapa program di bawah ini adalah yang paling penting.

### llama-cli

llama-cli adalah program command line yang secara default berada dalam kondisi percakapan.

Selain itu, llama-cli cocok untuk melakukan eksperimen dengan konfigurasi dan fungsionalitasnya.

Penampakan llama-cli saat digunakan adalah seperti chatbot yang berjalan di terminal.

### llama-server

llama-server adalah program berbasis web yang memungkinkan pengguna untuk melakukan percakapan via web ui.

llama-server juga bisa menjadi backend API yang nantinya bisa merespon request dari program lain yang dibuat, misalnya, dengan Node.js.

Dengan kata lain, kita menggunakan browser untuk chat dengan llama-server atau menggunakan API jika di-request dari program lain.

### llama-bench

llama-bench adalah program command line yang dibuat untuk melakukan benchmarking dengan konfigurasi-konfigurasi tertentu.

hasil output dari llama-bench adalah berupa tabel dengan kolom-kolom berisi nilai-nilai yang diukurnya.

Contohnya seperti di bawah ini:

```
load_backend: loaded RPC backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-rpc.so
load_backend: loaded CPU backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-cpu-alderlake.so
| model                          |       size |     params | backend    | ngl | n_batch |            test |                  t/s |
| ------------------------------ | ---------: | ---------: | ---------- | --: | ------: | --------------: | -------------------: |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |     512 |           pp512 |         24.61 ± 0.49 |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |     512 |           tg128 |          9.09 ± 0.05 |

build: e8215dbb (5760)
```

## Apa yang Diperlukan untuk Melanjutkan Seri Ini?

Setidaknya, Anda perlu:

-   Terbiasa memahami bacaan berbahasa Inggris.
-   Paham penggunaan Ubuntu Server 24.04.
-   Terbiasa menggunakan terminal di Linux.
-   Paham dengan pemrograman Node.js.
-   Paham dengan pemrograman Python3.
-   Dan lain-lain, jika diperlukan.

Jika ada yang tidak terpenuhi, maka:

-   Pelajarilah hal-hal yang perlu diketahui seiring membaca seri ini.
-   Gunakan search engine atau layanan LLM yang paling banyak penggunanya untuk memahami istilah yang asing di seri ini.